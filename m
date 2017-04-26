Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:33475 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1949998AbdDZFwZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 26 Apr 2017 01:52:25 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <alpine.DEB.2.20.1704250906150.7992@vps.pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5f628aa9-092f-52c0-549c-db7bdb7ea67b@siemens.com>
Date: Wed, 26 Apr 2017 07:37:34 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1704250906150.7992@vps.pmeerw.net>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-25 09:31, Peter Meerwald-Stadler wrote:
> 
>> This is an upstream port of an IIO driver for the TI ADC108S102 and
>> ADC128S102. The former can be found on the Intel Galileo Gen2 and the
>> Siemens SIMATIC IOT2000. For those boards, ACPI-based enumeration is
>> included.
> 
> comments below
> 
> naming: don't use placeholders, name after one of the supported chips and 
> list them in Kconfig and the driver file
> 
> what is the difference between this chip and those supported 
> by ti-adc084s021 which was proposed by Mårten Lindahl on April 21?

I've cross-read that driver, and it looks fairly different to me.

> 
> I think board-specific stuff should not go into the driver -> DT?

Still looking for suggestions how to provide the external reference
voltage as parameter. Chip select is gone now.

Also, should I suggest a device tree binding even though I have no test
case for it? My current feeling is to better leave this exercise to the
first user on a DT platform.

[...]

>> +
>> +/*
>> + * Defining the ADC resolution being 12 bits, we can use the same driver for
>> + * both ADC108S102 (10 bits resolution) and ADC128S102 (12 bits resolution)
>> + * chips. The ADC108S102 effectively returns a 12-bit result with the 2
>> + * least-significant bits unset.
>> + */
>> +#define ADC1x8S102_BITS		12

[...]

>> +#define ADC1X8S102_V_CHAN(index)					\
>> +	{								\
>> +		.type = IIO_VOLTAGE,					\
>> +		.indexed = 1,						\
>> +		.channel = index,					\
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
>> +			BIT(IIO_CHAN_INFO_SCALE),			\
>> +		.address = index,					\
>> +		.scan_index = index,					\
>> +		.scan_type = {						\
>> +			.sign = 'u',					\
>> +			.realbits = ADC1x8S102_BITS,			\
> 
> this should be different for the 128 and 108 part, shift missing
> 
> most drivers do shifting and don't use _SCALE for that purpose

What would be the difference when following your suggestion?

To my understanding, which is based on the comment above, the 108 simply
has its two least significant bits cleared, i.e. it provides a value
with the exact same scale, just with lower resolution.

> 
>> +			.storagebits = 16,				\
>> +			.endianness = IIO_BE,				\
>> +		},							\
>> +	}

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
