Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58016 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3IGTvJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 15:51:09 -0400
Message-ID: <522B91C5.6000101@kernel.org>
Date: Sat, 07 Sep 2013 21:51:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/9] staging: iio: ad7192: Use devm_* APIs
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org> <52223664.7000803@kernel.org> <CAK9yfHy_NR=dMr2j2wPVks3PX79U04J5eBSmkOku+949sZZm4g@mail.gmail.com>
In-Reply-To: <CAK9yfHy_NR=dMr2j2wPVks3PX79U04J5eBSmkOku+949sZZm4g@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/13 06:51, Sachin Kamat wrote:
> On 1 September 2013 00:01, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 08/31/13 18:12, Sachin Kamat wrote:
>>> devm_* APIs are device managed and make code simpler.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> ---
>>> This series is compile tested and based on togreg branch
>>> of iio tree.
>>
>> Just to note, there is a memory leak fixed by this patch as well
>> as the remove function didn't free the struct iio_dev before.
> 
> Yes. I forgot to mention that in the commit log. Thanks for noticing.
> 
>>
>> Thanks for these Sachin.  All look good to me.
>> I won't take them today as effectively IIO for 3.12 is now
>> closed, as I doubt we'll see more than one more rc on
>> 3.11, and others may want to have time to look through these.
> 
> I wasn't aware of it, sorry.
> 
>>
>> I'll pick them up in a few days and queue up for 3.13 assuming
>> no one spots anything I have missed.
> 
> Sure. Thanks.

All applied to the togreg branch of iio.git.

Thanks as ever for your work on these!

Jonathan
