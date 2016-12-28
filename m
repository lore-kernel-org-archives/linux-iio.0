Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:34140 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751338AbcL1Lii (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 06:38:38 -0500
Received: by mail-pf0-f175.google.com with SMTP id c4so58721340pfb.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 03:38:38 -0800 (PST)
Message-ID: <1482925101.8484.1.camel@researchut.com>
Subject: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Wed, 28 Dec 2016 17:08:21 +0530
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hello Srini,

Regarding: https://www.spinics.net/lists/linux-input/msg48540.html

This patch does not seem to fix the issue entirely. On my machine, where on
previous kernels from 4.7 and 4.8 worked fine, this patch hasn't made much
difference on 4.9.

rrs@learner:~$ lspci
00:02.0 VGA compatible controller: Intel Corporation Haswell-ULT Integrated
Graphics Controller (rev 0b)
00:03.0 Audio device: Intel Corporation Haswell-ULT HD Audio Controller (rev 0b)
00:14.0 USB controller: Intel Corporation 8 Series USB xHCI HC (rev 04)
00:16.0 Communication controller: Intel Corporation 8 Series HECI #0 (rev 04)
00:1b.0 Audio device: Intel Corporation 8 Series HD Audio Controller (rev 04)
00:1c.0 PCI bridge: Intel Corporation 8 Series PCI Express Root Port 4 (rev e4)
00:1d.0 USB controller: Intel Corporation 8 Series USB EHCI #1 (rev 04)
00:1f.0 ISA bridge: Intel Corporation 8 Series LPC Controller (rev 04)
00:1f.2 SATA controller: Intel Corporation 8 Series SATA Controller 1 [AHCI
mode] (rev 04)
00:1f.3 SMBus: Intel Corporation 8 Series SMBus Controller (rev 04)
01:00.0 Network controller: Realtek Semiconductor Co., Ltd. RTL8723BE PCIe
Wireless Network Adapter
2016-12-28 / 17:07:16 ♒♒♒  ☺  
rrs@learner:~$ uname -a
Linux learner 4.9.0+ #1 SMP Mon Dec 26 14:20:36 IST 2016 x86_64 GNU/Linux
2016-12-28 / 17:07:24 ♒♒♒  ☺  



- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhjpC0ACgkQpjpYo/Lh
dWmnbBAAnzCzilRkwE1Oa0nANMvKC/YQJVV+dJeJq5XGAOks3Fe2goMTB4vcOSIj
Crt1f3JD+0H6aC7+JqdByPa6oxtXMCX8sX8zwhFkLkS6ExAheTtyuUFpZeGytU4G
e3Jm7dzWW6fa6MRTpSq8OwtdiMwBb3g6fe072npEheRuHEj5uex2AxzcHmP/DOiD
ErTTLxY4ItcvZQURybWdsdOrVoWdh7uZj+KiQcBfNQvzQLpdDdL2ZfxGnt2Dsk2e
PPNI7qyq2rYb+iA9U+65zKLQr8k6Q8y+MM9NqDKWDmhF6Jft9AKZIylwpUeN9/B/
m5g6b7NmwPQo8vdJdwfCJKusHrUp6WQ9Y2SOVJN9k4D8/lJepSfbL5MdX2A9KS1z
clYwTDKVEWNsAWlahdDraZRujLhx3vBoMMESDGia/j4xrEMfOe26XclTp1rynopD
oCW62UDugIm+l6GRjAfehYoPXtDSyBKTauW3LAZvUAELOvZX5T0SZqKJjbJmsp5m
Wpwva9XNlX4N8g36BdUv04hbWxqbbNANGu8dO8Y+MSmMZRmYC2f2f+qY7s2711Dt
Bc/5g8nLv602tkQbXm8hr66H/QKpivxn0oSbST3UHFzRlHUt9+k5LEIdezJwQ1RL
1fp6+9jc507TXMbId5GarYOwQHkLoBEIDPxQ6eTAEdo0rnQ7/PI=
=bCkL
-----END PGP SIGNATURE-----

