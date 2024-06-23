Config = {}

Config.Debug                =       false               -- Debug Modus

Config.EKS                  =       true                -- Einkommenssteuer Aktiviert/Deaktiviert
Config.FZS                  =       true                -- Fahrzeugsteuer Aktiviert/Deaktiviert
Config.VS                   =       true                -- Vermögenssteuer Aktiviert/Deaktiviert

Config.EKSP                 =       18                  -- Einkommenssteuer Prozent

Config.FZSP                 =       33.29               -- Fahrzeugsteuer pro Fahrzeug

Config.VSP                  =       1                   -- Vermögenssteuer Prozent (Geldvermögen)
Config.VSPmin               =       600000              -- Vermögenssteuer aktiviert ab folgendem Geldvermögen

Config.Account              =       'bank'              -- Bank Account Name
Config.Reciever             =       'society_police'    -- Society Name der Fraktion die die Steuern erhalten soll

Config.Intervall            =       60                  -- Intervall zwischen jeder Steuer in Minuten