Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:45699 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756583Ab1LNRHd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2011 12:07:33 -0500
References: <1323864772-24051-1-git-send-email-michael.hennerich@analog.com> <1323864772-24051-3-git-send-email-michael.hennerich@analog.com> <Prayer.1.3.4.1112141414040.19575@hermes-2.csi.cam.ac.uk> <544AC56F16B56944AEC3BD4E3D59177148734E3498@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D59177148734E3498@LIMKCMBX1.ad.analog.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: [PATCH 3/3] iio: gyro: ADXRS450: Add support for ADXRS453 Digital Gyroscope
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 14 Dec 2011 17:07:23 +0000
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Message-ID: <8df5c330-42a9-4fb4-810a-420075841bcd@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



"Hennerich, Michael" <Michael.Hennerich@analog.com> wrote:

>J.I. Cameron wrote on 2011-12-14:
>> Mostly fine, but why does the adxrs453 not have a scale associated
>with
>> the gyro readings and the adxrs450 does?
>
>Please see again - both have a scale associated with the gyro readings.
>The difference is that the ADXRS453 doesn't have the
>IIO_CHAN_INFO_CALIBBIAS.
Ah my missread. Feel free to add my ack.
>
>>
>> Also, just out curiosity what is the difference between these two
>parts?
>> I'm not finding it obvious from the website :)
>
>Honestly - I was asking me the same thing.
>
>But from a functional point of view the only difference I found was the
>missing
>dynamic null correction feature on the ADXRS453. (exposed as CALIBBIAS)
>In addition there are slightly different datasheet specifications.
>
>Regards,
>Michael
>
>
>>>
>>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com> ---
>>> drivers/staging/iio/gyro/Kconfig         |    6 +-
>>> drivers/staging/iio/gyro/adxrs450.h      |    5 ++
>>> drivers/staging/iio/gyro/adxrs450_core.c |   60
>>> +++++++++++++++++++++--------- 3 files changed, 50 insertions(+), 21
>>> deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/gyro/Kconfig
>>> b/drivers/staging/iio/gyro/Kconfig index 22aea5b..ea295b2 100644 ---
>>> a/drivers/staging/iio/gyro/Kconfig +++
>>> b/drivers/staging/iio/gyro/Kconfig @@ -37,11 +37,11 @@ config
>ADIS16260
>>>        will be called adis16260.
>>>
>>> config ADXRS450 -    tristate "Analog Devices ADXRS450 Digital
>Output
>>> Gyroscope SPI driver" +      tristate "Analog Devices ADXRS450/3
>Digital
>>> Output Gyroscope SPI driver"         depends on SPI  help -    Say
>yes here to
>>> build support for Analog Devices ADXRS450 programmable -      
>digital
>>> output gyroscope. +    Say yes here to build support for Analog
>Devices
>>> ADXRS450 and ADXRS453 +        programmable digital output
>gyroscope.
>>>
>>>        This driver can also be built as a module.  If so, the module
>>> will be called adxrs450. diff --git
>>> a/drivers/staging/iio/gyro/adxrs450.h
>>> b/drivers/staging/iio/gyro/adxrs450.h index b6b6828..af0c870 100644
>---
>>> a/drivers/staging/iio/gyro/adxrs450.h +++
>>> b/drivers/staging/iio/gyro/adxrs450.h @@ -39,6 +39,11 @@
>>>
>>> #define ADXRS450_GET_ST(a)   ((a >> 26) & 0x3)
>>>
>>> +enum {
>>> +    ID_ADXRS450,
>>> +    ID_ADXRS453,
>>> +};
>>> +
>>> /**
>>>  * struct adxrs450_state - device instance specific data
>>>  * @us:                      actual spi_device
>>> diff --git a/drivers/staging/iio/gyro/adxrs450_core.c
>>> b/drivers/staging/iio/gyro/adxrs450_core.c index a146d55..61690e2
>>> 100644 --- a/drivers/staging/iio/gyro/adxrs450_core.c +++
>>> b/drivers/staging/iio/gyro/adxrs450_core.c @@ -1,5 +1,5 @@ /* - *
>>> ADXRS450 Digital Output Gyroscope Driver + * ADXRS450/ADXRS453
>Digital
>>> Output Gyroscope Driver
>>>  *
>>>  * Copyright 2011 Analog Devices Inc.
>>>  *
>>> @@ -323,20 +323,36 @@ static int adxrs450_read_raw(struct iio_dev
>>> *indio_dev,  return ret; }
>>>
>>> -static const struct iio_chan_spec adxrs450_channels[] = { - { -    
>        .type
>>> = IIO_ANGL_VEL, -            .modified = 1, -               
>.channel2 = IIO_MOD_Z,
>>> -            .info_mask = IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
>>> -            IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT |
>>> -            IIO_CHAN_INFO_SCALE_SEPARATE_BIT, -     }, { -         
>.type = IIO_TEMP,
>>> -            .indexed = 1, -         .channel = 0, -        
>.info_mask =
>>> IIO_CHAN_INFO_SCALE_SEPARATE_BIT, -  } +static const struct
>>> iio_chan_spec adxrs450_channels[2][2] = { +  [ID_ADXRS450] = { +    
>        {
>>> +                    .type = IIO_ANGL_VEL, +                
>.modified = 1, +                        .channel2 = IIO_MOD_Z,
>>> +                    .info_mask =
>IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
>>> +                   
>IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT |
>>> +                    IIO_CHAN_INFO_SCALE_SEPARATE_BIT, +            
>}, { +                  .type = IIO_TEMP,
>>> +                    .indexed = 1, +                 .channel = 0, +
>                .info_mask =
>>> IIO_CHAN_INFO_SCALE_SEPARATE_BIT, +          } +     }, +   
>[ID_ADXRS453] = { +             {
>>> +                    .type = IIO_ANGL_VEL, +                
>.modified = 1, +                        .channel2 = IIO_MOD_Z,
>>> +                    .info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
>>> +                   
>IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE_BIT, +         }, {
>>> +                    .type = IIO_TEMP, +                    
>.indexed = 1, +                 .channel = 0,
>>> +                    .info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT,
>+                } +     }, };
>>>
>>> static const struct iio_info adxrs450_info = { @@ -366,7 +382,8 @@
>>> static int __devinit adxrs450_probe(struct spi_device *spi)
>>>      indio_dev->dev.parent = &spi->dev;      indio_dev->info =
>&adxrs450_info;
>>>      indio_dev->modes = INDIO_DIRECT_MODE; - indio_dev->channels =
>>> adxrs450_channels; + indio_dev->channels =
>>> +            adxrs450_channels[spi_get_device_id(spi)->driver_data];
>>>      indio_dev->num_channels = ARRAY_SIZE(adxrs450_channels);
>>>      indio_dev->name = spi->dev.driver->name;
>>>
>>> @@ -396,6 +413,13 @@ static int adxrs450_remove(struct spi_device
>*spi)
>>>      return 0; }
>>>
>>> +static const struct spi_device_id adxrs450_id[] = {
>>> +    {"adxrs450", ID_ADXRS450},
>>> +    {"adxrs453", ID_ADXRS453},
>>> +    {}
>>> +};
>>> +MODULE_DEVICE_TABLE(spi, adxrs450_id);
>>> +
>>> static struct spi_driver adxrs450_driver = {
>>>      .driver = {
>>>              .name = "adxrs450",
>>> @@ -403,6 +427,7 @@ static struct spi_driver adxrs450_driver = {
>>>      },
>>>      .probe = adxrs450_probe,
>>>      .remove = __devexit_p(adxrs450_remove),
>>> +    .id_table       = adxrs450_id,
>>> };
>>>
>>> static __init int adxrs450_init(void)
>>> @@ -418,6 +443,5 @@ static __exit void adxrs450_exit(void)
>>> module_exit(adxrs450_exit);
>>>
>>> MODULE_AUTHOR("Cliff Cai <cliff.cai@xxxxxxxxxx>");
>>> -MODULE_DESCRIPTION("Analog Devices ADXRS450 Gyroscope SPI driver");
>>> +MODULE_DESCRIPTION("Analog Devices ADXRS450/ADXRS453 Gyroscope SPI
>>> driver"); MODULE_LICENSE("GPL v2"); -MODULE_ALIAS("spi:adxrs450");
>>>
>
>Greetings,
>Michael
>
>--
>Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
>Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
>Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
>Margaret Seif

-- 
Sent from my Android phone 
with K-9 Mail. Please excuse my brevity.
