Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 19 Nov 2010 15:19:47 +0000
Subject: RE: [PATCH] staging: iio: adc: Enable driver support for ad7887 AD
 converter
Message-ID: <544AC56F16B56944AEC3BD4E3D591771312EE154B7@LIMKCMBX1.ad.analog.com>
References: <1290097328-6236-1-git-send-email-michael.hennerich@analog.com>
 <4CE68D1F.3050200@cam.ac.uk>
In-Reply-To: <4CE68D1F.3050200@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Sorry my Outlook QuoteFix Macro often fails with patches...

>-----Original Message-----
>From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>Sent: Friday, November 19, 2010 3:44 PM
>To: Hennerich, Michael
>Cc: linux-iio@vger.kernel.org; Drivers; device-drivers-
>devel@blackfin.uclinux.org
>Subject: Re: [PATCH] staging: iio: adc: Enable driver support for
>ad7887 AD converter
>
>On 11/18/10 16:22, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> Enable support for AD7887:  SPI Micropower, 2-Channel, 125 kSPS,
>> 12-Bit ADC
>Nice driver. Few very minor questions / suggestions inline.
>>
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>> ---
>>  drivers/staging/iio/adc/Kconfig       |   14 ++
>>  drivers/staging/iio/adc/Makefile      |    4 +
>>  drivers/staging/iio/adc/ad7887.h      |   92 ++++++++++
>>  drivers/staging/iio/adc/ad7887_core.c |  303
>> +++++++++++++++++++++++++++++++++
>> drivers/staging/iio/adc/ad7887_ring.c |  273
>> +++++++++++++++++++++++++++++
>>  5 files changed, 686 insertions(+), 0 deletions(-)  create mode
>> 100644 drivers/staging/iio/adc/ad7887.h  create mode 100644
>> drivers/staging/iio/adc/ad7887_core.c
>>  create mode 100644 drivers/staging/iio/adc/ad7887_ring.c
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig
>> b/drivers/staging/iio/adc/Kconfig index 9ca6565..86869cd 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -97,6 +97,20 @@ config AD7476
>>        To compile this driver as a module, choose M here: the
>>        module will be called ad7476.
>>
>> +config AD7887
>> +    tristate "Analog Devices AD7887 ADC driver"
>> +    depends on SPI
>> +    select IIO_RING_BUFFER
>> +    select IIO_SW_RING
>> +    select IIO_TRIGGER
>> +    help
>> +      Say yes here to build support for Analog Devices
>> +      AD7887 SPI analog to digital convertor (ADC).
>converter
>> +      If unsure, say N (but it's safe to say "Y").
>> +
>> +      To compile this driver as a module, choose M here: the
>> +      module will be called ad7887.
>> +
>>  config AD7745
>>      tristate "Analog Devices AD7745, AD7746 AD7747 capacitive sensor
>driver"
>>      depends on I2C
>> diff --git a/drivers/staging/iio/adc/Makefile
>> b/drivers/staging/iio/adc/Makefile
>> index a7dce6b..6f231a2 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -15,6 +15,10 @@ ad7476-y :=3D ad7476_core.o
>>  ad7476-$(CONFIG_IIO_RING_BUFFER) +=3D ad7476_ring.o
>>  obj-$(CONFIG_AD7476) +=3D ad7476.o
>>
>> +ad7887-y :=3D ad7887_core.o
>> +ad7887-$(CONFIG_IIO_RING_BUFFER) +=3D ad7887_ring.o
>> +obj-$(CONFIG_AD7887) +=3D ad7887.o
>> +
>>  obj-$(CONFIG_AD7150) +=3D ad7150.o
>>  obj-$(CONFIG_AD7152) +=3D ad7152.o
>>  obj-$(CONFIG_AD7291) +=3D ad7291.o
>> diff --git a/drivers/staging/iio/adc/ad7887.h
>> b/drivers/staging/iio/adc/ad7887.h
>> new file mode 100644
>> index 0000000..43c5fa1
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7887.h
>> @@ -0,0 +1,92 @@
>> +/*
>> + * AD7887 SPI ADC driver
>> + *
>> + * Copyright 2010 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +#ifndef IIO_ADC_AD7887_H_
>> +#define IIO_ADC_AD7887_H_
>> +
>> +#define AD7887_REF_DIS              (1 << 5) /* on-chip reference
>disable */
>> +#define AD7887_DUAL         (1 << 4) /* dual-channel mode */
>> +#define AD7887_CH_AIN1              (1 << 3) /* convert on channel 1,
>DUAL=3D1 */
>> +#define AD7887_CH_AIN0              (0 << 3) /* convert on channel 0,
>DUAL=3D0,1 */
>> +#define AD7887_PM_MODE1             (0)      /* CS based shutdown */
>> +#define AD7887_PM_MODE2             (1)      /* full on */
>> +#define AD7887_PM_MODE3             (2)      /* auto shutdown after
>conversion */
>> +#define AD7887_PM_MODE4             (3)      /* standby mode */
>> +
>> +enum ad7887_channels {
>> +    AD7887_CH0,
>> +    AD7887_CH0_CH1,
>> +    AD7887_CH1,
>> +};
>> +
>> +#define RES_MASK(bits)      ((1 << (bits)) - 1)
>It feels like this ought to be a standard macro, but I can't find it in
>any of the obvious headers...

I thought so too.
But I also can't find it - maybe add to one of the iio common headers?

>> +
>> +/*
>> + * TODO: struct ad7887_platform_data needs to go into
>> +include/linux/iio  */
>> +
>Please document this structure.  That en_dual in particular is not
>entirely obvious.

ok

>> +struct ad7887_platform_data {
>> +    u16                             vref_mv;
>> +    bool                            en_dual;
>> +    bool                            use_onchip_ref;
>> +};
>> +
>Ideally this struct could do with some docs as well.
>That res_shift is non obvious.

ok

>> +struct ad7887_chip_info {
>> +    u8                              bits;
>> +    u8                              storagebits;
>> +    u8                              res_shift;
>> +    char                            sign;
>> +    u16                             int_vref_mv;
>> +};
>> +
>> +struct ad7887_state {
>> +    struct iio_dev                  *indio_dev;
>> +    struct spi_device               *spi;
>> +    const struct ad7887_chip_info   *chip_info;
>> +    struct regulator                *reg;
>> +    struct work_struct              poll_work;
>> +    atomic_t                        protect_ring;
>> +    u16                             int_vref_mv;
>> +    bool                            en_dual;
>> +    struct spi_transfer             xfer[4];
>> +    struct spi_message              msg[3];
>> +    struct spi_message              *ring_msg;
>> +    unsigned char                   tx_cmd_buf[8];
>> +
>> +    /*
>> +     * DMA (thus cache coherency maintenance) requires the
>> +     * transfer buffers to live in their own cache lines.
>> +     */
>> +
>> +    unsigned char                   data[4] ____cacheline_aligned;
>> +};
>> +
>> +enum ad7887_supported_device_ids {
>> +    ID_AD7887
>> +};
>> +
>> +#ifdef CONFIG_IIO_RING_BUFFER
>> +int ad7887_scan_from_ring(struct ad7887_state *st, long mask); int
>> +ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev); void
>> +ad7887_ring_cleanup(struct iio_dev *indio_dev); #else /*
>> +CONFIG_IIO_RING_BUFFER */ static inline int
>> +ad7887_scan_from_ring(struct ad7887_state *st, long mask) {
>> +    return 0;
>> +}
>> +
>> +static inline int
>> +ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev) {
>> +    return 0;
>> +}
>> +
>> +static inline void ad7887_ring_cleanup(struct iio_dev *indio_dev) {
>> +} #endif /* CONFIG_IIO_RING_BUFFER */ #endif /* IIO_ADC_AD7887_H_ */
>> diff --git a/drivers/staging/iio/adc/ad7887_core.c
>> b/drivers/staging/iio/adc/ad7887_core.c
>> new file mode 100644
>> index 0000000..aee70cd
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7887_core.c
>> @@ -0,0 +1,303 @@
>> +/*
>> + * AD7887 SPI ADC driver
>> + *
>> + * Copyright 2010 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2 or later.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/list.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/regulator/consumer.h> #include <linux/err.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "../ring_generic.h"
>> +#include "adc.h"
>> +
>> +#include "ad7887.h"
>> +
>> +static int ad7887_scan_direct(struct ad7887_state *st, unsigned ch) {
>> +    int ret =3D spi_sync(st->spi, &st->msg[ch]);
>> +    if (ret)
>> +            return ret;
>> +
>Use one of the endian macros for this perhaps?

Can do but need to make data 16-bit aligned.

>> +    return (st->data[(ch * 2)] << 8) | st->data[(ch * 2) + 1]; }
>> +
>> +static ssize_t ad7887_scan(struct device *dev,
>> +                        struct device_attribute *attr,
>> +                        char *buf)
>> +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7887_state *st =3D dev_info->dev_data;
>> +    struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
>> +    int ret;
>> +
>> +    mutex_lock(&dev_info->mlock);
>> +    if (iio_ring_enabled(dev_info))
>> +            ret =3D ad7887_scan_from_ring(st, 1 << this_attr->address);
>> +    else
>> +            ret =3D ad7887_scan_direct(st, this_attr->address);
>> +    mutex_unlock(&dev_info->mlock);
>> +
>> +    if (ret < 0)
>> +            return ret;
>> +
>> +    return sprintf(buf, "%d\n", (ret >> st->chip_info->res_shift) &
>> +                   RES_MASK(st->chip_info->bits)); } static
>> +IIO_DEV_ATTR_IN_RAW(0, ad7887_scan, 0); static
>> +IIO_DEV_ATTR_IN_RAW(1, ad7887_scan, 1);
>> +
>> +static ssize_t ad7887_show_scale(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            char *buf)
>> +{
>> +    /* Driver currently only support internal vref */
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7887_state *st =3D iio_dev_get_devdata(dev_info);
>> +    /* Corresponds to Vref / 2^(bits) */
>> +    unsigned int scale_uv =3D (st->int_vref_mv * 1000) >>
>> +st->chip_info->bits;
>> +
>> +    return sprintf(buf, "%d.%d\n", scale_uv / 1000, scale_uv % 1000);
>}
>> +static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7887_show_scale, NULL,
>> +0);
>> +
>> +static ssize_t ad7887_show_name(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             char *buf)
>> +{
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7887_state *st =3D iio_dev_get_devdata(dev_info);
>> +
>> +    return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
>> +}
>> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad7887_show_name, NULL, 0);
>> +
>> +static struct attribute *ad7887_attributes[] =3D {
>> +    &iio_dev_attr_in0_raw.dev_attr.attr,
>> +    &iio_dev_attr_in1_raw.dev_attr.attr,
>> +    &iio_dev_attr_in_scale.dev_attr.attr,
>> +    &iio_dev_attr_name.dev_attr.attr,
>> +    NULL,
>> +};
>> +
>
>I learn something new every day. Didn't know you could do this. Might
>be a sensible method to clean up a number of other drivers... Will look
>into it futher at some point.

