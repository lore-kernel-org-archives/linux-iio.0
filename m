Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49779 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427Ab1K2RLN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Nov 2011 12:11:13 -0500
References: <CAH5GJ0qTW_DwaAVhe6ZjGYg=1CPPVuQQn3biyg+2BuYHp1Hefw@mail.gmail.com> <2402756.ajAVtrHn6B@harkonnen> <4ED3FD52.4080103@kernel.org> <11116491.uDYpRseJj2@harkonnen>
In-Reply-To: <11116491.uDYpRseJj2@harkonnen>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: ZIO wiki analysis of IIO and why it doesn't meet there requirements [was Re: Industrial Input Output analysis]
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 29 Nov 2011 17:11:06 +0000
To: Federico Vaga <federico.vaga@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Greg KH <greg@kroah.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Alessandro Rubini <rubini@gnudd.com>
Message-ID: <6f28eade-d4fc-452e-8582-dec6309a5663@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org





Federico Vaga <federico.vaga@gmail.com> wrote:

>> > In our use case the board can be on a machine, but data is analyzed
>on
>> > an other one.  Again meta-information are fundamental for
>> > post-analysis of thousands on MB of samples; 2 days later we can't
>> > query devices to know which was their configuration. We can also
>use
>> > meta-information to pre-setup a device output offline, and then
>> > configure it immediately when is required.
>>
>> Agreed.  That meta data could mostly be added by the userspace
>capture
>> app entirely out of band.  It's there until changed.  It wouldn't be
>> inconcievable to add the hooks and a buffer variant to do much the
>same
>> in iio.
>
>Yes, configuration data is there until changed but it can change really
>fast and
>we cannot stop the acquisition to wait user-space data collection.
>
>> >> 4) The reason for the weird 'fake' floating point (which I agree
>is ...
>> >
>> > You are right, mircovolt some times are insufficient, but we
>still...
>>
>> Userspace knowing device detail is typically a bad idea for kernel
>> drivers. You'll get some pushing back on that front!
>
>We want the kernel part to remain small and simple. User
>space has the name in the meta-data, so it will make sense of its
>stream. I
>think that drivers should only implement mechanisms to interact with
>device,
>very few policies. User-space must know what it is doing and which
>device it is
>controlling; intelligence should be in user-space not in kernel, we
>provide
>tools, user should know the tool before use it (an hammer can be
>dangerous if
>used in the wrong way, so you need to know what is an hammer and how
>use it )
I will be interested to see how that goes down.
>
>
>> >> 6) On the precision control bit I'm a little unclear what you mean
>but
>>
>> Exactly, thus massively increasing your local storge (doubling it for
>> starters)? There are devices out there that can change over a much
>wider
>> range than that.
>
>We trade storage for simplicity. You can change resolution on the fly,
>but the stream will reman 2-bytes per sample. Not set in stone, but
>it's way simpler for fast development.
Fair enough I guess.
>> > I was meaning spinlock, semaphores and all this stuff. We'd like to
>> > avoid them in the low-level drivers, as the core should take care
>> > of all the complexities (as far as possible, obviously).
>>
>> The only stuff I think we don't protect in the core that you do is
>> things like scale factors.  In our case perhaps live changes in these
>> make sense.  Maybe in yours ...
>
>No. It's just serializing access (more on this later).
>
>[about trigger assignment]
>> >I think I need to do something like the sysfs
>> >
>> > trigger; otherwise, why is done in that way for the sysfs trigger?
>Am
>> > I wrong?
>
>>From your answer, I don't understand if in this case I need to do
>something like
>sysfs trigger in IIO.
We could instantiate sysfs triggers on demand like you do. Would add a special case so I am not that keen to do so unless the alternative of specifically creating them does not work.
>
>> The reason is there are plenty of setups where you want only one
>capture
>> trigger for all your devices.  Why create more than one?
>
>A battery of the same boards need a single trigger implementation with
>different
>instances. With ZIO we allocate both buffer and trigger by instances;
>when the
>trigger/buffer change, then the old instance is destroyed and a new one
>is
>created. No waste of resources.
Fair enough.
>
>> >> 13) Event's used to configure a trigger value? I'm not sure what
>you ...
>> >
>> > Isn't this what is done in the max1363 driver? When you configure
>> > threshold through sysfs, you write the value on device. Aren't you
>> > configuring a trigger threshold? (I don't know the max1363
>> > specification but from the code I suppose you set a register value
>for
>> > the threshold event)
>>
>> No.  You are configuring an event threshold.  They are not 'normally'
>> used as triggers because it has never yet made sense to do so.
>
>It is not clear and I don't know device details, just read the driver.
>But I
>always abstract a trigger as something that when an event occur, then
>do
>something; so, why throw an event if you do "nothing" when it occurs?
Different requirement. Could use the same infrastructure but result would be considerably complex I think.  So could merge the two if the requirement is there.  Right now the use cases are rather different.
>
>> >> 14) There is nothing to stop developers declaring chan ...
>> >> ....
>> >> If it is very much device specific (and very few things
>> >> actually are) then there is nothing to stop it being added.
>> >
>> > We like to centralize all the sysfs stuff, common attributes and
>> > specific ones.  For our drivers we chose not to require low-level
>> > developers to write the full sysfs interface.
>>
>> Indeed. Nor do we.  Only things you have to write are the odd corners
>> that aren't currently supported by the core.
>
>But, as I understand, for the odd corners you need to write the
>complete sysfs interface for your specific attributes: show, store,
>register,
>remove ...
Yes but they are rare so we don't know what they are. Note
 that many could only be mapped to integers using magic numbers and in kernel drivers that is pretty much not allowed.
>
>> > Boards have many configuration registers and I want to export them
>to
>> > the host system through sysfs. To avoid unexpected result I want to
>> > serialize the register access. Thus the request to handle
>concurrency
>> > issues in the core framework.
>> Agreed, where such issues make sense.  Often they don't so you have
>just
>> slowed down the access to the device for now purpose.  That's why we
>do
>> it when necessary in the drivers.
>
>Usually configuring means accessing device registers. And this must be
>serialized, that's the most common case.  Sure sometimes our locking
>slows down without a need but are you really configuring the same
>device at the same time from two different cores and must do it
>immediately?
>
>Maybe it's different use cases, again. But after all, tasklets and
>works are serialized, and the slowdown isn't a problem.
>
>
>> > We plan to offer a buffer for each channel and one for
>interleaving.
>> > When the acquisition is interleaved, the channel-set is a single
>> > channel.  User-space knows about this and can demux data if it
>> > wants. (Note, it is not implemented yet. But it is our idea at this
>point
>> Is this fully described to userspace?  If not you are going to run
>into
>> a lot of review feedback that your framework isn't general.  People
>> really don't like userspace code having to match against a specific
>> driver.  A lot of our effort has been around avoiding this
>requirement.
>
>Yes, that's what is being evaluated. With our usual overhead, not good
>for your use cases (I wouldn't drive an accelerometer with the zio
>overhead, especially on small systems).

>
>Thanks again.
 
You are welcome and some interesting stuff. May be some time before I can take in depth look at code though!
>--
>Federico Vaga
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my brevity.
