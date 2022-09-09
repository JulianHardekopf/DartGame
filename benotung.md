
# Benotung von Julian Hardekopf

- 30% => Mitarbeit Praktikum (Anwesenheit + Testergebnisse): 1,00
- 50% => Projekt (Mittelwert der folgenden Einzelnoten): Dokumentation=1,30; Code Game=2,00; Backend=3,00; Pipeline=3,00
- 20% => Kreativität/Spielspaß: 3,00

Rechnerische Note: 2,06 => __Gegebene Note: 2,00__

Anmerkungen:

- Kapitelabfolge der Wiki-Dokumentation etwas durcheinander. Nur wirklich gut als PDF zu lesen.
- Die Klasse Patform im Model nutzt querySelector, DivElement, etc.. Player-Klasse des Models regeistiert Listener => Beides klarer Verstoß gegen MVC..
- Controller arbeitet hardcodiert mit http://localhost:5000/leaderboard. D.h. das Backend funktioniert nur lokal aber nicht im Cluster! Auch wenn das Backend erfolgreich gebaut und deplot wird.
- Ingress wird nicht für REST-API eingerichtet und funktioniert auch nicht für das Game. Beide Ingress werden aber für ein funktionierendes Backend im Cluster benötigt.
- Spiel erscheint mir noch etwas "buggy" zu sein. Der Jumper fing mehrmals an wie verrückt auf und ab zu hüpfen und ließ sich nicht mehr steuern. Backend konnte nur lokal getest werden.
