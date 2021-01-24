# How to use
# "x" = Laufwerksbuchstabe; "computername" = Computername des zu erreichenden Computers bei Remote-Befehl

# zeige den Status der Bitlocker-Verschluesselung auf dem Laufwerk an
manage-bde -status "x"
# deaktiviere die Bitlocker-Verschluesselung auf dem Laufwerk
manage-bde off "x"
# starte die Bitlocker-Verschluesselung ohne Hardwaretest und fuege Wiederherstellungskennwort hinzu
manage-bde -on "x" -skiphardwaretest -recoverypassword
# gleicher Befehl wie oben als Remotebefehl. Nach dem -cn-Parameter kommt der Computername
manage-bde -on "x" -skiphardwaretest -recoverypassword -cn "computername"