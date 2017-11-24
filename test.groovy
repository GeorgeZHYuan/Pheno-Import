def sout = new StringBuilder(), serr = new StringBuilder()
def proc = './pheno-import.sh'.execute()
proc.consumeProcessOutput(sout, serr)
proc.waitForOrKill(5000)
println "out> $sout. err> $serr"
