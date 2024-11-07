$computername = "testpc11"
# check bitlocker status on computer
#manage-bde -status -cn $computername
# start bitlocker encryption on computer
#manage-bde -on C: -skiphardwaretest -recoverypassword -cn $computername
# start bitlocker decryption on computer
#manage-bde -off C: -cn $computername
# get bitlocker recovery key of computer
#manage-bde -protectors -get C: -type recoverypassword -cn $computername
# write bitlocker key of computer $computername to active directory
#manage-bde -protectors -adbackup C: -id {5C137DFA-87B9-4AA3-8C1A-F265B6263860} -cn $computername