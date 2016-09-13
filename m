Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33424 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754771AbcIMRaV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Sep 2016 13:30:21 -0400
Received: by mail-pa0-f65.google.com with SMTP id h5so9463536pao.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Sep 2016 10:30:21 -0700 (PDT)
Message-ID: <1473787814.8047.8.camel@researchut.com>
Subject: possible odd acceleration scaling
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: linux-iio@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Date: Tue, 13 Sep 2016 23:00:14 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Srinivas and Others,

[Please CC me in replies. I'm not subscribed to the list]

This email is in regard to an odd behavior, we seems to have discovered with
iio-sensor-proxy version 1.2 and the iio driver in Linux, maybe particular to
the following driver.


rrs@learner:~$ lsusb 
Bus 003 Device 002: ID 8087:8000 Intel Corp. 
Bus 003 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 006: ID 048d:8350 Integrated Technology Express, Inc. 
Bus 001 Device 005: ID 0bda:b728 Realtek Semiconductor Corp. 
Bus 001 Device 004: ID 04f2:b40f Chicony Electronics Co., Ltd 
Bus 001 Device 003: ID 04f3:0303 Elan Microelectronics Corp. 
Bus 001 Device 002: ID 0bda:0129 Realtek Semiconductor Corp. RTS5129 Card Reader
Controller
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
2016-09-13 / 22:56:58 ♒♒♒  ☺  


rrs@learner:/sys/devices/pci0000:00/0000:00:14.0/usb1/1-8/1-
8:1.0/0003:048D:8350.0002/HID-SENSOR-200073.4.auto$ find iio\:device2/ -iname
"*scale*" -print -exec cat '{}' \;
iio:device2/in_accel_scale
0.009806
2016-09-13 / 22:37:29 ♒♒♒  ☺  


Machine: Lenovo Yoga 2 13.


For a background, please have a look at the github bug report.
https://github.com/hadess/iio-sensor-proxy/issues/100


If you need any information, please let me know. I'm not sure what other
information to provide upfront, that maybe be relevant.


- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJX2DemAAoJEKY6WKPy4XVpdVwP+QEgk8lQ4IyWwF65N0EwAubG
Pnbf9sKcQ/uy8AALsOMFXDp0YKt3zLJPZfdMthdWPN9KjzX5GB5euspmbtF5ds81
8ws4t1JVOvDK1IEmL8SNbk7Xe62Q1tzQ5UxYbsrchNbM8MnLPXQFc5g6rHIveun+
xkS19l+pziwH5PdulrvDj5S4Db0TIM1ICqDJON74+ufaZ4APsHpLQ2EAB65AQVfJ
c4DEpB8kIN1dtHwJYzt1ZowKbJiDytCnUGUkI2tRTkMkVlA6CG+w+GzRbBCJerGd
3GgXNcEB23oteM3V6Je2oLoiH5Wvp3unwBTQgsX2WRPfLb9EnUlcCQxTbb8eAmF/
9krmKmC6y9k1aLzp+CgpbV9l97rJROpnqiGdEZyNWvBIfhzaMaz5rXY/6QFTfOh6
3LznSfGrZghwFq0vELsUx93xxR7qWBBj1Ra8XfTX0ueOQmdDbkCW0jB16TDCsgnu
gOhultIlalnmCjOvz7xTnIYp2vbM6kpa85Vp0t4UTtDhDepJCBCohx0nqYWhel9I
4MCPbWPYb24X7+XEYFQsPO8W4wiEqcx8kGXv8bF94eGWHsJK47xvNdlKtDq4IL9k
vxaIIUhPauvgoHW9s15+AgZ/bn46Qnma4BTSTwL3fqNuElX98uIDNxJGbor63eo5
m6/0B4X6jy2HJgUpnwCb
=KDnB
-----END PGP SIGNATURE-----

