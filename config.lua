Config = {}

Config.EKS                  =       true            -- Einkommenssteuer Aktiviert/Deaktiviert
Config.FZS                  =       true            -- Fahrzeugsteuer Aktiviert/Deaktiviert
Config.GS                   =       false           -- BETA FEATURE: Grundsteuer Aktiviert/Deaktiviert (Funktioniert evtl. nicht)
Config.VS                   =       true            -- Vermögenssteuer Aktiviert/Deaktiviert

Config.EKSP                 =       18              -- Einkommenssteuer Prozent

Config.FZSP                 =       33.29           -- Fahrzeugsteuer pro Fahrzeug

Config.GSA                  =       670             -- Grundsteuer pro PROPERTY in Besitz

Config.VSP                  =       1               -- Vermögenssteuer Prozent (Geldvermögen)
Config.VSPmin               =       461354          -- Vermögenssteuer aktiviert ab folgendem Geldvermögen

Config.Bankaccount          =       'bank'          -- Bank Account Name
Config.Reciver              =       'society_gov'   -- Society Name der Fraktion die die Steuern erhalten soll

Config.Intervall            =       60              -- Intervall zwischen jeder Steuer in Minuten