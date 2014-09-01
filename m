Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38729 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752245AbaIAGlQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 1 Sep 2014 02:41:16 -0400
Message-ID: <540414D0.3070709@ti.com>
Date: Mon, 1 Sep 2014 12:10:16 +0530
From: Vignesh R <vigneshr@ti.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
CC: Randy Dunlap <rdunlap@infradead.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>, Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] iio: adc: ti_am335x_adc: make sample delay, open
 delay, averaging DT parameters
References: <1409141990-29627-1-git-send-email-vigneshr@ti.com> <1409141990-29627-2-git-send-email-vigneshr@ti.com> <54019CDC.5060107@kernel.org>
In-Reply-To: <54019CDC.5060107@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On Saturday 30 August 2014 03:13 PM, Jonathan Cameron wrote:
> On 27/08/14 13:19, Vignesh R wrote:
>> Number of averaging, open delay, sample delay are made DT parameters.
>> By decreasing averaging and delays more samples can be obtained per
>> second increasing performance of ADC. Previously the number of
>> averages per step was fixed to 16. Making these parameters
>> configurable will help in balancing speed vs accuracy.
>> For each ADC step provide DT based paramters to set open delay,
>> sample delay and number of averaging. One configurable step is
>> used per ADC channel. Since there can be atmost 8 ADC channels,
>> steps 16 to 8 are used for ADC.
>>
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> My main question here is whether these make sense purely as DT parameters
> or whether userspace control would be useful?  Still, even if we add that
> later, there is nothing wrong with specifying an initial value in the DT.
> 

I agree. These value can act as initial hardware parameters. Will look
at adding userspace control in another patch.

> Average in particular strikes me as a straight forward parameter where userspace
> control might make sense...
> 

I looked at Documentation/ABI/testing/sysfs-bus-iio but could not find
any framework support to make step-average a sysfs entry. Looks like I
need to create a new (my hardware specific) sysfs entry?

> Mostly fine, but I think your example has a stray F.

Actually maximum value for step-opendelay is 0x3FFFF (18 bits). I will
correct the documentation.

> 
> J
>> ---
>>  .../bindings/input/touchscreen/ti-tsc-adc.txt      |   18 +++++++
>>  drivers/iio/adc/ti_am335x_adc.c                    |   49 +++++++++++++++++---
>>  include/linux/mfd/ti_am335x_tscadc.h               |    3 ++
>>  3 files changed, 63 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> index 878549b..09ac097 100644
>> --- a/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> +++ b/Documentation/devicetree/bindings/input/touchscreen/ti-tsc-adc.txt
>> @@ -27,6 +27,21 @@ Required properties:
>>  - child "adc"
>>  	ti,adc-channels: List of analog inputs available for ADC.
>>  			 AIN0 = 0, AIN1 = 1 and so on till AIN7 = 7.
>> +Optional properties:
>> +- child "adc"
>> +	ti,step-opendelay: List of open delays for each channel of ADC in the order
>> +			   of ti,adc-channels. This value is written to corresponding
>> +			   step-config register. Default value is 0x098.
>> +			   Maximum value is 0x3FFF.
> 
> Any chance of real numbers in here rather than magic constants? If they are real
> numbers, then some explanation of how they relate to time would be good. 

The values correspond to number of ADC clock cycles. I will document the
same. I will also drop the mention of "default value" - thats really a
driver implementation detail and not a DT careabout.

>I also wonder if we need to name them after steps here, given they correspond directly to adc channels.

These values are written to corresponding STEPDELAYX and STEPCONFIGX
registers. The technical reference manual for am335x also says "number
of averages per step". In order to maintain consistency with above
naming conventions I have named these parameters after steps.

I can make it ti,chan-step-average if that feels more right.

