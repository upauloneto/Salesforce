//SOQL Child to Parent

for(Contact objContact: [SELECT Id, LastName, AccountId, Account.Name FROM Contact])
{
  system.debug('==== Filho ===='+objContact.Account.Name);
}

//SOQL Parent to child

for(Account objAccount: [SELECT Id, Name, (SELECT Id, LastName FROM Contacts)  FROM Account])
{
    for(Contact objContact: objAccount.Contacts)
    {
       system.debug('==== Pai ===='+objContact);
    }
 }