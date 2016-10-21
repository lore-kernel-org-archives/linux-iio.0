Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45835 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752603AbcJUHRC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2016 03:17:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 21 Oct 2016 08:17:00 +0100
From: jic23@kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio-owner@vger.kernel.org
Subject: Re: [PATCH 0/4] IIO wrapper drivers, dpot-dac and envelope-detector
In-Reply-To: <ba941bcd-c542-b699-638f-3b3003e8af00@axentia.se>
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <9b8c0789-566d-67a3-b4f5-dbe4c69f6932@metafoo.de>
 <8B9238AE-D53C-4A22-84CF-EC42FDA2DFB2@jic23.retrosnub.co.uk>
 <DB170A5C-B172-4B86-80D5-58FD53752ED4@jic23.retrosnub.co.uk>
 <ba941bcd-c542-b699-638f-3b3003e8af00@axentia.se>
Message-ID: <736c146284d93633a4692b1102eaadaf@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20.10.2016 19:17, Peter Rosin wrote:
> On 2016-10-20 19:37, Jonathan Cameron wrote:
>> On 20 October 2016 18:30:19 BST, Jonathan Cameron 
>> <jic23@jic23.retrosnub.co.uk> wrote:
>>> On 20 October 2016 13:55:12 BST, Lars-Peter Clausen <lars@metafoo.de> 
>>> wrote:
>>>> On 10/20/2016 11:25 AM, Peter Rosin wrote:
>>>>> Also, is there some agreed-upon way to dig out the maximum value 
>>>>> from
>>>>> an iio channel? If so, "dpot-dac,max-ohms" can be eliminated from 
>>>>> the
>>>>> dt bindings, which would have been nice...
>>>> 
>>>> Yes, this is something we could really use. In a sense it exists for
>>>> the
>>>> devices with buffer-capable channels where there is the real_bits 
>>>> field
>>>> which tells us the data width of the channel. But a dedicated 
>>>> mechanism
>>>> for
>>>> querying the maximum (and minimum) valid code seems like a useful
>>>> feature.
>>>> Not only for in-kernel clients, but also for userspace.
>>> 
>>> This was something that was addressed by the rather ancient patch
>>> series i posted that added
>>> an available call back which provided info on range and values for 
>>> all
>>> info mask elements.
>>> Series got buried by there being a lot of precursors but quite a few 
>>> of
>>> those have merged since.
>>> 
>>> Hmm Google won't let me find it on my phone. Was a while back now. 
>>> Will
>>> try to get on pc with
>>> decent email archive later and dig out a reference.
>> http://marc.info/?l=linux-iio&m=138469765309868&w=2 I think...
> 
> Interesting, one issue with that is that it is all in real world
> units, while I'd rather have the raw value.
Um.. It's been a while, but the principle was (IIRC) that every
_available would match the units fo the associated info mask element.
Thus if you have a _raw element it would be in adc counts (most likely).

_input would be in relevant real world units, scale etc in the whatever
units the value itself is in.

> So, I would need to
> convert back to the raw value using the scale, which sounds boring
> but doable. However, I wonder if calibration may also be involved
> with that conversion back to raw for some channels? That sounds a
> bit more driver specific and potentially troublesome...
I've not had a chance to look at your code (only picked up on this as
there was a fair length thread developing), but I wouldn't have thought 
we'd
need to deal with calibrations.   Might need them to move to real world
units from raw but that's always the case anyway (unfortunately).

Jonathan
> 
> Cheers,
> Peter
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
