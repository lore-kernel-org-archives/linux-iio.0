Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41567 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbbJKOHX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 11 Oct 2015 10:07:23 -0400
Subject: Re: [PATCH] vf610_adc: Fix internal temperature calculation
To: Duan Andy <fugang.duan@freescale.com>,
	Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1443015807-17764-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <560810DD.5030900@kernel.org>
 <BN3PR0301MB12193E5AE29F8FBCF0308D15F5350@BN3PR0301MB1219.namprd03.prod.outlook.com>
 <561A6CB7.6010700@kernel.org>
Cc: "stefan@agner.ch" <stefan@agner.ch>,
	"maitysanchayan@gmail.com" <maitysanchayan@gmail.com>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <561A6D19.90902@kernel.org>
Date: Sun, 11 Oct 2015 15:07:21 +0100
MIME-Version: 1.0
In-Reply-To: <561A6CB7.6010700@kernel.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/15 15:05, Jonathan Cameron wrote:
> On 08/10/15 03:01, Duan Andy wrote:
>> From: Jonathan Cameron <jic23@kernel.org> Sent: Sunday, September 27, 2015 11:53 PM
>>> To: Bhuvanchandra DV; linux-iio@vger.kernel.org
>>> Cc: stefan@agner.ch; maitysanchayan@gmail.com; Duan Fugang-B38611;
>>> knaack.h@gmx.de; lars@metafoo.de; pmeerw@pmeerw.net; shawn.guo@linaro.org;
>>> linux-kernel@vger.kernel.org; Duan Fugang-B38611
>>> Subject: Re: [PATCH] vf610_adc: Fix internal temperature calculation
>>>
>>> On 23/09/15 14:43, Bhuvanchandra DV wrote:
>>>> There is an observed temperature difference of ~20°C with the internal
>>>> temperature reading and the temperature measured on SoC package.
>>>> Existing calculations consider the typical values provided in
>>>> datasheet. Those typical values are valid for VREFH_ADC at 3.0V.
>>>> Voltage at 25°C is different for different VREFH_ADC voltages. With
>>>> VREFH_ADC at 3.3V, voltage at 25°C is 0.699V. Hence update the VTEMP25
>>>> to 0.699V which gives ADCR@Temp25 as 867 and the final temperature
>>>> readings differs with ~5°C from the external readings.
>>>>
>>>> Formula for finding ADCR@Temp25:
>>>> ADCR@Temp25 = (ADCR@Vdd * V@TEMP25 * 10) / VDDconv
>>>>
>>>> ADCR@Vdd for 12-Bit ADC = 4095
>>>> VDDconv = VREFH_ADC * 10
>>>>
>>>> VREFH_ADC@3.3V
>>>> ADCR@Temp25 = (4095 * .699 * 10) / 33
>>>> ADCR@Temp25 ~= 867
>>>>
>>>> | VREFH_ADC | V@TEMP25 | VDDconv | ADCR@Temp25 |
>>>> |   3.0V    | 0.696mV  |    30   |     950     |
>>>> |   3.3V    | 0.699mV  |    33   |     867     |
>>>>
>>>> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
>>> Looks fine to me, but I'll need an Ack from Fugang on this one as I don't
>>> know or have the part I'm afraid.
>>>
>>> Jonathan
>>
>> The patch is fine for me. Sorry for the late response due to vacation.
>>
>> Acked-by: Fugang Duan <B38611@freescale.com>
> Applied to the fixes-togreg branch of iio.git and marked for stable.
> Thanks,
> Jonathan
Actually, change of plan.  I'll hold this until Stefan's query is answered.
(naughty me - I hadn't read the whole thread!)
>>
>>>> ---
>>>>  drivers/iio/adc/vf610_adc.c | 19 ++++++++++++++-----
>>>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
>>>> index f4df2a7..e7abc13 100644
>>>> --- a/drivers/iio/adc/vf610_adc.c
>>>> +++ b/drivers/iio/adc/vf610_adc.c
>>>> @@ -103,6 +103,13 @@
>>>>
>>>>  #define DEFAULT_SAMPLE_TIME		1000
>>>>
>>>> +/* V at 25°C of 696 mV */
>>>> +#define VF610_VTEMP25_3V0		950
>>>> +/* V at 25°C of 699 mV */
>>>> +#define VF610_VTEMP25_3V3		867
>>>> +/* Typical sensor slope coefficient at all temperatures */
>>>> +#define VF610_TEMP_SLOPE_COEFF		1840
>>>> +
>>>>  enum clk_sel {
>>>>  	VF610_ADCIOC_BUSCLK_SET,
>>>>  	VF610_ADCIOC_ALTCLK_SET,
>>>> @@ -636,11 +643,13 @@ static int vf610_read_raw(struct iio_dev
>>> *indio_dev,
>>>>  			break;
>>>>  		case IIO_TEMP:
>>>>  			/*
>>>> -			* Calculate in degree Celsius times 1000
>>>> -			* Using sensor slope of 1.84 mV/°C and
>>>> -			* V at 25°C of 696 mV
>>>> -			*/
>>>> -			*val = 25000 - ((int)info->value - 864) * 1000000 /
>>> 1840;
>>>> +			 * Calculate in degree Celsius times 1000
>>>> +			 * Using the typical sensor slope of 1.84 mV/°C
>>>> +			 * and VREFH_ADC at 3.3V, V at 25°C of 699 mV
>>>> +			 */
>>>> +			*val = 25000 - ((int)info->value - VF610_VTEMP25_3V3) *
>>>> +					1000000 / VF610_TEMP_SLOPE_COEFF;
>>>> +
>>>>  			break;
>>>>  		default:
>>>>  			mutex_unlock(&indio_dev->mlock);
>>>>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

