rscriptfile <- "requiredfiles/timeapache.R"
library(RESS)

command1 <- essQuery("aq_udb -exp logsapache3:vector3", "--debug")

command2 <- essQuery("aq_udb -exp logsapache1:vector1 -sort pagecount -dec", "--debug")
command3 <- essQuery("aq_udb -exp logsapache4:vector4 -sort pagecount -dec", "--debug")
command4 <- essQuery("aq_udb -exp logsapache2:vector2 -sort pagecount -dec", "--debug")
command5 <- essQuery("ess task stream 125accesslogs '2014-12-07' '2014-12-07'","tail -5 | \\
logcnv -f,eok - -d ip:ip sep:' ' s:rlog sep:' ' s:rusr sep:' [' i,tim:time sep:'] \\\"' s,clf,hl1:req_line1 sep:'\\\" ' i:res_status sep:' ' i:res_size sep:' \\\"' s,clf:referrer sep:'\\\" \\\"' s,clf:user_agent sep:'\\\"' X | \\
cat -","#Rinclude ####")

print(command5)

print(command1)
print(command2)
print(command3)
print(command4)

source(rscriptfile, echo=FALSE)
# Turn echo to TRUE to make the output less results-oriented and easier to debug.
remove(rscriptfile)

