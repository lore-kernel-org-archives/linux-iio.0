Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53526 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbcAPMxa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Jan 2016 07:53:30 -0500
Subject: Re: [PATCH 2/2] iio: light: opt3001: enable operation w/o IRQ
To: Alexander Koch <mail@alexanderkoch.net>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1452622180-12728-1-git-send-email-mail@alexanderkoch.net>
 <1452622180-12728-3-git-send-email-mail@alexanderkoch.net>
 <alpine.DEB.2.02.1601122024340.10606@pmeerw.net>
 <56955F43.90705@alexanderkoch.net> <569A3D06.80701@kernel.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, mhornung.linux@gmail.com,
	dannenberg@ti.com, balbi@ti.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <569A3D48.8040703@kernel.org>
Date: Sat, 16 Jan 2016 12:53:28 +0000
MIME-Version: 1.0
In-Reply-To: <569A3D06.80701@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/16 12:52, Jonathan Cameron wrote:
> On 12/01/16 20:17, Alexander Koch wrote:
>> Am 12.01.2016 um 20:27 schrieb Peter Meerwald-Stadler:
>>> On Tue, 12 Jan 2016, Alexander Koch wrote:
>>>
>>>> Enable operation of the TI OPT3001 light sensor without having an
>>>> interrupt line available to connect the INT pin to.
>>>>
>>>> In this operation mode, we issue a conversion request and simply wait
>>>> for the conversion time available as timeout value, determined from
>>>> integration time configuration and the worst-case time given in the data
>>>> sheet (sect. 6.5, table on p. 5):
>>>>
>>>>   short integration time (100ms): 110ms + 3ms = 113ms
>>>>    long integration time (800ms): 880ms + 3ms = 883ms
>>>>
>>>> This change is transparent as behaviour defaults to using the interrupt
>>>> method if an interrupt no. is configured via device tree. Interrupt-less
>>>> operation mode is performed when no valid interrupt no. is given.
>>>
>>> looks good, I'd rather use a bool for use_irq and the msecs_to_jiffies() 
>>> call moved from the #define to the code (which is not strictly necessary 
>>> for the patch) -- matter of taste
>>
>> Thanks - actually this is my first patch, so positive feedback much
>> appreciated!
>>
>> Concerning the bool for 'use_irq': I first had it that way but then
>> opted for the bit field of length 1 as I wasn't sure whether bool would
>> get optimized to the same level by the compiler.
> Bit fields are often less efficient as the compiler has to separate them out
> using shifts and masks.  Also from a space point of view the data structure
> will be considerably padded anyway for a couple of reasons:
> 1) It contains u32 fields so will at least be padded to a multiple of u32.
> 2) Memory allocations may well be a good bit larger depending on exact
> sizes vs the blob levels available in the memory allocator.
> 
> Basic rule of thumb - keep things simple and let the compiler do the work.
> So a bool is suitable here.
> 
>>
>> I'm a bit irritated by your comment concerning the msecs_to_jiffies()
>> call, as my patch indeed moves this call from the #define to the code.
>> Did you mean it the other way round, then?
> Presumably ;) 
>> My reason to move it was that I need to work with microseconds for the
>> IRQ-less operation mode, and jiffies are only required in one place for
>> the IRQ mode.
> Now perhaps the 'right' way to do this would be have been a precursor patch
> removing the define rather than lumping what is an an connected change (in
> many ways) in here.  Overall I agree the change is worthwhile and trivial.
> As Peter said, it's a matter of taste!  We both happen to disagree with him
> on this point.

ps. Should have said that other than the bit field vs bool change, the patch
looks good to me.

Jonathan
>>
>>
> 	> Best regards
>>
>> lynix
>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

