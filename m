Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59044 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752089AbcDRNm6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 18 Apr 2016 09:42:58 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Mon, 18 Apr 2016 14:42:55 +0100
From: jic23@jic23.retrosnub.co.uk
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, linux-iio@vger.kernel.org,
	linux-iio-owner@vger.kernel.org
Subject: Re: Question about differential muxing
In-Reply-To: <5714CD81.6000100@metafoo.de>
References: <5711362A.1020700@ti.com> <57123BA0.4070501@kernel.org>
 <5714CD81.6000100@metafoo.de>
Message-ID: <ad4731130339ef86e98f31065f1489b7@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18.04.2016 13:05, Lars-Peter Clausen wrote:
> On 04/16/2016 03:18 PM, Jonathan Cameron wrote:
> [...]
>>> The other issue is with the input pins, I believe the standard way to
>>> handle this is by exposing every mux setting as a separate channel, 
>>> then
>>> only allowing one bit set in the scan mask, but for this part, when 
>>> all
>>> differential combinations are exposed we have more than 100 channels,
>>> and the other part I'm working on makes this several times worse.
>>> 
>>> Could someone point to any information, or an existing driver, that
>>> explains the preferred way to handle this?
>> You have it correct above.  At the end of the day there isn't much we 
>> can
>> do to provide a compact yet general interface and occasionally we do 
>> end
>> up with an awful lot of channels.  There are some analog devices 
>> battery
>> chargers for example that end up as a cascade resulting in similar 
>> numbers
>> of channels.
>> 
>> Each channel doesn't cost us that much other than making for a big set 
>> of
>> files.
>> 
>> Doing it as mux switches would work, but be extremely difficult to 
>> describe
>> simply to userspace in any way that would generalize.  The resulting 
>> programs
>> would have to know too much about the sensor routing or to have a lot
>> of complexity decoding how to set up the channel combinations they 
>> actually
>> want.
>> 
>> As for existing drivers... Hmm. any of the differential ADC drivers 
>> provide a
>> reference of sorts. For high channel counts, the ad7280a driver is 
>> still in
>> staging but the principles are fine...
>> 
>> Lars, any input on this sort of highly complex device?  Looks a bit 
>> like some
>> of the more nuts audio chips in some ways.
> 
> In my opinion we need to model MUXs and assorted sequencers properly in 
> IIO
> and not hide the real hardware topology behind a simplified view. It 
> causes
> all kinds of trouble since it obfuscates the real behavior of the 
> device and
> makes it very hard for generic applications to understand what is going 
> on.
Conversely it makes for an interface that is simple to use.  I'd like to 
maintain
that simplicity (but allow for the complexity as well!) Just to make 
life
harder ;)
> 
> It worked somewhat OK, when we had a simple hardware with a single 
> fixed
> sequencer where you could easily expose the sequencer settings as 
> multiple
> channels. But even for those what we expose to userspace is wrong. We 
> only
> get a single scan set for all enabled channels with a single timestamp, 
> even
> though when you use a sequencer these measurements are not taken at the 
> same
> time.
The intent there was always to support description of the relative 
timings - we'd
need to do that for any sequencer description anyway.  The comedi stuff 
does
precisely that sort of description for example (and includes the various 
elements
that we would need).  It got discussed at various times, but hasn't 
actually
gotten implemented yet.  Worth keeping in mind that the description of 
this
stuff can obviously get very complex.  Setup times can vary depending on 
the
exact sequence for example.
> 
> More recent hardware usually has a completely freely programmable 
> sequencer,
> this means it is possible to e.g. have a sample sequence like 
> 1,2,1,3,...
> this can currently not be modeled. We can't model sequences where one
> channel is sampled more often than other and we can't model sequences 
> where
> the channel order is different from the default. Both are valid use 
> cases
> and not being able to support them hurts framework adoption. And even 
> if
> we'd model all the possible combinations we get a combinatorial 
> explosion of
> channels where only a subset can be selected at the same time which 
> requires
> complex validation routines.
The complex sequencer is indeed a case we currently dodge around at the 
moment.
It's actually worse than you describe as we can also have interleved 
multiple
sequences on different clocks that interact with each other and have 
priority
levels... The sort of hardware that I'm not sure can be described in 
less than
a few pages of big diagrams.

I have no problem with proposals to support this sort of complexity - 
even a
wholesale replacement for the scan_elements stuff is fine - though 
ideally any
such new framework would allow that also to work as it does cover the 
most common
case (or would with a little extra description).

There are devices out there that support effectively unlimited sequencer 
lengths
- how do we support those?  They stop being a scan in any sense - but 
become an
arbitrary stream of readings.  The meta data itself becomes complex 
enough that
you can't really put it in the buffers either.  Perhaps if we restrict 
things to
a 'short' length then things can remain manageable.  This stuff gets 
really hard
to describe really quickly - even when you describe the muxes 
explicitly.

