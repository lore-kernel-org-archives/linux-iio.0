Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48315 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbcDPNS2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 09:18:28 -0400
Subject: Re: Question about differential muxing
To: "Andrew F. Davis" <afd@ti.com>
References: <5711362A.1020700@ti.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <57123BA0.4070501@kernel.org>
Date: Sat, 16 Apr 2016 14:18:24 +0100
MIME-Version: 1.0
In-Reply-To: <5711362A.1020700@ti.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/04/16 19:42, Andrew F. Davis wrote:
> Hello all,
> 
> I am currently working on a driver for a part similar to the AFE4300. I
> was hoping to get some information on the recommended way to handle a
> mux such as the one in the AFE4300 BCM front-end (page 13 of
> http://www.ti.com/lit/ds/symlink/afe4300.pdf has a good image).
That's marginally bonkers..

You do seem to get the weird and wonderful ;)  I'd never appreciated
some of these weird devices existed!  Much more interesting than
the average ADC.
> 
> The top several pins are outputs that can be routed to the OP-AMP, but
> only one at a time, because of this I'm not sure if they should be
> exposed as output channels, or sysfs switches.
So they are outputs the whole time?  But sometime internally fed back
in to that amplifier.. both connecting to the input and output...

Is there a finite list of what the outputs can actually be at any time?
I'm not sure if we can map this onto standard output channels or not.

It's described in the text as selecting between 6 contact points and
4 impedances so I'll pretend I can see exactly how the circuit is doing that
as this is far too much thinking for a Saturday afternoon.

If treated as output channels it would have to be done on a last come
basis with the others all being set to 0.  That's fine under the ABI that
allows for any value to result in a change to any other but clunky.

Hmm. Treating it as output channels does kind of match with how the device
is used I think?  Fire a current out of pointN and read the resulting
voltage between 2 points (one of which might be a reference)...

It's all channels, there is just a lot of restrictions on what can happen
at a time.

> 
> The other issue is with the input pins, I believe the standard way to
> handle this is by exposing every mux setting as a separate channel, then
> only allowing one bit set in the scan mask, but for this part, when all
> differential combinations are exposed we have more than 100 channels,
> and the other part I'm working on makes this several times worse.
> 
> Could someone point to any information, or an existing driver, that
> explains the preferred way to handle this?
You have it correct above.  At the end of the day there isn't much we can
do to provide a compact yet general interface and occasionally we do end
up with an awful lot of channels.  There are some analog devices battery
chargers for example that end up as a cascade resulting in similar numbers
of channels.

Each channel doesn't cost us that much other than making for a big set of
files. 

Doing it as mux switches would work, but be extremely difficult to describe
simply to userspace in any way that would generalize.  The resulting programs
would have to know too much about the sensor routing or to have a lot
of complexity decoding how to set up the channel combinations they actually
want.

As for existing drivers... Hmm. any of the differential ADC drivers provide a
reference of sorts. For high channel counts, the ad7280a driver is still in
staging but the principles are fine...

Lars, any input on this sort of highly complex device?  Looks a bit like some
of the more nuts audio chips in some ways.

Jonathan
> 
> Thanks,
> Andrew
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

