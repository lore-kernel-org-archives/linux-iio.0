Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51461 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1K1V3p (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Nov 2011 16:29:45 -0500
Message-ID: <4ED3FD52.4080103@kernel.org>
Date: Mon, 28 Nov 2011 21:29:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Federico Vaga <federico.vaga@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Alessandro Rubini <rubini@gnudd.com>
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there requirements
 [was Re: Industrial Input Output analysis]
References: <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com> <4ED21960.1000002@kernel.org> <2402756.ajAVtrHn6B@harkonnen>
In-Reply-To: <2402756.ajAVtrHn6B@harkonnen>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/28/2011 08:14 PM, Federico Vaga wrote:
> Thank you again for your answer.
> 
>> 1) Number of devices is currently limited at 256 entirely because it...
> 
> I know that in IIO it is just a define to change, but as is, it is
> limited to 256. Yes, It sounds like an excuse, my apologies. In our
> systems we can have hundreds of board for many kilometers, 256
> probably it is not enough. Anyways, there is no overhead in asking for
> many minors, IIRC.
Fair enough.
> 
>> 2) Output signal support is patchy and currently unbuffered, but there ...
> 
> We need output to generate waveforms, again with big amounts of data
> 
>> 3) I disagree with your analysis of meta data. We do not carry it with...
> 
> In our use case the board can be on a machine, but data is analyzed on
> an other one.  Again meta-information are fundamental for
> post-analysis of thousands on MB of samples; 2 days later we can't
> query devices to know which was their configuration. We can also use
> meta-information to pre-setup a device output offline, and then
> configure it immediately when is required.
Agreed.  That meta data could mostly be added by the userspace capture
app entirely out of band.  It's there until changed.  It wouldn't be
inconcievable to add the hooks and a buffer variant to do much the same
in iio.
> 
>> 4) The reason for the weird 'fake' floating point (which I agree is ...
> 
> You are right, mircovolt some times are insufficient, but we still
> prefer integer because both kernel and device handle integers;
> user-space can interpret the value by knowing the device detail. In ZIO
> we currently suggest to use microvolts, and we know that we must clarify the
> concept, because microvolts are not enough.
Userspace knowing device detail is typically a bad idea for kernel
drivers. You'll get some pushing back on that front!
> 
>> 6) On the precision control bit I'm a little unclear what you mean but ...
> 
> Devices can change resolution in order to perform a faster acquisition,
> so it can change at run-time. We set the sample size at the maximum needed
> by device to make the framework easy. If the board has 16bit
> resolution but can work also with 14 or 8 ... then we always use
> 2bytes for that channel.
Exactly, thus massively increasing your local storge (doubling it for
starters)? There are devices out there that can change over a much wider
range than that.
> 
>> 7) Buffer file operations stuff.  Trivial to add. ...
> 
> Ack.
> 
>> 8) concurency support if really needed can be done in userspace....
> 
> I was meaning spinlock, semaphores and all this stuff. We'd like to
> avoid them in the low-level drivers, as the core should take care
> of all the complexities (as far as possible, obviously).
The only stuff I think we don't protect in the core that you do is
things like scale factors.  In our case perhaps live changes in these
make sense.  Maybe in yours they are always locked down.  Yes we can't
always know what the current value is, but then some stuff like filter
coefficients isn't an instant change anyway...  I'd say whether these
should be fixed is an application issue.  Sounds like in your
applications it makes sense to make these fixed in kernel.  Basically if
it doesn't make the driver or userspace fall over, we are happy for
things to be changed whilst capture is occuring. You want predictable
consistent data. (fair enough)
> 
>> 9) I suspect the disagreement about scan's may be down to the types...
> 
> Demux an interleaved scan is a waste of time, you are right. What I
> don't understand is why IIO use an index scan? Is it possible to change
> it on run time? If it is not, the scan order never change, so why don't
> you use a single index for both naming and scan order?
channel tells whether we  have voltage channel 1 or voltage channel 2.
Or it tells is if it is temperature 1 or temperature 2.

