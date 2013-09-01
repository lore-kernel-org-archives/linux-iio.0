Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:34501 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3IAFv5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Sep 2013 01:51:57 -0400
Received: by mail-oa0-f43.google.com with SMTP id i10so4029422oag.16
        for <linux-iio@vger.kernel.org>; Sat, 31 Aug 2013 22:51:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <52223664.7000803@kernel.org>
References: <1377969159-2491-1-git-send-email-sachin.kamat@linaro.org>
	<52223664.7000803@kernel.org>
Date: Sun, 1 Sep 2013 11:21:54 +0530
Message-ID: <CAK9yfHy_NR=dMr2j2wPVks3PX79U04J5eBSmkOku+949sZZm4g@mail.gmail.com>
Subject: Re: [PATCH 1/9] staging: iio: ad7192: Use devm_* APIs
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 1 September 2013 00:01, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/31/13 18:12, Sachin Kamat wrote:
>> devm_* APIs are device managed and make code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> This series is compile tested and based on togreg branch
>> of iio tree.
>
> Just to note, there is a memory leak fixed by this patch as well
> as the remove function didn't free the struct iio_dev before.

Yes. I forgot to mention that in the commit log. Thanks for noticing.

>
> Thanks for these Sachin.  All look good to me.
> I won't take them today as effectively IIO for 3.12 is now
> closed, as I doubt we'll see more than one more rc on
> 3.11, and others may want to have time to look through these.

I wasn't aware of it, sorry.

>
> I'll pick them up in a few days and queue up for 3.13 assuming
> no one spots anything I have missed.

Sure. Thanks.


-- 
With warm regards,
Sachin
