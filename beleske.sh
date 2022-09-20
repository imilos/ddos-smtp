#
# Milos Ivanovic, Septembar 2022.
#

#
# Izdvajanje IP-ova iz Postfix logova
#
cat /var/log/maillog | grep "authentication failed" | grep -E -o "\[([0-9]{1,3}[\.]){3}[0-9]{1,3}\]" > ips.txt
#
# Skidanje zagrada
#
sed -i -e "s/\[//g" ips.txt
sed -i -e "s/\]//g" ips.txt
#
# Izdvajanje timestamp-ova u odgovarajucem formatu
#
cat /var/log/maillog | grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | grep "authentication failed" | awk '{print "2022-" $1"-"$2" "$3}' > ts.txt
#
# Spajanje Timestamp i IP u jedan CSV
#
echo "Timestamp,IP" > napadi_smtp1.txt
paste -d"," ts.txt ips.txt >> napadi_smtp1.txt

