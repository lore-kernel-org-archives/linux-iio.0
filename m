Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34819 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbbJNUNL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2015 16:13:11 -0400
Received: by lffy185 with SMTP id y185so379460lff.2
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2015 13:13:09 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 14 Oct 2015 15:13:09 -0500
Message-ID: <CAF8px55G9aLXWcRKvhfAb7W=GUSbGn9TKdr_wnPyYiiTg-qG6w@mail.gmail.com>
Subject: iio: inv_mpu6050: client: Erratic data.
From: Mike Mestnik <cheako@mikemestnik.net>
To: linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This was taken with the tablet as still as I could without resorting
to using a vice and clamps.

How to know if this is kernel or app?

root@debian:~# G_MESSAGES_DEBUG=all /usr/sbin/iio-sensor-proxy | awk
'{ print strftime("%M:%S"), $0; fflush(); }'
00:21 ** (process:22742): DEBUG: Found accel_3d at
/sys/devices/pci0000:00/INT3432:00/i2c-7/i2c-INVN6500:00/iio:device0
00:21 ** (process:22742): DEBUG: Found device
/sys/devices/pci0000:00/INT3432:00/i2c-7/i2c-INVN6500:00/iio:device0
of type accelerometer at IIO Buffer accelerometer
00:21 ** (process:22742): DEBUG: Found associated trigger at
/sys/devices/pci0000:00/INT3432:00/i2c-7/i2c-INVN6500:00/trigger0
00:21 ** (process:22742): DEBUG: Got type for in_anglvel_x: is signed:
1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Got type for in_anglvel_y: is signed:
1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Got type for in_anglvel_z: is signed:
1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Got type for in_accel_x: is signed:
1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Got type for in_accel_y: is signed:
1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Got type for in_accel_z: is signed:
1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Got type for in_timestamp: is signed:
1, bytes: 8, bits_used: 64, shift: 0, mask: 0x18446744073709551615,
be: 0
00:21 ** (process:22742): DEBUG: Built channel array for in_anglvel_x:
is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Built channel array for in_anglvel_y:
is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Built channel array for in_anglvel_z:
is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Built channel array for in_accel_x:
is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Built channel array for in_accel_y:
is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Built channel array for in_accel_z:
is signed: 1, bytes: 2, bits_used: 16, shift: 0, mask: 0x65535, be: 1
00:21 ** (process:22742): DEBUG: Built channel array for in_timestamp:
is signed: 1, bytes: 8, bits_used: 64, shift: 0, mask:
0x18446744073709551615, be: 0
00:27 ** (process:22742): DEBUG: Handling driver refcounting method
'ClaimAccelerometer' for accelerometer device
00:27 ** (process:22742): DEBUG: Handling driver refcounting method
'ClaimLight' for ambient light sensor device
00:28 ** (process:22742): DEBUG: Read from IIO: 2304, -1, 1280
00:28 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): -1, 0, 0
00:28 ** (process:22742): DEBUG: Emitted orientation changed: from
undefined to left-up
00:29 ** (process:22742): DEBUG: Read from IIO: 3840, 2304, 2816
00:29 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): -2, -1, 1
00:29 ** (process:22742): DEBUG: Read from IIO: 1024, 512, -1281
00:29 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, 0
00:30 ** (process:22742): DEBUG: Read from IIO: 1536, -513, -2049
00:30 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, -1
00:31 ** (process:22742): DEBUG: Read from IIO: 1024, -1025, -1281
00:31 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, 0
00:31 ** (process:22742): DEBUG: Read from IIO: 1280, -1537, -1537
00:31 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, 0
00:32 ** (process:22742): DEBUG: Read from IIO: 1536, -1537, -1281
00:32 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, 0
00:33 ** (process:22742): DEBUG: Read from IIO: 768, 512, -2561
00:33 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, -1
00:34 ** (process:22742): DEBUG: Read from IIO: 2048, -513, -2049
00:34 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): -1, 0, -1
00:34 ** (process:22742): DEBUG: Read from IIO: 1280, -5121, -769
00:34 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 3, 0
00:34 ** (process:22742): DEBUG: Emitted orientation changed: from
left-up to normal
00:35 ** (process:22742): DEBUG: Read from IIO: 768, -513, -1025
00:35 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, 0
00:36 ** (process:22742): DEBUG: Read from IIO: 768, 2816, -513
00:36 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, -1, 0
00:36 ** (process:22742): DEBUG: Emitted orientation changed: from
normal to bottom-up
00:36 ** (process:22742): DEBUG: Read from IIO: 1024, 1280, -513
00:36 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, 0
00:37 ** (process:22742): DEBUG: Read from IIO: 1280, -4865, -2049
00:37 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 2, -1
00:37 ** (process:22742): DEBUG: Emitted orientation changed: from
bottom-up to normal
00:38 ** (process:22742): DEBUG: Read from IIO: 1536, 256, -769
00:38 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, 0, 0
00:38 ** (process:22742): DEBUG: Read from IIO: 2304, 7936, 1280
00:38 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): -1, -4, 0
00:38 ** (process:22742): DEBUG: Emitted orientation changed: from
normal to bottom-up
00:39 ** (process:22742): DEBUG: Read from IIO: 0, 4864, -5377
00:39 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): 0, -2, -3
00:40 ** (process:22742): DEBUG: Read from IIO: 2304, 10496, 0
00:40 ** (process:22742): DEBUG: Accel sent by driver (quirk applied): -1, -6, 0

The client reported the motion ?!correctly!?:
** Message: Accelerometer orientation changed: left-up
** Message: Accelerometer orientation changed: normal
** Message: Accelerometer orientation changed: bottom-up
** Message: Accelerometer orientation changed: normal
** Message: Accelerometer orientation changed: bottom-up


Patches applied, there are a few!
get them from here:
http://j.mp/1VSEEnK

Project link:
http://j.mp/1VST95v
