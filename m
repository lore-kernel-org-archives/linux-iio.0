Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>, "guenter.roeck@ericsson.com"
	<guenter.roeck@ericsson.com>
Date: Wed, 5 Oct 2011 09:39:01 +0100
Subject: RE: [PATCH] staging:iio:adc:ad7314 removal. Supported via hwmon.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7343656@LIMKCMBX1.ad.analog.com>
References: <1317378054-9511-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317378054-9511-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-30:
> Driver ported over to hwmon where it fits much better.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
> Technically there is a slight loss of functionality in the hwmon
> driver (no power down mode).
>
> Otherwise, lets clear this one out.
>
> 3 more to go on my removal list ;)
> adt7310, adt7410 and adt75.
>
> If anyone is bored, those are rather more effort than this one was.
>
> Jonathan
>
>  drivers/staging/iio/adc/Kconfig  |    7 -
>  drivers/staging/iio/adc/Makefile |    1 -
>  drivers/staging/iio/adc/ad7314.c |  281 ------------------------------
>  -------- 3 files changed, 0 insertions(+), 289 deletions(-) delete mode
>  100644 drivers/staging/iio/adc/ad7314.c
> diff --git a/drivers/staging/iio/adc/Kconfig
> b/drivers/staging/iio/adc/Kconfig index 070efd3..2c1b7de 100644 ---
> a/drivers/staging/iio/adc/Kconfig +++ b/drivers/staging/iio/adc/Kconfig
> @@ -34,13 +34,6 @@ config AD7298
>         To compile this driver as a module, choose M here: the
>         module will be called ad7298.
> -config AD7314
> -     tristate "Analog Devices AD7314 temperature sensor driver"
> -     depends on SPI
> -     help
> -       Say yes here to build support for Analog Devices AD7314
> -       temperature sensors.
> -
>  config AD7606
>       tristate "Analog Devices AD7606 ADC driver"
>       depends on GPIOLIB
> diff --git a/drivers/staging/iio/adc/Makefile
> b/drivers/staging/iio/adc/Makefile index 8adf096..93dc84b 100644 ---
> a/drivers/staging/iio/adc/Makefile +++
> b/drivers/staging/iio/adc/Makefile @@ -32,7 +32,6 @@
> obj-$(CONFIG_AD7298) +=3D ad7298.o
>  obj-$(CONFIG_AD7150) +=3D ad7150.o obj-$(CONFIG_AD7152) +=3D ad7152.o
>  obj-$(CONFIG_AD7291) +=3D ad7291.o -obj-$(CONFIG_AD7314) +=3D ad7314.o
>  obj-$(CONFIG_AD7746) +=3D ad7746.o obj-$(CONFIG_AD7780) +=3D ad7780.o
>  obj-$(CONFIG_AD7793) +=3D ad7793.o
 diff --git a/drivers/staging/iio/adc/ad7314.c
 b/drivers/staging/iio/adc/ad7314.c deleted file mode 100644 index
 094a4ee..0000000 --- a/drivers/staging/iio/adc/ad7314.c +++ /dev/null @@
 -1,281 +0,0 @@ -/* - * AD7314 digital temperature sensor driver for
 AD7314, ADT7301 and ADT7302 - * - * Copyright 2010 Analog Devices Inc. -
 * - * Licensed under the GPL-2 or later. - */ - -#include
 <linux/device.h> -#include <linux/kernel.h> -#include <linux/slab.h>
 -#include <linux/sysfs.h> -#include <linux/spi/spi.h> -#include
 <linux/module.h> - -#include "../iio.h" -#include "../sysfs.h" - -/* - *
 AD7314 power mode - */ -#define AD7314_PD              0x2000 - -/* - * AD=
7314
 temperature masks - */ -#define AD7314_TEMP_SIGN               0x200 -#def=
