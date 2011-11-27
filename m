Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34534 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385Ab1K0LE5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 06:04:57 -0500
Message-ID: <4ED21960.1000002@kernel.org>
Date: Sun, 27 Nov 2011 11:05:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Federico Vaga <federico.vaga@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Lars-Peter Clausen <lars@metafoo.de>
CC: Alessandro Rubini <rubini@gnudd.com>
Subject: ZIO wiki analysis of IIO and why it doesn't meet there requirements
 [was Re: Industrial Input Output analysis]
References: <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com>
In-Reply-To: <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

I'm posting this reply to linux-iio as it may cut down on the amount of
repeated discussion and allow us to draw everyone relevant together.
Please CC anyone relevant (I've just added Greg and Lars-Peter as they
commented on the ZIO RFC and hence are probably at least vaguely
interested.)

Federico asked me to comment on the zio wiki page analysing IIO a week
or so ago.  I didn't get round to it until yesterday (was prompted to
take the time to do it by their posting of the patch series).

Anyhow, my points below are intended more for discussion than anything
else.  There are clearly things we can learn from each other and I
suspect at some point the question of whether we can merge (or at least
share some infrastructure) will come up so it is worth keeping that in
mind as we go. Targets are different but there will clearly be a blurred
region between the two!  There are strengths and weaknesses to both
approaches so lets work out what they are and make sure we agree the facts.

Jonathan

> Hello Mr Cameron,
> 
> I'm working on a new linux framework for data acquisition systems, ZIO.
> The open hardware repository (http://www.ohwr.org/) hosts the ZIO
> project at http://www.ohwr.org/projects/zio/.
> 
> Before starting with this project I analyzed both COMEDI and IIO to
> undestand if they comply with our requirements, and they don't. I'm glad
> if you can read my analysis about IIO on the wiki page of the ZIO project,
> and give me your opinion. There is not much documentation about IIO, so I
> read the entire code to understand how it works; maybe I misunderstood
> something and you can correct me where I'm wrong in my analysis.
> Bear in mind that our main case are boards with mega-samples for second
> and with a time-stamp precision of sub-nanoseconds. Data output is as
> important as data input and we don't handle small sets of samples.
> 
> I think that IIO is a good work (absolutely better the COMEDI) but it
> doesn't meet with our requirements and is directed toward a different
> target (small chips). The first time, I analyzed the IIO version within kernel
> 2.6.38/39 and I really appreciate the improvements done about sysfs
> centralization and channel organization, but there are some points
> where I still disagree.
> 
> The ZIO project is under development at this time, but we think that
> we'll submit a patch in one or two weeks based on the linux next tree;
> Greg K.H. suggests us to write also on the IIO mailing list when the ZIO
> patch is submitted.
> 
> PS: English is not my native language, so ... I'm sorry.
Would you mind if I posted this to linux-iio as well?  It might save us
all some time.  (If you don't mind and want to reply, then just cc the list)

Sorry I didn't get to this earlier. Things have been a bit manic for the
last few weeks.

Anyhow, overview of IIO is mostly fair and accurate. Few minor comments
though (particularly as you've now posted and received the predictable
questions!)  Note some of these refer to changes we could make,
obviously your consideration is based on what is there so they don't
directly apply to the web page.

1) Number of devices is currently limited at 256 entirely because it is
considered rude to request many more devices than you actually expect to
see.  Can up this the moment someone actually says they have a reason to
do so.

2) Output signal support is patchy and currently unbuffered, but there
is some.  Agreed it is rubbish.  Analog Devices were putting some effort
in on this front, but  I don't know what stage it reached.
It wasn't of interest to me so wasn't in the early code.

3) I disagree with your analysis of meta data. We do not carry it with
the main data streams precisely because it is unnecessary overhead.
Userspace knows what it setup and what it read. (If your stream is not
controlled from userspace then fair enough, you need meta data).
The meta data is valid whenever the buffer is enabled and hence can be
read once, out of band.

4) The reason for the weird 'fake' floating point (which I agree is
clunky) is the enormous range of real values one sees.  Straight integer
just doesn't give you enough space.  Hence we cheat and use
those two integers with a variable definition of what they mean.
It's all that we have found that works for the devices we have seen.
It's a wierd world but I doubt you'll find a single integer works in
all cases.  Microvolts is incidently not a very fine granularity at all.
Some of the values we have are already in picovolts and there are
nastier devices out there.

5) On the sysfs naming, this is lifted from what hwmon does.  The naming
channel types has worked well for them so there is a lot of support for
it.  The two indexes are for flexibility and come from our decisions on
channel naming.  If we are going to have temp0, temp1 etc and in0 in1
etc then we need one to do the naming index and one to do the location
in the buffer (ordering is always maintained).  Agreed if you argue the
naming is a bad choice, then you could just use one. So this is clearly
tied up with the previous point.

6)  On the precision control bit I'm a little unclear what you mean but
will take a punt...

Devices have radically different precisions, 8 bit to 24 bit so far in
IIO. Without this we have to store 4 times the data (as always align to
save time) for the 8 bit devices. Is this what you mean?  If so you've
just multiplied your data size by 4 in order to avoid a little bit of
trivial handling code.  Again a difference of opinion.  Note we don't
allow these to be changed at run time (more or less, there is one
exception which is when there is a hardware buffer involved).

