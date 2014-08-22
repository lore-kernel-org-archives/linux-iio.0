Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vc0-f172.google.com ([209.85.220.172]:57732 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755868AbaHVLof convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Aug 2014 07:44:35 -0400
Received: by mail-vc0-f172.google.com with SMTP id im17so12270683vcb.3
        for <linux-iio@vger.kernel.org>; Fri, 22 Aug 2014 04:44:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+BWVUSvm54_xLeXGf0d5oo1-1DH_z=K1TFsrFLQHMBV_gA7gA@mail.gmail.com>
References: <CAN0s7yTK1_1u65nodysfiGxYbgKTeDS0Vf_+14KQJS92_Di1vg@mail.gmail.com>
	<CAN0s7yRwXGgPLhyucnR+=EybQFjunt66MKYvQuZnR_PSdgjS1Q@mail.gmail.com>
	<CA+BWVUSSO0kA1mW6BJ9F5VrZErK1D7YDOrA-gtuW5ZF3wNNZXA@mail.gmail.com>
	<CAN0s7yTYwEsu2uJ3kUjW-SsvoyqSXebNT3=1D1oNfdJwi=Q5Qw@mail.gmail.com>
	<CA+BWVUSZDb_+gtLY5JeryMMfYRrQCkdYBUfG9m3rzL1P9wawYg@mail.gmail.com>
	<CA+BWVUSvm54_xLeXGf0d5oo1-1DH_z=K1TFsrFLQHMBV_gA7gA@mail.gmail.com>
Date: Fri, 22 Aug 2014 14:44:34 +0300
Message-ID: <CAN0s7yT017sCS9K4q5avRBz5JM+Oj4RM-M8oYVStbWEDx1yWXg@mail.gmail.com>
Subject: Re: Resource Temporarily Unavailable error when trying to read from
 the accelerator on a ThinkPad twist
From: Elad Alfassa <elad@fedoraproject.org>
To: Reyad Attiyat <reyad.attiyat@gmail.com>
Cc: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Reyad!

I've preformed the steps to enable the scan elements and the buffer,
and when using `cat` on the character device I got some gibberish
(looked like ���� /���).

Here's the dmeg output: https://elad.fedorapeople.org/iio-debug/dmesg.txt
and here's the rdesc file: https://elad.fedorapeople.org/iio-debug/rdesc.txt

Furthermore, after preforming these steps, I tried to read the _raw files,
[root@rincewind iio:device3]# cat in_accel_*raw
-27
56
-974

According to the developer of iio-sensor-proxy the numbers should
always be lower than 400, and as you can see one of the raw values is
974

It seems that iio-sensor-proxy is getting EAGAIN when trying to read
the data, but I can still cat the raw files.
Examining the iio-sensor-proxy output it seems that it manages to read
the sensor data ONCE and then gets EAGAIN in all the following read
attempts.

** (process:2889): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.0/0003:0483:91D1.0003/HID-SENSOR-200073.1.auto/iio:device3
** (process:2889): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.5/2-1.5:1.0/0003:0483:91D1.0003/HID-SENSOR-200073.1.auto/trigger3
** (process:2889): DEBUG: Got type for in_accel_x: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2889): DEBUG: Got type for in_accel_y: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2889): DEBUG: Got type for in_accel_z: is signed: 1,
bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2889): DEBUG: Built channel array for in_accel_x: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2889): DEBUG: Built channel array for in_accel_y: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2889): DEBUG: Built channel array for in_accel_z: is
signed: 1, bytes: 4, bits_used: 32, shift: 0, mask: 0x0, be: 0
** (process:2889): DEBUG: Read from IIO: 18, -51, -976
** (process:2889): DEBUG: Found orientation: undefined, prev:undefined

** (process:2889): WARNING **: Couldn't read from device: Resource
temporarily unavailable
** (process:2889): DEBUG: Found orientation: undefined, prev:undefined

** (process:2889): WARNING **: Couldn't read from device: Resource
temporarily unavailable
** (process:2889): DEBUG: Found orientation: undefined, prev:undefined
^C


While trying to figure out what's going on, I tried to `cat` the _raw
files while iio-sensor-proxy was running, and I noticed that every
time I `cat` them, iio-sensor-proxy can read the data too!

So, we have two issues here:
1) The numbers returned from the raw file are "weird", as
iio-sensor-proxy expects them to be under 400
2) When iio-sensor-proxy is running it can't read the data until I
manually read the _raw files in a different terminal window, upon
which iio-sensor-proxy suddenly gets the data too.

I hope this helps debug the issue.

Do you think it's a driver problem, or is it iio-sensor-proxy doing
something wrong?

-- 
-Elad Alfassa.
