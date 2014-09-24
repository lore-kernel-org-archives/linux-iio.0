Return-Path: <bruce.bushby@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1409142241110.15094@pmeerw.net>
References: <CAHvj1qauaxANPHaZo_WoeF7pSmXDzJ0YynOoW-Wvz6AvMEF-Jw@mail.gmail.com>
	<25e65d5c-2bfc-449c-93c4-111c3c766922@email.android.com>
	<alpine.DEB.2.01.1409142241110.15094@pmeerw.net>
Date: Wed, 24 Sep 2014 16:16:37 +0100
Message-ID: <CAHvj1qayzOJuWUFpzOebJz=NzJmkp2NTh2uSzGuTP=oprbqHTw@mail.gmail.com>
Subject: Re: Need some help porting IIO based driver from 3.4 to 3.16 kernel
From: bruce bushby <bruce.bushby@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi

Quick thank you to Peter and Jonathan for the pointers, worked like a charm.

A special thanks to Daniel Baluta for his help.


Bruce




On Sun, Sep 14, 2014 at 9:43 PM, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> Hello,
>
>> >I wanted to ask for some advice/pointers for porting this IIO based
>> >"imu" driver:
>> >https://android.googlesource.com/kernel/msm/+/android-msm-hammerhead-3.4-kk-fr2/drivers/staging/iio/imu/inv_mpu
>> >
>> >to a 3.16 kernel.
>> >
>> >I'm struggling to make sense of the header files in that the header
>> >names appear to have changed and the definitions are completely
>> >different.
>> >
>> >My compiles bombs with this message:
>> >
>> >  CC [M]  drivers/iio/imu/inv_mpu/inv_mpu_core.o
>> >In file included from drivers/iio/imu/inv_mpu/inv_mpu_core.c:31:0:
>> >drivers/iio/imu/inv_mpu/inv_mpu_iio.h:23:17: fatal error: iio.h: No
>> >such file or directory
>> > #include "iio.h"
>
> iio moved out of staging after 3.4
>
> try #include <linux/iio/iio.h>
>
>> >But my kernel has this "iio" header file:
>> >[bruce@build iio]$ pwd
>> >/home/bruce/buildroot/output/build/linux-3.16.2/drivers/iio
>> >[bruce@build iio]$ ls -l iio_core.h
>> >-rw-rw-r--. 1 bruce bruce 2155 Sep  6 00:37 iio_core.h
>> >[bruce@build iio]$
>> >
>> >
>> >So I'm guessing "iio.h" has evolved and is now "iio_core.h"? ....but
>> >they seem so different?
>> iio.h is now in include/linux/iio with a lot of the other headers...
>>
>>
>>
>>
>> >
>> >
>> >Any help/pointers much appreciated!!!
>> >
>> >
>> >Thanks
>> >Bruce
>> >--
>> >To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> >the body of a message to majordomo@vger.kernel.org
>> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
