# Home-assistant-train-on-time
"Is the next train on time" scraper for Home-assistant
======================================================

This utility tells if the next train is on time. 

Gets the result from searching for next train from a specified origin to a pretended destination.

Times are scrapped from the [website](http://infraestruturasdeportugal.pt/negocios-e-servicos/horarios/) portuguese national infrastructure institute and showed at your [Home-assistant](https://www.home-assistant.io/) (HA) as sensors. 

Every time the user accesses the HA Graphical User Interface (GUI), the values are scrapped from the [website](http://infraestruturasdeportugal.pt/negocios-e-servicos/horarios/) they are showed on screen.

This means that you have to change HA 'configuration.yaml' to add a 'command_line' sensor that will execute this script. 

The [website](http://infraestruturasdeportugal.pt/negocios-e-servicos/horarios/) responds to the url requests with in json. This script rellies in [jq](https://stedolan.github.io/jq/) to interprete this response, this needs to be installed in your system. 

---

## HOW-TO

First of all, you need to install [jq](https://stedolan.github.io/jq/).
1. 'sudo apt-get install jq'

Then, you will need to find out the identifier for the train you want to verify.
1. Open a web browser (Firefox is fine) and open the developer tools (Usually pressing F12 key).
1. Select the network tab from the development tools so you can see the requests sent from the browser to the server.  
1. Go to http://infraestruturasdeportugal.pt/negocios-e-servicos/horarios.
1. Type the full name of the trainstation you want info from and pay atention to the GET requests to http://infraestruturasdeportugal.pt/rede/estacoes/json/YOURTRAINSTRATION
1. In the developer tools, on the network tab, right click on this request and select "Open in new tab".
1. The result will be a text showing two values: id and name.
1. Take note of the value for id. We will be using it to call this script.
1. Repeat the above steps to get the destination station id number.
1. Place the script in a directory reachable by Home-assistant user. 
1. Make it executable: 'chmod +x /path/to/train-in-time.sh'

## For hass.io
Place the script at the /config/scripts/ directory.

## Change your configuration.yaml

In your configuration.yaml add the following command_line sensor:
'sensor:
  - platform: command_line
    name: "Is my train on time?"
    command: "/path/to/is-next-train-on-time.sh YOURTRAINSTRATIONID DESTINATIONSTATION"'
(If you already have a 'sensor:' section, just remove this part and add it there.)
