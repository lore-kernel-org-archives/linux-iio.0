Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34791 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeKLAtI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 11 Nov 2018 19:49:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id p6so4440243lfc.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Nov 2018 07:00:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181111124044.52f61897@archlinux>
References: <208f9043fbd9b14b7a0c2743f68fa424388f5dcd.1541733478.git.baolin.wang@linaro.org>
 <20181111124044.52f61897@archlinux>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Sun, 11 Nov 2018 23:00:18 +0800
Message-ID: <CAMz4kuJoJAEq1uGvwnnkbQDi8SqS+kWfpgjtmcNoutfgJDwQaw@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: sc27xx: Add ADC data conversion timeout
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        freeman.liu@unisoc.com, Mark Brown <broonie@kernel.org>,
        linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On 11 November 2018 at 20:40, Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri,  9 Nov 2018 11:25:31 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> From: Freeman Liu <freeman.liu@unisoc.com>
>>
>> Sometimes the ADC controller met some problems, and it will not complete
>> the data conversion, that will can not wake up the read process any more
>> to block users. So we should add one maximum conversion time to avoid
>> this issue.
>>
>> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Hi.
>
> Patch looks good, but sounds like this is a fix so could I have a fixes
> tag and a patch title that makes that clear?
>
> I think we will want this one back ported to stable by the sound of it.
>
> If it is just a theoretical issue then perhaps we don't need to bother.

Thanks for your review. This patch is not one bug fix, just make the
code more robust in case of some bad cases. So I think we do not need
the stable tag.

>
> Thanks,
>
> Jonathan
>
>> ---
>>  drivers/iio/adc/sc27xx_adc.c |   12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
>> index 7940b23..f7f7a189 100644
>> --- a/drivers/iio/adc/sc27xx_adc.c
>> +++ b/drivers/iio/adc/sc27xx_adc.c
>> @@ -52,6 +52,9 @@
>>  /* Timeout (ms) for the trylock of hardware spinlocks */
>>  #define SC27XX_ADC_HWLOCK_TIMEOUT    5000
>>
>> +/* Timeout (ms) for ADC data conversion according to ADC datasheet */
>> +#define SC27XX_ADC_RDY_TIMEOUT               100
>> +
>>  /* Maximum ADC channel number */
>>  #define SC27XX_ADC_CHANNEL_MAX               32
>>
>> @@ -223,7 +226,14 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>>       if (ret)
>>               goto disable_adc;
>>
>> -     wait_for_completion(&data->completion);
>> +     ret = wait_for_completion_timeout(&data->completion,
>> +                             msecs_to_jiffies(SC27XX_ADC_RDY_TIMEOUT));
>> +     if (!ret) {
>> +             dev_err(data->dev, "read ADC data timeout\n");
>> +             ret = -ETIMEDOUT;
>> +     } else {
>> +             ret = 0;
>> +     }
>>
>>  disable_adc:
>>       regmap_update_bits(data->regmap, data->base + SC27XX_ADC_CTL,
>



-- 
Baolin Wang
Best Regards
