Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>
Date: Fri, 8 Oct 2010 09:33:19 +0100
Subject: RE: [RFC PATCH] staging: iio: adc: ad7476 new SPI ADC driver
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F35A10208@LIMKCMBX1.ad.analog.com>
References: <1286462190-2002-1-git-send-email-michael.hennerich@analog.com>
 <4CAE0097.5020702@cam.ac.uk>
In-Reply-To: <4CAE0097.5020702@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-10-07:
> On 10/07/10 15:36, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
> Hi Michael,
>
> Just a quick look tonight, I'll take a closer one tomorrow.
>
>> New driver handling:         AD7475, AD7476, AD7477, AD7478, AD7466, AD7=
467,
>> AD7468, AD7495 SPI micropower and high speed 12-/10-/8-Bit ADCs
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/adc/ad7476.h      |   66 +++++++
>>  drivers/staging/iio/adc/ad7476_core.c |  324
>> +++++++++++++++++++++++++++++++++
>> drivers/staging/iio/adc/ad7476_ring.c |  184 +++++++++++++++++++
>>  3 files changed, 574 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/staging/iio/adc/ad7476.h  create mode 100644
>> drivers/staging/iio/adc/ad7476_core.c
>>  create mode 100644 drivers/staging/iio/adc/ad7476_ring.c
>> diff --git a/drivers/staging/iio/adc/ad7476.h
>> b/drivers/staging/iio/adc/ad7476.h
>> new file mode 100644
>> index 0000000..499a773
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7476.h
>> @@ -0,0 +1,66 @@
>> +/*
>> + * AD7476/5/7/8 (A) SPI ADC driver
>> + *
>> + * Copyright 2010 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +#ifndef IIO_ADC_AD7476_H_
>> +#define IIO_ADC_AD7476_H_
>> +
>> +#define RES_MASK(bits)      ((1 << (bits)) - 1)
>> +
>> +/*
>> + * TODO: struct ad7476_platform_data needs to go into
>> +include/linux/iio  */
>> +
>> +struct ad7476_platform_data {
>> +    char                            name[12];
> Why provide the name as platform data?  Isn't an appropriate id table
> and correct board info for the spi bus a better bet?
>
> The id stuff hasn't been available for spi devices for that long, but
> it is now and makes things a lot easier. Similar to i2c but you have
> to use spi_get_device_id to get it from the spi_device struct.

Yeah - of course that's even better - I didn't know that this was added to
the spi bus driver recently - I'll update.


>> +    unsigned int                    vref_mv; +}; + +struct ad7476_chip_=
info {
>> +    char                            name[12]; Easier as a const char * =
and appropriate const
>> string asignment? +  u8                              bits; + u8         =
                     storagebits; +  u8                              res_sh=
ift;
>> +    char                            sign; + unsigned int               =
     int_vref_mv; +  struct
>> attribute_group              *scan_attrs; +};
> I'll look at the rest tomorrow.
>
>
> Jonathan

Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
