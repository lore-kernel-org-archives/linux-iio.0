Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51653 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753510Ab3GBVHH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Jul 2013 17:07:07 -0400
Message-ID: <51D340F5.5020209@kernel.org>
Date: Tue, 02 Jul 2013 22:07:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>
Subject: Re: [PATCH] iio: add ds1077 programmable oscillator driver
References: <1371938043-3865-1-git-send-email-pmeerw@pmeerw.net> <51C87806.5000700@metafoo.de> <alpine.DEB.2.01.1306241932420.13960@pmeerw.net> <51C8887D.4080406@metafoo.de> <51CEACD8.7070804@kernel.org> <alpine.DEB.2.01.1306291659180.5368@pmeerw.net> <51D338C8.6000405@kernel.org> <alpine.DEB.2.01.1307022236270.32342@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1307022236270.32342@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/02/2013 09:49 PM, Peter Meerwald wrote:
> Hello Jonathan,
> 
>>>>>> the ds1077 is a small, separate chip which can generate a frequency; using 
>>>>>> IIO I can easily control that frequency from userspace
>>>>>>
>>>>>> clk seems to be targetted more at integrated clocksources that get 
>>>>>> activated automatically when needed by other components (maybe I am wrong)
>>>
>>>>> I think there is a userspace consumer for the clk API in the making.
>>>
>>> are you referring to this? https://patchwork.kernel.org/patch/2551831/
>>> I'm trying to figure out the status...
>> No idea on this I'm afraid, Lars?
> 
> I've been in contact with the person who proposed above patch (Soren);
> the proposal was rejected and he is not following up on it to get 
> it mainline due to lack of time/interest, it is going to be used in his 
> vendor tree only
I've just had a read of the thread. I can see why he gave up on it given
the resistence.

So what is your usecase for this chip that isn't just providing a clock to
some other on board component? (and hence a case where userspace control is
necessary)

> 
>>>> Just to jump on the end of this conversation, sorry Peter but this one definitely
>>>> looks to me like it belongs clk rather than IIO. If there wasn't a userspace
>>>> API in the making, I'd suggest now was the time to propose one as you
>>>> clearly have an application for one.
>>>
>>> fine; so far no reasons were given
>>> does that mean iio frequency is deprecated?
> 
>> So as you see it is a bit fuzzy at best, and sometimes I find myself deliberating
>> for some time on whether to push a driver in another direction from IIO or not.
>> I agreed to the existing frequency drivers on the basis that they didn't fit well
>> elsewhere, but if there is now a userspace clock interface in the works, perhaps
>> it is time to revisit these.
> 
> thank you for the background information
> 
>>> is there a fundamental difference between hardware supported in iio 
>>> frequency and the ds1077?
> 
>> Not a clear one, no.  The ds1077 to my reading is a very simple example of a programable
>> clock but ultimately I 'think' the other two are similar if more complex beasts with
>> perhaps rather different target uses. Note that whether they should go in IIO has was
>> raised at merge time for them. Honestly I'm more than a little lost in the relevant datasheets. I can verify the code is
> 
> ok, understood
> 
>> If there is a blured edge region where things don't fit in clk but do provide
>> functionality that does, then perhaps we need to do a similar job to iio-hwmon?
>> This might be true for some of the DDS parts which can be used as clocks, but
>> would be a very expensive way of doing that.
> 
> I'll keep looking at clk to see what's going on there (if anything :)
> 
> thanks, regards, p.
> 
