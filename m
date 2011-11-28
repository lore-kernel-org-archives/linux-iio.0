Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46297 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078Ab1K1UMg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2011 15:12:36 -0500
Received: by bke11 with SMTP id 11so8991274bke.19
        for <linux-iio@vger.kernel.org>; Mon, 28 Nov 2011 12:12:34 -0800 (PST)
From: Federico Vaga <federico.vaga@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Alessandro Rubini <rubini@gnudd.com>
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there requirements [was Re: Industrial Input Output analysis]
Date: Mon, 28 Nov 2011 21:14:53 +0100
Message-ID: <2402756.ajAVtrHn6B@harkonnen>
In-Reply-To: <4ED21960.1000002@kernel.org>
References: <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com> <4ED21960.1000002@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thank you again for your answer.

> 1) Number of devices is currently limited at 256 entirely because it...

I know that in IIO it is just a define to change, but as is, it is
limited to 256. Yes, It sounds like an excuse, my apologies. In our
systems we can have hundreds of board for many kilometers, 256
probably it is not enough. Anyways, there is no overhead in asking for
many minors, IIRC.

> 2) Output signal support is patchy and currently unbuffered, but there ...

We need output to generate waveforms, again with big amounts of data

> 3) I disagree with your analysis of meta data. We do not carry it with...

In our use case the board can be on a machine, but data is analyzed on
an other one.  Again meta-information are fundamental for
post-analysis of thousands on MB of samples; 2 days later we can't
query devices to know which was their configuration. We can also use
meta-information to pre-setup a device output offline, and then
configure it immediately when is required.

> 4) The reason for the weird 'fake' floating point (which I agree is ...

You are right, mircovolt some times are insufficient, but we still
prefer integer because both kernel and device handle integers;
user-space can interpret the value by knowing the device detail. In ZIO
we currently suggest to use microvolts, and we know that we must clarify the
concept, because microvolts are not enough.

> 6) On the precision control bit I'm a little unclear what you mean but ...

Devices can change resolution in order to perform a faster acquisition,
so it can change at run-time. We set the sample size at the maximum needed
by device to make the framework easy. If the board has 16bit
resolution but can work also with 14 or 8 ... then we always use
2bytes for that channel.

> 7) Buffer file operations stuff.  Trivial to add. ...

Ack.

> 8) concurency support if really needed can be done in userspace....

I was meaning spinlock, semaphores and all this stuff. We'd like to
avoid them in the low-level drivers, as the core should take care
of all the complexities (as far as possible, obviously).

> 9) I suspect the disagreement about scan's may be down to the types...

Demux an interleaved scan is a waste of time, you are right. What I
don't understand is why IIO use an index scan? Is it possible to change
it on run time? If it is not, the scan order never change, so why don't
you use a single index for both naming and scan order?

We are studying a solution for interleaved I/O, which is currently
missing from ZIO, so at the moment we can't propose a solution, maybe
in next time.

> 10) Buffer type choice at runtime is not there as you say.

It's not that mandatory, actually. We want to have it for symmetry
and to help us while developing.

> 11) I am intrigued to know what could be easier in associating a trigger ...

What are you referring to? I think is ok assign a trigger by
name. Probably we misunderstood with point 12.

> 12) The stuff about instance management for triggers only applies...

Sure, you are right; but what if you have a generic trigger suitable
for many devices? I think the IIO solution is the same of the sysfs
trigger where user space need to create each instance by hand, and
then assign to a device.  For example, a device family has the same
identical trigger; to avoid code duplication by coping the trigger
code in each device driver, you have to write the trigger code as
independent module. Then you need to assign different instance to
different device driver; I think I need to do something like the sysfs
trigger; otherwise, why is done in that way for the sysfs trigger? Am
I wrong?

> 13) Event's used to configure a trigger value? I'm not sure what you ...

Isn't this what is done in the max1363 driver? When you configure
threshold through sysfs, you write the value on device. Aren't you
configuring a trigger threshold? (I don't know the max1363
specification but from the code I suppose you set a register value for
the threshold event)

> 14) There is nothing to stop developers declaring chan ...
> ....
> If it is very much device specific (and very few things
> actually are) then there is nothing to stop it being added.

We like to centralize all the sysfs stuff, common attributes and
specific ones.  For our drivers we chose not to require low-level
developers to write the full sysfs interface.

> 16) Concurrent processes can change attributes, but only in non ...

Boards have many configuration registers and I want to export them to
the host system through sysfs. To avoid unexpected result I want to
serialize the register access. Thus the request to handle concurrency
issues in the core framework.

> 18) Can add a warning about registering the buffer before the device ...

I waste some hours on this only because I call the functions in a different
order; in my opinion it is better an error which stop device registration.

> Bits and bobs from your table at the end. Note some of these are
> considerations of how we could adapt the code to make it fit your
> usecase better.

Thank you very much. We'll keep an eye on IIO as well, trying to see
if our usecase really needs a new framework or some merge can be devised
over time.

> As above, I think the trigger instance confusion is based on reading one
> fairly odd trigger type.

Yes it is; my answer to point 12 still valid

> Anyhow, I will be interested to have a read of your proposed code.
>
> The big difference I think are that you split data out into independent
> buffers, one per channel. We use the concept of scan's because that is
> often how adcs actually work and cuts the overhead to minimum. Two
> options and which is best is probably dictated by the use case.

We plan to offer a buffer for each channel and one for interleaving.
When the acquisition is interleaved, the channel-set is a single
channel.  User-space knows about this and can demux data if it
wants. (Note, it is not implemented yet. But it is our idea at this point)

> Will be interesting to compare.

Actually our main boards are under development, so we cannot code on
them. But probably we code ZIO drivers for some of the IIO devices,
just to test ZIO and to compare with IIO; bear in mind that these kind
of devices are not our target.

