Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:38361 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab1JUI6b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 04:58:31 -0400
Message-ID: <4EA13439.8060504@cam.ac.uk>
Date: Fri, 21 Oct 2011 09:58:33 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: Userspace event handling and header files
References: <4EA11D7D.80202@metafoo.de> <544AC56F16B56944AEC3BD4E3D59177146E75C17CA@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177146E75C17CA@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/21/11 09:02, Hennerich, Michael wrote:
> Lars-Peter Clausen wrote on 2011-10-21:
>> Hi Jonathan,
>>
>> I tried to write a small userspace iio event monitor in the style of
>> evtest. Right now we have four header files for iio: iio_core.h iio.h
>> chrdev.h and sysfs.h. To be able to receive and probably decode events
>> in userspace we need three of theses headers: chrdev.h for ioctls and
>> the iio_event_data struct, sysfs.h for the different iio_event enums and
>> associated macros, iio.h for the iio_chan_type and iio_modifier enums.
I agree entirely.  In the in kern patches, I introduced include/linux/iio/inkern.h
which contains those channel types and modifiers.  As you have pointed
out we need those for userspace as well so that header isn't exactly well named!

>>
>> Since we probably don't want to export the sysfs.h and chrdev.h headers
>> to userspace I propose that we move everything which is needed for
>> external API into a common header for example iio.h and move all
>> internal API, which is only required to write a IIO driver for by the
>> core itself, from the iio.h header to a different header like iio_core.h.
Looking at distribution in other subsystems:
input does it all in input.h (kernel bits at the bottom under an #ifdef KERNEL
hmwon doesn't have userspace stuff so doesn't matter
usb has entirely separate headers (I think anyway). 

So only one that would work for us is the input one giant header. hmm.

I think people writing drivers are going to expect iio.h to be the primary
header they need for iio_register_device etc - so I'd leave that be.
iio-core (and friends) should have neatly encapsulated stuff
that neither drivers nor userspace cares about.

Howabout
iio/iio.h for driver stuff (has to include types.h)
	Sub files for the bits drivers may or may not use
	iio/sysfs.h
	iio/buffer.h (contents of current buffer_generic.h)
	(obviously anything offering events will need events.h as well)
iio/types.h for the enums that matter to both
	iio_chan_type, iio_modifier
iio/events.h for the event code stuff
	IIO_EVENT_CODE and friends.  + everything in chrdev.h  So this
is the stuff that userspace cares about.
	Also include iio_event_type, iio_event_direction
iio/inkern.h for inkernel request functions etc.

We may need a further divide to keep the in kernel interface stuff fairly
self contained.  That needs to know about stuff like iio_chan_info_enum
(should drop the enum from the end of that...)

Thus drivers include the following based on what they provide
iio.h - always
sysfs.h - if sysfs interface
events.h - if event interface
buffer.h - if buffer interface.

In kernel interfaces
inkern.h which includes types.h

Userspace
iio/events.h


>>
>> What is your opinion on this?
> 
> I think we should also convince Greg to allow staging IIO includes in
> include/linux/staging/iio.
> Only this would allow us to write maintainable user space code.
Realistically I don't think that is going to happen.
Best bet is going to bet to carry local patches until the events bit
of iio is out of staging.

I think that is all that userspace needs to know about?

In the way of these things I worked this set out by doing it, so patch to follow
shortly. Sorry Lars-Peter if you have one as well on the same basis!

The usage in the core of events.h does perhaps imply that might be better
split up as well. But that's a bigger job to get right.

Nice cleanup Lars-Peter.  It's good to have someone poking these corners that
have just evolved rather than being properly thought out.

how are you coming with that patch to get rid of the switching on the bit mask?
