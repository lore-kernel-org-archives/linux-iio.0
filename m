Return-Path: <bhuvanchandra.dv@toradex.com>
From: Bhuvanchandra <bhuvanchandra.dv@toradex.com>
Subject: Re: [PATCH] vf610_adc: Fix internal temperature calculation
To: Stefan Agner <stefan@agner.ch>
References: <1443015807-17764-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <0b977c21c414aef0c250755c9d772ead@agner.ch>
CC: <linux-iio@vger.kernel.org>, <jic23@kernel.org>,
	<maitysanchayan@gmail.com>, <B38611@freescale.com>, <knaack.h@gmx.de>,
	<lars@metafoo.de>, <pmeerw@pmeerw.net>, <shawn.guo@linaro.org>,
	<linux-kernel@vger.kernel.org>, <bhuvanchandra.dv@toradex.com>
Message-ID: <561C7C93.4090608@toradex.com>
Date: Tue, 13 Oct 2015 09:07:55 +0530
MIME-Version: 1.0
In-Reply-To: <0b977c21c414aef0c250755c9d772ead@agner.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Stefan,

Sorry! for the delay.

On 10/08/2015 11:46 AM, Stefan Agner wrote:

> Hi Bhuvan,
>
> On 2015-09-23 06:43, Bhuvanchandra DV wrote:
>> There is an observed temperature difference of ~20°C with the
>> internal temperature reading and the temperature measured on
>> SoC package. Existing calculations consider the typical values
>> provided in datasheet. Those typical values are valid for
>> VREFH_ADC at 3.0V. Voltage at 25°C is different for different
>> VREFH_ADC voltages. With VREFH_ADC at 3.3V, voltage at 25°C is
>> 0.699V. Hence update the VTEMP25 to 0.699V which gives ADCR@Temp25
>> as 867 and the final temperature readings differs with ~5°C from
>> the external readings.
> I am not entirely happy with the message. The proposed changes seem not
> to alter the offset which would explain a ~20°C difference... Where do
> this 20°C come from?

The ~20°C difference is observed at higher temperatures when VTEMP25
at VREDH_ADC of 3V0 is considered. Will update the comment according
to the updated VTEMP25 constant instead of the 20°C difference which
is confusing wrt the changes done here.

Best regards,
Bhuvan

> --
> Stefan
>
>> Formula for finding ADCR@Temp25:
>> ADCR@Temp25 = (ADCR@Vdd * V@TEMP25 * 10) / VDDconv
>>
>> ADCR@Vdd for 12-Bit ADC = 4095
>> VDDconv = VREFH_ADC * 10
>>
>> VREFH_ADC@3.3V
>> ADCR@Temp25 = (4095 * .699 * 10) / 33
>> ADCR@Temp25 ~= 867
>>
>> | VREFH_ADC | V@TEMP25 | VDDconv | ADCR@Temp25 |
>> |   3.0V    | 0.696mV  |    30   |     950     |
>> |   3.3V    | 0.699mV  |    33   |     867     |
>>
>> Signed-off-by: Bhuvanchandra DV<bhuvanchandra.dv@toradex.com>
>> ---
>>   drivers/iio/adc/vf610_adc.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
>> index f4df2a7..e7abc13 100644
>> --- a/drivers/iio/adc/vf610_adc.c
>> +++ b/drivers/iio/adc/vf610_adc.c
>> @@ -103,6 +103,13 @@
>>   
>>   #define DEFAULT_SAMPLE_TIME		1000
>>   
>> +/* V at 25°C of 696 mV */
>> +#define VF610_VTEMP25_3V0		950
>> +/* V at 25°C of 699 mV */
>> +#define VF610_VTEMP25_3V3		867
>> +/* Typical sensor slope coefficient at all temperatures */
>> +#define VF610_TEMP_SLOPE_COEFF		1840
>> +
>>   enum clk_sel {
>>   	VF610_ADCIOC_BUSCLK_SET,
>>   	VF610_ADCIOC_ALTCLK_SET,
>> @@ -636,11 +643,13 @@ static int vf610_read_raw(struct iio_dev *indio_dev,
>>   			break;
>>   		case IIO_TEMP:
>>   			/*
>> -			* Calculate in degree Celsius times 1000
>> -			* Using sensor slope of 1.84 mV/°C and
>> -			* V at 25°C of 696 mV
>> -			*/
>> -			*val = 25000 - ((int)info->value - 864) * 1000000 / 1840;
>> +			 * Calculate in degree Celsius times 1000
>> +			 * Using the typical sensor slope of 1.84 mV/°C
>> +			 * and VREFH_ADC at 3.3V, V at 25°C of 699 mV
>> +			 */
>> +			*val = 25000 - ((int)info->value - VF610_VTEMP25_3V3) *
>> +					1000000 / VF610_TEMP_SLOPE_COEFF;
>> +
>>   			break;
>>   		default:
>>   			mutex_unlock(&indio_dev->mlock);
