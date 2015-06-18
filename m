Return-Path: <lars@metafoo.de>
Message-ID: <55831CF3.3070906@metafoo.de>
Date: Thu, 18 Jun 2015 21:33:07 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
 Vladimir Barinov <vladimir.barinov@cogentembedded.com>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Rob Herring <robh+dt@kernel.org>,
 Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
 Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: hi-843x: Holt HI-8435/8436/8437 descrete
 ADC
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com> <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com> <55746D35.1030409@kernel.org>
In-Reply-To: <55746D35.1030409@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 06/07/2015 06:11 PM, Jonathan Cameron wrote:
> On 01/06/15 13:20, Vladimir Barinov wrote:
>> Add Holt descrete ADC driver for HI-8435/8436/8437 chips
>>
>> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Hmm. The main issue here is one man's discrete ADC is another man's
> configurable general purpose input device.

The term discrete ADC is a bit ambiguous and I'm not even sure if this is 
the right term for this kind of device.

I'd call this a threshold detector. The device seems to have two comparators 
for each channel, one for the lower threshold, one for the upper threshold. 
If the voltage level goes above the upper threshold a FF is set, if it goes 
below the lower threshold the FF is cleared. Both transitions happen 
asynchronously as soon has the signal is below/above the threshold. And 
while converts a analog signal to digital one this is not what you typically 
call a ADC.

>
> Anyhow, from an IIO point of view what we care about is consistent
> userspace interface. A discrete ADC to userspace is definitely a generic
> input, be it one with a configurable threshold level and other bells
> and whistles.
>
> Right now IIO does not have explicit support for digital I/O channels,
> but it's been discussed many times before.  We do want some buy in from
> the GPIO infrastructure guys though to avoid stepping on peoples toes!
> Also I suspect we'd need an IIO to gpio bridge pretty soon as well
> as the likelihood of someone using the gpios in an IIO device to save
> themselves some pins on their soc is very high.
>
> There are generic gpios on some of the IMUs and similar, but they have
> always been ignored in drivers, or just handled by registering them as
> a GPIO rather than through the buffered interfaces etc.  I suspect if
> the core support was in place, there would be interesting in this
> functionality.
>
> Lars, you've looked at the demux stuff a lot more recently than I have.
> One issue this driver raises is single bit channels. For those I think
> we need to support 1 bit packing throughout.  How hard do you think it
> would be?
> (1 bit, 8 bit, 16 bit, 32 bit, 64 bit etc) rather than any more complex
> packing.

Yea, good question. Would definitely need some changes to the core. But it 
is also definitely something we should do. The current approach taken by 
this driver is rather hackish and works around the limitations of the 
framework. This is something that more often than not leads to long term issues.

We'd kind of need a mechanism to say that multiple channels are contained 
within the same word. Maybe something like setting the same scan_index for 
those channels but with different shift offsets could work?

So say storagebits is 8, realbits is 1 and shift is depending on the 
position of the bit in the byte. All channels in the same byte would get the 
same scan index.

This could also be used to handle some of the devices which have additional 
metadata status information in the otherwise unused bits in the result word.

[...]
>> +#define HI843X_VOLTAGE_CHANNEL(num)				\
>> +	{							\
>> +		.type = IIO_VOLTAGE,				\
>> +		.indexed = 1,					\
>> +		.channel = num,					\
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),	\
>> +		.scan_index = num,				\
>> +		.scan_type = {					\
>> +			.sign = 'u',				\
>> +			.realbits = 1,				\
>> +			.storagebits = 8,			\
>> +		},						\
>> +	}
> As commented at the start of this review. These are not voltage channels
> as userspace understands them (I understand from a hardware point of
> view where you are coming from but we have to care about what the software
> using them cares about!)
>
> These are digital signals and need to be treated as such.

Exactly my thoughts as well.

>
> I wonder if we want to take this oportunity to add 1 bit packing to the
> demux etc in the IIO core so we can have tighter packing on these
> values.  Shouldn't be too hard to do and we probably do want it if we are
> going to support these sorts of devices.
>
> Will take a bit of shuffling to pack the relevant channels together if only
> a subset are enabled and to notice when no repacking at all is needed.
> This will probably first one implementing in the core and pushing out into
> the dummy driver to allow for testing of corner cases.

Yeah, the bit shuffling gets quite cumbersome and potentially expensive. I 
think we should try to avoid it if at least one of the channels in the same 
bank is enabled all of them are read. And then let userspace figure out 
which bits it wants to use.

But how exactly is the typical expect usage of this device. Like how would a 
userspace application use it? Is buffered mode where samples are taken in a 
continuous mode something that is really needed?
