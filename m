Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:34198 "EHLO
	www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbcDRMF3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 08:05:29 -0400
Subject: Re: Question about differential muxing
To: Jonathan Cameron <jic23@kernel.org>, "Andrew F. Davis" <afd@ti.com>
References: <5711362A.1020700@ti.com> <57123BA0.4070501@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5714CD81.6000100@metafoo.de>
Date: Mon, 18 Apr 2016 14:05:21 +0200
MIME-Version: 1.0
In-Reply-To: <57123BA0.4070501@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/16/2016 03:18 PM, Jonathan Cameron wrote:
[...]
>> The other issue is with the input pins, I believe the standard way to
>> handle this is by exposing every mux setting as a separate channel, then
>> only allowing one bit set in the scan mask, but for this part, when all
>> differential combinations are exposed we have more than 100 channels,
>> and the other part I'm working on makes this several times worse.
>>
>> Could someone point to any information, or an existing driver, that
>> explains the preferred way to handle this?
> You have it correct above.  At the end of the day there isn't much we can
> do to provide a compact yet general interface and occasionally we do end
> up with an awful lot of channels.  There are some analog devices battery
> chargers for example that end up as a cascade resulting in similar numbers
> of channels.
> 
> Each channel doesn't cost us that much other than making for a big set of
> files. 
> 
> Doing it as mux switches would work, but be extremely difficult to describe
> simply to userspace in any way that would generalize.  The resulting programs
> would have to know too much about the sensor routing or to have a lot
> of complexity decoding how to set up the channel combinations they actually
> want.
> 
> As for existing drivers... Hmm. any of the differential ADC drivers provide a
> reference of sorts. For high channel counts, the ad7280a driver is still in
> staging but the principles are fine...
> 
> Lars, any input on this sort of highly complex device?  Looks a bit like some
> of the more nuts audio chips in some ways.

In my opinion we need to model MUXs and assorted sequencers properly in IIO
and not hide the real hardware topology behind a simplified view. It causes
all kinds of trouble since it obfuscates the real behavior of the device and
makes it very hard for generic applications to understand what is going on.

It worked somewhat OK, when we had a simple hardware with a single fixed
sequencer where you could easily expose the sequencer settings as multiple
channels. But even for those what we expose to userspace is wrong. We only
get a single scan set for all enabled channels with a single timestamp, even
though when you use a sequencer these measurements are not taken at the same
time.

More recent hardware usually has a completely freely programmable sequencer,
this means it is possible to e.g. have a sample sequence like 1,2,1,3,...
this can currently not be modeled. We can't model sequences where one
channel is sampled more often than other and we can't model sequences where
the channel order is different from the default. Both are valid use cases
and not being able to support them hurts framework adoption. And even if
we'd model all the possible combinations we get a combinatorial explosion of
channels where only a subset can be selected at the same time which requires
complex validation routines.

There is also hardware with multiple ADCs, where each ADC has it's own MUX
and own sequencer and the ADCs do synchronous conversion. This is a
extension of the above case, which we can't model for similar reasons.

And then you have the case where you have external MUXs. These can either be
used together with internal sequencer or a external sequencer (e.g. just
some GPIOs). We can't model these either with the current approach since the
driver for the ADC would need to have support for the specific external MUX,
which doesn't really scale if you want to support different types of MUXs.

While this part only has a single ADC, it has multiple chained MUXs. Since
they are all internal you could model them as a single MUX and then by
extension the single ADC as multiple channels, but as Andrew said that leads
to state explosion, especially with the feedback paths.

Btw. I found the Comedi approach quite interesting:
http://www.comedi.org/doc/index.html#acquisitionterminology

Looking back I think this was one of the biggest mistakes we made in the IIO
ABI design, thinking that it was OK to hide the hardware complexities behind
a simplified view (Part of the problem is that the scope of IIO has grown
and back then we didn't really thing about the more complex usecases). If
you simplify at the lowest level there it is not possible to get the more
complex hardware representation which might be required for certain
applications. And to workaround the limitations you end up with all kind of
hacks and heuristics and hardware specific interfaces. On the other hand if
you adequately describe the hardware itself at the lowest level you can get
the information to those applications which need it and for those who don't
need it you can built simplified views on top.

Similar approaches can be seen in the e.g. the audio world, where ALSA
exposed the raw hardware capabilities and pulseaudio provides a simplified
view for simple applications. Or e.g. in the video world you now have the
new Vulcan API which exposes the raw hardware capabilities and simplified
APIs like OpenGL and DirectX are being built on top of it rather than being
at the lowest level themselves.

- Lars
