Return-Path: <knaack.h@gmx.de>
Message-ID: <5479052B.2090308@gmx.de>
Date: Sat, 29 Nov 2014 00:28:43 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>,
 Stefan Wahren <stefan.wahren@i2se.com>, =?UTF-8?Q?Marek_Va=c5=a1ut?=
 <marex@denx.de>
CC: Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@gmail.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mxs-lradc: check ranges of ts properties
References: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com> <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DJ7yyd47BKgm6AOAg=GGFdeswrb2NxA2krj3ATnRWPVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Fabio Estevam schrieb am 19.11.2014 um 23:42:
> [Adding Marek]
Taking a closer look on how these values are used, I wondered what the real value range of the registers actually are. So, anyone with access to the data sheets, please confirm.
Starting with over_sample_cnt, which according to the DT bindings has a range of 1...31. In mxs_lradc_setup_ts_channel(), currently line 429, the value decreased by one (0...30) gets written to register 0x50 (+ 0x10 for each channel) to bits 24-29. Question: What is the right value range there, 0...30 or 0...31?
In the same function, line 440, the value decreased by one (0...30) is written to register 0x100 into bits 11-15. Same question here: What is the right value range?
The same behavior can be found in mxs_lradc_setup_ts_pressure() in lines 485 and 498.
For over_sample_delay, the DT bindings state a range of 1...2047. In mxs_lradc_setup_ts_channel(), line 440, the value decreased by one (0...2046) is written to register 0x100, bits 0-10. Question: which value range is valid there? The same happens in line 498.
For settling_delay, the DT bindings state a range of 1...2047. In mxs_lradc_setup_ts_channel(), line 458, that value is written to register 0xf0, bits 0-10. Question: what value range is valid here, 1...2047 or 0...2047? The same happens in line 517.
Thanks,

Hartmut
> 
> On Wed, Nov 19, 2014 at 8:19 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> The devicetree binding for mxs-lradc defines ranges for the
>> touchscreen properties. In order to avoid unexpected behavior like
>> division by zero, we better check these ranges during probe and
>> abort in error case.
>>
>> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
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
