Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53763 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbaINLi2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Sep 2014 07:38:28 -0400
In-Reply-To: <CAHvj1qauaxANPHaZo_WoeF7pSmXDzJ0YynOoW-Wvz6AvMEF-Jw@mail.gmail.com>
References: <CAHvj1qauaxANPHaZo_WoeF7pSmXDzJ0YynOoW-Wvz6AvMEF-Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: Need some help porting IIO based driver from 3.4 to 3.16 kernel
From: Jonathan Cameron <jic23@kernel.org>
Date: Sun, 14 Sep 2014 12:38:22 +0100
To: bruce bushby <bruce.bushby@gmail.com>, linux-iio@vger.kernel.org
Message-ID: <25e65d5c-2bfc-449c-93c4-111c3c766922@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On September 14, 2014 12:21:25 PM GMT+01:00, bruce bushby <bruce.bushby@gmail.com> wrote:
>Hi
>
>I wanted to ask for some advice/pointers for porting this IIO based
>"imu" driver:
>https://android.googlesource.com/kernel/msm/+/android-msm-hammerhead-3.4-kk-fr2/drivers/staging/iio/imu/inv_mpu
>
>to a 3.16 kernel.
>
>I'm struggling to make sense of the header files in that the header
>names appear to have changed and the definitions are completely
>different.
>
>My compiles bombs with this message:
>
>  CC [M]  drivers/iio/imu/inv_mpu/inv_mpu_core.o
>In file included from drivers/iio/imu/inv_mpu/inv_mpu_core.c:31:0:
>drivers/iio/imu/inv_mpu/inv_mpu_iio.h:23:17: fatal error: iio.h: No
>such file or directory
> #include "iio.h"
>
>
>But my kernel has this "iio" header file:
>[bruce@build iio]$ pwd
>/home/bruce/buildroot/output/build/linux-3.16.2/drivers/iio
>[bruce@build iio]$ ls -l iio_core.h
>-rw-rw-r--. 1 bruce bruce 2155 Sep  6 00:37 iio_core.h
>[bruce@build iio]$
>
>
>So I'm guessing "iio.h" has evolved and is now "iio_core.h"? ....but
>they seem so different?
iio.h is now in include/linux/iio with a lot of the other headers...




>
>
>Any help/pointers much appreciated!!!
>
>
>Thanks
>Bruce
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
