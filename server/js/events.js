'use strict';

const aws = require('aws-sdk');
aws.config.update({region: process.env.AWS_REGION});
const ddb = new aws.DynamoDB.DocumentClient();

const ical = require('ical-generator');

const tblEvents = process.env.TBL_EVENTS;

const GameNames = {
  S: "Sun",
  M: "Moon",
  US: "Ultra Sun",
  UM: "Ultra Moon",
  GO: "GO",
  SW: "Sword",
  SH: "Shield",
  LGE: "Let's Go, Eevee!",
  LGP: "Let's Go, Pikachu!",
  BD: "Brilliant Diamond",
  SP: "Shining Pearl",
  LA: "Legends: Arceus",
  HO: "Home"
};

const Fields = [
  "Title",
  "Species",
  "Description",
  "Type",
  "Region",
  "Gender",
  "Ball",
  "OT",
  "TID",
  "Ability",
  "HoldItem",
  "Nature",
  "Code",
  "Level",
  "Shiny",
  "Gigantamax",
  "StartDate",
  "EndDate",
  "Moves",
  "Marks",
  "Ribbons",
  "Locations",
  "Games"
];

const createResponse = (statusCode, body) => {
  return {
    "statusCode": statusCode,
    "body": body || ""
  }
};

const createCalendar = (statusCode, body) => {
  return {
    "statusCode": statusCode,
    "body": body || "",
    "headers": {
        "Content-Type": "text/calendar"
    }
  }
};

exports.create = function(event, context, callback) {
  console.log(event.body);
  var result = {
    ID: context.awsRequestId
  }
  var newevent = JSON.parse(event.body);
  
  var params = {
    TableName: tblEvents,
    Item: {
      ID: result.ID
    }
  };
  
  Fields.forEach(field => params.Item[field] = newevent[field]);
  
  ddb.put(params, function(error, data) {
    if (error) {
      console.log(error);
      callback(null, createResponse(500))
    } else {
      callback(null, createResponse(201, JSON.stringify(result)))
    }
  });
}

exports.delete = function(event, context, callback) {
  var params = {
    TableName: tblEvents,
    Key: {
      ID: event.pathParameters.ID
    }
  };
  
  console.log(params);
  
  ddb.delete(params, function(error, data) {
    if (error) {
      console.log(error);
      callback(null, createResponse(500))
    } else {
      callback(null, createResponse(200))
    }
  });
}

exports.update = function(event, context, callback) {
  var updEvent = JSON.parse(event.body);
  
  var params = {
    TableName: tblEvents,
    Key: {
      ID: event.pathParameters.ID
    },
    ExpressionAttributeNames: {},
    ExpressionAttributeValues: {}
  };
  
  var setFields = Fields.filter(field => field in updEvent);
  params.UpdateExpression = "SET " + setFields.map((field, i) => "#f" + i + " = :f" + i).join(", ");
  
  for (var i = 0; i < setFields.length; i++) {
    params.ExpressionAttributeNames["#f" + i] = setFields[i];
    params.ExpressionAttributeValues[":f" + i] = updEvent[setFields[i]];
  }
  
  var removed = Fields.filter(field => !(field in updEvent));
  if (removed.length) {
    params.UpdateExpression += " REMOVE " + removed.map((field, i) => "#r" + i).join(", ");
  
    for (var i = 0; i < removed.length; i++) {
      params.ExpressionAttributeNames["#r" + i] = removed[i];
    }
  }
  
  console.log(params);
  
  ddb.update(params, function(error, data) {
    if (error) {
      console.log(error);
      callback(null, createResponse(500))
    } else {
      callback(null, createResponse(200))
    }
  });
}

exports.get = function(event, context, callback) {
  var params = {
    TableName: tblEvents
  }
  
  ddb.scan(params, function(error, data) {
    var response;
    
    if (error) {
      console.log(error, error.stack);
      response = createResponse(500, error);
    } else {
      console.log('Success!');
      response = createResponse(200, JSON.stringify(data.Items));
    }
    
    callback(null, response);
  });
}

