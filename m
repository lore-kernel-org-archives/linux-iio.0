Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:33729 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966040AbbLPVl2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Dec 2015 16:41:28 -0500
MIME-Version: 1.0
In-Reply-To: <CAEnQRZACu89UR2w=rN3mve8DFniqdf2=Y69FuBnoyXUber=kZA@mail.gmail.com>
References: <CAOhV88NP+bpN6oVk3_DbszNqKAo4T9z-umfVQAcyS3QArwguTA@mail.gmail.com>
	<CAEnQRZACu89UR2w=rN3mve8DFniqdf2=Y69FuBnoyXUber=kZA@mail.gmail.com>
Date: Wed, 16 Dec 2015 13:41:27 -0800
Message-ID: <CAOhV88PGnVWbnCjTf3W-jD22rtQYSXDVWez+gFkrPYky9kkQnw@mail.gmail.com>
Subject: Re: Issues with Lenovo Yoga 900 IIO devices (accelerometer, etc.)
From: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Daniel,

On Wed, Dec 16, 2015 at 1:43 AM, Daniel Baluta <daniel.baluta@gmail.com> wrote:
> On Tue, Dec 15, 2015 at 9:19 PM, Nish Aravamudan
> <nish.aravamudan@gmail.com> wrote:
>> So, I apologize in advance for this relatively vague report, but I'm fairly sure
>> the Yoga 900 has an accelerometer amongst other sensors (ambient light?)
>> exported over IIO.
>>
>> But, these sensors seem to not be updating at all with a 4.4-rc5+ kernel (a
>> set of patches from https://lkml.org/lkml/2015/11/30/441 applied to Linus'
>> tree).
>>
>> The odd part is at some point in messing with this, I'm fairly sure it did work!
>> That is,
>>
>> `watch -n 0.1 cat '/sys/bus/iio/devices/iio:device'*/*raw*`
>
> Can you send us a sample of the output? Also, would be
> good to identify the exact driver for accel.

cat /sys/bus/iio/devices/iio:device*/*raw*
65478
7
1023
0
0
0
100
-539062
-742187
1292968
1592
64932
2
275
0 0 0 0

Now, I should say that I distinctly remember at some point waving my
laptop around and seeing these values change ... but now they seem to
be "stuck". Maybe it's a hardware issue or something special that
WIndows does to leverage the IIO sensors?

> Perhaps: cat /sys/bus/iio/devices/iio:device'*/name

$ cat /sys/bus/iio/devices/iio:device*/name
accel_3d
gyro_3d
als
magn_3d
incli_3d
dev_rotation


>>
>> showed updating values as I moved the laptop around.
>>
>> I've not done any accelerometer debugging before, so any suggestion on
>> where to start would be greatly appreciated!
>
> Did you applied some patches and recompiled the kernel? Or when it did stopped
> working?

As far as I can tell, it only worked that one one time and hasn't
since. Although your question does make me wonder *which* kernel I was
on that I experienced the values changing. Let me go back to a stock
4.4-rc5 and see.

-Nish
