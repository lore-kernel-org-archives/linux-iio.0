Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:36016 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbbLPWhH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2015 17:37:07 -0500
MIME-Version: 1.0
In-Reply-To: <CAKv63uvEKOycY2pPCRwVXvYR1yj8SbBaPJyw41_7mc4Vnftkew@mail.gmail.com>
References: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
	<CAEnQRZACu89UR2w=rN3mve8DFniqdf2=Y69FuBnoyXUber=kZA@mail.gmail.com>
	<CAOhV88PGnVWbnCjTf3W-jD22rtQYSXDVWez+gFkrPYky9kkQnw@mail.gmail.com>
	<CAKv63uvEKOycY2pPCRwVXvYR1yj8SbBaPJyw41_7mc4Vnftkew@mail.gmail.com>
Date: Wed, 16 Dec 2015 14:37:05 -0800
Message-ID: <CAOhV88OJZO_zO7WJ4WAvToAJGzcXp+zZ6y8v_xMeRgbBbhYrkg@mail.gmail.com>
Subject: Re: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Crt Mori <cmo@melexis.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Wed, Dec 16, 2015 at 2:22 PM, Crt Mori <cmo@melexis.com> wrote:
> On 16 December 2015 at 22:41, Nish Aravamudan <nish.aravamudan@gmail.com> wrote:
>> Hi Daniel,
>>
>> On Wed, Dec 16, 2015 at 1:43 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
>>> On Tue, Dec 15, 2015 at 9:19 PM, Nish Aravamudan
>>> <nish.aravamudan@gmail.com> wrote:
>>>> So, I apologize in advance for this relatively vague report, but I'm fairly sure
>>>> the Yoga 900 has an accelerometer amongst other sensors (ambient light?)
>>>> exported over IIO.
>>>>
>>>> But, these sensors seem to not be updating at all with a 4.4-rc5+ kernel (a
>>>> set of patches from https://lkml.org/lkml/2015/11/30/441 applied to Linus'
>>>> tree).
>>>>
>>>> The odd part is at some point in messing with this, I'm fairly sure it did work!
>>>> That is,
>>>>
>>>> `watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`
>>>
>>> Can you send us a sample of the output? Also, would be
>>> good to identify the exact driver for accel.
>>
>> cat /sys/bus/iio/devices/iio:device*/*raw*
>> 65478
>> 7
>> 1023
>> 0
>> 0
>> 0
>> 100
>> -539062
>> -742187
>> 1292968
>> 1592
>> 64932
>> 2
>> 275
>> 0 0 0 0
>>
>> Now, I should say that I distinctly remember at some point waving my
>> laptop around and seeing these values change ... but now they seem to
>> be "stuck". Maybe it's a hardware issue or something special that
>> WIndows does to leverage the IIO sensors?
>>
>>> Perhaps: cat /sys/bus/iio/devices/iio:device'*/name
>>
>> $ cat /sys/bus/iio/devices/iio:device*/name
>> accel_3d
>
> Can you list the directory of iio:device with this name (it is:
> drivers/iio/accel/hid-sensor-accel-3d.c).
> This is something you will be looking at for accel debugging, but it
> seems more like
> standard

/sys/bus/iio/devices/iio:device0/name
gyro_3d
/sys/bus/iio/devices/iio:device1/name
dev_rotation
/sys/bus/iio/devices/iio:device2/name
als
/sys/bus/iio/devices/iio:device3/name
magn_3d
/sys/bus/iio/devices/iio:device4/name
accel_3d
/sys/bus/iio/devices/iio:device5/name
incli_3d

are all the IIO sensors, sorry about that!

>> gyro_3d
>> als
>> magn_3d
>> incli_3d
>> dev_rotation
>>
>>
>>>>
>>>> showed updating values as I moved the laptop around.
>>>>
>>>> I've not done any accelerometer debugging before, so any suggestion on
>>>> where to start would be greatly appreciated!
>>>
>>> Did you applied some patches and recompiled the kernel? Or when it did stopped
>>> working?
>>
>> As far as I can tell, it only worked that one one time and hasn't
>> since. Although your question does make me wonder *which* kernel I was
>> on that I experienced the values changing. Let me go back to a stock
>> 4.4-rc5 and see.
>
> Did you compile the stock kernel? It might be that .dts file you are
> using (or defconfig)
> is not correct.

I compiled the stock kernel, based off the the Ubuntu 15.04 .config,
trimmed to account for the hardware I have on the system. I can attach
the .config if that will be useful.

I just went back to 4.4-rc4 and it also didn't seem to have any
updates to the raw file contents.

-Nish
