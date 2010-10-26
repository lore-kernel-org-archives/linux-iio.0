Return-Path: <Sonic.Zhang@analog.com>
From: "Zhang, Sonic" <Sonic.Zhang@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, Mike Frysinger <vapier@gentoo.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 25 Oct 2010 23:35:15 -0400
Subject: RE: [PATCH 04/14] staging: iio: adc: new driver for AD7314 devices
Message-ID: <DB904C5425BA6F4E8424B3B51A1414D16578B2237B@NWD2CMBX1.ad.analog.com>
References: <1287865757-1031-1-git-send-email-vapier@gentoo.org>
 <1287865757-1031-4-git-send-email-vapier@gentoo.org>
 <4CC4ABA8.2010401@cam.ac.uk>
In-Reply-To: <4CC4ABA8.2010401@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>Sent: Monday, October 25, 2010 5:57 AM
>To: Mike Frysinger
>Cc: linux-iio@vger.kernel.org;
>device-drivers-devel@blackfin.uclinux.org; Zhang, Sonic
>Subject: Re: [PATCH 04/14] staging: iio: adc: new driver for
>AD7314 devices
>
>On 10/23/10 21:29, Mike Frysinger wrote:
>> From: Sonic Zhang <sonic.zhang@analog.com>
>>
>Why IIO?  Do you have a use case that needs features off IIO
>and wouldn't be covered by hwmon?

You are right. AD7314 is not necessary to use IIO framework without interru=
pt available.

We may move it to hwmon framework late.

Sonic

