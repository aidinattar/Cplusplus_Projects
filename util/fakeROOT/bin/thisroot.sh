SOURCE=${BASH_ARGV[0]}
export SCRIPT_COM=`echo ${SOURCE}`
#echo "COM "${SCRIPT_COM}
export SCRIPT_DIR=`dirname ${SCRIPT_COM}`
#echo "DIR "${SCRIPT_DIR}
export SCRIPT_TOP=`dirname ${SCRIPT_DIR}`
#echo "TOP "${SCRIPT_TOP}
export OLD_ROOTSYS=`printenv | awk -F= '($1=="ROOTSYS"){print $2}'`
#if { ${ROOTSYS_OLD} == "" } then
#  export ROOTSYS_OLD=root
#end
export ROOTSYS=`${SCRIPT_DIR}/getAbsPath.sh ${SCRIPT_TOP}`

export OLD_PATH=${PATH}
export PATH=`printenv | awk -F= '($1=="OLD_PATH"){print $2}' | awk -F: '{for(i=1;i<=NF;++i)print $i}' | awk -v OLD_ROOTSYS="${OLD_ROOTSYS}" 'BEGIN{c=0} {if((match($i,OLD_ROOTSYS)==0)||(OLD_ROOTSYS=="")){if(c==1)printf(":"); printf($i); c=1}} END{print ""}'`
if [ ${PATH} != "" ] ; then
  export PATH=${PATH}":"
fi
export PATH=${PATH}${ROOTSYS}"/bin"

export OLD_LD_LIBRARY_PATH=${PATH}
export LD_LIBRARY_PATH=`printenv | awk -F= '($1=="OLD_LD_LIBRARY_PATH"){print $2}' | awk -F: '{for(i=1;i<=NF;++i)print $i}' | awk -v OLD_ROOTSYS="${OLD_ROOTSYS}" 'BEGIN{c=0} {if((match($i,OLD_ROOTSYS)==0)||(OLD_ROOTSYS=="")){if(c==1)printf(":"); printf($i); c=1}} END{print ""}'`
if [ ${LD_LIBRARY_PATH} != "" ] ; then
  export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}":"
fi
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}${ROOTSYS}"/lib"

#if { ${ROOTSYS_OLD} != "" } then
#  export OLD_PATH=`printenv | awk -F= '($1=="PATH"){print $2}'`
#  if ( ${OLD_PATH} == != ) then
#    export PATH=${ROOTSYS}/bin
#  else
#    export PATH=``
#  end
#end
