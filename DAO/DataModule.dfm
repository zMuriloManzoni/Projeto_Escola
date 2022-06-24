object dmPrincipal: TdmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 207
  Width = 256
  object conConnect: TFDConnection
    Params.Strings = (
      
        'Database=D:\ProjetoEscola\Win32\Debug\DataBase\PROJETO_ESCOLA.FD' +
        'B'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=LocalHost'
      'Port=3050'
      'DriverID=FB')
    Connected = True
    Left = 112
    Top = 88
  end
end
