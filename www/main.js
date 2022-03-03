const regions = [
  "America", "Europe", "Japan", "Other"
]

const games = {
  GO: "GO",
  SW: "Sword",
  SH: "Shield",
  LGP: "Let's Go, Pikachu!",
  LGE: "Let's Go, Eevee!",
  BD: "Brilliant Diamond",
  SP: "Shining Pearl",
  LA: "Legends: Arceus",
  HO: "Home",
  SC: "Scarlet",
  VI: "Violet"
}

var currentCalendar = {
  region: null,
  games: {}
}

function getParameterByName(name, url = window.location.href) {
    name = name.replace(/[\[\]]/g, '\\$&');
    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
        results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return '';
    return decodeURIComponent(results[2].replace(/\+/g, ' '));
}

document.addEventListener('DOMContentLoaded', (event) => {
  document.getElementById('regions').innerHTML = regions.map(region => `<div><input type="radio" id="${region}" name="region" value="${region}" onclick="onRegionClick(this.value)"><label for="${region}">${region}</label></div>`).join('');
  
  document.getElementById('games').innerHTML = Object.keys(games).map(game => `<div><input type="checkbox" id="${game}" name="game" value="${game}" onclick="onGameClick(this.value)"><label for="${game}">${games[game]}</label></div>`).join('');
  
  Object.keys(games).forEach(game => currentCalendar[game] = false);
  
  var region = getParameterByName('region');
  if (regions.includes(region)) {
    currentCalendar.region = region;
    document.getElementById(region).checked = true;
  }
  
  var urlgames = (getParameterByName('games') || '').split(',');
  urlgames.forEach(game => {
    if (Object.keys(games).includes(game)) {
      currentCalendar.games[game] = true;
      document.getElementById(game).checked = true;
    }
  });
  
  refreshUI();
  
  if (!document.getElementById('generate').disabled)
    onGenerateClick();
});

function onGameClick(value) {
  currentCalendar.games[value] = !currentCalendar.games[value];
  
  refreshUI();
}

function onRegionClick(value) {
  if (value === currentCalendar.region)
    return;
  
  currentCalendar.region = value;
  
  refreshUI();
}

function onGenerateClick() {
  var calendar = window.location.protocol + '//' + window.location.host.replace('www','calendar') + '?region=' + currentCalendar.region + '&games=' + Object.keys(games).filter(game => currentCalendar.games[game]).join(',');
  
  document.getElementById('link').value = calendar;
  
  document.getElementById('linkdiv').style.visibility = 'visible';
}

function onCopyClick() {
  navigator.clipboard.writeText(document.getElementById('link').value);
}

function refreshUI() {
  var enabled = false;
  Object.keys(games).forEach(game => {
    document.getElementById(game).disabled = currentCalendar.region == null;
    enabled = enabled || currentCalendar.games[game];
  });
  enabled = enabled && currentCalendar.region != null;
  document.getElementById('generate').disabled = !enabled;
  document.getElementById('linkdiv').style.visibility = 'hidden';
}