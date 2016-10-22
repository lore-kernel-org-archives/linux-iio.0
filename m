Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52902 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935471AbcJVO0t (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 10:26:49 -0400
Subject: Re: [PATCH 0/4] IIO wrapper drivers, dpot-dac and envelope-detector
To: Peter Rosin <peda@axentia.se>
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <9b8c0789-566d-67a3-b4f5-dbe4c69f6932@metafoo.de>
 <8B9238AE-D53C-4A22-84CF-EC42FDA2DFB2@jic23.retrosnub.co.uk>
 <DB170A5C-B172-4B86-80D5-58FD53752ED4@jic23.retrosnub.co.uk>
 <ba941bcd-c542-b699-638f-3b3003e8af00@axentia.se>
 <736c146284d93633a4692b1102eaadaf@jic23.retrosnub.co.uk>
 <58b9c20d-6c3c-4693-b073-e5a8f9c4cb94@axentia.se>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio-owner@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6831bef2-78f6-d5dd-ee62-ffa50ad7a757@kernel.org>
Date: Sat, 22 Oct 2016 15:26:45 +0100
MIME-Version: 1.0
In-Reply-To: <58b9c20d-6c3c-4693-b073-e5a8f9c4cb94@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/10/16 23:58, Peter Rosin wrote:
> On 2016-10-21 09:17, jic23@kernel.org wrote:
>> On 20.10.2016 19:17, Peter Rosin wrote:
>>> On 2016-10-20 19:37, Jonathan Cameron wrote:
>>>> On 20 October 2016 18:30:19 BST, Jonathan Cameron 
>>>> <jic23@jic23.retrosnub.co.uk> wrote:
>>>>> On 20 October 2016 13:55:12 BST, Lars-Peter Clausen <lars@metafoo.de> 
>>>>> wrote:
>>>>>> On 10/20/2016 11:25 AM, Peter Rosin wrote:
>>>>>>> Also, is there some agreed-upon way to dig out the maximum value 
>>>>>>> from
>>>>>>> an iio channel? If so, "dpot-dac,max-ohms" can be eliminated from 
>>>>>>> the
>>>>>>> dt bindings, which would have been nice...
>>>>>>
>>>>>> Yes, this is something we could really use. In a sense it exists for
>>>>>> the
>>>>>> devices with buffer-capable channels where there is the real_bits 
>>>>>> field
>>>>>> which tells us the data width of the channel. But a dedicated 
>>>>>> mechanism
>>>>>> for
>>>>>> querying the maximum (and minimum) valid code seems like a useful
>>>>>> feature.
>>>>>> Not only for in-kernel clients, but also for userspace.
>>>>>
>>>>> This was something that was addressed by the rather ancient patch
>>>>> series i posted that added
>>>>> an available call back which provided info on range and values for 
>>>>> all info mask elements.
>>>>> Series got buried by there being a lot of precursors but quite a few of
>>>>> those have merged since.
>>>>>
>>>>> Hmm Google won't let me find it on my phone. Was a while back now. 
>>>>> Will
>>>>> try to get on pc with
>>>>> decent email archive later and dig out a reference.
>>>> http://marc.info/?l=linux-iio&m=138469765309868&w=2 I think...
>>>
>>> Interesting, one issue with that is that it is all in real world
>>> units, while I'd rather have the raw value.
>> Um.. It's been a while, but the principle was (IIRC) that every
>> _available would match the units fo the associated info mask element.
>> Thus if you have a _raw element it would be in adc counts (most likely).
>>
>> _input would be in relevant real world units, scale etc in the whatever
>> units the value itself is in.
> 
> Ok, so I forward ported that patch and added code so that the relevant
> channels provide what is available. I also added code to turn the
> rest of the parameter style devicetree properties into iio device/channel
> attributes. So, it is now much neater from a bindings point of view.
> 
> Before I post the updated patches, I'm wondering what the status is
> on that ancient patch? It didn't forward port without issues, but there
> were no real difficulties that I noticed. Should I just start off my v2
> series with that patch? I tend to think that that's the best option,
> because I suspect that adding a "max-ohms" devicetree property as a
> stop-gap pending some new infrastructure is pretty unrealistic...
> 
> Basically, my question is if that ancient patch as any chance of living
> at all in a form close to what it is, or if should start looking for
> an alternative right away?
The stoppers (IIRC) were that at the time we had a lot of drivers not
making full use off the info_mask stuff so there were a whole load
of precursor patches.  A lot of those have been done since, so we are
probably much more ready for it.

The controversial bit was the question of how to describe ranges, but
I don't think that got all that much attention back then.

If you are happy to take on looking after that series I'd certainly
be very happy!   3 years kind of implies I'm not going to get to
it particularly soon myself :(

Will be interesting to see what reviews we get of it when you post it
though.   Perhaps we deliberately push it into drivers only slowly
initially so that if we decide it was a horrible mistake (or that we
need to make changes to the ABI) we only end up supporting obsolete
ABI in a few drivers...

So a slowly but surely one perhaps rather than mass adoption.

Jonathan
> 
> Cheers,
> Peter
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

