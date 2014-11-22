Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40360 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbaKVMCG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Nov 2014 07:02:06 -0500
Message-ID: <54707B3D.6050806@kernel.org>
Date: Sat, 22 Nov 2014 12:02:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>
CC: =?UTF-8?B?S3Jpc3RpbmEgTWFydMWhZW5rbw==?=
	<kristina.martsenko@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com> <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/11/14 22:42, Fabio Estevam wrote:
> [Adding Marek]
It will sit in my testing branch for a day or two if Marek still
wants to take a look and comment...
> 
> On Wed, Nov 19, 2014 at 8:19 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> The devicetree binding for mxs-lradc defines ranges for the
>> touchscreen properties. In order to avoid unexpected behavior like
>> division by zero, we better check these ranges during probe and
>> abort in error case.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
>> ---
>>  drivers/staging/iio/adc/mxs-lradc.c |   20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
>> index 6757f10..57c3cf6 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -1500,16 +1500,36 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
>>         if (ret == 0)
>>                 lradc->over_sample_cnt = adapt;
>>
>> +       if (!lradc->over_sample_cnt || lradc->over_sample_cnt > 0x1f) {
>> +               dev_err(lradc->dev, "Invalid sample count (%u)\n",
>> +                                   lradc->over_sample_cnt);
>> +               return -EINVAL;
>> +       }
>> +
>>         lradc->over_sample_delay = 2;
>>         ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
>>         if (ret == 0)
>>                 lradc->over_sample_delay = adapt;
>>
>> +       if (!lradc->over_sample_delay ||
>> +           lradc->over_sample_delay > LRADC_DELAY_DELAY_MASK) {
>> +               dev_err(lradc->dev, "Invalid sample delay (%u)\n",
>> +                                   lradc->over_sample_delay);
>> +               return -EINVAL;
>> +       }
>> +
>>         lradc->settling_delay = 10;
>>         ret = of_property_read_u32(lradc_node, "fsl,settling", &adapt);
>>         if (ret == 0)
>>                 lradc->settling_delay = adapt;
>>
>> +       if (!lradc->settling_delay ||
>> +           lradc->settling_delay > LRADC_DELAY_DELAY_MASK) {
>> +               dev_err(lradc->dev, "Invalid settling delay (%u)\n",
>> +                                   lradc->settling_delay);
>> +               return -EINVAL;
>> +       }
>> +
> 
> Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

