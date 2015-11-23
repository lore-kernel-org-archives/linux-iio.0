Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx6-12.smtp.antispamcloud.com ([95.211.2.203]:48037 "EHLO
	mx6-12.smtp.antispamcloud.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752165AbbKWJYa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 23 Nov 2015 04:24:30 -0500
Subject: Re: [PATCH] iio/adc/ad9467.c: Add support for AD9649
To: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>
References: <1447658287-7785-1-git-send-email-mike.looijmans@topic.nl>
 <5651B19B.90504@kernel.org>
CC: <linux-iio@vger.kernel.org>
From: Mike Looijmans <mike.looijmans@topic.nl>
Message-ID: <5652CD5B.6060101@topic.nl>
Date: Mon, 23 Nov 2015 09:24:59 +0100
MIME-Version: 1.0
In-Reply-To: <5651B19B.90504@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

﻿On 22-11-15 13:14, Jonathan Cameron wrote:
> On 16/11/15 07:18, Mike Looijmans wrote:
>> The AD9649 is a 14-bit 20-80Msps ADC.
> Hi Mike,
>
> This patch is missing a sign-off. Please resend with one - see
> Documentation/SubmittingPatches if you want more detail.
>
> Also more excitingly this file doesn't actually exist in the iio tree.
> Guessing this patch is against Analog's tree?
> If so you'll need to work on persuading them to send it upstream.

In my enthousiasm that I got it all working, i forgot the "-s" switch for git 
and I was a bit overly zealous in copying email addresses from the 
get_maintainer script. The patch only applies to ADI's tree, indeed.

> Lars, Michael? I'm going to hazard a guess that this was sat waiting
> for the DMA patches to be upstreamed and might show up sometime soonish for review?
>
> One other trivial comment inline.
>
> Jonathan
>
>> ---
>>   drivers/iio/adc/ad9467.c     | 22 +++++++++++++++++++++-
>>   drivers/iio/adc/cf_axi_adc.h |  7 +++++++
>>   2 files changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
>> index dde27cb..ca67b74 100644
>> --- a/drivers/iio/adc/ad9467.c
>> +++ b/drivers/iio/adc/ad9467.c
>> @@ -370,6 +370,7 @@ static int ad9467_dco_calibrate(struct iio_dev *indio_dev, unsigned chan)
>>   	case CHIPID_AD9680:
>>   	case CHIPID_AD9625:
>>   	case CHIPID_AD9434:
>> +	case CHIPID_AD9649:
>>   		return 0;
>>   	case CHIPID_AD9265:
>>   	case CHIPID_AD9652:
>> @@ -417,6 +418,10 @@ static const int ad9652_scale_table[][2] = {
>>   	{1250, 0}, {1125, 1}, {1200, 2}, {1250, 3}, {1000, 5},
>>   };
>>
>> +static const int ad9649_scale_table[][2] = {
>> +	{2000, 0},
>> +};
>> +
>>   static int ad9467_scale(struct axiadc_converter *conv, int index)
>>   {
>>   	if (index > conv->chip_info->num_scales)
>> @@ -848,7 +853,15 @@ static const struct axiadc_chip_info axiadc_chip_info_tbl[] = {
>>   		       .channel[0] = AIM_CHAN_NOCALIB(0, 0, 12, 'S', 0, NULL, 0),
>>   		       .channel[1] = AIM_CHAN_NOCALIB(1, 1, 12, 'S', 0, NULL, 0),
>>   		       },
>> -
>> +	[ID_AD9649] = {
>> +		       .name = "AD9649",
>> +		       .max_rate = 80000000UL,
>> +		       .scale_table = ad9649_scale_table,
>> +		       .num_scales = ARRAY_SIZE(ad9649_scale_table),
>> +		       .max_testmode = TESTMODE_ONE_ZERO_TOGGLE,
>> +		       .num_channels = 1,
>> +		       .channel[0] = AIM_CHAN_NOCALIB(0, 0, 14, 'S', 0, NULL, 0),
>> +		       },
>>   };
>>
>>   static int ad9250_setup(struct spi_device *spi, unsigned m, unsigned l)
>> @@ -1351,6 +1364,12 @@ static int ad9467_probe(struct spi_device *spi)
>>   		    AD9643_DEF_OUTPUT_MODE | OUTPUT_MODE_TWOS_COMPLEMENT;
>>   		ret = ad9467_outputmode_set(spi, conv->adc_output_mode);
>>   		break;
>> +	case CHIPID_AD9649:
>> +		conv->chip_info = &axiadc_chip_info_tbl[ID_AD9649];
>> +		conv->adc_output_mode =
>> +		    AD9643_DEF_OUTPUT_MODE | OUTPUT_MODE_TWOS_COMPLEMENT;
>> +		ret = ad9467_outputmode_set(spi, conv->adc_output_mode);
>> +		break;
>>   	default:
>>   		dev_err(&spi->dev, "Unrecognized CHIP_ID 0x%X\n", conv->id);
>>   		ret = -ENODEV;
>> @@ -1424,6 +1443,7 @@ static const struct spi_device_id ad9467_id[] = {
>>   	{"ad9680", CHIPID_AD9680},
>>   	{"ad9652", CHIPID_AD9652},
>>   	{"ad9234", CHIPID_AD9234},
>> +	{"ad9649", CHIPID_AD9649},
>>   	{}
>>   };
>>
>> diff --git a/drivers/iio/adc/cf_axi_adc.h b/drivers/iio/adc/cf_axi_adc.h
>> index 0ad524e..8c36b9c 100644
>> --- a/drivers/iio/adc/cf_axi_adc.h
>> +++ b/drivers/iio/adc/cf_axi_adc.h
>> @@ -316,6 +316,12 @@ enum adc_data_sel {
>>
>>   #define CHIPID_AD9234			0xCE
>>
>> +/*
>> + * Analog Devices AD9649
>> + */
> Single line comment should have single line comment syntax
> /* Analog Device AD9649 */
>
>> +
>> +#define CHIPID_AD9649			0x6F
>> +
>>   /* debugfs direct register access */
>>   #define DEBUGFS_DRA_PCORE_REG_MAGIC	0x80000000
>>
>> @@ -335,6 +341,7 @@ enum {
>>   	ID_AD9652,
>>   	ID_AD9234,
>>   	ID_AD9680_x2,
>> +	ID_AD9649,
>>   };
>>
>>   struct axiadc_chip_info {
>>
>



Kind regards,

Mike Looijmans
System Expert

TOPIC Embedded Products
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: +31 (0) 499 33 69 79
Telefax: +31 (0) 499 33 69 70
E-mail: mike.looijmans@topicproducts.com
Website: www.topicproducts.com

Please consider the environment before printing this e-mail





