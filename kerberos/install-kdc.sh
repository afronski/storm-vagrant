cp /vagrant/kerberos/krb5.conf /etc/
mkdir /etc/krb5kdc
cp /vagrant/kerberos/kdc.conf /etc/krb5kdc/


cp /vagrant/kerberos/70-disable-random-entropy-estimation.rules /etc/udev/rules.d/70-disable-random-entropy-estimation.rules
udevadm control --reload-rules
udevadm trigger

sudo DEBIAN_FRONTEND=noninteractive apt-get install -y -qq krb5-kdc krb5-admin-server

sh /vagrant/kerberos/new_realm.sh


# Zookeeper (Will need one of these for each box in teh Zk ensamble)
sudo /usr/sbin/kadmin.local -q 'addprinc -randkey zookeeper/zookeeper.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/zk.keytab  zookeeper/zookeeper.witzend.com@WITZEND.COM"
# Nimbus
sudo /usr/sbin/kadmin.local -q 'addprinc -randkey nimbus/nimbus.witzend.com@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/storm.keytab nimbus/nimbus.witzend.com@WITZEND.COM"
# All UI and Supervisors
sudo /usr/sbin/kadmin.local -q 'addprinc -pw storm storm@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q 'change_password -pw storm storm@WITZEND.COM'
sudo /usr/sbin/kadmin.local -q "ktadd -k /tmp/storm.keytab storm@WITZEND.COM"

mkdir /vagrant/keytabs
cp /tmp/storm.keytab /vagrant/keytabs/
cp /tmp/zk.keytab /vagrant/keytabs/