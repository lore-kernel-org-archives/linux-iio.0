Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48285 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752966AbdCMVZm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 17:25:42 -0400
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: adc: Replace mlock with
 driver private lock
To: Lars-Peter Clausen <lars@metafoo.de>,
        Gargi Sharma <gs051095@gmail.com>,
        Alison Schofield <amsfield22@gmail.com>
References: <1489351546-21008-1-git-send-email-gs051095@gmail.com>
 <alpine.DEB.2.20.1703122154130.7649@hadrien>
 <CAOCi2DH9bNChZj4kyt3t1eK7R7uSv77zeVc2PkPYxoRDDHZLsA@mail.gmail.com>
 <alpine.DEB.2.20.1703122235320.7649@hadrien>
 <20170312221350.GA14070@d830.WORKGROUP>
 <CAOCi2DEyu6_bBjsrSFzf0VcXcUnZ3LugLf==R9zsSmj+1JdFKw@mail.gmail.com>
 <35231dfd-af42-bbd3-3be6-4e03a728a92f@kernel.org>
 <73d214e0-46d0-0d4a-27e1-7c85cf3c05ed@metafoo.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
        outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <883ac15c-8030-2d9b-1a5e-2077eddfe194@kernel.org>
Date: Mon, 13 Mar 2017 21:25:39 +0000
MIME-Version: 1.0
In-Reply-To: <73d214e0-46d0-0d4a-27e1-7c85cf3c05ed@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/03/17 20:54, Lars-Peter Clausen wrote:
> On 03/13/2017 09:51 PM, Jonathan Cameron wrote:
> [...]
>>>> Gargi,
>>>>
>>>> Please insert the new lock above the __cacheline_aligned struct
>>>> member.
>>>
>>> I will do that, but is there any reason why the lock should be above
>>> ____cacheline_aligned struct member?
>> Yes.  It's in fact very important that nothing comes after that.
>>
>> Will leave the why as an exercise for the reader.   I'll give the
>> hit of spi drivers that do DMA...
> 
> 
> One hint though, the answer is somewhere in Documentation/DMA-API.txt
Took me a while to come across this one when I first started writing SPI
drivers ;)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

