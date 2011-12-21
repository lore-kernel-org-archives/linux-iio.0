Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4EF1B670.2040306@analog.com>
Date: Wed, 21 Dec 2011 11:35:28 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: "J.I. Cameron" <jic23@cam.ac.uk>
CC: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: pll: New driver for ADF4350/ADF4351 Wideband Synthesizers
 (PLL)
References: <1323436951-11246-1-git-send-email-michael.hennerich@analog.com> <4EE36FA1.5070902@kernel.org> <4EE5D49E.7010507@analog.com> <4EE90733.9040304@kernel.org> <4EF05092.8050502@analog.com> <Prayer.1.3.4.1112201145580.21192@hermes-2.csi.cam.ac.uk>
In-Reply-To: <Prayer.1.3.4.1112201145580.21192@hermes-2.csi.cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 12/20/2011 12:45 PM, J.I. Cameron wrote:
> On Dec 20 2011, Michael Hennerich wrote:
>
>> On 12/14/2011 09:29 PM, Jonathan Cameron wrote:
>>> On 12/12/2011 10:17 AM, Michael Hennerich wrote:
>>>> On 12/10/2011 03:41 PM, Jonathan Cameron wrote:
>>>>> On 12/09/2011 01:22 PM, michael.hennerich@analog.com wrote:
>>>>>
>>> There is also the double indexes that we don't allow anywhere else.
>>> They are here because we have different waveforms with same underlying
>>> channel.  We could had a bonus optional index to all channels I suppose
>>> and have this as the only current user?  Or maybe just a flag to say its
>>> a 'subchannel' and use channel2.  Afterall these channels are neither
>>> going to have modifiers or to be differential so I can't see a clash
>>> occuring on the use of that...
>> Well one of the indexes with the DDS parts is used to distinguish
>> the tuning words options, in combination with the pincontrol feature.
>> PLL devices typically doesn't feature this.
>>
>> So bottom line - can we agree on:
>>
>> out_altvoltageX_freqY
>> out_altvoltageX_phaseY
>> out_altvoltageX_scale
>> out_altvoltageX_enable
>> ...
>> Where X stands for the output channel, and Y for some sort of option.
> Looks good as far as I am concerned. Might be worth a quick check through
> of dds and meter devices to see how we can extend this to cover them.

Hi Jonathan,

Looked at the various use cases. And the only user for the second
subindex seems to be the DDS parts.

I now wondering if we should handle freqY and phaseY by using extended_name,
rather than adding new postfixes for them. Which is going to be 
difficult anyways,
since I may need the current postfixes such as _scale as well.

out_altvoltageX_freqY_scale
out_altvoltageX_phaseY_scale

An alternative could be to introduce an indexed extended_name, using the index passed in channel2?
Not sure if it is worth adding it?



-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
