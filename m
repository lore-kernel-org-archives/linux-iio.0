Return-Path: <mtitinger@baylibre.com>
Subject: Re: [RFC 4/4] iio: ina2xx: add SOFTWARE buffer mode using an iio
 kfifo.
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, knaack.h@gmx.de, pmeerw@pmeerw.net
References: <1447171653-12756-1-git-send-email-mtitinger@baylibre.com>
 <1447171653-12756-5-git-send-email-mtitinger@baylibre.com>
 <56423613.6090403@metafoo.de> <5644675A.2080308@baylibre.com>
 <564780F6.5040300@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mturquette@baylibre.com, bcousson@baylibre.com, ptitiano@baylibre.com
From: Marc Titinger <mtitinger@baylibre.com>
Message-ID: <5649A3E1.4090106@baylibre.com>
Date: Mon, 16 Nov 2015 10:37:37 +0100
MIME-Version: 1.0
In-Reply-To: <564780F6.5040300@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 14/11/2015 19:44, Jonathan Cameron wrote:
> On 12/11/15 10:18, Marc Titinger wrote:
>> On 10/11/2015 19:23, Lars-Peter Clausen wrote:
>>> On 11/10/2015 05:07 PM, Marc Titinger wrote:
>>>> Capture the active scan_elements into a kfifo.
>>>> The capture thread will compute the remaining time until the next capture
>>>> tick, and do an active wait (udelay).
>>>>
>>>> This will produce a stream of up to fours channels plus a 64bits
>>>> timestamps (ns).
>>>>
>>>> # iio_readdev ina226 |  od -x
>>>> WARNING: High-speed mode not enabled
>>>> 0000000 042f 0d5a 002e 010c 4be8 4eb4 0013 0000
>>>> 0000020 0430 0d5a 002e 010c a704 4f3e 0013 0000
>>>> 0000040 0430 0d5a 002e 010c b477 4fc7 0013 0000
>>>> 0000060 042f 0d5b 002e 010c 8052 5050 0013 0000
>>>> 0000100 042f 0d5b 002e 010c 5d92 50d8 0013 0000
>>>> 0000120 0430 0d5a 002e 010c fa59 515e 0013 0000
>>>> 0000140 0430 0d5b 002e 010c 95d2 51e5 0013 0000
>>>>
>>>> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
>>
>> Hi Lars,
>>
>>>
>>> Interesting approach. I think if we are going to due this we want to make
>>> this kind of emulation generic. Have you seen the software trigger and
>>> configfs support patches[1] from Daniel? It kind of achieves the same as you
>>> do, but using hrtimers.
>>
>
>> I totally agree, let me have a look on those patches maybe I could
>> add an active waiting scheme for platforms w/o hrtimers ?

> I've no idea if this is a remotely common case any more but in theory
> I'd have no objection to such a patch though I would like it to be
> a stand alone trigger similar to that used in the patch Daniel has
> submitted.
>

Yes, I've started looking into something like a 'polling' trigger class. 
I understand that I'd need to support triggered buffer mode in the 
driver in this case. The current patch is rather simple, but having a 
generic and documented solution seems a good idea.

>>>
>>>>
>>>> ---
>>>> Ina2xx does not support auto-increment, hence the capture threads sticks
>>>> with single register reads instead of regmap_bulk_read.
>>>>
>>>> The proper scales must be applied to those raw register
>>>> values, I'm in favor of doing the conversion in userland in a client plugin
>>>
>>> Yes, conversion should not be done in kernel space, we don't want to impose
>>> the performance penalty on users which don't need it and you can typically
>>> do it faster in userspace anyway where you have floats and SSE and what not.
>>>
>>>> for instance a sigrok
>>>
>>> Slightly OT, but do you already have some Sigrok IIO support? I have this
>>> scheduled for end of the month, maybe we can align our strategies here and
>>> avoid duplicated work.
>>
>
>> How fortunate! I've started some preliminary work like cloning the
>> demo driver into a skeletton for 'hardware/generic-iio/api.c', adding
>> the build/ac plumbing, and linking to libiio with the idea of using
>> iio_info to create a generic enumeration of the iio-context into
>> sigrok channels.
>>
>> Now, I'm not familiar with Glib and it might not be my prio until a
>> couple of weeks, so I'd be super happy to wait for you if you are
>> keen to do that part :)
>>
>> What would be the best spot to chat about this ?
>>
>
>> Marc.
>>
>>
>>>
>>> - Lars
>>>
>>> [1] https://lkml.org/lkml/2015/8/10/877
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
