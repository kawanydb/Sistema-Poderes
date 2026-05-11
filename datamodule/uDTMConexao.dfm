object dtmConexao: TdtmConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 177
  Width = 286
  object conexaoDB: TFDConnection
    Params.Strings = (
      'Server=DC-TR-03-VM\SQLEXPRESS'
      'Database=SuperPoderes'
      'OSAuthent=Yes'
      'User_Name=sa'
      'Password=domtec@10'
      'DriverID=MSSQL')
    LoginPrompt = False
    Left = 64
    Top = 64
  end
  object FDScript1: TFDScript
    SQLScripts = <>
    Connection = conexaoDB
    Params = <>
    Macros = <>
    Left = 224
    Top = 72
  end
end
