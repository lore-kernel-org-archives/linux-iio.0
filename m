Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:35313 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757109Ab3D2RSO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 29 Apr 2013 13:18:14 -0400
Received: by mail-ob0-f182.google.com with SMTP id dn14so5715888obc.13
        for <linux-iio@vger.kernel.org>; Mon, 29 Apr 2013 10:18:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <516BDA77.5060402@jic23.retrosnub.co.uk>
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org>
	<CAK9yfHxht4L38absFAbDkX2=ort5HV7W=Q2uU2BbncQhXJ4T_Q@mail.gmail.com>
	<516BDA77.5060402@jic23.retrosnub.co.uk>
Date: Mon, 29 Apr 2013 22:48:13 +0530
Message-ID: <CAK9yfHz-m3ZUvNuYYcfjCGksTPXK=m2t40qVJbfxdEaPst9OiQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] adc: exynos_adc: Convert to devm_ioremap_resource()
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 15 April 2013 16:16, Jonathan Cameron <jic23@jic23.retrosnub.co.uk> wrote:
> On 15/04/13 09:22, Sachin Kamat wrote:
>>
>> On 3 April 2013 11:53, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>>>
>>> Use the newly introduced devm_ioremap_resource() instead of
>>> devm_request_and_ioremap() which provides more consistent error handling.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>
> Not sure why I missed this one.  I think I marked the entire thread
> as not ready based on the responses to patch 2.  Clearly nothing wrong
> with this one!  Will pick up for the next cycle now as I think it
> is a cleanup rather than an actual bug fix?
>
> Thanks for the ping.

Looks like this patch has still not made it to your tree as I did not
find it in Greg's pull request to Linus.
I however saw two of my other iio patches in his pull request.


-- 
With warm regards,
Sachin
