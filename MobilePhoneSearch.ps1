<#
This script assumes a SQL query using the custom SQL-Query function (which doesn't require SQLServer tools being installed on the host machine)
It also assumes that you are specifically seeking a database named "ADP"
- replacing default <ADP> or <servername> values prior to use is a must
- you will also (quite likely) need to modify your Table/Column names in the $Query variables so this script is able to query correctly
- the user account used to launch the powershell instance must have at least read permissions on the database and table
#>
Function Show-Menu
{
    param (
        [string]$Title = 'Mobile Phone Search'
    )
    Clear-Host
    Write-Host "========== $Title =========="

    Write-Host "1: Press '1' to search by username."
    Write-Host "2: Press '2' to search by display name."
    Write-Host "3: Press '3' to search by Office location."
    Write-Host "Q: Press 'Q' to quit."
}

do
{

    Show-Menu
    $selection = Read-Host "Please make a selection"
    switch($selection)
    {
    '1' {
    'You chose to search by username'

    $uname = Read-Host "Enter username to search"
$Query = "SELECT

      [status_worker]
      ,[name_family]
      ,[name_given]
      ,[name_middle]
      ,[job_location]
      ,[login_name]
      ,[division]
      ,[phone_cell]
      ,[email_personal]
      ,[name_display]
  FROM [ADP].[dbo].[vw_current_employees_list] with (NoLock)
  Where phone_cell is not NULL and status_worker = 'ACTIVE'"

  $results = SQL-Query -Instance <servername> -Database "<ADP>" -Query $Query

  $cell = $results.Results | Select-Object name_display,login_name,job_location,phone_cell

$cell | Write-Output | Where {$_.login_name -like "*$uname*"}

    } '2' {
    'You chose to search by display name'

    $dn = Read-Host "Enter display name to search"
$Query = "SELECT

      [status_worker]
      ,[name_family]
      ,[name_given]
      ,[name_middle]
      ,[job_location]
      ,[login_name]
      ,[division]
      ,[phone_cell]
      ,[email_personal]
      ,[name_display]
  FROM [ADP].[dbo].[vw_current_employees_list] with (NoLock)
  Where phone_cell is not NULL and status_worker = 'ACTIVE'"

  $results = SQL-Query -Instance <servername> -Database "<ADP>" -Query $Query

  $cell = $results.Results | Select-Object name_display,login_name,job_location,phone_cell

$cell | Write-Output | Where {$_.name_display -like "*$dn*"}

    } '3' {
    'You chose to search by Office location'

    $office = Read-Host "Enter Office location to search employees"
$Query = "SELECT

      [status_worker]
      ,[name_family]
      ,[name_given]
      ,[name_middle]
      ,[job_location]
      ,[login_name]
      ,[division]
      ,[phone_cell]
      ,[email_personal]
      ,[name_display]
  FROM [ADP].[dbo].[vw_current_employees_list] with (NoLock)
  Where phone_cell is not NULL and status_worker = 'ACTIVE'"

  $results = SQL-Query -Instance <servername> -Database "<ADP>" -Query $Query

  $cell = $results.Results | Select-Object name_display,login_name,job_location,phone_cell

$cell | Write-Output | Where {$_.job_location -like "*$office*"}

    } 
    }
    pause
}
until ($selection -ne $null)
