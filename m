Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:32837 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbaINLV1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 07:21:27 -0400
Received: by mail-lb0-f181.google.com with SMTP id z11so3034697lbi.40
        for <linux-iio@vger.kernel.org>; Sun, 14 Sep 2014 04:21:25 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 14 Sep 2014 12:21:25 +0100
Message-ID: <CAHvj1qauaxANPHaZo_WoeF7pSmXDzJ0YynOoW-Wvz6AvMEF-Jw@mail.gmail.com>
Subject: Need some help porting IIO based driver from 3.4 to 3.16 kernel
From: bruce bushby <bruce.bushby@gmail.com>
To: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

I wanted to ask for some advice/pointers for porting this IIO based
"imu" driver:
https://android.googlesource.com/kernel/msm/+/android-msm-hammerhead-3.4-kk-fr2/drivers/staging/iio/imu/inv_mpu

to a 3.16 kernel.

I'm struggling to make sense of the header files in that the header
names appear to have changed and the definitions are completely
different.

My compiles bombs with this message:

  CC [M]  drivers/iio/imu/inv_mpu/inv_mpu_core.o
In file included from drivers/iio/imu/inv_mpu/inv_mpu_core.c:31:0:
drivers/iio/imu/inv_mpu/inv_mpu_iio.h:23:17: fatal error: iio.h: No
such file or directory
 #include "iio.h"


But my kernel has this "iio" header file:
[bruce@build iio]$ pwd
/home/bruce/buildroot/output/build/linux-3.16.2/drivers/iio
[bruce@build iio]$ ls -l iio_core.h
-rw-rw-r--. 1 bruce bruce 2155 Sep  6 00:37 iio_core.h
[bruce@build iio]$


So I'm guessing "iio.h" has evolved and is now "iio_core.h"? ....but
they seem so different?


Any help/pointers much appreciated!!!


Thanks
Bruce
