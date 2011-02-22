Return-Path: <vapier.adi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <4D63D049.7040100@cam.ac.uk>
References: <1297863769-24022-1-git-send-email-michael.hennerich@analog.com> <4D63D049.7040100@cam.ac.uk>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Tue, 22 Feb 2011 17:35:29 -0500
Message-ID: <AANLkTikKRR4JOxS0e_7ezZu-AvN4d9=vtE2BEW=mq4yj@mail.gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH] IIO: trigger: New Blackfin
 specific trigger driver iio-trig-bfin-timer
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	drivers@analog.com, device-drivers-devel@blackfin.uclinux.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Tue, Feb 22, 2011 at 10:03, Jonathan Cameron wrote:
> On 02/16/11 13:42, michael.hennerich@analog.com wrote:
>> This driver allows any Blackfin system timer to be used as IIO trigger.
>> It supports trigger rates from 0 to 100kHz in Hz resolution.
>
> The reason we ended up with a rtc based trigger in the first place, was t=
hat
> I had a very similar set of timers on the pxa271 that I mainly develop wi=
th.
>
> At the time some debate opened up on whether there was a use case here fo=
r
> a more general way of providing access to system periodic timers for exac=
tly
> this sort of device. =C2=A0The view seemed to be that there was, but I ce=
rtainly didn't
> have time to do it at the time and no one else seems to have looked at it=
 since.
> My dirty solution was an rtc driver that just added a lot of rtcs. It was=
 never
> going to merge though...
>
> Right now I can only track down a previous email from myself saying this =
has
> been discussed a number of times, but naturally with no references at all=
. Oops.
>
> Anyhow, such a general subsystem for cpu timers doesn't exist AFAIK so fo=
r now
> lets just go with your approach. Perhaps if we find other possible users =
we can
> talk again about how best to support these.

does this offer functionality that is not available in the new PWM framewor=
k ?
http://thread.gmane.org/gmane.linux.kernel.embedded/3400
-mike