Scan index tells us where it is in the buffer.  So one counts over all
channels (sometimes with gaps) and the counts over channels of a
particular type.  This is to map devices doing more than one type of
channel to numbering schemes that make sense without reading the datasheet.
> 
> We are studying a solution for interleaved I/O, which is currently
> missing from ZIO, so at the moment we can't propose a solution, maybe
> in next time.
cool. Fiddly with your data rates!
> 
>> 10) Buffer type choice at runtime is not there as you say.
> 
> It's not that mandatory, actually. We want to have it for symmetry
> and to help us while developing.
> 
>> 11) I am intrigued to know what could be easier in associating a trigger ...
> 
> What are you referring to? I think is ok assign a trigger by
> name. Probably we misunderstood with point 12.
> 
>> 12) The stuff about instance management for triggers only applies...
> 
> Sure, you are right; but what if you have a generic trigger suitable
> for many devices?
There are actually very few of them.
> I think the IIO solution is the same of the sysfs
> trigger where user space need to create each instance by hand, and
> then assign to a device.  For example, a device family has the same
> identical trigger; to avoid code duplication by coping the trigger
> code in each device driver, you have to write the trigger code as
> independent module.
You can do that if you like. Nothing to stop you that I can think of.
> Then you need to assign different instance to
> different device driver; 
Not at all. If it has hardware and hence should be described in a board
file or device tree and it will be registered by the hardware driver
(that for the individual device). Whether it is in a separate module
or not is irrelevant to this question.

>I think I need to do something like the sysfs
> trigger; otherwise, why is done in that way for the sysfs trigger? Am
> I wrong?
Take generic trigger types.  If it's a gpio, then it's hardware and uses
the standard irq driver and is registered by board file / device tree.

Software timers are in the same category as userspace driver triggers
and as such should be allocated on demand.  Anything else is a waste of
resources (and got roundly flattened in review).

The reason is there are plenty of setups where you want only one capture
trigger for all your devices.  Why create more than one?
> 
>> 13) Event's used to configure a trigger value? I'm not sure what you ...
> 
> Isn't this what is done in the max1363 driver? When you configure
> threshold through sysfs, you write the value on device. Aren't you
> configuring a trigger threshold? (I don't know the max1363
> specification but from the code I suppose you set a register value for
> the threshold event)
No.  You are configuring an event threshold.  They are not 'normally'
used as triggers because it has never yet made sense to do so.
> 
>> 14) There is nothing to stop developers declaring chan ...
>> ....
>> If it is very much device specific (and very few things
>> actually are) then there is nothing to stop it being added.
> 
> We like to centralize all the sysfs stuff, common attributes and
> specific ones.  For our drivers we chose not to require low-level
> developers to write the full sysfs interface.
Indeed. Nor do we.  Only things you have to write are the odd corners
that aren't currently supported by the core.
> 
>> 16) Concurrent processes can change attributes, but only in non ...
> 
> Boards have many configuration registers and I want to export them to
> the host system through sysfs. To avoid unexpected result I want to
> serialize the register access. Thus the request to handle concurrency
> issues in the core framework.
Agreed, where such issues make sense.  Often they don't so you have just
slowed down the access to the device for now purpose.  That's why we do
it when necessary in the drivers.
> 
>> 18) Can add a warning about registering the buffer before the device ...
> 
> I waste some hours on this only because I call the functions in a different
> order; in my opinion it is better an error which stop device registration.
> 
>> Bits and bobs from your table at the end. Note some of these are
>> considerations of how we could adapt the code to make it fit your
>> usecase better.
> 
> Thank you very much. We'll keep an eye on IIO as well, trying to see
> if our usecase really needs a new framework or some merge can be devised
> over time.
Agreed.

>> As above, I think the trigger instance confusion is based on reading one
>> fairly odd trigger type.
> 
> Yes it is; my answer to point 12 still valid
> 
>> Anyhow, I will be interested to have a read of your proposed code.
>>
>> The big difference I think are that you split data out into independent
>> buffers, one per channel. We use the concept of scan's because that is
>> often how adcs actually work and cuts the overhead to minimum. Two
>> options and which is best is probably dictated by the use case.
> 
> We plan to offer a buffer for each channel and one for interleaving.
> When the acquisition is interleaved, the channel-set is a single
> channel.  User-space knows about this and can demux data if it
> wants. (Note, it is not implemented yet. But it is our idea at this point
)
Is this fully described to userspace?  If not you are going to run into
a lot of review feedback that your framework isn't general.  People
really don't like userspace code having to match against a specific
driver.  A lot of our effort has been around avoiding this requirement.
> 
>> Will be interesting to compare.
> 
> Actually our main boards are under development, so we cannot code on
> them. But probably we code ZIO drivers for some of the IIO devices,
> just to test ZIO and to compare with IIO; bear in mind that these kind
> of devices are not our target.
Indeed. Good luck with your more interesting boards ;)  sounds 'fun'.

Jonathan
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