>
>Not using any here, so I'm doubtful about this (Sonic and I
>exchanged a few emails about this a while back).
>
>Few comments inline and I guess iio then moving to hwmon is
>fine with me if you want to do it... (hwmon is simpler!).
>
>> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> ---
>>  drivers/staging/iio/adc/Kconfig  |    7 +
>>  drivers/staging/iio/adc/Makefile |    1 +
>>  drivers/staging/iio/adc/ad7314.c |  308
>> ++++++++++++++++++++++++++++++++++++++
>>  3 files changed, 316 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/staging/iio/adc/ad7314.c
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig
>> b/drivers/staging/iio/adc/Kconfig index 847f5f2..6d3b8bc 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -54,3 +54,10 @@ config AD7298
>>      help
>>        Say yes here to build support for Analog Devices AD7298
>>        temperature sensors and ADC.
>> +
>> +config AD7314
>> +    tristate "Analog Devices AD7314 temperature sensor driver"
>> +    depends on SPI
>Please list all parts supported (appear to be several others
>in the id table.)
>> +    help
>> +      Say yes here to build support for Analog Devices AD7314
>> +      temperature sensors.
>> diff --git a/drivers/staging/iio/adc/Makefile
>> b/drivers/staging/iio/adc/Makefile
>> index d0ea747..04fd93b 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -10,3 +10,4 @@ obj-$(CONFIG_AD7150) +=3D ad7150.o
>>  obj-$(CONFIG_AD7152) +=3D ad7152.o
>>  obj-$(CONFIG_AD7291) +=3D ad7291.o
>>  obj-$(CONFIG_AD7298) +=3D ad7298.o
>> +obj-$(CONFIG_AD7314) +=3D ad7314.o
>> diff --git a/drivers/staging/iio/adc/ad7314.c
>> b/drivers/staging/iio/adc/ad7314.c
>> new file mode 100644
>> index 0000000..8c17b1f
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7314.c
>> @@ -0,0 +1,308 @@
>> +/*
>> + * AD7314 digital temperature sensor driver for AD7314, ADT7301 and
>> +ADT7302
>> + *
>> + * Copyright 2010 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/gpio.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/rtc.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +
>> +/*
>> + * AD7314 power mode
>> + */
>> +#define AD7314_PD           0x2000
>> +
>> +/*
>> + * AD7314 temperature masks
>> + */
>> +#define AD7314_TEMP_SIGN            0x200
>> +#define AD7314_TEMP_MASK            0x7FE0
>> +#define AD7314_TEMP_OFFSET          5
>> +#define AD7314_TEMP_FLOAT_OFFSET    2
>> +#define AD7314_TEMP_FLOAT_MASK              0x3
>> +
>> +/*
>> + * ADT7301 and ADT7302 temperature masks  */
>> +#define ADT7301_TEMP_SIGN           0x2000
>> +#define ADT7301_TEMP_MASK           0x2FFF
>> +#define ADT7301_TEMP_FLOAT_OFFSET   5
>> +#define ADT7301_TEMP_FLOAT_MASK             0x1F
>> +
>> +/*
>> + * struct ad7314_chip_info - chip specifc information  */
>> +
>> +struct ad7314_chip_info {
>> +    const char *name;
>> +    struct spi_device *spi_dev;
>> +    struct iio_dev *indio_dev;
>> +    s64 last_timestamp;
>> +    u8  mode;
>> +};
>> +
>> +/*
>> + * ad7314 register access by SPI
>> + */
>> +
>> +static int ad7314_spi_read(struct ad7314_chip_info *chip,
>u16 *data)
>> +{
>> +    struct spi_device *spi_dev =3D chip->spi_dev;
>> +    int ret =3D 0;
>> +    u16 value;
>> +
>> +    ret =3D spi_read(spi_dev, (u8 *)&value, sizeof(value));
>> +    if (ret < 0) {
>> +            dev_err(&spi_dev->dev, "SPI read error\n");
>> +            return ret;
>> +    }
>> +
>> +    *data =3D be16_to_cpu((u16)value);
>> +
>> +    return ret;
>> +}
>> +
>> +static int ad7314_spi_write(struct ad7314_chip_info *chip,
>u16 data)
>> +{
>> +    struct spi_device *spi_dev =3D chip->spi_dev;
>> +    int ret =3D 0;
>> +    u16 value =3D cpu_to_be16(data);
>> +
>> +    ret =3D spi_write(spi_dev, (u8 *)&value, sizeof(value));
>> +    if (ret < 0)
>> +            dev_err(&spi_dev->dev, "SPI write error\n");
>> +
>> +    return ret;
>> +}
>> +
>> +static ssize_t ad7314_show_mode(struct device *dev,
>> +            struct device_attribute *attr,
>> +            char *buf)
>> +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7314_chip_info *chip =3D dev_info->dev_data;
>> +
>> +    if (chip->mode)
>> +            return sprintf(buf, "power-save\n");
>> +    else
>> +            return sprintf(buf, "full\n");
>> +}
>> +
>> +static ssize_t ad7314_store_mode(struct device *dev,
>> +            struct device_attribute *attr,
>> +            const char *buf,
>> +            size_t len)
>> +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7314_chip_info *chip =3D dev_info->dev_data;
>> +    u16 mode =3D 0;
>> +    int ret;
>> +
>> +    if (!strcmp(buf, "full"))
>> +            mode =3D AD7314_PD;
>> +
>> +    ret =3D ad7314_spi_write(chip, mode);
>> +    if (ret)
>> +            return -EIO;
>> +
>> +    chip->mode =3D mode;
>> +
>> +    return len;
>> +}
>> +
>> +static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR,
>> +            ad7314_show_mode,
>> +            ad7314_store_mode,
>> +            0);
>I'm still anti 'mode' attributes. They just don't generalize.
>> +
>> +static ssize_t ad7314_show_available_modes(struct device *dev,
>> +            struct device_attribute *attr,
>> +            char *buf)
>> +{
>> +    return sprintf(buf, "full\npower-save\n");
>Do this via sampling_frequency (assuming that is what changes!)
>> +}
>> +
>> +static IIO_DEVICE_ATTR(available_modes, S_IRUGO,
>> +ad7314_show_available_modes, NULL, 0);
>mode_available please.
>> +
>> +static ssize_t ad7314_show_temperature(struct device *dev,
>> +            struct device_attribute *attr,
>> +            char *buf)
>> +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7314_chip_info *chip =3D dev_info->dev_data;
>> +    u16 data;
>> +    char sign =3D ' ';
>> +    int ret;
>> +
>> +    if (chip->mode) {
>> +            ret =3D ad7314_spi_write(chip, 0);
>> +            if (ret)
>> +                    return -EIO;
>Error eating.
>> +    }
>> +
>> +    ret =3D ad7314_spi_read(chip, &data);
>> +    if (ret)
>> +            return -EIO;
>> +
>> +    if (chip->mode)
>> +            ad7314_spi_write(chip, chip->mode);
>> +
>> +    if (strcmp(chip->name, "ad7314")) {
>> +            data =3D (data & AD7314_TEMP_MASK) >>
>> +                    AD7314_TEMP_OFFSET;
>> +            if (data & AD7314_TEMP_SIGN) {
>> +                    data =3D (AD7314_TEMP_SIGN << 1) - data;
>> +                    sign =3D '-';
>> +            }
>> +
>> +            return sprintf(buf, "%c%d.%.2d\n", sign,
>> +                            data >> AD7314_TEMP_FLOAT_OFFSET,
>> +                            (data & AD7314_TEMP_FLOAT_MASK) * 25);
>> +    } else {
>> +            data &=3D ADT7301_TEMP_MASK;
>> +            if (data & ADT7301_TEMP_SIGN) {
>> +                    data =3D (ADT7301_TEMP_SIGN << 1) - data;
>> +                    sign =3D '-';
>> +            }
>> +
>> +            return sprintf(buf, "%c%d.%.5d\n", sign,
>> +                            data >> ADT7301_TEMP_FLOAT_OFFSET,
>> +                            (data &
>ADT7301_TEMP_FLOAT_MASK) * 3125);
>> +    }
>> +}
>> +
>> +static IIO_DEVICE_ATTR(temperature, S_IRUGO,
>ad7314_show_temperature,
>> +NULL, 0);
>> +
>> +static ssize_t ad7314_show_name(struct device *dev,
>> +            struct device_attribute *attr,
>> +            char *buf)
>> +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7314_chip_info *chip =3D dev_info->dev_data;
>> +    return sprintf(buf, "%s\n", chip->name); }
>> +
>> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad7314_show_name, NULL, 0);
>> +
>> +static struct attribute *ad7314_attributes[] =3D {
>> +    &iio_dev_attr_available_modes.dev_attr.attr,
>> +    &iio_dev_attr_mode.dev_attr.attr,
>> +    &iio_dev_attr_temperature.dev_attr.attr,
>temp_input please (we match hwmon where possible).
>
>> +    &iio_dev_attr_name.dev_attr.attr,
>> +    NULL,
>> +};
>> +
>> +static const struct attribute_group ad7314_attribute_group =3D {
>> +    .attrs =3D ad7314_attributes,
>> +};
>> +
>> +/*
>> + * device probe and remove
>> + */
>> +
>> +static int __devinit ad7314_probe(struct spi_device *spi_dev) {
>> +    struct ad7314_chip_info *chip;
>> +    int ret =3D 0;
>> +
>> +    chip =3D kzalloc(sizeof(struct ad7314_chip_info), GFP_KERNEL);
>> +
>> +    if (chip =3D=3D NULL)
>> +            return -ENOMEM;
>> +
>> +    /* this is only used for device removal purposes */
>> +    dev_set_drvdata(&spi_dev->dev, chip);
>> +
>> +    chip->spi_dev =3D spi_dev;
>> +    chip->name =3D spi_dev->modalias;
>> +
>> +    chip->indio_dev =3D iio_allocate_device();
>> +    if (chip->indio_dev =3D=3D NULL) {
>> +            ret =3D -ENOMEM;
>> +            goto error_free_chip;
>> +    }
>> +
>> +    chip->indio_dev->dev.parent =3D &spi_dev->dev;
>> +    chip->indio_dev->attrs =3D &ad7314_attribute_group;
>> +    chip->indio_dev->dev_data =3D (void *)chip;
>> +    chip->indio_dev->driver_module =3D THIS_MODULE;
>> +
>> +    ret =3D iio_device_register(chip->indio_dev);
>> +    if (ret)
>> +            goto error_free_dev;
>> +
>> +    dev_info(&spi_dev->dev, "%s temperature sensor registered.\n",
>> +                     chip->name);
>> +
>> +    return 0;
>> +error_free_dev:
>> +    iio_free_device(chip->indio_dev);
>> +error_free_chip:
>> +    kfree(chip);
>> +
>> +    return ret;
>> +}
>> +
>> +static int __devexit ad7314_remove(struct spi_device *spi_dev) {
>> +    struct ad7314_chip_info *chip =3D dev_get_drvdata(&spi_dev->dev);
>> +    struct iio_dev *indio_dev =3D chip->indio_dev;
>> +
>> +    dev_set_drvdata(&spi_dev->dev, NULL);
>> +    if (spi_dev->irq)
>> +            iio_unregister_interrupt_line(indio_dev, 0);
>> +    iio_device_unregister(indio_dev);
>> +    iio_free_device(chip->indio_dev);
>> +    kfree(chip);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct spi_device_id ad7314_id[] =3D {
>> +    { "adt7301", 0 },
>> +    { "adt7302", 0 },
>> +    { "ad7314", 0 },
>> +    {}
>> +};
>> +
>> +static struct spi_driver ad7314_driver =3D {
>> +    .driver =3D {
>> +            .name =3D "ad7314",
>> +            .bus =3D &spi_bus_type,
>> +            .owner =3D THIS_MODULE,
>> +    },
>> +    .probe =3D ad7314_probe,
>> +    .remove =3D __devexit_p(ad7314_remove),
>> +    .id_table =3D ad7314_id,
>> +};
>> +
>> +static __init int ad7314_init(void)
>> +{
>> +    return spi_register_driver(&ad7314_driver);
>> +}
>> +
>> +static __exit void ad7314_exit(void)
>> +{
>> +    spi_unregister_driver(&ad7314_driver);
>> +}
>> +
>> +MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
>> +MODULE_DESCRIPTION("Analog Devices AD7314, ADT7301 and
>ADT7302 digital"
>> +                    " temperature sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> +
>> +module_init(ad7314_init);
>> +module_exit(ad7314_exit);
>
>
