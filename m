Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44173 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbFUOOa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Jun 2015 10:14:30 -0400
Message-ID: <5586C6C0.8000307@kernel.org>
Date: Sun, 21 Jun 2015 15:14:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: hi-843x: Holt HI-8435/8436/8437 descrete
 ADC
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com> <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com> <55746D35.1030409@kernel.org> <55831CF3.3070906@metafoo.de> <55833B1D.8000407@cogentembedded.com>
In-Reply-To: <55833B1D.8000407@cogentembedded.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/06/15 22:41, Vladimir Barinov wrote:
> Hi Lars,
> 
> Thank you for the review.
> 
> On 18.06.2015 22:33, Lars-Peter Clausen wrote:
>> On 06/07/2015 06:11 PM, Jonathan Cameron wrote:
>>> On 01/06/15 13:20, Vladimir Barinov wrote:
>>>> Add Holt descrete ADC driver for HI-8435/8436/8437 chips
>>>>
>>>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
>>> Hmm. The main issue here is one man's discrete ADC is another man's
>>> configurable general purpose input device.
>>
>> The term discrete ADC is a bit ambiguous and I'm not even sure if this is the right term for this kind of device.
>> 

>> I'd call this a threshold detector. The device seems to have two
>> comparators for each channel, one for the lower threshold, one for
>> the upper threshold. If the voltage level goes above the upper
>> threshold a FF is set, if it goes below the lower threshold the FF
>> is cleared. Both transitions happen asynchronously as soon has the
>> signal is below/above the threshold. And while converts a analog
>> signal to digital one this is not what you typically call a ADC.
> 
> Should this be a separate/new directory in the drivers/iio/ for such driver?
Given we could in theory have comparators for any type of channel it probably doesn't
make sense to have a whole new directory.  Perhaps a section in the config.
> What the type of iio_chan_spec should I use instead of IIO_VOLTAGE?
I've been thinking about this.  Maybe we should use the same approach we already
use for 'computed' channel values such as root sum squared accelerations that turn
up occasionally and do this as a modifier.

So the channel type would be voltage, but with the modifier comparator (shortening
it would just get confusing).  This also maps nicely to devices that offer both
normal adc channels and comparators on the same pin (if that ever happens!)

Hence the attributes etc would be:
in_voltage0_comparator_raw

Do you think that would be clear / flexible enough?
> 
>>
>>>
>>> I wonder if we want to take this oportunity to add 1 bit packing to the
>>> demux etc in the IIO core so we can have tighter packing on these
>>> values.  Shouldn't be too hard to do and we probably do want it if we are
>>> going to support these sorts of devices.
>>>
>>> Will take a bit of shuffling to pack the relevant channels together if only
>>> a subset are enabled and to notice when no repacking at all is needed.
>>> This will probably first one implementing in the core and pushing out into
>>> the dummy driver to allow for testing of corner cases.
>> 
>> Yeah, the bit shuffling gets quite cumbersome and potentially
>> expensive. I think we should try to avoid it if at least one of the
>> channels in the same bank is enabled all of them are read. And then
>> let userspace figure out which bits it wants to use.
>> 
>> But how exactly is the typical expect usage of this device. Like
>> how would a userspace application use it? Is buffered mode where
>> samples are taken in a continuous mode something that is really
>> needed?
> I was expecting to use triggered buffer for this device:

> 1) setup threshold levels via sysfs
> 2) enable scan elements
> 3) setup trigger 
> 4) grab data from triggered iio buffer like the
> tools/iio/generic_buffer.c does, f.e. ./generic_buffer -n hi-8435 -t
> irqtrig0 -l 100 -c 1000
Good, you are going about it the right way then.  Makes sense as this
is what you'd do for similar devices such as a logic analyzer.
> 
> Actually I understand that I can just read manually the
> /sysfs/.../in_voltageXX_raw (or new/other name) values but using of
> iio generic irq trigger would be very good.
What is generating the interrupt?   Are we looking at a 'dataready'
type interrupt or some other pseudo (or actual) fixed frequency, or
are we talking an interrupt on the state of one of the inputs changing?

If the second case, then an event based approach may make more sense
than using buffers.
> 
> About bits shuffling/separating. I do think we can use banks byte
> length for one iio channel instead of 1-bit length to avoid such
> complexity. Then let user space separate bank's channels by itself.
On high channel count devices this could get nasty quickly.

I'd like to explore Lars' suggestion that we use shared scan_indexes
for a set of channels, and different shift / mask values.  I don't
think it would need any particularly substantial changes in kernel
and obviously only usespace code using this new type of device would
need to know about it. 

I'd relax the suggestion he made to have it always sample all channels
in a given scan index, to say that it can if it makes sense.  We won't
bother masking them out, but if it is quicker for the device to not read
those that aren't enabled, then it is up to the device whether it does.

The issue is that if we let a device in now with the 8bits per bit
interface, we kind of commit to at least having userspace support that
long term which isn't nice (though not too bad I suppose as it is just
the least efficient case of what we are talking about doing anyway).

Jonathan  
> 
> Regards,
> Vladimir
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
