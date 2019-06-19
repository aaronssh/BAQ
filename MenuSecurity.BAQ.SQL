select 
	[Security].[SecCode] as [Security_SecCode],
	[Security].[Description] as [Security_Description],
	((case when Security.EntryList LIKE ('%'+ @UserToCopyFrom + '%') /* when the list contains UserToCopyFrom */
 then
 replace(
   replace(
     replace(
       replace(Security.EntryList,',','~')                     /* replaces the commas with tildes to be usable by DMT */
       ,('~' + @UserToCopyTo),'')                              /* delete ~user if it exists */
       ,(@UserToCopyTo + '~'),'')                              /* delete user~ if it exists */
     , @UserToCopyFrom,@UserToCopyFrom + '~' + @UserToCopyTo)  /* adds in the UserToCopyTo to the list */
     else replace(Security.EntryList,',','~') end)) as [Calculated_NewEntryList],
	((case when Security.NoEntryList LIKE ('%'+ @UserToCopyFrom + '%') /* when the list contains UserToCopyFrom */
 then
 replace(
   replace(
     replace(
       replace(Security.NoEntryList,',','~')                     /* replaces the commas with tildes to be usable by DMT */
       ,('~' + @UserToCopyTo),'')                              /* delete ~user if it exists */
       ,(@UserToCopyTo + '~'),'')                              /* delete user~ if it exists */
     , @UserToCopyFrom,@UserToCopyFrom + '~' + @UserToCopyTo)  /* adds in the UserToCopyTo to the list */
     else replace(Security.NoEntryList,',','~') end)) as [Calculated_NewNoEntryList]
from ICE.Security as Security
where (Security.EntryList <> '*'  and Security.EntryList <> '')