Yeah is_visible can help a lot. Actually I think this facility is pretty ne=
w.

>> +static mode_t ad7887_attr_is_visible(struct kobject *kobj,
>> +                                 struct attribute *attr, int n) {
>> +    struct device *dev =3D container_of(kobj, struct device, kobj);
>> +    struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>> +    struct ad7887_state *st =3D iio_dev_get_devdata(dev_info);
>> +
>> +    mode_t mode =3D attr->mode;
>> +
>> +    if (attr =3D=3D &iio_dev_attr_in1_raw.dev_attr.attr)
>> +            if (!st->en_dual)
>combine the two if statements

ok

>> +                    mode =3D 0;
>> +
>> +    return mode;
>> +}
>> +
>> +static const struct attribute_group ad7887_attribute_group =3D {
>> +    .attrs =3D ad7887_attributes,
>> +    .is_visible =3D ad7887_attr_is_visible, };
>> +
>
>So is there a plan to add more parts to this driver?  Usually one
>doesn't put this code in until at's needed, but if more are following
>shortly then it's fine with me. Perhaps add something to the commit
>message to indicate that this is going to be needed by future device
>support?

Plan is to add more drivers - indeed I already have added one.
But I need to wait for test hardware to arrive.

>
>> +static const struct ad7887_chip_info ad7887_chip_info_tbl[] =3D {
>> +    [ID_AD7887] =3D {
>> +            .bits =3D 12,
>> +            .storagebits =3D 16,
>> +            .res_shift =3D 0,
>> +            .sign =3D IIO_SCAN_EL_TYPE_UNSIGNED,
>> +            .int_vref_mv =3D 2500,
>> +    },
>> +};
>> +
>> +static int __devinit ad7887_probe(struct spi_device *spi) {
>> +    struct ad7887_platform_data *pdata =3D spi->dev.platform_data;
>> +    struct ad7887_state *st;
>> +    int ret, voltage_uv =3D 0;
>> +
>> +    st =3D kzalloc(sizeof(*st), GFP_KERNEL);
>> +    if (st =3D=3D NULL) {
>> +            ret =3D -ENOMEM;
>> +            goto error_ret;
>> +    }
>> +
>> +    st->reg =3D regulator_get(&spi->dev, "vcc");
>> +    if (!IS_ERR(st->reg)) {
>> +            ret =3D regulator_enable(st->reg);
>> +            if (ret)
>> +                    goto error_put_reg;
>> +
>> +            voltage_uv =3D regulator_get_voltage(st->reg);
>Technically you might want to register for the voltage change
>notification from the regulator.  Some other driver might request a
>different voltage and I don't think you have prevented it from changing.

I'm not quite sure what you mean. I don't think someone wants to change thi=
s voltage on the fly.

>> +    }
>> +
>> +    st->chip_info =3D
>> +            &ad7887_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>> +
>> +    spi_set_drvdata(spi, st);
>> +
>> +    atomic_set(&st->protect_ring, 0);
>> +    st->spi =3D spi;
>> +
>> +    st->indio_dev =3D iio_allocate_device();
>> +    if (st->indio_dev =3D=3D NULL) {
>> +            ret =3D -ENOMEM;
>> +            goto error_disable_reg;
>> +    }
>> +
>> +    /* Estabilish that the iio_dev is a child of the i2c device */
>> +    st->indio_dev->dev.parent =3D &spi->dev;
>> +    st->indio_dev->attrs =3D &ad7887_attribute_group;
>> +    st->indio_dev->dev_data =3D (void *)(st);
>> +    st->indio_dev->driver_module =3D THIS_MODULE;
>> +    st->indio_dev->modes =3D INDIO_DIRECT_MODE;
>> +
>> +    /* Setup default message */
>> +
>> +    st->tx_cmd_buf[0] =3D AD7887_CH_AIN0 | AD7887_PM_MODE4 |
>> +                        ((pdata && pdata->use_onchip_ref) ?
>> +                        0 : AD7887_REF_DIS);
>> +
>> +    st->xfer[0].rx_buf =3D &st->data[0];
>> +    st->xfer[0].tx_buf =3D &st->tx_cmd_buf[0],
>> +    st->xfer[0].len =3D 2,
>> +
>> +    spi_message_init(&st->msg[AD7887_CH0]);
>> +    spi_message_add_tail(&st->xfer[0], &st->msg[AD7887_CH0]);
>> +
>> +    if (pdata && pdata->en_dual) {
>> +            st->tx_cmd_buf[0] |=3D AD7887_DUAL | AD7887_REF_DIS;
>> +
>> +            st->tx_cmd_buf[2] =3D AD7887_CH_AIN1 | AD7887_DUAL |
>> +                                AD7887_REF_DIS | AD7887_PM_MODE4;
>> +            st->tx_cmd_buf[4] =3D AD7887_CH_AIN0 | AD7887_DUAL |
>> +                                AD7887_REF_DIS | AD7887_PM_MODE4;
>> +            st->tx_cmd_buf[6] =3D AD7887_CH_AIN1 | AD7887_DUAL |
>> +                                AD7887_REF_DIS | AD7887_PM_MODE4;
>> +
>> +            st->xfer[1].rx_buf =3D &st->data[0];
>> +            st->xfer[1].tx_buf =3D &st->tx_cmd_buf[2],
>> +            st->xfer[1].len =3D 2,
>> +
>> +            st->xfer[2].rx_buf =3D &st->data[2];
>> +            st->xfer[2].tx_buf =3D &st->tx_cmd_buf[4],
>> +            st->xfer[2].len =3D 2,
>> +
>> +            spi_message_init(&st->msg[AD7887_CH0_CH1]);
>> +            spi_message_add_tail(&st->xfer[1], &st-
>>msg[AD7887_CH0_CH1]);
>> +            spi_message_add_tail(&st->xfer[2], &st-
>>msg[AD7887_CH0_CH1]);
>> +
>> +            st->xfer[3].rx_buf =3D &st->data[0];
>> +            st->xfer[3].tx_buf =3D &st->tx_cmd_buf[6],
>> +            st->xfer[3].len =3D 2,
>> +
>> +            spi_message_init(&st->msg[AD7887_CH1]);
>> +            spi_message_add_tail(&st->xfer[3], &st->msg[AD7887_CH1]);
>> +
>> +            st->en_dual =3D true;
>> +
>> +            if (pdata && pdata->vref_mv)
>> +                    st->int_vref_mv =3D pdata->vref_mv;
>> +            else if (voltage_uv)
>> +                    st->int_vref_mv =3D voltage_uv / 1000;
>> +            else
>> +                    dev_warn(&spi->dev, "reference voltage
>unspecified\n");
>> +
>> +    } else {
>> +            if (pdata && pdata->vref_mv)
>> +                    st->int_vref_mv =3D pdata->vref_mv;
>> +            else if (pdata && pdata->use_onchip_ref)
>> +                    st->int_vref_mv =3D st->chip_info->int_vref_mv;
>> +            else
>> +                    dev_warn(&spi->dev, "reference voltage
>unspecified\n");
>> +    }
>> +
>> +
>> +    ret =3D ad7887_register_ring_funcs_and_init(st->indio_dev);
>> +    if (ret)
>> +            goto error_free_device;
>> +
>> +    ret =3D iio_device_register(st->indio_dev);
>> +    if (ret)
>> +            goto error_free_device;
>> +
>> +    ret =3D iio_ring_buffer_register(st->indio_dev->ring, 0);
>> +    if (ret)
>> +            goto error_cleanup_ring;
>> +    return 0;
>> +
>> +error_cleanup_ring:
>> +    ad7887_ring_cleanup(st->indio_dev);
>> +    iio_device_unregister(st->indio_dev);
>> +error_free_device:
>> +    iio_free_device(st->indio_dev);
>> +error_disable_reg:
>> +    if (!IS_ERR(st->reg))
>> +            regulator_disable(st->reg);
>> +error_put_reg:
>> +    if (!IS_ERR(st->reg))
>> +            regulator_put(st->reg);
>> +    kfree(st);
>> +error_ret:
>> +    return ret;
>> +}
>> +
>> +static int ad7887_remove(struct spi_device *spi) {
>> +    struct ad7887_state *st =3D spi_get_drvdata(spi);
>> +    struct iio_dev *indio_dev =3D st->indio_dev;
>> +    iio_ring_buffer_unregister(indio_dev->ring);
>> +    ad7887_ring_cleanup(indio_dev);
>> +    iio_device_unregister(indio_dev);
>> +    if (!IS_ERR(st->reg)) {
>> +            regulator_disable(st->reg);
>> +            regulator_put(st->reg);
>> +    }
>> +    kfree(st);
>> +    return 0;
>> +}
>> +
>> +static const struct spi_device_id ad7887_id[] =3D {
>> +    {"ad7887", ID_AD7887},
>> +    {}
>> +};
>> +
>> +static struct spi_driver ad7887_driver =3D {
>> +    .driver =3D {
>> +            .name   =3D "ad7887",
>> +            .bus    =3D &spi_bus_type,
>> +            .owner  =3D THIS_MODULE,
>> +    },
>> +    .probe          =3D ad7887_probe,
>> +    .remove         =3D __devexit_p(ad7887_remove),
>> +    .id_table       =3D ad7887_id,
>> +};
>> +
>> +static int __init ad7887_init(void)
>> +{
>> +    return spi_register_driver(&ad7887_driver);
>> +}
>> +module_init(ad7887_init);
>> +
>> +static void __exit ad7887_exit(void) {
>> +    spi_unregister_driver(&ad7887_driver);
>> +}
>> +module_exit(ad7887_exit);
>> +
>> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices AD7887 ADC"); MODULE_LICENSE("GPL
>> +v2"); MODULE_ALIAS("spi:ad7887");
>> diff --git a/drivers/staging/iio/adc/ad7887_ring.c
>> b/drivers/staging/iio/adc/ad7887_ring.c
>> new file mode 100644
>> index 0000000..a207d07
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7887_ring.c
>> @@ -0,0 +1,273 @@
>> +/*
>> + * Copyright 2010 Analog Devices Inc.
>> + * Copyright (C) 2008 Jonathan Cameron
>> + *
>> + * Licensed under the GPL-2 or later.
>> + *
>> + * ad7887_ring.c
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
>> +
>> +#include "../iio.h"
>> +#include "../ring_generic.h"
>> +#include "../ring_sw.h"
>> +#include "../trigger.h"
>> +#include "../sysfs.h"
>> +
>> +#include "ad7887.h"
>> +
>> +static IIO_SCAN_EL_C(in0, 0, 0, NULL); static IIO_SCAN_EL_C(in1, 1,
>> +0, NULL);
>> +
>> +static ssize_t ad7887_show_type(struct device *dev,
>> +                            struct device_attribute *attr,
>> +                            char *buf)
>> +{
>> +    struct iio_ring_buffer *ring =3D dev_get_drvdata(dev);
>> +    struct iio_dev *indio_dev =3D ring->indio_dev;
>> +    struct ad7887_state *st =3D indio_dev->dev_data;
>> +
>> +    return sprintf(buf, "%c%d/%d>>%d\n", st->chip_info->sign,
>> +                   st->chip_info->bits, st->chip_info->storagebits,
>> +                   st->chip_info->res_shift);
>> +}
>> +static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad7887_show_type, NULL, 0);
>> +
>> +static struct attribute *ad7887_scan_el_attrs[] =3D {
>> +    &iio_scan_el_in0.dev_attr.attr,
>> +    &iio_const_attr_in0_index.dev_attr.attr,
>> +    &iio_scan_el_in1.dev_attr.attr,
>> +    &iio_const_attr_in1_index.dev_attr.attr,
>> +    &iio_dev_attr_in_type.dev_attr.attr,
>> +    NULL,
>> +};
>> +
>> +static mode_t ad7887_scan_el_attr_is_visible(struct kobject *kobj,
>> +                                 struct attribute *attr, int n) {
>> +    struct device *dev =3D container_of(kobj, struct device, kobj);
>> +    struct iio_ring_buffer *ring =3D dev_get_drvdata(dev);
>> +    struct iio_dev *indio_dev =3D ring->indio_dev;
>> +    struct ad7887_state *st =3D indio_dev->dev_data;
>> +
>> +    mode_t mode =3D attr->mode;
>> +
>> +    if ((attr =3D=3D &iio_scan_el_in1.dev_attr.attr) ||
>> +            (attr =3D=3D &iio_const_attr_in1_index.dev_attr.attr))
>> +            if (!st->en_dual)
>> +                    mode =3D 0;
>> +
>> +    return mode;
>> +}
>> +
>> +static struct attribute_group ad7887_scan_el_group =3D {
>> +    .name =3D "scan_elements",
>> +    .attrs =3D ad7887_scan_el_attrs,
>> +    .is_visible =3D ad7887_scan_el_attr_is_visible, };
>> +
>> +int ad7887_scan_from_ring(struct ad7887_state *st, long mask) {
>> +    struct iio_ring_buffer *ring =3D st->indio_dev->ring;
>> +    int count =3D 0, ret;
>> +    u16 *ring_data;
>> +
>> +    if (!(ring->scan_mask & mask)) {
>> +            ret =3D -EBUSY;
>> +            goto error_ret;
>> +    }
>> +
>> +    ring_data =3D kmalloc(ring->access.get_bytes_per_datum(ring),
>GFP_KERNEL);
>> +    if (ring_data =3D=3D NULL) {
>> +            ret =3D -ENOMEM;
>> +            goto error_ret;
>> +    }
>> +    ret =3D ring->access.read_last(ring, (u8 *) ring_data);
>> +    if (ret)
>> +            goto error_free_ring_data;
>> +
>> +    /* for single channel scan the result is stored with zero offset
>*/
>This does seem somewhat over complex given the device only has two
>channels...

Ok - will simplify a bit.


>> +    if (hweight_long(ring->scan_mask) > 1) {
>> +            /* Need a count of channels prior to this one */
>> +            mask >>=3D 1;
>> +            while (mask) {
>> +                    if (mask & ring->scan_mask)
>> +                            count++;
>> +                    mask >>=3D 1;
>> +            }
>> +    }
>> +
>> +    ret =3D be16_to_cpu(ring_data[count]);
>> +
>> +error_free_ring_data:
>> +    kfree(ring_data);
>> +error_ret:
>> +    return ret;
>> +}
>> +
>> +/**
>> + * ad7887_ring_preenable() setup the parameters of the ring before
>> +enabling
>> + *
>> + * The complex nature of the setting of the nuber of bytes per datum
>> +is due
>> + * to this driver currently ensuring that the timestamp is stored at
>> +an 8
>> + * byte boundary.
>> + **/
>> +static int ad7887_ring_preenable(struct iio_dev *indio_dev) {
>> +    struct ad7887_state *st =3D indio_dev->dev_data;
>> +    struct iio_ring_buffer *ring =3D indio_dev->ring;
>> +    size_t d_size;
>> +
>> +    if (indio_dev->ring->access.set_bytes_per_datum) {
>> +            d_size =3D st->chip_info->storagebits / 8 + sizeof(s64);
>> +            if (d_size % 8)
>> +                    d_size +=3D 8 - (d_size % 8);
>> +            indio_dev->ring->access.set_bytes_per_datum(indio_dev->ring=
,
>> +                                                        d_size);
>> +    }
>> +
>> +    switch (ring->scan_mask) {
>> +    case 1:
>> +            st->ring_msg =3D &st->msg[AD7887_CH0];
>> +            break;
>> +    case 2:
>To clarify for code readers what is happening here, can you make this:
>case (1 << 1):

ok
>> +            st->ring_msg =3D &st->msg[AD7887_CH1];
>> +            /* Dummy read: push CH1 setting down to hardware */
>> +            spi_sync(st->spi, st->ring_msg);
>> +            break;
>As a clarification here, can you make this case (1 << 1) | 1:

ok
>> +    case 3:
>> +            st->ring_msg =3D &st->msg[AD7887_CH0_CH1];
>> +            break;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int ad7887_ring_postdisable(struct iio_dev *indio_dev) {
>> +    struct ad7887_state *st =3D indio_dev->dev_data;
>> +
>> +    /* dummy read: restore default CH0 settin */
>> +    return spi_sync(st->spi, &st->msg[AD7887_CH0]); }
>> +
>> +/**
>> + * ad7887_poll_func_th() th of trigger launched polling to ring
>> +buffer
>> + *
>> + * As sampling only occurs on i2c comms occuring, leave timestamping
>> +until
>> + * then.  Some triggers will generate their own time stamp.
>> +Currently
>> + * there is no way of notifying them when no one cares.
>> + **/
>> +static void ad7887_poll_func_th(struct iio_dev *indio_dev, s64 time)
>> +{
>> +    struct ad7887_state *st =3D indio_dev->dev_data;
>> +
>> +    schedule_work(&st->poll_work);
>> +    return;
>> +}
>> +/**
>> + * ad7887_poll_bh_to_ring() bh of trigger launched polling to ring
>buffer
>> + * @work_s: the work struct through which this was scheduled
>> + *
>> + * Currently there is no option in this driver to disable the saving
>> +of
>> + * timestamps within the ring.
>> + * I think the one copy of this at a time was to avoid problems if
>> +the
>> + * trigger was set far too high and the reads then locked up the
>computer.
>> + **/
>Good to see my random comments turning up in lots of drivers ;)  I
>really ought to clear some of these out...
>
>> +static void ad7887_poll_bh_to_ring(struct work_struct *work_s) {
>> +    struct ad7887_state *st =3D container_of(work_s, struct
>ad7887_state,
>> +                                              poll_work);
>> +    struct iio_dev *indio_dev =3D st->indio_dev;
>> +    struct iio_sw_ring_buffer *sw_ring =3D iio_to_sw_ring(indio_dev-
>>ring);
>> +    struct iio_ring_buffer *ring =3D indio_dev->ring;
>> +    s64 time_ns;
>> +    __u8 *buf;
>> +    int b_sent;
>> +    size_t d_size;
>> +
>> +    unsigned int bytes =3D ring->scan_count * st->chip_info->storagebit=
s
>/
>> +8;
>> +
>> +    /* Ensure the timestamp is 8 byte aligned */
>> +    d_size =3D bytes + sizeof(s64);
>> +    if (d_size % sizeof(s64))
>Spacing looks dubious round that minus sign. Would have thought
>checkpatch would have moaned about that.

Actually checkpatch complained about having the spacing.
I removed it to make checkpatch happy.
Must be a bug in checkpatch, I'll revert.


>> +            d_size +=3D sizeof(s64)-(d_size % sizeof(s64));
>> +
>> +    /* Ensure only one copy of this function running at a time */
>> +    if (atomic_inc_return(&st->protect_ring) > 1)
>> +            return;
>> +
>> +    buf =3D kzalloc(d_size, GFP_KERNEL);
>> +    if (buf =3D=3D NULL)
>> +            return;
>> +
>> +    b_sent =3D spi_sync(st->spi, st->ring_msg);
>> +    if (b_sent)
>> +            goto done;
>> +
>> +    time_ns =3D iio_get_time_ns();
>> +
>> +    memcpy(buf, st->data, bytes);
>> +    memcpy(buf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
>> +
>> +    indio_dev->ring->access.store_to(&sw_ring->buf, buf, time_ns);
>> +done:
>> +    kfree(buf);
>> +    atomic_dec(&st->protect_ring);
>> +}
>> +
>> +int ad7887_register_ring_funcs_and_init(struct iio_dev *indio_dev) {
>> +    struct ad7887_state *st =3D indio_dev->dev_data;
>> +    int ret =3D 0;
>Don't think this ret needs to be assigned. Can't see any path to the
>end where it isn't set first anyway.
Right

>> +
>> +    indio_dev->ring =3D iio_sw_rb_allocate(indio_dev);
>> +    if (!indio_dev->ring) {
>> +            ret =3D -ENOMEM;
>> +            goto error_ret;
>> +    }
>> +    /* Effectively select the ring buffer implementation */
>> +    iio_ring_sw_register_funcs(&indio_dev->ring->access);
>> +    ret =3D iio_alloc_pollfunc(indio_dev, NULL, &ad7887_poll_func_th);
>> +    if (ret)
>> +            goto error_deallocate_sw_rb;
>> +
>> +    /* Ring buffer functions - here trigger setup related */
>> +
>> +    indio_dev->ring->preenable =3D &ad7887_ring_preenable;
>> +    indio_dev->ring->postenable =3D &iio_triggered_ring_postenable;
>> +    indio_dev->ring->predisable =3D &iio_triggered_ring_predisable;
>> +    indio_dev->ring->postdisable =3D &ad7887_ring_postdisable;
>> +    indio_dev->ring->scan_el_attrs =3D &ad7887_scan_el_group;
>> +
>> +    INIT_WORK(&st->poll_work, &ad7887_poll_bh_to_ring);
>> +
>> +    /* Flag that polled ring buffering is possible */
>> +    indio_dev->modes |=3D INDIO_RING_TRIGGERED;
>> +    return 0;
>> +error_deallocate_sw_rb:
>> +    iio_sw_rb_free(indio_dev->ring);
>> +error_ret:
>> +    return ret;
>> +}
>> +
>
>Not a comment on this driver specifically, but this function is exactly
>replicated across a number of drivers. Guess ripping it out to a helper
>function is one for the todo list!

Great idea

>> +void ad7887_ring_cleanup(struct iio_dev *indio_dev) {
>> +    /* ensure that the trigger has been detached */
>> +    if (indio_dev->trig) {
>> +            iio_put_trigger(indio_dev->trig);
>> +            iio_trigger_dettach_poll_func(indio_dev->trig,
>> +                                          indio_dev->pollfunc);
>> +    }
>> +    kfree(indio_dev->pollfunc);
>> +    iio_sw_rb_free(indio_dev->ring);
>> +}

Thanks for reviewing!

-Michael
