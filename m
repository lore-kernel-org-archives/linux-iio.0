Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52821 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbcL3TJj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 14:09:39 -0500
Subject: Re: [PATCH] iio: mxs-lradc: fix error handling in mxs_lradc_probe()
To: Stefan Wahren <stefan.wahren@i2se.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <1482531319-26935-1-git-send-email-khoroshilov@ispras.ru>
 <1600801097.88831.1482789844722@email.1und1.de>
Cc: linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org,
        linux-iio@vger.kernel.org, lee.jones@linaro.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <104b932a-86b3-1ef0-29d2-d27eade1f97d@kernel.org>
Date: Fri, 30 Dec 2016 19:09:36 +0000
MIME-Version: 1.0
In-Reply-To: <1600801097.88831.1482789844722@email.1und1.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/12/16 22:04, Stefan Wahren wrote:
> 
>> Alexey Khoroshilov <khoroshilov@ispras.ru> hat am 23. Dezember 2016 um 23:15 geschrieben:
>>
>>
>> During transition to using devm_input_allocate_device()
>> goto to resource deallocation block was replaced by return
>> in case of error in iio_device_register().
>> That is wrong since resources are left undeallocated.
>>
>> Found by Linux Driver Verification project (linuxtesting.org).
>>
>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>> Fixes: 962ed43a3eac ("iio: mxs-lradc: remove mxs_lradc_ts_unregister")
> 
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> 
> But since Ksenija's patch series [1] (which doesn't have this issue) this patch is only relevant for stable.
It's slightly doubtful as stable material as well unless it causes
a crash. Obviously failing to clean up isn't good, but its not critical
enough to justify the churn. 

Good find though.

Should you wish to post it to stable and let the stable maintainers make
a decision feel free to do so.

Jonathan
> 
> Thanks
> 
> [1] - http://marc.info/?l=linux-iio&m=148131774219426&w=2
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

