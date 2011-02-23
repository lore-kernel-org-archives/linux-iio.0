Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4D64EABA.2030005@cam.ac.uk>
References: <1297863769-24022-1-git-send-email-michael.hennerich@analog.com>
 <4D63D049.7040100@cam.ac.uk> <AANLkTikKRR4JOxS0e_7ezZu-AvN4d9=vtE2BEW=mq4yj@mail.gmail.com>
 <4D64EABA.2030005@cam.ac.uk>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Wed, 23 Feb 2011 13:00:01 -0500
Message-ID: <AANLkTinRGtPvZNNXPStSnhCwDmhUiN5gCK+u86YjOvkb@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH] IIO: trigger: New Blackfin
 specific trigger driver iio-trig-bfin-timer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	drivers@analog.com, device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Feb 23, 2011 at 06:08, Jonathan Cameron wrote:
> On 02/22/11 22:35, Mike Frysinger wrote:
>> On Tue, Feb 22, 2011 at 10:03, Jonathan Cameron wrote:
>>> On 02/16/11 13:42, michael.hennerich@analog.com wrote:
>>>> This driver allows any Blackfin system timer to be used as IIO trigger=
.
>>>> It supports trigger rates from 0 to 100kHz in Hz resolution.
>>>
>>> The reason we ended up with a rtc based trigger in the first place, was=
 that
>>> I had a very similar set of timers on the pxa271 that I mainly develop =
with.
>>>
>>> At the time some debate opened up on whether there was a use case here =
for
>>> a more general way of providing access to system periodic timers for ex=
actly
>>> this sort of device. =C2=A0The view seemed to be that there was, but I =
certainly didn't
>>> have time to do it at the time and no one else seems to have looked at =
it since.
>>> My dirty solution was an rtc driver that just added a lot of rtcs. It w=
as never
>>> going to merge though...
>>>
>>> Right now I can only track down a previous email from myself saying thi=
s has
>>> been discussed a number of times, but naturally with no references at a=
ll. Oops.
>>>
>>> Anyhow, such a general subsystem for cpu timers doesn't exist AFAIK so =
for now
>>> lets just go with your approach. Perhaps if we find other possible user=
s we can
>>> talk again about how best to support these.
>>
>> does this offer functionality that is not available in the new PWM frame=
work ?
>> http://thread.gmane.org/gmane.linux.kernel.embedded/3400
>
> It's certainly conceivable that we could treat these as some sort of 'vir=
tual' pwm,
> possibly with rather more limited controls than you usual get.

sorry, i was thinking the gptimers were being exposed via IIO for
different purposes.  this driver is OK independent of the PWM
framework.  i imagine in the future when the PWM framework is merged,
it might obsolete this driver, but that can wait.

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