exports.calendar = async function(event, context, callback) {
  if (!event.queryStringParameters) {
    console.error("No parameters supplied.");
    callback(null, createResponse(400));
    return;
  }
  
  if (!event.queryStringParameters.region) {
    console.error("No region specified.");
    callback(null, createResponse(400));
    return;
  }
  
  var region = event.queryStringParameters.region;
  if (!["Worldwide","America","Japan","Europe","Other"].includes(region)) {
    console.error("Unknown region: " + region);
    callback(null, createResponse(400));
    return;
  }
  
  if (!event.queryStringParameters.games) {
    console.error("No games specified.");
    callback(null, createResponse(400));
    return;
  }
  
  var games = event.queryStringParameters.games.split(",");
  
  for (var game in games)
    if (!GameNames[games[game]]) {
      console.error("Unknown game: " + games[game]);
      callback(null, createResponse(400));
      return;
    }
  
  var gameClauses = [];
  var gameValues = {};
  
  games.forEach((game,i) => {
    gameClauses.push("contains(Games, :game" + i + ")");
    gameValues[":game" + i] = game;
  });
  
  var params = {
    TableName: tblEvents,
    FilterExpression: "(attribute_not_exists(EndDate) OR EndDate >= :today) AND (" + gameClauses.join(" OR ") + ")",
    ExpressionAttributeValues: Object.assign({
      ":today": new Date().toISOString().substring(0,10)
    }, gameValues)
  }
  
  // console.log(params);
  
  function pok2cal(pokevent) {
    if (pokevent.EndDate) {
      var endDate = new Date(pokevent.EndDate.substring(0,10));
      endDate.setDate(endDate.getDate() + 1);
    } else {
      var endDate = new Date(2200,0,1)
    }
    
    return {
      id: pokevent.ID,
      summary: pokevent.Title,
      start: new Date(pokevent.StartDate.substring(0,10)),
      end: endDate,
      location: pokevent.Locations.join(", "),
      busystatus: ical.ICalEventBusyStatus.FREE,
      description:
        pokevent.Description +
        "\n\n" +
        "Games: " + pokevent.Games.map(game => GameNames[game]).join(", ") + "\n" +
        "Type: " + pokevent.Type + "\n" +
        (pokevent.Code ? "Code: " + pokevent.Code + "\n" : "") +
        "\n" +
        (pokevent.Level ? "Lvl." + pokevent.Level + " " : "") +
        pokevent.Species +
        (pokevent.Ball ? " [" + pokevent.Ball + " Ball]\n" : "\n") +
        (pokevent.Shiny ? "☑ Shiny\n" : "") +
        (pokevent.Gigantamax ? "☑ Gigantamax\n" : "") +
        (pokevent.OT ? "OT: " + pokevent.OT + "\n" : "") +
        (pokevent.TID ? "ID: " + pokevent.TID + "\n" : "") +
        (pokevent.Nature ? "Nature: " + pokevent.Nature + "\n" : "") +
        (pokevent.Ability ? "Ability: " + pokevent.Ability + "\n" : "") +
        (pokevent.HoldItem ? "Hold Item: " + pokevent.HoldItem : "") +
        (pokevent.Moves && pokevent.Moves.length ? "\nMoves:\n" + pokevent.Moves.map(move => " • " + move).join("\n") : "")
    }
  }
    
  var pokevents = [];
  if (region == "Worldwide") {
    try {
      var data = await ddb.scan(params).promise();
    } catch (error) {
      console.error(error);
      callback(null, createResponse(500));
    }
    
    pokevents = pokevents.concat(data.Items.map(pok2cal));
  } else {
    params.IndexName = 'idxRegion';
    params.KeyConditionExpression = '#region = :region';
    params.ExpressionAttributeNames = {
      '#region': 'Region'
    };
    
    params.ExpressionAttributeValues[':region'] = 'Worldwide';
    try {
      var data = await ddb.query(params).promise();
    } catch (error) {
      console.error(error);
      callback(null, createResponse(500));
    }
    pokevents = pokevents.concat(data.Items.map(pok2cal));
    
    params.ExpressionAttributeValues[':region'] = region;
    try {
      data = await ddb.query(params).promise();
    } catch (error) {
      console.error(error);
      callback(null, createResponse(500));
    }
    pokevents = pokevents.concat(data.Items.map(pok2cal));
  }
  
  // console.log("Listing events");
  // console.log(JSON.stringify(pokevents));
  
  const calendar = ical({name: "Pokémon Distribution Events (Region: " + region + ", Games: " + games.map(game => GameNames[game]) + ")"});
  pokevents.forEach(pokevent => calendar.createEvent(pokevent));
  
  
  callback(null, createCalendar(200, calendar.toString()));
};