7) Buffer file operations stuff.  Trivial to add. I certainly intend to
do mmapped (and for that matter splice) as soon as buffers exist that
use it.  Was kind of hoping something nice would come out of the tracing
guys trying to unify their buffers, but not seen anything yet.

8) concurency support if really needed can be done in userspace. I'd
consider it decidely odd if you have a high speed read application where
concurrent reading makes sense.  We talked about this ages ago and
concluded it wasn't worth the hassle.
True concurrent reader buffers are a pain.  See the fun evdev goes
through and they definitely aren't trying to handle much data.

9) I suspect the disagreement about scan's may be down to the types of
hardware involved.  A lot of devices I see are 'only' capable of reading
sets of channels together.  We could then demux them into
multiple buffers (one per channel as you have done), but only by adding
considerable overhead. These share a timestamp, so if nothing else we
only want to save one copy of that.  I'll have to have a close look at
your code to understand what your data flow actually looks like. Perhaps
I am completely missunderstanding it.

10) Buffer type choice at runtime is not there as you say. Note that the
infrastructure is there though after the inkernel push interface patches
merge (they use a demux unit to handle splitting our 'scans' coming from
hardware out to as many buffers as one likes.  However to do this
coherently we would have to have all buffers registered at the start or
disassociate them from the iio device in some way.  Note this may be a
pass through if a given buffer wants all the channels.)  So it can be
done, but we haven't yet had a usecase.  This has been on my todo list,
but not urgent as of yet!

11) I am intrigued to know what could be easier in associating a trigger
to a device than writing the trigger's 'name' value returned from the
oponomous sysfs attribute into 'current_trigger' of the
device you wish to trigger?  This is entirely a userspace operation.
You can set a default if it makes sense (typically data ready signal
of the same device).

12) The stuff about instance management for triggers only applies to
one very special trigger type.  This is the userspace sysfs trigger.
Any trigger associated with hardware is initialized from board files
describing the hardware. We would probably do the same with a high
res timer trigger, but though one has been proposed it isn't ready
to merge as yet.

13) Event's used to configure a trigger value? I'm not sure what you
mean by that. Perhaps it is a disconnnect in what 'events' mean to each
of us?  Anything can be a trigger is someone rights a driver that
exports it as such.

14) There is nothing to stop developers declaring channel specific
attributes. If there is a channel related control that is fairly general
then it should not be separately registered but instead added to the
channel_info mask.  That way it is available for inkernel control from
other drivers.  If it is very much device specific (and very few things
actually are) then there is nothing to stop it being added.

15) The address field being used to give the mask is a spurious point as
the full channel structure is also available so translation to addresses
is trivial if needed.  Note this isn't the case for non channel related
attributes, hence the address is used differently.

16) Concurrent processes can change attributes, but only in non
distructive ways (from stability point of view anyway).  For example,
buffer contents is protected. If a buffer is live then no one can edit
what goes into it.  Hence userspace should setup and initialize the
buffer then check that it is set to what it wants it to be set to before
opening / reading from it.  I am unclear what else you would suggest
protecting?

17) I take your point on the event open/close issues.  Events are one
bit we aren't really happy with!  Devices ought to have opened the file
before turning anything on, so this probably doesn't make any difference
in practice, but as you say it is inconsistent.

18) Can add a warning about registering the buffer before the device I
guess if getting this wrong is common! First report on that one.

Bits and bobs from your table at the end.  Note some of these are
considerations of how we could adapt the code to make it fit your
usecase better.

Buffers only currently work on a sample by sample basis. Technically
there is nothing stopping us from adding a 'push lots' optional
callback.  Getting this to interact well with the demux code needed for
inkernel users would require an optional unroll into individual samples
though.  This doesn't occur in the case where the buffer 'contains
everything' that is captured.  Not too bad, but not pain free.  Kind of
need this anyway to handle chaining a hardware buffer into a software
buffer.

As above, I think the trigger instance confusion is based on reading one
fairly odd trigger type.

Offset gain etc inconsistency of naming bothers me.  These certainly
should be consistent!  There are some drivers in need of cleanup that
may have confused the issue here.  These  are tightly defined by the abi
spec and mostly implemented via the info_mask of the channels.

The number of devices limit arguement is spurious.  If you are using
chrdevs then your number of devices is limited by what it is considered
polite to request.  we set it at 256 as that is considered reasonable.
Could trivially make it a compile time configurable option.  Note we
will only have one iio device per set of triggerable channels (e.g. if
it looks like two separable devices from a data flow point of view, it
will be registered as such.).

Good point on the timestamp limitations. Easy to work around though, but
making the special treatement of timestamps happen only if it is both a
timestamp and not indexed.  Any 'real' channel should be indexed or have
a modifier so this is valid.  Two line patch I think.  Only worth doing
when there is a user though!

Anyhow, I will be interested to have a read of your proposed code.

The big difference I think are that you split data out into independent
buffers, one per channel.  We use the concept of scan's because that is
often how adcs actually work and cuts the overhead to minimum.  Two
options and which is best is probably dictated by the use case.

Other big one is that our output support is currently minimal to say the
least.

Will be interesting to compare.

Jonathan
