Return-Path: <peda@axentia.se>
Subject: Re: [PATCH 0/4] IIO wrapper drivers, dpot-dac and envelope-detector
To: <jic23@kernel.org>
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <9b8c0789-566d-67a3-b4f5-dbe4c69f6932@metafoo.de>
 <8B9238AE-D53C-4A22-84CF-EC42FDA2DFB2@jic23.retrosnub.co.uk>
 <DB170A5C-B172-4B86-80D5-58FD53752ED4@jic23.retrosnub.co.uk>
 <ba941bcd-c542-b699-638f-3b3003e8af00@axentia.se>
 <736c146284d93633a4692b1102eaadaf@jic23.retrosnub.co.uk>
CC: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, Lars-Peter Clausen
	<lars@metafoo.de>, <linux-kernel@vger.kernel.org>, Hartmut Knaack
	<knaack.h@gmx.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio-owner@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <28861d1d-7f50-7ea2-f8cb-5a9d359f74c0@axentia.se>
Date: Fri, 21 Oct 2016 10:24:24 +0200
MIME-Version: 1.0
In-Reply-To: <736c146284d93633a4692b1102eaadaf@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2016-10-21 09:17, jic23@kernel.org wrote:
> On 20.10.2016 19:17, Peter Rosin wrote:
>> On 2016-10-20 19:37, Jonathan Cameron wrote:
>>> http://marc.info/?l=linux-iio&m=138469765309868&w=2 I think...
>>
>> Interesting, one issue with that is that it is all in real world
>> units, while I'd rather have the raw value.
> Um.. It's been a while, but the principle was (IIRC) that every
> _available would match the units fo the associated info mask element.
> Thus if you have a _raw element it would be in adc counts (most likely).
> 
> _input would be in relevant real world units, scale etc in the whatever
> units the value itself is in.

Ah, that was just me totally misreading the patch. I didn't realize
that the iio_format_value function is also used for raw values and
assumed it was all about real world units when that function was
used. Feel rather silly ATM...

>> So, I would need to
>> convert back to the raw value using the scale, which sounds boring
>> but doable. However, I wonder if calibration may also be involved
>> with that conversion back to raw for some channels? That sounds a
>> bit more driver specific and potentially troublesome...
> I've not had a chance to look at your code (only picked up on this as
> there was a fair length thread developing), but I wouldn't have thought 
> we'd
> need to deal with calibrations.   Might need them to move to real world
> units from raw but that's always the case anyway (unfortunately).

Right.

Cheers,
Peter