ine
 AD7314_TEMP_MASK               0x7FE0 -#define AD7314_TEMP_OFFSET         =
     5 -#define
 AD7314_TEMP_FLOAT_OFFSET       2 -#define AD7314_TEMP_FLOAT_MASK          =
     0x3 - -/* - *
 ADT7301 and ADT7302 temperature masks - */ -#define
 ADT7301_TEMP_SIGN              0x2000 -#define ADT7301_TEMP_MASK          =
     0x2FFF -#define
 ADT7301_TEMP_FLOAT_OFFSET      5 -#define ADT7301_TEMP_FLOAT_MASK         =
     0x1F - -/*
 - * struct ad7314_chip_info - chip specifc information - */ - -struct
 ad7314_chip_info { -   struct spi_device *spi_dev; -   s64 last_timestamp;
 -      u8  mode; -}; - -/* - * ad7314 register access by SPI - */ - -stati=
c
 int ad7314_spi_read(struct ad7314_chip_info *chip, u16 *data) -{ -     str=
uct
 spi_device *spi_dev =3D chip->spi_dev; - int ret =3D 0; -  u16 value; - - =
 ret
 =3D spi_read(spi_dev, (u8 *)&value, sizeof(value)); -    if (ret < 0) {
 -              dev_err(&spi_dev->dev, "SPI read error\n"); -           ret=
urn ret; -   } -
 -      *data =3D be16_to_cpu((u16)value); - -    return ret; -} - -static =
