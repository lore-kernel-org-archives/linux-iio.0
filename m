Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36116 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750976AbcL1Rhr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 12:37:47 -0500
Received: by mail-pf0-f194.google.com with SMTP id c4so19759467pfb.3
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 09:37:46 -0800 (PST)
Message-ID: <1482946633.12558.1.camel@researchut.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Wed, 28 Dec 2016 23:07:13 +0530
In-Reply-To: <1482945855.8484.8.camel@researchut.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
         <1482945855.8484.8.camel@researchut.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, 2016-12-28 at 22:54 +0530, Ritesh Raj Sarraf wrote:
> Device4, for which there are no x, y, z attributes, reports the name
> "dev_rotation".
> Even for the other devices, I see no change in the reported values.

On the 4.8 kernel, the values do change. The iio-sensor-proxy still does not do
the rotation.

rrs@learner:/sys/bus/iio/devices$ while true; do for x in iio*; do echo -en
"Device: $x\t `cat $x/*[x-z]_raw`\n"; done; echo -en "sleep 2 secs\n\n"; sleep
2;  done
Device: iio:device0	 616
6
3570
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 111905
- -44762
- -22381
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1625000
402343
- -2531250
sleep 2 secs

Device: iio:device0	 616
6
3570
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 22381
0
0
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1632812
402343
- -2531250
sleep 2 secs

Device: iio:device0	 542
65503
3599
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 -111905
- -2887161
4274790
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1625000
429687
- -2511718
sleep 2 secs

Device: iio:device0	 94
64699
425
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 693814
- -223811
1589058
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1539062
492187
- -2523437
sleep 2 secs

Device: iio:device0	 145
893
2676
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 -738576
872862
- -6065278
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1503906
230468
- -2609375
sleep 2 secs

Device: iio:device0	 488
808
2692
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 2551445
- -3536213
14592477
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1597656
222656
- -2621093
sleep 2 secs

Device: iio:device0	 64240
750
2437
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 2663350
- -581908
3021448
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1488281
347656
- -2601562
sleep 2 secs

Device: iio:device0	 63984
891
2470
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 -358097
402859
- -828100
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1468750
375000
- -2601562
sleep 2 secs

Device: iio:device0	 1637
64842
524
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 11548647
2663350
- -16606776
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1441406
50781
- -2585937
sleep 2 secs

Device: iio:device0	 649
642
2564
cat: 'iio:device1/*[x-z]_raw': No such file or directory
Device: iio:device1	 
Device: iio:device2	 -5237177
- -2126204
19225364
cat: 'iio:device3/*[x-z]_raw': No such file or directory
Device: iio:device3	 
Device: iio:device4	 27
64861
65298
Device: iio:device5	 -1652343
210937
- -2570312
sleep 2 secs

^C
2016-12-28 / 23:01:36 ♒♒♒  ☹  => 130  
(reverse-i-search)`name': quilt rename data-Fix-compass-property-^Cme.patch2016-
12-28 / 23:01:54 ♒♒♒  ☹  => 130  

rrs@learner:/sys/bus/iio/devices$ cat iio\:device*/name
incli_3d
als
gyro_3d
dev_rotation
accel_3d
magn_3d
2016-12-28 / 23:02:35 ♒♒♒  ☺  

rrs@learner:/sys/bus/iio/devices$ uname -a
Linux learner 4.8.15+ #47 SMP Wed Dec 21 14:19:46 IST 2016 x86_64 GNU/Linux
2016-12-28 / 23:02:41 ♒♒♒  ☺  


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhj+EkACgkQpjpYo/Lh
dWlAFhAAk882ZoICevpQH3kZ47WJKE/yrtOVQwmyxrkHa7kxWZVAfbZcr+Vlhktt
GIa8zM/rZ7TXwy794iEZMvTR5f6ZGMojHLuKRBdvnEr7lYHg/7396Rrw5mlOWhmS
/8B99ERQnDzmKExXcLts+4V6WbsWxJJlI4oNsaLn8vybZEImniDySqIehhKUEPtX
escMhgAdgcpmbps2oJYfQ6Oa4kOQjx34KeTPIUBaLHyd89jYYwygWG0K8oQpfMuG
tLcPrXOpgNBvyr4FHsHWhC9IYHIUArmKzyADnkaRJSbKjH/vh5lFw2FsjFNK2V2f
/fyy0hO5AqLluE1/dDERejekm+0uQ9TAlWouvRfvgtaSeoTgTuFmce51tp8An/wq
nzFBJJl085EgBby1NO2NJQwOd/Uh4TD3UBHIb5D8azlVXeN0his6ETWPQs00HHvn
PUNQVYXxEXtzZPkWrUCMNFVktRS8kCNmp/Hty655Wkj+jNF54/JHAb/1jD1ak9nQ
N0eTEBqHsthcZuSStmtsEfIZ0MybCY6xrqFc+uyoYvp3crqi4IPi96tlblU2lDiJ
loceFx+Ks+Y1Kj31D/zKvIKuYDEtQH6VZMzbvDaCgmCDnhoHctXVIfT8hhbSur5V
ubhHAx72xu5BFVzxJ3/0S685hVC1oBWq8fx/1lFsqA4GJILylJI=
=dKU5
-----END PGP SIGNATURE-----

