Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:59843 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752805Ab3DNS2l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Apr 2013 14:28:41 -0400
Message-ID: <516AF5EA.4040404@metafoo.de>
Date: Sun, 14 Apr 2013 20:31:06 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3]  staging:iio:adis16130 bits and bobs.
References: <1365938625-21778-1-git-send-email-jic23@kernel.org> <516A9F1B.5060407@metafoo.de> <516AED37.6030204@kernel.org> <516AEDD1.9050206@kernel.org>
In-Reply-To: <516AEDD1.9050206@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/14/2013 07:56 PM, Jonathan Cameron wrote:
> On 04/14/2013 06:53 PM, Jonathan Cameron wrote:
>> On 04/14/2013 01:20 PM, Lars-Peter Clausen wrote:
>>> On 04/14/2013 01:23 PM, Jonathan Cameron wrote:
>>>> Hi All,
>>>>
>>>> Had a few bored moments so thought I'd take a quick look at this driver.
>>>> The read function is rather odd to say the least, Lars/Michael could one of
>>>> you take a quick look at this.  Right now it does an spi sync that I think
>>>> should read the data and follows it with an additional read.  I can't
>>>> immediately see what the read is for.
>>>
>>> Yea I noticed that too, I think that read was introduced by accident during
>>> some refactoring. See
>>> https://github.com/lclausen-adi/linux-2.6/commit/1889f3a5d291ad57a5faed83652c465de29d740f
>> oops.
>>>
>>> Unfortunately I couldn't get my hands on a adis16030 board yet to test those
>>> changes otherwise I'd already submitted them.
>> I did wonder why this one had slipped through your net.
>>
>> Even untested, I'd be tempted to apply your patch.  What is there is pretty
>> obviously garbage whereas yours is probably right!  I guess it depends on time
>> scales for getting the part.
>>
>>>
>>>>
>>>> Also note the introduction of IIO_INT_PLUS_PICO which is going to be common
>>>> with 24 bit plus devices.  For now I've ignored the write case as this driver
>>>> doesn't support it, but it will be needed if for example 24/16 bit options
>>>> are both supported for this driver.
>>>>
>>>> Note to my mind this device is far enough away from the other adis parts
>>>> in interface to justify it's own driver.
>>>
>>> Yes.
>>>
>>>>
>>>> Also could someone check my scale/offset calcs are right. It's Sunday
>>>> morning and I'm not feeling all that awake ;)
>>>>
>>>
>>> For temp scale you seem to be off by a factor of 1000000 (well or maybe
>>> I'm), otherwise I got the same.
>> oops :)  Divide vs multiply...
>>
>> Will post a v2 in a few mins for what we had here and let you handle
>> the interesting read as you like.
> 
> Actually seeing as you have similar patches queued up in your tree I'll
> leave it all for you and take the lazy way out ;)
> 
> *continues looking about in the tree you referenced to see what other nuggets
> you are working on :)*

Nothing really in there, it's more of a junkyard ;)

- Lars

