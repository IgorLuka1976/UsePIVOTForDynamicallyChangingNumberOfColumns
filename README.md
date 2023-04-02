# UsePIVOTForDynamicallyChangingNumberOfColumns
Usage PIVOT for dynamically changing number of columns

This option is used if it is necessary to add one column per day for a certain period of time.

In Example PriceByDateColumnsInDinamic.sql, we create listOFDays from period between startdate and enddate and save it in variable @listOFDays
, and list jf filter, which save in variable @filter.
Than, mail query executed used EXECUTE('SELECT ...'+@listOFDays+'...'+@filter+...)'
