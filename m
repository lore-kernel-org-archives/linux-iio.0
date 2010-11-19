Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 19 Nov 2010 14:51:19 +0000
Subject: RE: [PATCH] staging: iio: dac: Add support for AD5541A, AD5512A
 digital to analog convertors
Message-ID: <544AC56F16B56944AEC3BD4E3D591771312EE15491@LIMKCMBX1.ad.analog.com>
References: <1290174968-10461-1-git-send-email-michael.hennerich@analog.com>
 <4CE68D94.5090107@cam.ac.uk>
In-Reply-To: <4CE68D94.5090107@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2010-11-19:
> On 11/19/10 13:56, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> Looks fine to me.

This one is for a new driver, that you haven't reviewed yet.

>>Signed-off-by: Michael Hennerich
>> <michael.hennerich@analog.com> Acked-by: Jonathan Cameron
>> <jic23@cam.ac.uk> ---
>>  drivers/staging/iio/dac/Kconfig  |    6 +++---
>>  drivers/staging/iio/dac/ad5446.c |   27 +++++++++++++++++++++++++--
>>  drivers/staging/iio/dac/ad5446.h |    2 ++
>>  3 files changed, 30 insertions(+), 5 deletions(-)
>> diff --git a/drivers/staging/iio/dac/Kconfig
>> b/drivers/staging/iio/dac/Kconfig index 88914e9..9c497cc 100644
>> --- a/drivers/staging/iio/dac/Kconfig
>> +++ b/drivers/staging/iio/dac/Kconfig
>> @@ -11,11 +11,11 @@ config AD5624R_SPI
>>        AD5664R convertors (DAC). This driver uses the common SPI
> interface.
>>
>>  config AD5446
>> -    tristate "Analog Devices AD5444, AD5446 DAC SPI driver"
>> +    tristate "Analog Devices AD5444, AD5446 and AD5541A, AD5512A DAC
> SPI driver"
>>      depends on SPI
>>      help
>> -      Say yes here to build support for Analog Devices AD5444 and AD544=
6
>> -      multiplying DACs. +     Say yes here to build support for Analog
>> Devices AD5444, AD5446 +       and AD5541A, AD5512A DACs.
>>
>>        To compile this driver as a module, choose M here: the
>>        module will be called ad5446.
>> diff --git a/drivers/staging/iio/dac/ad5446.c
>> b/drivers/staging/iio/dac/ad5446.c
>> index c70243a..154a7c2 100644
>> --- a/drivers/staging/iio/dac/ad5446.c
>> +++ b/drivers/staging/iio/dac/ad5446.c
>> @@ -43,8 +43,17 @@ static ssize_t ad5446_write(struct device *dev,
>>      }
>>
>>      mutex_lock(&dev_info->mlock);
>> -    st->data =3D cpu_to_be16(AD5446_LOAD |
>> -                           (val << st->chip_info->res_shift));
>> +    switch (spi_get_device_id(st->spi)->driver_data) {
>> +    case ID_AD5444:
>> +    case ID_AD5446:
>> +                    st->data =3D cpu_to_be16(AD5446_LOAD |
>> +                                    (val << st->chip_info->res_shift));
>> +                    break;
>> +    case ID_AD5542A:
>> +    case ID_AD5512A:
>> +                    st->data =3D cpu_to_be16(val << st->chip_info-
>> res_shift);
>> +                    break;
>> +    }
>>
>>      ret =3D spi_sync(st->spi, &st->msg);
>>      mutex_unlock(&dev_info->mlock);
>> @@ -103,6 +112,18 @@ static const struct ad5446_chip_info
> ad5446_chip_info_tbl[] =3D {
>>              .res_shift =3D 0,
>>              .sign =3D 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>>      },
>> +    [ID_AD5542A] =3D {
>> +            .bits =3D 16,
>> +            .storagebits =3D 16,
>> +            .res_shift =3D 0,
>> +            .sign =3D 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>> +    },
>> +    [ID_AD5512A] =3D {
>> +            .bits =3D 12,
>> +            .storagebits =3D 16,
>> +            .res_shift =3D 4,
>> +            .sign =3D 'u', /* IIO_SCAN_EL_TYPE_UNSIGNED */
>> +    },
>>  };
>>
>>  static int __devinit ad5446_probe(struct spi_device *spi) @@ -196,6
>> +217,8 @@ static int ad5446_remove(struct spi_device *spi)  static
>> const struct spi_device_id ad5446_id[] =3D {
>>      {"ad5444", ID_AD5444},
>>      {"ad5446", ID_AD5446},
>> +    {"ad5542a", ID_AD5542A},
>> +    {"ad5512a", ID_AD5512A},
>>      {}
>>  };
>> diff --git a/drivers/staging/iio/dac/ad5446.h
>> b/drivers/staging/iio/dac/ad5446.h
>> index 3456382..0a655f1 100644
>> --- a/drivers/staging/iio/dac/ad5446.h
>> +++ b/drivers/staging/iio/dac/ad5446.h
>> @@ -39,6 +39,8 @@ struct ad5446_state {  enum
>> ad5446_supported_device_ids {
>>      ID_AD5444,
>>      ID_AD5446,
>> +    ID_AD5542A,
>> +    ID_AD5512A,
>>  };
>>
>>  #endif /* IIO_ADC_AD5446_H_ */

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