int
 ad7314_spi_write(struct ad7314_chip_info *chip, u16 data) -{ - struct
 spi_device *spi_dev =3D chip->spi_dev; - int ret =3D 0; -  u16 value =3D
 cpu_to_be16(data); - - ret =3D spi_write(spi_dev, (u8 *)&value,
 sizeof(value)); -      if (ret < 0) -          dev_err(&spi_dev->dev, "SPI=
 write
 error\n"); - - return ret; -} - -static ssize_t ad7314_show_mode(struct
 device *dev, -         struct device_attribute *attr, -                cha=
r *buf) -{ - struct
 iio_dev *dev_info =3D dev_get_drvdata(dev); -    struct ad7314_chip_info *=
chip
 =3D iio_priv(dev_info); - -      if (chip->mode) -               return sp=
rintf(buf,
 "power-save\n"); -     else -          return sprintf(buf, "full\n"); -} -=
 -static
 ssize_t ad7314_store_mode(struct device *dev, -                struct devi=
ce_attribute
 *attr, -               const char *buf, -              size_t len) -{ -   =
     struct iio_dev *dev_info =3D
 dev_get_drvdata(dev); -        struct ad7314_chip_info *chip =3D
 iio_priv(dev_info); -  u16 mode =3D 0; - int ret; - -    if (!strcmp(buf,
 "full")) -             mode =3D AD7314_PD; - -   ret =3D ad7314_spi_write(=
chip, mode);
 -      if (ret) -              return -EIO; - -        chip->mode =3D mode=
; - -  return len; -} -
 -static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, -             ad7314_show=
_mode,
 -              ad7314_store_mode, -            0); - -static ssize_t
 ad7314_show_available_modes(struct device *dev, -              struct
 device_attribute *attr, -              char *buf) -{ - return sprintf(buf,
 "full\npower-save\n"); -} - -static IIO_DEVICE_ATTR(available_modes,
 S_IRUGO, ad7314_show_available_modes, NULL, 0); - -static ssize_t
 ad7314_show_temperature(struct device *dev, -          struct device_attri=
bute
 *attr, -               char *buf) -{ - struct iio_dev *dev_info =3D
 dev_get_drvdata(dev); -        struct ad7314_chip_info *chip =3D
 iio_priv(dev_info); -  u16 data; -     char sign =3D ' '; -      int ret; =
- -    if
 (chip->mode) { -               ret =3D ad7314_spi_write(chip, 0); -       =
       if (ret) -                      return
 -EIO; -        } - -   ret =3D ad7314_spi_read(chip, &data); -   if (ret) =
-              return
 -EIO; - -      if (chip->mode) -               ad7314_spi_write(chip, chip=
->mode); - - if
 (strcmp(dev_info->name, "ad7314")) { -         data =3D (data & AD7314_TEM=
P_MASK)
 >> -                   AD7314_TEMP_OFFSET; -           if (data & AD7314_T=
EMP_SIGN) { -                        data =3D
 (AD7314_TEMP_SIGN << 1) - data; -                      sign =3D '-'; -    =
       } - -           return
 sprintf(buf, "%c%d.%.2d\n", sign, -                            data >> AD7=
314_TEMP_FLOAT_OFFSET,
 -                              (data & AD7314_TEMP_FLOAT_MASK) * 25); -   =
     } else { -              data &=3D
 ADT7301_TEMP_MASK; -           if (data & ADT7301_TEMP_SIGN) { -          =
             data =3D
 (ADT7301_TEMP_SIGN << 1) - data; -                     sign =3D '-'; -    =
       } - -           return
 sprintf(buf, "%c%d.%.5d\n", sign, -                            data >> ADT=
7301_TEMP_FLOAT_OFFSET,
 -                              (data & ADT7301_TEMP_FLOAT_MASK) * 3125); -=
     } -} - -static
 IIO_DEVICE_ATTR(temperature, S_IRUGO, ad7314_show_temperature, NULL, 0);
 - -static struct attribute *ad7314_attributes[] =3D {
 -      &iio_dev_attr_available_modes.dev_attr.attr,
 -      &iio_dev_attr_mode.dev_attr.attr,
 -      &iio_dev_attr_temperature.dev_attr.attr, -      NULL, -}; - -static=
 const
 struct attribute_group ad7314_attribute_group =3D { -    .attrs =3D
 ad7314_attributes, -}; - -static const struct iio_info ad7314_info =3D {
 -      .attrs =3D &ad7314_attribute_group, -     .driver_module =3D THIS_M=
ODULE, -};
 -/* - * device probe and remove - */ - -static int __devinit
 ad7314_probe(struct spi_device *spi_dev) -{ -  struct ad7314_chip_info
 *chip; -       struct iio_dev *indio_dev; -    int ret =3D 0; - -        i=
ndio_dev =3D
 iio_allocate_device(sizeof(*chip)); -  if (indio_dev =3D=3D NULL) { -     =
         ret =3D
 -ENOMEM; -             goto error_ret; -       } -     chip =3D iio_priv(i=
ndio_dev); -   /* this
 is only used for device removal purposes */
 -      dev_set_drvdata(&spi_dev->dev, chip); - -       chip->spi_dev =3D s=
pi_dev; -
 -      indio_dev->name =3D spi_get_device_id(spi_dev)->name;
 -      indio_dev->dev.parent =3D &spi_dev->dev; -        indio_dev->info =
=3D
 &ad7314_info; - -      ret =3D iio_device_register(indio_dev); - if (ret)
 -              goto error_free_dev; - -        dev_info(&spi_dev->dev, "%s=
 temperature
 sensor registered.\n", -                        indio_dev->name); - -  ret=
urn 0;
 -error_free_dev: -     iio_free_device(indio_dev); -error_ret: -       ret=
urn ret;
 -} - -static int __devexit ad7314_remove(struct spi_device *spi_dev) -{
 -      struct iio_dev *indio_dev =3D dev_get_drvdata(&spi_dev->dev); -
 -      dev_set_drvdata(&spi_dev->dev, NULL);
 -      iio_device_unregister(indio_dev); - -   return 0; -} - -static cons=
t
 struct spi_device_id ad7314_id[] =3D { - { "adt7301", 0 }, -     { "adt730=
2", 0
 }, -   { "ad7314", 0 }, -      {} -}; - -static struct spi_driver ad7314_d=
river
 =3D { -  .driver =3D { -           .name =3D "ad7314", -             .bus =
=3D &spi_bus_type, -         .owner
 =3D THIS_MODULE, -       }, -    .probe =3D ad7314_probe, -        .remove=
 =3D
 __devexit_p(ad7314_remove), -  .id_table =3D ad7314_id, -}; - -static __in=
it
 int ad7314_init(void) -{ -     return spi_register_driver(&ad7314_driver);=
 -}
 - -static __exit void ad7314_exit(void) -{
 -      spi_unregister_driver(&ad7314_driver); -} - -MODULE_AUTHOR("Sonic Z=
hang
 <sonic.zhang@analog.com>"); -MODULE_DESCRIPTION("Analog Devices AD7314,
 ADT7301 and ADT7302 digital" -                 " temperature sensor driver=
");
 -MODULE_LICENSE("GPL v2"); - -module_init(ad7314_init);
 -module_exit(ad7314_exit);

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
