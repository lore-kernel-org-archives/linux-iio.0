Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f198.google.com ([209.85.211.198]:38048 "EHLO
	mail-yw0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753410Ab0EKPHn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 May 2010 11:07:43 -0400
Received: by ywh36 with SMTP id 36so2719384ywh.4
        for <linux-iio@vger.kernel.org>; Tue, 11 May 2010 08:07:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BE93FF2.9020605@cam.ac.uk>
References: <AANLkTinVNqGBQqVaitQHwxmh_EVzkNhLNpl1Fzyc0eTC@mail.gmail.com>
	<4BE93FF2.9020605@cam.ac.uk>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 May 2010 23:07:21 +0800
Message-ID: <AANLkTikhQp8XjgfDfdK_TZwmDjRuFq6QUp0yVX5S4w1O@mail.gmail.com>
Subject: Re: adis16220 capture event
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, May 11, 2010 at 7:30 PM, Jonathan Cameron <jic23@cam.ac.uk> wro=
te:
>
> On 05/11/10 08:59, Barry Song wrote:
> > Jonathan,
> > adis16260 in drivers/staging/iio/gyro/ has been ready too.
> > Do you have time to take a look at the datasheet of adis16220? I th=
ink
> > it is much different. The chip has no register to show the current
> > sample value. It only has a capture buffer mode. =C2=A0For every ca=
pture(by
> > manual or by period at least 1 second), the ADIS16220 produces and
> > stores 1024
> > samples of acceleration and analog input channel data into the capt=
ure
> > buffers. It has no a fixed frequency to sample, by depends on user
> > commands or timer to trigger a capture.
>
> I've been waiting for a device like this to be supported :)
>
> > I think current iio doesn't support it at all:
> > 1. sysfs node is useless to show current value
> Indeed so don't supply one. =C2=A0All the sysfs interfaces are option=
al and should
> only be supplied where they make sense.
> > 2. it doesn't sample periodically, so ring is useless too.
> Agreed that the ring buffer you have been using for the others is
> inappropriate. However, what you have below looks very like a
> hardware buffer (see the accel/sca3000_ring.c for an example).
> > Its work flow is:
> > capture -> 1024 data -> capture -> 1024 data -> capture -> 1024 dat=
a ....
> > I want to add a binary sysfs node for capture buffer.
> No. This really isn't a single value so it won't be accepted for main=
line.
binary sysfs node is not a single value but a document which can hold
much data. some devices like i2c eeprom are using bin_attribute to
support read and write a big memory.

> =C2=A0Every time, users
> > begin a capture, after finishing, read 1024 data from the binary no=
de.
> >
> > Do you have any idea?
> Yes. I'd set the whole thing up as a hardware buffer. As an aside, we
> really need to get the word 'ring' out of the code at some point give=
n
> quite a few implementations aren't going to be rings.
i don't think it is a hardware ring buffer. every-time, data number is
fixed 1024 for a capture event. Without periodic input, a binary node
should be enough for this.

>
> From the datasheet I see there are a couple of different ways to trig=
ger
> capture. =C2=A0I would be inclined to handle the manual mode via a tr=
igger.
> I think a general userspace manual trigger would be helpful anyway fo=
r
> testing other devices if nothing else. =C2=A0Probably just a sysfs at=
tribute
> called capture_now that otherwise looks much like the gpio trigger.
>
> The timer option is more or less the equivalent of a conventional fix=
ed
> frequency capture (be it with a lot of data per capture!). One could
> supply a trigger to indicate this has finished. Probably better to ha=
ve
> the event in question come from the buffer event chrdev (see below).
>
> The last option of doing it based on an event is more interesting.
> The options that come to mind are:
>
> * A seperate trigger - You would need a way for other devices to know=
 the
> =C2=A0trigger has fired. This would pretty much require tying the ala=
rm in question
> =C2=A0to one of the gpio pins so as to pass the notification on. =C2=A0=
Perhaps this only
> =C2=A0happens if another device attaches to the trigger? (bit fiddly =
to code).
>
> * Do it internally as control attributes of a new hardware buffer.
> =C2=A0If you are also supporting general alarm events the logic would=
 get a little
> =C2=A0complex as obviously these could be shared (event can trigger a=
 buffer fill
> =C2=A0as well as causing an external gpio interrupt).
>
> I would prefer the first option, but the second is fine for now if it=
 is
> easier to code up. =C2=A0The first allows us to say chain on a gyro t=
o get
> additional info triggered off trigger events from adis16220. =C2=A0Cl=
early
> there are a few complexities to be considered. =C2=A0For one thing th=
e exact
> nature of the trigger consumer function would be different from the u=
serspace
> trigger (when it would cause a capture) to the event based triggers
> (where the capture would already have happened). =C2=A0This is actual=
ly a case
> that needs better handling in some of the current drivers. =C2=A0In t=
heory
> with the lis3l02dq for example, one can trigger another device off it=
's
> datardy signal without actually triggering the lis3l02dq itself. =C2=A0=
This
> would result in no read of data and the datardy signal would not clea=
r.
> Obviously this would be a pretty strange thing to do, but the interfa=
ce
> does allow it and so it ought to be nicely handled. =C2=A0Currently i=
t is not!
> That one has been at the bottom of the todo list for a long time.
>
> The new buffer would have an event chrdev from which a new type of ev=
ent
> can be read (not sure on naming, something like BUFFER_CAPTURE_EVENT_=
=46INISHED)
> It would also have an access chrdev as per the software ring you have
> been using so far. =C2=A0This access chrdev will read directly (via s=
pi) from the
> buffer on the device. =C2=A0A while back there was some discussion ab=
out whether
> devices like these (with hardware buffering) should always feed into =
an
> intermediate software buffer. =C2=A0Personally I don't think they nee=
d to and
> if we decide otherwise this can always be added at a later date.
>
> Obviously there would be a number of new abi elements introduced that=
 might
> well generalize over a range of devices, so if you go this way please=
 propose
> them formally on the list (and possibly also lkml) for discussion.
>
> Thanks,
>
> Jonathan