Funnily enough the other really nasty cases to describe generically are 
internal
sequencers.  Often, though there is a general MUX in the part supporting 
any
combination, the sequencer only supports a random (complicated) subset 
of
possible sequences.  Those would need describing as well... Or we are 
back to
the complex validation logic that currently causes us trouble.  That's 
what drove
the available_scan_masks approach in the first place (good old max1363 
and
friends)
> 
> There is also hardware with multiple ADCs, where each ADC has it's own 
> MUX
> and own sequencer and the ADCs do synchronous conversion. This is a
> extension of the above case, which we can't model for similar reasons.

This is also reasonable to want to fully support, but how do you 
describe it?
As you've highlighted the simple read one channel with a given mux setup 
is
straight forward.  How do you provide sane meta data to set up a 
sequence of
such readings with multiple muxes switching (possibly several levels 
deep) to
multiple ADCs?

I think you'd have to apply some sort of model that limits what can 
happen if
you want a userspace interface (even via a library) that can describe 
such muxes.
That's kind of where we ended up with a description based on what was 
actually
read, rather than how it was done.

Perhaps step one in any work on this is to define the model we are going 
to
apply.  I'm not sure we can make it arbitrary. Even Vulkan defines a 
fairly
strict model it seems.
> 
> And then you have the case where you have external MUXs. These can 
> either be
> used together with internal sequencer or a external sequencer (e.g. 
> just
> some GPIOs). We can't model these either with the current approach 
> since the
> driver for the ADC would need to have support for the specific external 
> MUX,
> which doesn't really scale if you want to support different types of 
> MUXs.

Sure - this one has been bothering me for a while.  Conceptually we 
could handle
this as the mux being a client device of the IIO ADC, effectively 
reformatting
the buffered data as it passes through (In fact I think we may 
ultimately do
it this way, even if we have a better description of muxes in general)

The same is true for any front end device - we ultimately need to invert 
whatever
the front end has done to establish what the original input is.  This 
could be
as simple as a potential divider halving the voltage.  That could be 
done as
a simple consumer driver that pushes the data straight through but 
adjusts the
reported scale.  An external MUX (not driven by a device based 
sequencer) is much
the same. Synchronizing could get a little 'exciting', but shouldn't be 
impossible
using input and output buffers running off the same triggers.

A device driven external sequencer is to my mind the same as one inside 
the device.
It might need a little more description of course and there may be 
places
to sensibly use library code to help handle it (some of which may be 
shared with
the external muxes support).

> 
> While this part only has a single ADC, it has multiple chained MUXs. 
> Since
> they are all internal you could model them as a single MUX and then by
> extension the single ADC as multiple channels, but as Andrew said that 
> leads
> to state explosion, especially with the feedback paths.
> 
> Btw. I found the Comedi approach quite interesting:
> http://www.comedi.org/doc/index.html#acquisitionterminology
> 
> Looking back I think this was one of the biggest mistakes we made in 
> the IIO
> ABI design, thinking that it was OK to hide the hardware complexities 
> behind
> a simplified view (Part of the problem is that the scope of IIO has 
> grown
> and back then we didn't really thing about the more complex usecases). 
> If
> you simplify at the lowest level there it is not possible to get the 
> more
> complex hardware representation which might be required for certain
> applications. And to workaround the limitations you end up with all 
> kind of
> hacks and heuristics and hardware specific interfaces. On the other 
> hand if
> you adequately describe the hardware itself at the lowest level you can 
> get
> the information to those applications which need it and for those who 
> don't
> need it you can built simplified views on top.

I still think we need that simple view, even at the kernel boundary.  I 
think
that if we'd gone straight for the most complex option we would have 
ended up
with poor adoption due to the barrier to entry that would provide.

The intent was always to fall back to an interface no more complex than
hwmon and I think having that was and is vital to the subsystem.  When a 
device
is simple, it should look simple.

> 
> Similar approaches can be seen in the e.g. the audio world, where ALSA
> exposed the raw hardware capabilities and pulseaudio provides a 
> simplified
> view for simple applications. Or e.g. in the video world you now have 
> the
> new Vulcan API which exposes the raw hardware capabilities and 
> simplified
> APIs like OpenGL and DirectX are being built on top of it rather than 
> being
> at the lowest level themselves.
> 
It's an interesting balance for where you provide the exposure of this 
complexity.

I have no objection at all to providing a means to describe this 
complexity.
We certainly aren't limited to what we currently have in the way of 
interface.

However, we are dealing with a nasty case - you could I suppose compare 
it to an
alsa system with dozens of parallel channels - each with a mux / 
processing
description that could be a large number levels deep. Each of which has 
a variable
timing offset wrt to the others. Every element in a scan needs it's own 
description
of how it is muxed... At least in ALSA type devices you tend to have 
only a few
paths going on at a time.

It's fiddly and I'm not certain we can get to an ultimate answer to 
everything
in one go (we certainly haven't so far!).
In the meantime we have to work with what we have.  If we have 
oversimplified a
particular device description to make it work with current frameworks, 
then as long
as the defaults are right, nothing stops us adding more interface to 
describe it
better in the future!

Jonathan
