# Oblig 3 IMT2282

## Bemerkelser

* Erstattet alle norske bokstaver med sine engelske-alfabetiske varianter, da Windows ikke virker særlig god på norsk.
* Brukte kortversjonen av ulike kommandoer i "task13_10b.ps1" da oppgaven gikk ut på å få det så kort som mulig. På grunn av dette vil analysen vise tre advarsler. Jeg har lagt til en løsning som analysen liker i en kommentar.

## Kvalitetsikring

Brukte "https://github.com/PowerShell/PSScriptAnalyzer" til kvalitetsikring av koden. Installerte og kjørte som beskrevet her: <https://github.com/NTNUcourses/opsys/blob/master/README-PowerShell-code-quality.txt>

For å kjøre kvalitetsjekk selv; kjør disse kommandoene (én per script):

```
Invoke-ScriptAnalyser task11_7b.ps1
Invoke-ScriptAnalyser task12_4d.ps1
Invoke-ScriptAnalyser task13_10b.ps1
```
