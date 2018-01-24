Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35352 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932238AbeAXVPh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Jan 2018 16:15:37 -0500
Subject: Re: [PATCH v3 1/2] iio: adc: driver for ti adc081s/adc101s/adc121s
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-kernel@vger.kernel.org, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, pombredanne@nexb.com
References: <1515961960-35157-1-git-send-email-milan.o.stevanovic@gmail.com>
 <20180121123926.429b7de5@archlinux>
From: Milan Stevanovic <milan.o.stevanovic@gmail.com>
Message-ID: <506c94b8-6b09-d029-e709-6f60de4cfb5d@gmail.com>
Date: Wed, 24 Jan 2018 22:15:28 +0100
MIME-Version: 1.0
In-Reply-To: <20180121123926.429b7de5@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/21/2018 01:39 PM, Jonathan Cameron wrote:
> On Sun, 14 Jan 2018 21:32:39 +0100
> Milan Stevanovic <milan.o.stevanovic@gmail.com> wrote:
>
>>      Add Linux device driver for TI single-channel CMOS
>>      8/10/12-bit analog-to-digital converter with a
>>      high-speed serial interface.
>>
>> Signed-off-by: Milan Stevanovic <milan.o.stevanovic@gmail.com>
>>
> Great, applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to play with it.
>
> A useful follow up for this at some point would be to put in
> a proper devicetree table and document the bindings but not real
> rush on that.
>
> Thanks,
>
> Jonathan
>   
Ok.. Thanks a lot.. I will add devicetree later

Best regards
Milan
>> ---
>> Changes in v2:
>>       - Fix typo error
>>       - Keep Copyright comment
>> Changes in v3:
>>       - Split patch in two patches.
>>       - Second patch is license description
>> ---
>>   drivers/iio/adc/ad7476.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>> index b7706bf..0ea0f90 100644
>> --- a/drivers/iio/adc/ad7476.c
>> +++ b/drivers/iio/adc/ad7476.c
>> @@ -1,5 +1,6 @@
>>   /*
>> - * AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
>> + * Analog Devices AD7466/7/8 AD7476/5/7/8 (A) SPI ADC driver
>> + * TI ADC081S/ADC101S/ADC121S 8/10/12-bit SPI ADC driver
>>    *
>>    * Copyright 2010 Analog Devices Inc.
>>    *
>> @@ -56,6 +57,9 @@ enum ad7476_supported_device_ids {
>>   	ID_AD7468,
>>   	ID_AD7495,
>>   	ID_AD7940,
>> +	ID_ADC081S,
>> +	ID_ADC101S,
>> +	ID_ADC121S,
>>   };
>>   
>>   static irqreturn_t ad7476_trigger_handler(int irq, void  *p)
>> @@ -147,6 +151,8 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>>   	},							\
>>   }
>>   
>> +#define ADC081S_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
>> +		BIT(IIO_CHAN_INFO_RAW))
>>   #define AD7476_CHAN(bits) _AD7476_CHAN((bits), 13 - (bits), \
>>   		BIT(IIO_CHAN_INFO_RAW))
>>   #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
>> @@ -192,6 +198,18 @@ static const struct ad7476_chip_info ad7476_chip_info_tbl[] = {
>>   		.channel[0] = AD7940_CHAN(14),
>>   		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>   	},
>> +	[ID_ADC081S] = {
>> +		.channel[0] = ADC081S_CHAN(8),
>> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>> +	},
>> +	[ID_ADC101S] = {
>> +		.channel[0] = ADC081S_CHAN(10),
>> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>> +	},
>> +	[ID_ADC121S] = {
>> +		.channel[0] = ADC081S_CHAN(12),
>> +		.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>> +	},
>>   };
>>   
>>   static const struct iio_info ad7476_info = {
>> @@ -294,6 +312,9 @@ static const struct spi_device_id ad7476_id[] = {
>>   	{"ad7910", ID_AD7467},
>>   	{"ad7920", ID_AD7466},
>>   	{"ad7940", ID_AD7940},
>> +	{"adc081s", ID_ADC081S},
>> +	{"adc101s", ID_ADC101S},
>> +	{"adc121s", ID_ADC121S},
>>   	{}
>>   };
>>   MODULE_DEVICE_TABLE(spi, ad7476_id);

