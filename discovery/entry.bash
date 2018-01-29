#!/bin/bash

#start lldp daemon
lldpd -dd &
mv -f /usr/bin/ipmitool /usr/bin/ipmitool.real
cat > /usr/bin/ipmitool <<EOF
#!/bin/bash
OUTPUT=\$(mktemp)
/usr/bin/ipmitool.real \$@ > \$OUTPUT
REALEXIT=\$?
EXIT=\$REALEXIT
if [ \$REALEXIT -ne 0 ]; then
        grep -A1 "Mezz Slot" \$OUTPUT | grep -q "Device not present"
        if [ \$? -eq 0 ]; then
                EXIT=0
        fi
        grep -A1 "FRU Device Description" \$OUTPUT | grep -q "Device not present"
        if [ \$? -eq 0 ]; then
                EXIT=0
        fi
fi
cat \$OUTPUT
rm -f \$OUTPUT
exit \$EXIT
EOF
chmod 755 /usr/bin/ipmitool

curl -s http://$SERVER:$PORT/api/current/tasks/bootstrap.js?macAddress=$MAC | node > /tmp/bootstrap.log
exit $?
