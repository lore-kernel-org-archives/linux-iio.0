Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35374 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751249AbcL1RYl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Dec 2016 12:24:41 -0500
Received: by mail-pg0-f66.google.com with SMTP id i5so16293568pgh.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 09:24:28 -0800 (PST)
Message-ID: <1482945855.8484.8.camel@researchut.com>
Subject: Re: sensor-hub: Move the memset to sensor_hub_get_feature()
From: Ritesh Raj Sarraf <rrs@researchut.com>
Reply-To: rrs@researchut.com
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>
Date: Wed, 28 Dec 2016 22:54:15 +0530
In-Reply-To: <1482943685.4497.19.camel@linux.intel.com>
References: <1482925101.8484.1.camel@researchut.com>
         <1482931381.8484.3.camel@researchut.com>
         <1482943685.4497.19.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

Hi Srinivas,

Thank you very much for the quick reply.

On Wed, 2016-12-28 at 08:48 -0800, Srinivas Pandruvada wrote:
> Hi Ritesh,
> On Wed, 2016-12-28 at 18:53 +0530, Ritesh Raj Sarraf wrote:
> > Oh! That did not include my usb listing. Please find it below. If you
> > need more
> > information, please tell me.
> > 
> 
> Did you pick up the latest iio-sensor-proxy? There was some changes
> required in that.
> 

I tested it with 2.0, which was release around 3 weeks ago. Since then, there's
been 1 single change from today. I've picked that up and am building it now.
I'll share results with the newer proxy daemon soon.

> Also check under /sys/bus/iio/devices/iio:device*
> cat the raw x, y z for accelerometer and check if they change.

Thanks for mentioning this. The output on my setup looks suspicious.


rrs@learner:/sys/bus/iio/devices$ while true; do for x in iio*; do echo -en "Device: $x\t `cat $x/*[x-z]_raw`\n"; done; echo -en "sleep 2 secs\n\n"; sleep 2;  done
Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

Device: iio:device0	 553
6
3561
Device: iio:device1	 -1644531
441406
- -2484375
cat: 'iio:device2/*[x-z]_raw': No such file or directory
Device: iio:device2	 
Device: iio:device3	 22381
- -22381
0
cat: 'iio:device4/*[x-z]_raw': No such file or directory
Device: iio:device4	 
Device: iio:device5	 15
64615
65220
sleep 2 secs

^C
2016-12-28 / 22:46:54 ♒♒♒  ☹  => 130  
rrs@learner:/sys/bus/iio/devices$ ls iio\:device2/
buffer/  in_intensity_both_raw    in_intensity_offset              in_intensity_scale  power/          subsystem@  uevent
dev      in_intensity_hysteresis  in_intensity_sampling_frequency  name                scan_elements/  trigger/
2016-12-28 / 22:47:08 ♒♒♒  ☺  

rrs@learner:/sys/bus/iio/devices$ cat iio\:device*/name
incli_3d
magn_3d
als
gyro_3d
dev_rotation
accel_3d
2016-12-28 / 22:47:29 ♒♒♒  ☺  

Device4, for which there are no x, y, z attributes, reports the name "dev_rotation".
Even for the other devices, I see no change in the reported values.

- -- 
Ritesh Raj Sarraf
RESEARCHUT - http://www.researchut.com
"Necessity is the mother of invention."
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAlhj9T8ACgkQpjpYo/Lh
dWkhgw/+Kthf+DDvsRlJNUrLGqzXqZnAOA7Eqpp1NeGXhoMOSzszh5biosrxzsUc
F99pBirxJ0E6RLHFIgTaX4BVy9KaRXH7bichOaRFn+BG7WgtxEJPtKbXxH0Wa/kQ
MhCK0HLgVxmNtlPX1fZW6AzrIV+mEGiXFf5pItcv6PpgATHTMZb98XCahnygzNnX
UZBBSRDcbOHKS8Fp3UER2IubuaBzn09x/5DsKwnaaOl6XILSG592fgY177vRcaq4
CH+UGLKal6YrAg/48e2Pi2G18RNWJiL2wDkqWL60wZB+++VGdseRmwdFAcrAPhQW
FPhwO1+/3cnbMx/lQn9DjwQ9ZhsA5t8JupEc5zzH60NFpTfgUOy8LWeGbvAQwsI9
hlknmMDBiaT6hoJmEKp4aSiwYrJFcuRgBqOiuAyhIp+nzh8FlJkvzfFSiOaWKuXp
wzsKRBfQ1CfbI9FqqL+tQiw4u98uR68itGIAnwWNdx8qXYlSPR0WZfc2AEQBlW4r
+AO8LhDS+5/0YRwfIvvMD2UCG4COEidZulC/Z/pHt5akv4AIc5JwAzII/EAQg8UF
5Fj9BMLkmoExTwrFeK6ylphhrAfmtKz1K6fdE72r6P3Fn/L+drv0KJuIWtrjaWBO
n4y5MSUPcJGOf0ykYLiBzXL7SEkz0g614ye1QFL5gpue+Kc2K6E=
=dV5z
-----END PGP SIGNATURE-----

