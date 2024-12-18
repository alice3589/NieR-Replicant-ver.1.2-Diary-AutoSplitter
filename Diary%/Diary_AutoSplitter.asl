state("NieR Replicant ver.1.22474487139", "1.00")
{
    byte Loading: 0x00EE29B0, 0xD4;
    string32 Event: 0x15C3163;
    string32 characterName: 0x43727BC;
    string32 nameInput: 0x017B6EB0, 0x58, 0x710, 0x7E0;
    string32 question: 0x017B6EB0, 0x58, 0x710, 0x6E0;
}

state("NieR Replicant ver.1.22474487139", "1.03")
{
    byte Loading: 0x00EE49C0, 0xD4;
    string32 Event: 0x15C53F3;
    string32 characterName: 0x437DCAC;
    string32 nameInput: 0x017B9140, 0x58, 0x710, 0x7E0;
    string32 question: 0x017B9140, 0x58, 0x710, 0x6E0;
}

init
{
    byte[] exeMD5HashBytes = new byte[0];
    using (var md5 = System.Security.Cryptography.MD5.Create())
    {
        using (var s = File.Open(modules.First().FileName, FileMode.Open, FileAccess.Read, FileShare.ReadWrite))
        {
            exeMD5HashBytes = md5.ComputeHash(s); 
        }
    }
    var MD5Hash = exeMD5HashBytes.Select(x => x.ToString("X2")).Aggregate((a, b) => a + b);

    print("hashy boi is: " + MD5Hash);
    switch (MD5Hash) {
        case "3306698C51503A7783BD401712d9AC6C":
            version = "1.00";
            break;
        case "E5411222E5247B981EF2B1FC219B770A":
            version = "1.03";
            break;
        case "89E4C3D0AF6C86DB2312FB911DAFEC91":
            version = "1.03";
            break;
    }
    print("ModuleMemorySize: " + modules.First().ModuleMemorySize.ToString());

    vars.hasSplitTriggered = false; 
    vars.splitCounter = 0;         
}

start
{
    return current.Loading > 4;
}

split
{
    if (current.Loading > 4 && !vars.hasSplitTriggered)
    {
        if (vars.splitCounter < 2)
        {
            vars.splitCounter++;    
            return false;           
        }

        vars.hasSplitTriggered = true; 
        return true;                   
    }

    if (current.Loading <= 4)
    {
        vars.hasSplitTriggered = false; 
    }

    return false;
}

isLoading
{
    return current.Loading > 4;
}