> 
>> +	ti,step-sampledelay: List of sample delays for each channel of ADC in the order
>> +			     of ti,adc-channels. This value is written to corresponding
>> +			     step-config register. Default value is 0x0.
>> +			     Maximum value is 0xFF.
>> +	ti,step-average: Number of averages to be performed for each channel of ADC.
>> +			 If average is 16 then input is sampled 16 times and averaged to
>> +			 get more accurate value. This increases the time taken by ADC
>> +			 to generate a sample. Valid range is 0 average to 16 averages.
>> +			 Default value is 16. Maximum value is 16.
>>  
>>  Example:
>>  	tscadc: tscadc@44e0d000 {
>> @@ -40,5 +55,8 @@ Example:
>>  
>>  		adc {
>>  			ti,adc-channels = <4 5 6 7>;
>> +			ti,step-opendelay = <0x098 0x3FFFF 0x098 0x0>;
> too many F's?
> 
>> +			ti,step-sampledelay = <0xFF 0x0 0xF 0x0>;
>> +			ti,step-average = <16 2 4 8>;
>>  		};
>>  	}
>> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
>> index dfb0db0..2b31ef2 100644
>> --- a/drivers/iio/adc/ti_am335x_adc.c
>> +++ b/drivers/iio/adc/ti_am335x_adc.c
>> @@ -37,6 +37,7 @@ struct tiadc_device {
>>  	u8 channel_line[8];
>>  	u8 channel_step[8];
>>  	int buffer_en_ch_steps;
>> +	u32 open_delay[8], sample_delay[8], step_avg[8];
>>  	u16 data[8];
>>  };
>>  
>> @@ -86,6 +87,7 @@ static u32 get_adc_step_bit(struct tiadc_device *adc_dev, int chan)
>>  static void tiadc_step_config(struct iio_dev *indio_dev)
>>  {
>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> +	struct device *dev = adc_dev->mfd_tscadc->dev;
>>  	unsigned int stepconfig;
>>  	int i, steps;
>>  
>> @@ -100,20 +102,41 @@ static void tiadc_step_config(struct iio_dev *indio_dev)
>>  	 */
>>  
>>  	steps = TOTAL_STEPS - adc_dev->channels;
>> -	if (iio_buffer_enabled(indio_dev))
>> -		stepconfig = STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1
>> -					| STEPCONFIG_MODE_SWCNT;
>> -	else
>> -		stepconfig = STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1;
>> -
>>  	for (i = 0; i < adc_dev->channels; i++) {
>>  		int chan;
>>  
>>  		chan = adc_dev->channel_line[i];
>> +
>> +		if (adc_dev->step_avg[i] > STEPCONFIG_AVG_MAX) {
>> +			dev_warn(dev, "channel %d step average exceeds max value, truncating to %d\n",
>> +				 chan, STEPCONFIG_AVG_MAX);
>> +			adc_dev->step_avg[i] = STEPCONFIG_AVG_MAX;
>> +		}
>> +
>> +		stepconfig = STEPCONFIG_AVG(ffs(adc_dev->step_avg[i]) - 1) |
>> +			     STEPCONFIG_FIFO1;
>> +
>> +		if (iio_buffer_enabled(indio_dev))
>> +			stepconfig |= STEPCONFIG_MODE_SWCNT;
>> +
>>  		tiadc_writel(adc_dev, REG_STEPCONFIG(steps),
>>  				stepconfig | STEPCONFIG_INP(chan));
>> +
>> +		if (adc_dev->open_delay[i] > STEPDELAY_OPEN_MAX) {
>> +			dev_warn(dev, "channel %d step delay open exceeds max value, truncating to %d\n",
>> +				 chan, STEPDELAY_OPEN_MAX);
>> +			adc_dev->open_delay[i] = STEPDELAY_OPEN_MAX;
>> +		}
>> +
>> +		if (adc_dev->sample_delay[i] > STEPDELAY_SAMPLE_MAX) {
>> +			dev_warn(dev, "channel %d step delay sample max value, truncating to %d\n",
>> +				 chan, STEPDELAY_SAMPLE_MAX);
>> +			adc_dev->sample_delay[i] = STEPDELAY_SAMPLE_MAX;
>> +		}
>> +
>>  		tiadc_writel(adc_dev, REG_STEPDELAY(steps),
>> -				STEPCONFIG_OPENDLY);
>> +			     STEPDELAY_OPEN(adc_dev->open_delay[i]) |
>> +			     STEPDELAY_SAMPLE(adc_dev->sample_delay[i]));
>>  		adc_dev->channel_step[i] = steps;
>>  		steps++;
>>  	}
>> @@ -418,10 +441,22 @@ static int tiadc_parse_dt(struct platform_device *pdev,
>>  
>>  	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
>>  		adc_dev->channel_line[channels] = val;
>> +
>> +		/* Set Default values for optional DT parameters */
>> +		adc_dev->open_delay[channels] = STEPCONFIG_OPENDLY;
>> +		adc_dev->sample_delay[channels] = STEPCONFIG_SAMPLEDLY;
>> +		adc_dev->step_avg[channels] = 16;
>>  		channels++;
>>  	}
>>  
>>  	adc_dev->channels = channels;
>> +	of_property_read_u32_array(node, "ti,step-average",
>> +				   adc_dev->step_avg, channels);
>> +	of_property_read_u32_array(node, "ti,step-opendelay",
>> +				   adc_dev->open_delay, channels);
>> +	of_property_read_u32_array(node, "ti,step-sampledelay",
>> +				   adc_dev->sample_delay, channels);
>> +
>>  	return 0;
>>  }
>>  
>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>> index fb96c84..26d3e84 100644
>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>> @@ -82,14 +82,17 @@
>>  #define STEPCONFIG_INP_AN4	STEPCONFIG_INP(4)
>>  #define STEPCONFIG_INP_ADCREFM	STEPCONFIG_INP(8)
>>  #define STEPCONFIG_FIFO1	BIT(26)
>> +#define STEPCONFIG_AVG_MAX	16
>>  
>>  /* Delay register */
>>  #define STEPDELAY_OPEN_MASK	(0x3FFFF << 0)
>>  #define STEPDELAY_OPEN(val)	((val) << 0)
>>  #define STEPCONFIG_OPENDLY	STEPDELAY_OPEN(0x098)
>> +#define STEPDELAY_OPEN_MAX	0x3FFFF
>>  #define STEPDELAY_SAMPLE_MASK	(0xFF << 24)
>>  #define STEPDELAY_SAMPLE(val)	((val) << 24)
>>  #define STEPCONFIG_SAMPLEDLY	STEPDELAY_SAMPLE(0)
>> +#define STEPDELAY_SAMPLE_MAX	0xFF
>>  
>>  /* Charge Config */
>>  #define STEPCHARGE_RFP_MASK	(7 << 12)
>>

Regards
Vignesh R
