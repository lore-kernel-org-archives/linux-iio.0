Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:55425 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932711Ab3DDDgA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Apr 2013 23:36:00 -0400
Received: by mail-ob0-f173.google.com with SMTP id wn14so1116020obc.4
        for <linux-iio@vger.kernel.org>; Wed, 03 Apr 2013 20:35:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHfPSqBvX8WFR6Up7mEior1USYZ=723MMNB+cFHrh8P6gv4YBQ@mail.gmail.com>
References: <1364970239-8242-1-git-send-email-sachin.kamat@linaro.org>
	<1364970239-8242-2-git-send-email-sachin.kamat@linaro.org>
	<CAHfPSqBvX8WFR6Up7mEior1USYZ=723MMNB+cFHrh8P6gv4YBQ@mail.gmail.com>
Date: Thu, 4 Apr 2013 09:05:59 +0530
Message-ID: <CAK9yfHzKGq2KVv0nQNQ_Z_MoSvb=oLDjFBsRb1iqQD1AzxmFhw@mail.gmail.com>
Subject: Re: [PATCH 2/2] adc: exynos_adc: Fix incorrect variable type
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Naveen Krishna Ch <naveenkrishna.ch@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk, jic23@kernel.org,
	My self <ch.naveen@samsung.com>, patches@linaro.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 3 April 2013 22:57, Naveen Krishna Ch <naveenkrishna.ch@gmail.com> wrote:
> On 2 April 2013 23:23, Sachin Kamat <sachin.kamat@linaro.org> wrote:
>> wait_for_completion_interruptible_timeout() returns negative value on error
>> but is assigned to an unsigned variable. Though this might not matter much
>> as the return value is only tested for '0', for the sake of code correctness
>> modify the variable type suitably. Without this patch we get the following
>> smatch error:
>> drivers/iio/adc/exynos_adc.c:147 exynos_read_raw() error:
>> 'wait_for_completion_interruptible_timeout()' returns negative and
>> 'timeout' is unsigned
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>>  drivers/iio/adc/exynos_adc.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
>> index 22d034a..3bf5132 100644
>> --- a/drivers/iio/adc/exynos_adc.c
>> +++ b/drivers/iio/adc/exynos_adc.c
>> @@ -118,7 +118,7 @@ static int exynos_read_raw(struct iio_dev *indio_dev,
>>                                 long mask)
>>  {
>>         struct exynos_adc *info = iio_priv(indio_dev);
>> -       unsigned long timeout;
>> +       long timeout;
> Sachin thank you for your efforts.
>
> Apart from just changing it to long. we seem to have other corner cases
> and a CL is under discussion https://patchwork.kernel.org/patch/2279591/

Thanks for pointing this out. I had not seen this earlier. My patch
was to fix an obvious issue with the existing code.
However, since you have more elaborate plans about handling this,
please go ahead with that.


-- 
With warm regards,
Sachin
