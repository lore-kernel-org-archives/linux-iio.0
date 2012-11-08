Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:42122 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab2KHP5R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Nov 2012 10:57:17 -0500
Message-ID: <509BD1D9.20100@jic23.retrosnub.co.uk>
Date: Thu, 08 Nov 2012 15:38:01 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Roland Stigge <stigge@antcom.de>
CC: Alban Bedel <alban.bedel@avionic-design.de>,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] staging:iio:lpc32xx_adc: Add scale/offset support
References: <1352306690-25841-1-git-send-email-alban.bedel@avionic-design.de> <509B7BF0.5050704@antcom.de>
In-Reply-To: <509B7BF0.5050704@antcom.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/11/12 09:31, Roland Stigge wrote:
> Hi Alban,
>
> thanks for the patch. I can confirm that it compiles and runs fine, but
> maybe someone else can comment on the IIO part.
>
Why not do this with regulators?  That would give a more flexible
system and all that stuff is already well supported (if fixed voltages
are supplied then used fixed regulators).
> Some nitpicking below.
>
> On 07/11/12 17:44, Alban Bedel wrote:
>> Signed-off-by: Alban Bedel <alban.bedel@avionic-design.de>
>> ---
>>   .../bindings/staging/iio/adc/lpc32xx-adc.txt       |    6 ++++
>>   drivers/staging/iio/adc/lpc32xx_adc.c              |   30 +++++++++++++++++++-
>>   2 files changed, 35 insertions(+), 1 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt b/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
>> index b3629d3..515c128 100644
>> --- a/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
>> +++ b/Documentation/devicetree/bindings/staging/iio/adc/lpc32xx-adc.txt
>> @@ -6,6 +6,11 @@ Required properties:
>>     region.
>>   - interrupts: The ADC interrupt
>>
>> +Optional properties:
>> +- reference-voltages: the 3 reference voltages value (in mV) to use
>> +  for scaling. If not given or 0 a scaling factor of 1 is used.
>> +- offsets: the 3 offsets to add to the raw value before scaling.
>> +
>>   Example:
>>
>>   	adc@40048000 {
>> @@ -13,4 +18,5 @@ Example:
>>   		reg = <0x40048000 0x1000>;
>>   		interrupt-parent = <&mic>;
>>   		interrupts = <39 0>;
>> +		reference-voltages = <5000>, <3300>, <1200>;
>>   	};
>> diff --git a/drivers/staging/iio/adc/lpc32xx_adc.c b/drivers/staging/iio/adc/lpc32xx_adc.c
>> index 10c5962..aaa23ac 100644
>> --- a/drivers/staging/iio/adc/lpc32xx_adc.c
>> +++ b/drivers/staging/iio/adc/lpc32xx_adc.c
>> @@ -64,6 +64,8 @@ struct lpc32xx_adc_info {
>>   	struct completion completion;
>>
>>   	u32 value;
>> +	u32 ref_voltage[3];
>> +	u32 offset[3];
>>   };
>>
>>   static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>> @@ -91,6 +93,26 @@ static int lpc32xx_read_raw(struct iio_dev *indio_dev,
>>   		return IIO_VAL_INT;
>>   	}
>>
>> +	if (mask == IIO_CHAN_INFO_SCALE) {
>> +		if (info->ref_voltage[chan->channel]) {
>> +			unsigned factor;
>> +			factor = div_u64((u64)info->ref_voltage[chan->channel] *
>> +					 (u64)1000000,
>> +					 ADC_VALUE_MASK);
>> +			*val = factor / 1000000;
>> +			*val2 = factor % 1000000;
>> +			return IIO_VAL_INT_PLUS_MICRO;
>> +		} else {
>> +			*val = 1;
>> +			return IIO_VAL_INT;
>> +		}
>> +	}
>> +
>> +	if (mask == IIO_CHAN_INFO_OFFSET) {
>> +		*val = info->offset[chan->channel];
>> +		return IIO_VAL_INT;
>> +	}
>> +
>>   	return -EINVAL;
>>   }
>>
>> @@ -103,7 +125,9 @@ static const struct iio_info lpc32xx_adc_iio_info = {
>>   	.type = IIO_VOLTAGE,				\
>>   	.indexed = 1,					\
>>   	.channel = _index,				\
>> -	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
>> +	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
>> +	             IIO_CHAN_INFO_SCALE_SEPARATE_BIT |	\
>> +	             IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,	\
>
> Shouldn't here be tabs instead of spaces? You can check with
> scripts/checkpatch.pl
>
>>   	.address = AD_IN * _index,			\
>>   	.scan_index = _index,				\
>>   }
>> @@ -149,6 +173,10 @@ static int __devinit lpc32xx_adc_probe(struct platform_device *pdev)
>>   	}
>>
>>   	info = iio_priv(iodev);
>> +	of_property_read_u32_array(pdev->dev.of_node, "reference-voltages",
>> +				   info->ref_voltage, ARRAY_SIZE(info->ref_voltage));
>
> Considering that there is one line break already, maybe there should be
> another one for keeping line length.
>
>> +	of_property_read_u32_array(pdev->dev.of_node, "offsets",
>> +				   info->offset, ARRAY_SIZE(info->offset));
>>
>>   	info->adc_base = ioremap(res->start, resource_size(res));
>>   	if (!info->adc_base) {
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

