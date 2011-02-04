Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 4 Feb 2011 14:27:25 +0000
Subject: RE: [PATCH] IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324C1BA54D@LIMKCMBX1.ad.analog.com>
References: <1296744691-24320-1-git-send-email-michael.hennerich@analog.com>
 <4D4B1208.3080604@cam.ac.uk>
In-Reply-To: <4D4B1208.3080604@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
> On 02/03/11 14:51, michael.hennerich@analog.com wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>

[--snip--]

> > +
> > +What:              /sys/bus/iio/devices/deviceX/range_available
> > +KernelVersion:     2.6.38
> > +Contact:   linux-iio@vger.kernel.org
> > +Description:
> > +           Hardware dependent supported vales for ADC Full Scale
> Range.
> > +
> > +What:              /sys/bus/iio/devices/deviceX/oversampling
> > +KernelVersion:     2.6.38
> > +Contact:   linux-iio@vger.kernel.org
> > +Description:
> > +           Hardware dependent ADC oversamplimg.
> Typo.
> > Controls the sampling ratio
> > +           of the digital filter if available.
> What are the units?  The obvious choice is a multiplier, but could be
> frequency.
> Either way, needs to be specified here.

'Ratio' or 'rate' is the best you can use here.
http://mathworld.wolfram.com/Oversampling.html

> > +
> > +What:              /sys/bus/iio/devices/deviceX/oversampling_available
> > +KernelVersion:     2.6.38
> > +Contact:   linux-iio@vger.kernel.org
> > +Description:
> > +           Hardware dependent supported vales
> values (and should probably be Hardware dependent values supported by
> the
> oversampling filter.)
> > by the oversampling filter.
> > +
> >  What:              /sys/bus/iio/devices/deviceX/inY_raw
> >  What:              /sys/bus/iio/devices/deviceX/inY_supply_raw
> >  KernelVersion:     2.6.35
> > diff --git a/drivers/staging/iio/adc/Kconfig
> b/drivers/staging/iio/adc/Kconfig
> > index 86869cd..70767ff 100644
> > --- a/drivers/staging/iio/adc/Kconfig
> > +++ b/drivers/staging/iio/adc/Kconfig
> > @@ -62,6 +62,33 @@ config AD7314
> >       Say yes here to build support for Analog Devices AD7314
> >       temperature sensors.
> >
> > +config AD7606
> > +   tristate "Analog Devices AD7606 ADC driver"
> > +   select IIO_RING_BUFFER
> > +   select IIO_TRIGGER
> > +   select IIO_SW_RING
> Looks like a generic gpio dependency is need as well?

Will do

> > +   help
> > +     Say yes here to build support for Analog Devices:
> > +     ad7606, ad7606-6, ad7606-4 analog to digital convertors (ADC).
> > +
> > +     To compile this driver as a module, choose M here: the
> > +     module will be called ad7606.
> > +
> > +config AD7606_IFACE_PARALLEL
> > +   bool "parallel interface support"
> > +   depends on AD7606
> > +   help
> > +     Say yes here to include parallel interface support on the
> AD7606
> > +     ADC driver.
> > +
> > +config AD7606_IFACE_SPI
> > +   bool "spi interface support"
> > +   depends on AD7606
> > +   depends on SPI
> > +   help
> > +     Say yes here to include parallel interface support on the
> AD7606
> > +     ADC driver.
> > +
> >  config AD799X
> >     tristate "Analog Devices AD799x ADC driver"
> >     depends on I2C
> > diff --git a/drivers/staging/iio/adc/Makefile
> b/drivers/staging/iio/adc/Makefile
> > index 6f231a2..cb73346 100644
> > --- a/drivers/staging/iio/adc/Makefile
> > +++ b/drivers/staging/iio/adc/Makefile
> > @@ -7,6 +7,12 @@ max1363-y +=3D max1363_ring.o
> >
> >  obj-$(CONFIG_MAX1363) +=3D max1363.o
> >
> > +ad7606-y :=3D ad7606_core.o
> > +ad7606-$(CONFIG_IIO_RING_BUFFER) +=3D ad7606_ring.o
> > +ad7606-$(CONFIG_AD7606_IFACE_PARALLEL) +=3D ad7606_par.o
> > +ad7606-$(CONFIG_AD7606_IFACE_SPI) +=3D ad7606_spi.o
> > +obj-$(CONFIG_AD7606) +=3D ad7606.o
> > +
> >  ad799x-y :=3D ad799x_core.o
> >  ad799x-$(CONFIG_AD799X_RING_BUFFER) +=3D ad799x_ring.o
> >  obj-$(CONFIG_AD799X) +=3D ad799x.o
> > diff --git a/drivers/staging/iio/adc/ad7606.h
> b/drivers/staging/iio/adc/ad7606.h
> > new file mode 100644
> > index 0000000..99f21c5
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad7606.h
> > @@ -0,0 +1,119 @@
> > +/*
> > + * AD7606 ADC driver
> > + *
> > + * Copyright 2011 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2.
> > + */
> > +
> > +#ifndef IIO_ADC_AD7606_H_
> > +#define IIO_ADC_AD7606_H_
> > +
> Only one use. I'd put it inline.
> > +#define DRVNAME    "iio-ad7606"
> > +
> > +/*
> > + * TODO: struct ad7606_platform_data needs to go into
> include/linux/iio
> > + */
> > +
> > +/**
> > + * struct ad7606_platform_data - platform/board specifc information
> > + * @default_os:            default oversampling value {0, 2, 4, 8,
> 16, 32, 64}
> > + * @default_range: default range +/-{5, 10} Volt
> > + * @gpio_convst:   number of gpio connected to the CONVST pin
> > + * @gpio_reset:            gpio connected to the RESET pin, if not
> used set to -1
> > + * @gpio_range:            gpio connected to the RANGE pin, if not
> used set to -1
> > + * @gpio_os0:              gpio connected to the OS0 pin, if not used =
set
> to -1
> > + * @gpio_os1:              gpio connected to the OS1 pin, if not used =
set
> to -1
> > + * @gpio_os2:              gpio connected to the OS2 pin, if not used =
set
> to -1
> > + * @gpio_frstdata: gpio connected to the FRSTDAT pin, if not used
> set to -1
> > + * @gpio_stby:             gpio connected to the STBY pin, if not used=
 set
> to -1
> > + */
> > +
> > +struct ad7606_platform_data {
> > +   unsigned                        default_os;
> > +   unsigned                        default_range;
> > +   unsigned                        gpio_convst;
> > +   unsigned                        gpio_reset;
> > +   unsigned                        gpio_range;
> > +   unsigned                        gpio_os0;
> > +   unsigned                        gpio_os1;
> > +   unsigned                        gpio_os2;
> > +   unsigned                        gpio_frstdata;
> > +   unsigned                        gpio_stby;
> > +};
> > +
> > +/**
> > + * struct ad7606_chip_info - chip specifc information
> > + * @name:          indentification string for chip
> > + * @bits:          accuracy of the adc in bits
> > + * @bits:          output coding [s]igned or [u]nsigned
> > + * @int_vref_mv:   the internal reference voltage
> > + * @num_channels:  number of physical inputs on chip
> > + */
> > +
> > +struct ad7606_chip_info {
> > +   char                            name[10];
> > +   u8                              bits;
> > +   char                            sign;
> > +   u16                             int_vref_mv;
> > +   unsigned                        num_channels;
> > +};
> > +
> > +/**
> > + * struct ad7606_state - driver instance specific data
> > + */
> > +
> > +struct ad7606_state {
> > +   struct iio_dev                  *indio_dev;
> > +   struct device                   *dev;
> > +   const struct ad7606_chip_info   *chip_info;
> > +   struct ad7606_platform_data     *pdata;
> > +   struct regulator                *reg;
> > +   struct work_struct              poll_work;
> > +   wait_queue_head_t               wq_data_avail;
> > +   atomic_t                        protect_ring;
> > +   size_t                          d_size;
> > +   const struct ad7606_bus_ops     *bops;
> > +   int                             irq;
> > +   unsigned                        id;
> > +   unsigned                        range;
> > +   unsigned                        oversampling;
> > +   bool                            done;
> > +   bool                            have_frstdata;
> > +   bool                            have_os;
> > +   bool                            have_stby;
> > +   bool                            have_reset;
> > +   bool                            have_range;
> > +   void __iomem                    *base_address;
> > +
> > +   /*
> > +    * DMA (thus cache coherency maintenance) requires the
> > +    * transfer buffers to live in their own cache lines.
> > +    */
> > +
> > +   unsigned short                  data[8] ____cacheline_aligned;
> > +};
> > +
> > +struct ad7606_bus_ops {
> > +   /* more methods added in future? */
> > +   int (*read_block)(struct device *, int, void *);
> > +};
> > +
> > +void ad7606_suspend(struct ad7606_state *st);
> > +void ad7606_resume(struct ad7606_state *st);
> > +struct ad7606_state *ad7606_probe(struct device *dev, int irq,
> > +                         void __iomem *base_address, unsigned id,
> > +                         const struct ad7606_bus_ops *bops);
> > +int ad7606_remove(struct ad7606_state *st);
> > +int ad7606_reset(struct ad7606_state *st);
> > +
> > +enum ad7606_supported_device_ids {
> > +   ID_AD7606_8,
> > +   ID_AD7606_6,
> > +   ID_AD7606_4
> > +};
> > +
> > +int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch);
> > +int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev);
> > +void ad7606_ring_cleanup(struct iio_dev *indio_dev);
> > +#endif /* IIO_ADC_AD7606_H_ */
> > diff --git a/drivers/staging/iio/adc/ad7606_core.c
> b/drivers/staging/iio/adc/ad7606_core.c
> > new file mode 100644
> > index 0000000..21e5af8
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad7606_core.c
> > @@ -0,0 +1,560 @@
> > +/*
> > + * AD7606 SPI ADC driver
> > + *
> > + * Copyright 2011 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/list.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/err.h>
> > +#include <linux/gpio.h>
> > +#include <linux/delay.h>
> > +
> > +#include "../iio.h"
> > +#include "../sysfs.h"
> > +#include "../ring_generic.h"
> > +#include "adc.h"
> > +
> > +#include "ad7606.h"
> > +
> > +int ad7606_reset(struct ad7606_state *st)
> > +{
> > +   if (st->have_reset) {
> > +           gpio_set_value(st->pdata->gpio_reset, 1);
> > +           ndelay(100); /* t_reset >=3D 100ns */
> could it be a sleep?

Only 100ns are required!
Why would I go to sleep?


> > +           gpio_set_value(st->pdata->gpio_reset, 0);
> > +           return 0;
> > +   }
> > +
> > +   return -ENODEV;
> > +}
> > +
> > +static int ad7606_scan_direct(struct ad7606_state *st, unsigned ch)
> > +{
> > +   int ret;
> > +
> > +   gpio_set_value(st->pdata->gpio_convst, 1);
> > +   st->done =3D false;
> > +
> > +   ret =3D wait_event_interruptible(st->wq_data_avail, st->done);
> > +   if (ret)
> > +           goto error_ret;
> > +
> > +   if (st->have_frstdata) {
> > +           st->bops->read_block(st->dev, 1, st->data);
> > +           if (!gpio_get_value(st->pdata->gpio_frstdata)) {
> > +                   /* This should never happen */
>                       As below.... does it and if so why?

In case it happens we're out of sync.

Most people won't use FRSTDATA checks at all.

However some signal glitch caused perhaps by some electrostatic
discharge, could cause an extra read or clock.
This allows recovery.

> > +                   ad7606_reset(st);
> > +                   ret =3D -EIO;
> > +                   goto error_ret;
> > +           }
> > +           st->bops->read_block(st->dev,
> > +                   st->chip_info->num_channels - 1, &st->data[1]);
> > +   } else {
> > +           st->bops->read_block(st->dev,
> > +                   st->chip_info->num_channels, st->data);
> > +   }
> > +
> > +   ret =3D st->data[ch];
> > +
> > +error_ret:
> > +   gpio_set_value(st->pdata->gpio_convst, 0);
> > +
> > +   return ret;
> > +}
> > +
> > +static ssize_t ad7606_scan(struct device *dev,
> > +                       struct device_attribute *attr,
> > +                       char *buf)
> > +{
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D dev_info->dev_data;
> > +   struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> > +   int ret;
> > +
> > +   mutex_lock(&dev_info->mlock);
> > +   if (iio_ring_enabled(dev_info))
> > +           ret =3D ad7606_scan_from_ring(st, this_attr->address);
> > +   else
> > +           ret =3D ad7606_scan_direct(st, this_attr->address);
> > +   mutex_unlock(&dev_info->mlock);
> > +
> > +   if (ret < 0)
> > +           return ret;
> > +
> > +   return sprintf(buf, "%d\n", (short) ret);
> > +}
> > +
> > +static IIO_DEV_ATTR_IN_RAW(0, ad7606_scan, 0);
> > +static IIO_DEV_ATTR_IN_RAW(1, ad7606_scan, 1);
> > +static IIO_DEV_ATTR_IN_RAW(2, ad7606_scan, 2);
> > +static IIO_DEV_ATTR_IN_RAW(3, ad7606_scan, 3);
> > +static IIO_DEV_ATTR_IN_RAW(4, ad7606_scan, 4);
> > +static IIO_DEV_ATTR_IN_RAW(5, ad7606_scan, 5);
> > +static IIO_DEV_ATTR_IN_RAW(6, ad7606_scan, 6);
> > +static IIO_DEV_ATTR_IN_RAW(7, ad7606_scan, 7);
> > +
> > +static ssize_t ad7606_show_scale(struct device *dev,
> > +                           struct device_attribute *attr,
> > +                           char *buf)
> > +{
> > +   /* Driver currently only support internal vref */
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D iio_dev_get_devdata(dev_info);
> > +   unsigned int scale_uv =3D (st->range * 1000000) >> st->chip_info-
> >bits;
> > +
> > +   return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv %
> 1000);
> > +}
> > +static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7606_show_scale, NULL,
> 0);
> > +
> > +static ssize_t ad7606_show_name(struct device *dev,
> > +                            struct device_attribute *attr,
> > +                            char *buf)
> > +{
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +   return sprintf(buf, "%s\n", st->chip_info->name);
> > +}
> > +
> > +static IIO_DEVICE_ATTR(name, S_IRUGO, ad7606_show_name, NULL, 0);
> > +
> > +static ssize_t ad7606_show_range(struct device *dev,
> > +                   struct device_attribute *attr, char *buf)
> > +{
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +   return sprintf(buf, "%u\n", st->range);
> > +}
> > +
> > +static ssize_t ad7606_store_range(struct device *dev,
> > +           struct device_attribute *attr, const char *buf, size_t
> count)
> > +{
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D iio_dev_get_devdata(dev_info);
> > +   unsigned long lval;
> > +
> These are voltage values, so should be in millivolts? (as
> we lift the nearest interface from hwmon)
> > +   if (strict_strtoul(buf, 10, &lval))
> > +           return -EINVAL;
> > +   if (!(lval =3D=3D 5 || lval =3D=3D 10)) {
> > +           dev_err(dev, "range is not supported\n");
> > +           return -EINVAL;
> > +   }
> > +   mutex_lock(&dev_info->mlock);
> > +   gpio_set_value(st->pdata->gpio_range, lval =3D=3D 10);
> > +   st->range =3D lval;
> > +   mutex_unlock(&dev_info->mlock);
> > +
> > +   return count;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(range, S_IRUGO | S_IWUSR, \
> > +                  ad7606_show_range, ad7606_store_range, 0);
> > +static IIO_CONST_ATTR(range_available, "5 10");
> > +
> > +static ssize_t ad7606_show_oversampling(struct device *dev,
> > +                   struct device_attribute *attr, char *buf)
> > +{
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +   return sprintf(buf, "%u\n", st->oversampling);
> > +}
> > +
> Name is a little missleading. It is actually finding the index and name
> should reflect that.

ok

> > +static int ad7606_check_oversampling(unsigned val)
> > +{
> > +   unsigned char supported[] =3D {0, 2, 4, 8, 16, 32, 64};
> > +   int i;
> > +
> > +   for (i =3D 0; i < ARRAY_SIZE(supported); i++)
> > +           if (val =3D=3D supported[i])
> > +                   return i;
> > +
> > +   return -EINVAL;
> > +}
> > +
> > +static ssize_t ad7606_store_oversampling(struct device *dev,
> > +           struct device_attribute *attr, const char *buf, size_t
> count)
> > +{
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D iio_dev_get_devdata(dev_info);
> > +   unsigned long lval;
> > +   int ret;
> > +
> > +   if (strict_strtoul(buf, 10, &lval))
> > +           return -EINVAL;
> > +
> > +   ret =3D ad7606_check_oversampling(lval);
> > +   if (ret < 0) {
> > +           dev_err(dev, "oversampling %lu is not supported\n", lval);
> > +           return ret;
> > +   }
> > +
> > +   mutex_lock(&dev_info->mlock);
> > +   gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
> > +   gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
> > +   gpio_set_value(st->pdata->gpio_os1, (ret >> 2) & 1);
> > +   st->oversampling =3D lval;
> > +   mutex_unlock(&dev_info->mlock);
> > +
> > +   return count;
> > +}
> > +
> > +static IIO_DEVICE_ATTR(oversampling, S_IRUGO | S_IWUSR, \
> Need the '\' ?

No

> > +                  ad7606_show_oversampling, ad7606_store_oversampling,
> 0);
> > +static IIO_CONST_ATTR(oversampling_available, "0 2 4 8 16 32 64");
> > +
> > +static struct attribute *ad7606_attributes[] =3D {
> > +   &iio_dev_attr_in0_raw.dev_attr.attr,
> > +   &iio_dev_attr_in1_raw.dev_attr.attr,
> > +   &iio_dev_attr_in2_raw.dev_attr.attr,
> > +   &iio_dev_attr_in3_raw.dev_attr.attr,
> > +   &iio_dev_attr_in4_raw.dev_attr.attr,
> > +   &iio_dev_attr_in5_raw.dev_attr.attr,
> > +   &iio_dev_attr_in6_raw.dev_attr.attr,
> > +   &iio_dev_attr_in7_raw.dev_attr.attr,
> > +   &iio_dev_attr_in_scale.dev_attr.attr,
> > +   &iio_dev_attr_name.dev_attr.attr,
> > +   &iio_dev_attr_range.dev_attr.attr,
> > +   &iio_const_attr_range_available.dev_attr.attr,
> > +   &iio_dev_attr_oversampling.dev_attr.attr,
> > +   &iio_const_attr_oversampling_available.dev_attr.attr,
> > +   NULL,
> > +};
> > +
> > +static mode_t ad7606_attr_is_visible(struct kobject *kobj,
> > +                                struct attribute *attr, int n)
> > +{
> > +   struct device *dev =3D container_of(kobj, struct device, kobj);
> > +   struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +   struct ad7606_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +   mode_t mode =3D attr->mode;
> > +
> As with the other is_visible function, I'd rather see this use the
> chip_info->num_channels element instead of the ids. Makes it very
> obvious what is happening.
>
> Then becomes
>
> if (st->chip_info->num_channels < 6 &
>     (attr =3D=3D &iio_dev_attr_in7_raw.dev_attr.attr ||
>      attr =3D=3D &iio_dev_attr_in6_raw.dev_attr.attr)
>      mode =3D 0;
> if (st->chip_info->num_channels < 4 &
>     (attr =3D=3D &iio_dev_attr_in5_raw.dev_attr.attr ||
>      attr =3D=3D &iio_dev_attr_in4_raw.dev_attr.attr)
>      mode =3D 0;
>
> (other the same - though I'd reorder so first thing one
> sees is the cause, then the attributes. More readable in
> my opinion).
>
> Probably not worth optimizing the order in this function.

ok

>
> > +   if ((attr =3D=3D &iio_dev_attr_in7_raw.dev_attr.attr) &&
> > +           ((st->id =3D=3D ID_AD7606_6) || (st->id =3D=3D ID_AD7606_4)=
))
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_dev_attr_in6_raw.dev_attr.attr) &&
> > +           ((st->id =3D=3D ID_AD7606_6) || (st->id =3D=3D ID_AD7606_4)=
))
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_dev_attr_in5_raw.dev_attr.attr) &&
> > +           (st->id =3D=3D ID_AD7606_4))
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_dev_attr_in4_raw.dev_attr.attr) &&
> > +           (st->id =3D=3D ID_AD7606_4))
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_dev_attr_oversampling.dev_attr.attr ||
> > +           attr =3D=3D
> &iio_const_attr_oversampling_available.dev_attr.attr) &&
> > +           !st->have_os)
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_dev_attr_range.dev_attr.attr ||
> > +           attr =3D=3D &iio_const_attr_range_available.dev_attr.attr) =
&&
> > +           !st->have_range)
> > +                   mode =3D 0;
> > +
> > +   return mode;
> > +}
> > +
> > +static const struct attribute_group ad7606_attribute_group =3D {
> > +   .attrs =3D ad7606_attributes,
> > +   .is_visible =3D ad7606_attr_is_visible,
> > +};
> > +
> > +static const struct ad7606_chip_info ad7606_chip_info_tbl[] =3D {
> > +   /*
> > +    * More devices added in future
> Good. Otherwise I'd moan about the fact that these are nearly
> identical and you could hard code most of them into the driver.
>
> > +    */
> > +   [ID_AD7606_8] =3D {
> > +           .name =3D "ad7606",
> > +           .bits =3D 16,
> > +           .sign =3D IIO_SCAN_EL_TYPE_SIGNED,
> > +           .int_vref_mv =3D 2500,
> > +           .num_channels =3D 8,
> > +   },
> > +   [ID_AD7606_6] =3D {
> > +           .name =3D "ad7606-6",
> > +           .bits =3D 16,
> > +           .sign =3D IIO_SCAN_EL_TYPE_SIGNED,
> > +           .int_vref_mv =3D 2500,
> > +           .num_channels =3D 6,
> > +   },
> > +   [ID_AD7606_4] =3D {
> > +           .name =3D "ad7606-4",
> > +           .bits =3D 16,
> > +           .sign =3D IIO_SCAN_EL_TYPE_SIGNED,
> > +           .int_vref_mv =3D 2500,
> > +           .num_channels =3D 4,
> > +   },
> > +};
> > +
> > +static int ad7606_request_gpio_out(struct ad7606_state *st,
> > +                              unsigned gpio, unsigned val)
> > +{
> > +   int ret =3D -EINVAL;
> > +
> > +   if (gpio_is_valid(gpio)) {
> > +           ret =3D gpio_request(gpio, st->chip_info->name);
> > +           if (!ret)
> > +                   gpio_direction_output(gpio, val);
> > +   }
> > +   return ret;
> > +}
> > +
> > +static int ad7606_request_gpios(struct ad7606_state *st)
> > +{
> > +   int ret;
> > +
> > +   ret =3D ad7606_request_gpio_out(st, st->pdata->gpio_convst, 0);
> > +   if (ret) {
> > +           dev_err(st->dev, "failed to request GPIO CONVST\n");
> > +           return ret;
> > +   }
> > +
> > +   ret =3D ad7606_request_gpio_out(st, st->pdata->gpio_os0,
> > +           (st->oversampling >> 0) & 1);
> > +   if (ret < 0) {
> > +           st->have_os =3D false;
> > +   } else {
> > +           ret =3D ad7606_request_gpio_out(st, st->pdata->gpio_os1,
> > +                   (st->oversampling >> 1) & 1);
> st->oversampling & 2 ?

ok

> > +           if (ret < 0) {
> > +                   gpio_free(st->pdata->gpio_os0);
> > +                   st->have_os =3D false;
> > +           } else {
> > +                   ret =3D ad7606_request_gpio_out(st, st->pdata-
> >gpio_os2,
> > +                           (st->oversampling >> 2) & 1);
> st->oversampling & 4 or st->oversampling & (1 << 2) if you want to make
> it explicity.
> Compiler will neatly clean that up into a constant whereas it may not
> this way around.
> > +                   if (ret < 0) {
> > +                           gpio_free(st->pdata->gpio_os0);
> > +                           gpio_free(st->pdata->gpio_os1);
> > +                           st->have_os =3D false;
> > +                   } else {
> > +                           st->have_os =3D true;
> > +                   }
> > +           }
> > +   }
> > +
> > +   ret =3D ad7606_request_gpio_out(st, st->pdata->gpio_reset, 0);
> > +   if (!ret)
> > +           st->have_reset =3D true;
> > +
> > +   ret =3D ad7606_request_gpio_out(st, st->pdata->gpio_range,
> > +           st->range =3D=3D 10);
> > +   if (!ret)
> > +           st->have_range =3D true;
> > +
> > +   ret =3D ad7606_request_gpio_out(st, st->pdata->gpio_stby, 1);
> > +   if (!ret)
> > +           st->have_stby =3D true;
> > +
> > +   if (gpio_is_valid(st->pdata->gpio_frstdata)) {
> > +           ret =3D gpio_request(st->pdata->gpio_frstdata,
> > +                   st->chip_info->name);
> Looks like you register a number of gpio's with the same name. Would be
> nice to be a little more specific on what they are...
ok

> > +           if (!ret) {
> > +                   gpio_direction_input(st->pdata->gpio_frstdata);
> > +                   st->have_frstdata =3D true;
> > +           }
> > +   }
> > +
> > +   return 0;
> > +}
> > +
> > +static void ad7606_free_gpios(struct ad7606_state *st)
> > +{
> > +   if (st->have_range)
> > +           gpio_free(st->pdata->gpio_range);
> > +
> > +   if (st->have_stby)
> > +           gpio_free(st->pdata->gpio_stby);
> > +
> > +   if (st->have_os) {
> > +           gpio_free(st->pdata->gpio_os0);
> > +           gpio_free(st->pdata->gpio_os1);
> > +           gpio_free(st->pdata->gpio_os2);
> > +   }
> > +
> > +   if (st->have_reset)
> > +           gpio_free(st->pdata->gpio_reset);
> > +
> > +   if (st->have_frstdata)
> > +           gpio_free(st->pdata->gpio_frstdata);
> > +
> > +   gpio_free(st->pdata->gpio_convst);
> > +}
> > +
> > +/**
> > + *  Interrupt handler
> > + */
> > +static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
> > +{
> > +   struct ad7606_state *st =3D dev_id;
> > +
> > +   if (iio_ring_enabled(st->indio_dev)) {
> > +           if (!work_pending(&st->poll_work))
> > +                   schedule_work(&st->poll_work);
> > +   } else {
> > +           st->done =3D true;
> > +           wake_up_interruptible(&st->wq_data_avail);
> > +   }
> > +
> > +   return IRQ_HANDLED;
> > +};
> > +
> > +struct ad7606_state *ad7606_probe(struct device *dev, int irq,
> > +                         void __iomem *base_address,
> > +                         unsigned id,
> > +                         const struct ad7606_bus_ops *bops)
> > +{
> > +   struct ad7606_platform_data *pdata =3D dev->platform_data;
> > +   struct ad7606_state *st;
> > +   int ret;
> > +
> > +   st =3D kzalloc(sizeof(*st), GFP_KERNEL);
> > +   if (st =3D=3D NULL) {
> > +           ret =3D -ENOMEM;
> > +           goto error_ret;
> > +   }
> > +
> > +   st->dev =3D dev;
> > +   st->id =3D id;
> > +   st->irq =3D irq;
> > +   st->bops =3D bops;
> > +   st->base_address =3D base_address;
> > +   st->range =3D pdata->default_range =3D=3D 10 ? 10 : 5;
> > +
> > +   ret =3D ad7606_check_oversampling(pdata->default_os);
> > +   if (ret < 0) {
> > +           dev_warn(dev, "oversampling %d is not supported\n",
> > +                    pdata->default_os);
> > +           st->oversampling =3D 0;
> > +   } else {
> > +           st->oversampling =3D pdata->default_os;
> > +   }
> > +
> > +   st->reg =3D regulator_get(dev, "vcc");
> > +   if (!IS_ERR(st->reg)) {
> > +           ret =3D regulator_enable(st->reg);
> > +           if (ret)
> > +                   goto error_put_reg;
> > +   }
> > +
> > +   st->pdata =3D pdata;
> > +   st->chip_info =3D &ad7606_chip_info_tbl[id];
> > +
> > +   atomic_set(&st->protect_ring, 0);
> > +
> > +   st->indio_dev =3D iio_allocate_device();
> > +   if (st->indio_dev =3D=3D NULL) {
> > +           ret =3D -ENOMEM;
> > +           goto error_disable_reg;
> > +   }
> > +
> > +   st->indio_dev->dev.parent =3D dev;
> > +   st->indio_dev->attrs =3D &ad7606_attribute_group;
> > +   st->indio_dev->dev_data =3D (void *)(st);
> > +   st->indio_dev->driver_module =3D THIS_MODULE;
> > +   st->indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +   init_waitqueue_head(&st->wq_data_avail);
> > +
> > +   ret =3D ad7606_request_gpios(st);
> > +   if (ret)
> > +           goto error_free_device;
> > +
> > +   ret =3D ad7606_reset(st);
> > +   if (ret)
> > +           dev_warn(st->dev, "failed to RESET: no RESET GPIO
> specified\n");
> > +
> > +   ret =3D request_irq(st->irq, ad7606_interrupt,
> > +           IRQF_TRIGGER_FALLING, st->chip_info->name, st);
> > +   if (ret)
> > +           goto error_free_gpios;
> > +
> > +   ret =3D ad7606_register_ring_funcs_and_init(st->indio_dev);
> > +   if (ret)
> > +           goto error_free_irq;
> > +
> > +   ret =3D iio_device_register(st->indio_dev);
> > +   if (ret)
> > +           goto error_free_irq;
> > +
> > +   ret =3D iio_ring_buffer_register(st->indio_dev->ring, 0);
> > +   if (ret)
> > +           goto error_cleanup_ring;
> > +
> > +   return st;
> > +
> > +error_cleanup_ring:
> > +   ad7606_ring_cleanup(st->indio_dev);
> > +   iio_device_unregister(st->indio_dev);
> > +
> > +error_free_irq:
> > +   free_irq(st->irq, st);
> > +
> > +error_free_gpios:
> > +   ad7606_free_gpios(st);
> > +
> > +error_free_device:
> > +   iio_free_device(st->indio_dev);
> > +
> > +error_disable_reg:
> > +   if (!IS_ERR(st->reg))
> > +           regulator_disable(st->reg);
> > +error_put_reg:
> > +   if (!IS_ERR(st->reg))
> > +           regulator_put(st->reg);
> > +   kfree(st);
> > +error_ret:
> > +   return ERR_PTR(ret);
> > +}
> > +
> > +int ad7606_remove(struct ad7606_state *st)
> > +{
> > +   struct iio_dev *indio_dev =3D st->indio_dev;
> > +   iio_ring_buffer_unregister(indio_dev->ring);
> > +   ad7606_ring_cleanup(indio_dev);
> > +   iio_device_unregister(indio_dev);
> > +   free_irq(st->irq, st);
> > +   if (!IS_ERR(st->reg)) {
> > +           regulator_disable(st->reg);
> > +           regulator_put(st->reg);
> > +   }
> > +
> > +   ad7606_free_gpios(st);
> > +
> > +   kfree(st);
> > +   return 0;
> > +}
> > +
> > +void ad7606_suspend(struct ad7606_state *st)
> > +{
> > +   if (st->have_stby) {
> > +           if (st->have_range)
> > +                   gpio_set_value(st->pdata->gpio_range, 1);
> > +           gpio_set_value(st->pdata->gpio_stby, 0);
> > +
> Bonus white line (I'm getting fussy).
> > +   }
> > +}
> > +
> > +void ad7606_resume(struct ad7606_state *st)
> > +{
> > +   if (st->have_stby) {
> > +           if (st->have_range)
> > +                   gpio_set_value(st->pdata->gpio_range, st->range =3D=
=3D
> 10);
> > +
> > +           gpio_set_value(st->pdata->gpio_stby, 1);
> > +           ad7606_reset(st);
> > +   }
> > +}
> > +
> > +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> > +MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/staging/iio/adc/ad7606_par.c
> b/drivers/staging/iio/adc/ad7606_par.c
> > new file mode 100644
> > index 0000000..d787c06
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad7606_par.c
> > @@ -0,0 +1,191 @@
> > +/*
> > + * AD7606 Parallel Interface ADC driver
> > + *
> > + * Copyright 2011 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/types.h>
> > +#include <linux/err.h>
> > +#include <linux/io.h>
> > +
> > +#include "ad7606.h"
> > +
> > +static int ad7606_par16_read_block(struct device *dev,
> > +                            int count, void *buf)
> > +{
> > +   struct platform_device *pdev =3D to_platform_device(dev);
> > +   struct ad7606_state *st =3D platform_get_drvdata(pdev);
> > +
> > +   insw((unsigned long) st->base_address, buf, count);
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct ad7606_bus_ops ad7606_par16_bops =3D {
> > +   .read_block     =3D ad7606_par16_read_block,
> > +};
> > +
> > +static int ad7606_par8_read_block(struct device *dev,
> > +                            int count, void *buf)
> > +{
> > +   struct platform_device *pdev =3D to_platform_device(dev);
> > +   struct ad7606_state *st =3D platform_get_drvdata(pdev);
> > +
> > +   insb((unsigned long) st->base_address, buf, count * 2);
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct ad7606_bus_ops ad7606_par8_bops =3D {
> > +   .read_block     =3D ad7606_par8_read_block,
> > +};
> > +
> > +static int __devinit ad7606_par_probe(struct platform_device *pdev)
> > +{
> > +   struct resource *res;
> > +   struct ad7606_state *st;
> > +   void __iomem *addr;
> > +   resource_size_t remap_size;
> > +   int ret, irq;
> > +
> > +   irq =3D platform_get_irq(pdev, 0);
> > +   if (irq < 0) {
> > +           dev_err(&pdev->dev, "no irq\n");
> > +           return -ENODEV;
> > +   }
> > +
> > +   res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +   if (!res)
> > +           return -ENODEV;
> > +
> > +   remap_size =3D resource_size(res);
> > +
> Nitpick.  I think this the only time you use this particular syntax
> for comments. Please stick to /* ... */ on one line.
> > +   /*
> > +    * Request the regions.
> > +    */
> > +   if (!request_mem_region(res->start, remap_size, DRVNAME)) {
> > +           ret =3D -EBUSY;
> > +           goto out1;
> > +   }
> > +   addr =3D ioremap(res->start, remap_size);
> > +   if (!addr) {
> > +           ret =3D -ENOMEM;
> > +           goto out1;
> > +   }
> > +
> > +   st =3D ad7606_probe(&pdev->dev, irq, addr,
> > +                     platform_get_device_id(pdev)->driver_data,
> > +                     remap_size > 1 ? &ad7606_par16_bops :
> > +                     &ad7606_par8_bops);
> > +
> > +   if (IS_ERR(st))  {
> > +           ret =3D PTR_ERR(st);
> > +           goto out2;
> > +   }
> > +
> > +   platform_set_drvdata(pdev, st);
> > +
> > +   return 0;
> > +
> > +out2:
> > +   iounmap(addr);
> > +out1:
> > +   release_mem_region(res->start, remap_size);
> > +
> > +   return ret;
> > +}
> > +
> > +static int __devexit ad7606_par_remove(struct platform_device *pdev)
> > +{
> > +   struct ad7606_state *st =3D platform_get_drvdata(pdev);
> > +   struct resource *res;
> > +
> > +   ad7606_remove(st);
> > +
> > +   iounmap(st->base_address);
> > +   res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +   release_mem_region(res->start, resource_size(res));
> > +
> > +   platform_set_drvdata(pdev, NULL);
> > +
> > +   return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int ad7606_par_suspend(struct device *dev)
> > +{
> > +   struct ad7606_state *st =3D dev_get_drvdata(dev);
> > +
> > +   ad7606_suspend(st);
> > +
> > +   return 0;
> > +}
> > +
> > +static int ad7606_par_resume(struct device *dev)
> > +{
> > +   struct ad7606_state *st =3D dev_get_drvdata(dev);
> > +
> > +   ad7606_resume(st);
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct dev_pm_ops ad7606_pm_ops =3D {
> > +   .suspend =3D ad7606_par_suspend,
> > +   .resume  =3D ad7606_par_resume,
> > +};
> > +#define AD7606_PAR_PM_OPS (&ad7606_pm_ops)
> > +
> > +#else
> > +#define AD7606_PAR_PM_OPS NULL
> > +#endif  /* CONFIG_PM */
> > +
> Nitpick, Bonus empty line.
> > +
> > +static struct platform_device_id ad7606_driver_ids[] =3D {
> > +   {
> > +           .name           =3D "ad7606-8",
> > +           .driver_data    =3D ID_AD7606_8,
> > +   }, {
> > +           .name           =3D "ad7606-6",
> > +           .driver_data    =3D ID_AD7606_6,
> > +   }, {
> > +           .name           =3D "ad7606-4",
> > +           .driver_data    =3D ID_AD7606_4,
> > +   },
> > +   { }
> > +};
> > +
> > +MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
> > +
> > +static struct platform_driver ad7606_driver =3D {
> > +   .probe =3D ad7606_par_probe,
> > +   .remove =3D __devexit_p(ad7606_par_remove),
> > +   .id_table =3D ad7606_driver_ids,
> > +   .driver =3D {
> > +           .name    =3D "ad7606",
> > +           .owner  =3D THIS_MODULE,
> > +           .pm    =3D AD7606_PAR_PM_OPS,
> > +   },
> > +};
> > +
> > +static int __init ad7606_init(void)
> > +{
> > +   return platform_driver_register(&ad7606_driver);
> > +}
> > +
> > +static void __exit ad7606_cleanup(void)
> > +{
> > +   platform_driver_unregister(&ad7606_driver);
> > +}
> > +
> > +module_init(ad7606_init);
> > +module_exit(ad7606_cleanup);
> > +
> > +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> > +MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("platform:ad7606-par");
> > diff --git a/drivers/staging/iio/adc/ad7606_ring.c
> b/drivers/staging/iio/adc/ad7606_ring.c
> > new file mode 100644
> > index 0000000..ab06503
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad7606_ring.c
> > @@ -0,0 +1,261 @@
> > +/*
> > + * Copyright 2011 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2.
> > + *
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/gpio.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
>
> Do we need this?
> > +#include <linux/list.h>
> > +
> > +#include "../iio.h"
> > +#include "../ring_generic.h"
> > +#include "../ring_sw.h"
> > +#include "../trigger.h"
> > +#include "../sysfs.h"
> > +
> > +#include "ad7606.h"
> > +
> > +static IIO_SCAN_EL_C(in0, 0, 0, NULL);
> > +static IIO_SCAN_EL_C(in1, 1, 0, NULL);
> > +static IIO_SCAN_EL_C(in2, 2, 0, NULL);
> > +static IIO_SCAN_EL_C(in3, 3, 0, NULL);
> > +static IIO_SCAN_EL_C(in4, 4, 0, NULL);
> > +static IIO_SCAN_EL_C(in5, 5, 0, NULL);
> > +static IIO_SCAN_EL_C(in6, 6, 0, NULL);
> > +static IIO_SCAN_EL_C(in7, 7, 0, NULL);
> > +
> > +static ssize_t ad7606_show_type(struct device *dev,
> > +                           struct device_attribute *attr,
> > +                           char *buf)
> > +{
> > +   struct iio_ring_buffer *ring =3D dev_get_drvdata(dev);
> > +   struct iio_dev *indio_dev =3D ring->indio_dev;
> > +   struct ad7606_state *st =3D indio_dev->dev_data;
> > +
> > +   return sprintf(buf, "%c%d/%d\n", st->chip_info->sign,
> > +                  st->chip_info->bits, st->chip_info->bits);
> > +}
> > +static IIO_DEVICE_ATTR(in_type, S_IRUGO, ad7606_show_type, NULL, 0);
> > +
> > +static struct attribute *ad7606_scan_el_attrs[] =3D {
> > +   &iio_scan_el_in0.dev_attr.attr,
> > +   &iio_const_attr_in0_index.dev_attr.attr,
> > +   &iio_scan_el_in1.dev_attr.attr,
> > +   &iio_const_attr_in1_index.dev_attr.attr,
> > +   &iio_scan_el_in2.dev_attr.attr,
> > +   &iio_const_attr_in2_index.dev_attr.attr,
> > +   &iio_scan_el_in3.dev_attr.attr,
> > +   &iio_const_attr_in3_index.dev_attr.attr,
> > +   &iio_scan_el_in4.dev_attr.attr,
> > +   &iio_const_attr_in4_index.dev_attr.attr,
> > +   &iio_scan_el_in5.dev_attr.attr,
> > +   &iio_const_attr_in5_index.dev_attr.attr,
> > +   &iio_scan_el_in6.dev_attr.attr,
> > +   &iio_const_attr_in6_index.dev_attr.attr,
> > +   &iio_scan_el_in7.dev_attr.attr,
> > +   &iio_const_attr_in7_index.dev_attr.attr,
> > +   &iio_dev_attr_in_type.dev_attr.attr,
> > +   NULL,
> > +};
> > +
> > +static mode_t ad7606_scan_el_attr_is_visible(struct kobject *kobj,
> > +                                struct attribute *attr, int n)
> > +{
> > +   struct device *dev =3D container_of(kobj, struct device, kobj);
> > +   struct iio_ring_buffer *ring =3D dev_get_drvdata(dev);
> > +   struct iio_dev *indio_dev =3D ring->indio_dev;
> > +   struct ad7606_state *st =3D indio_dev->dev_data;
> > +
> > +   mode_t mode =3D attr->mode;
> > +
> Ouch.  I think this works out as the same, perhaps simpler to read?
>
> if ((st->id =3D=3D ID_AD7606_6) || (st->id =3D=3D ID_AD7606_4) &&
>     attr =3D=3D &iio_scan_el_in7.dev_attr.attr ||
>     attr =3D=3D &iio_const_attr_in7_index.dev_attr.attr ||
>     attr =3D=3D &iio_scan_el_in6.dev_attr.attr ||
>     attr =3D=3D &iio_const_attr_in6_index.dev_attr.attr)
>       mode =3D 0;
> if (st->id =3D=3D ID_AD7606_4 &&
>     (attr =3D=3D &iio_scan_el_in4.dev_attr.attr ||
>      attr =3D=3D &iio_const_attr_in4_index.dev_attr.attr ||
>      attr =3D=3D &iio_scan_el_in5.dev_attr.attr ||
>      attr =3D=3D &iio_const_attr_in5_index.dev_attr.attr))
>       mode =3D 0;
>
> Or could use st->id !=3D ID_AD7606_8 for first condition.
>
> Actually I'd personally the tests to be on the chip_info->num_channels
> as then is more obvious what is going on.
>
> > +   if ((attr =3D=3D &iio_scan_el_in7.dev_attr.attr ||
> > +           attr =3D=3D &iio_const_attr_in7_index.dev_attr.attr) &&
> > +           ((st->id =3D=3D ID_AD7606_6) || (st->id =3D=3D ID_AD7606_4)=
))
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_scan_el_in6.dev_attr.attr ||
> > +           attr =3D=3D &iio_const_attr_in6_index.dev_attr.attr) &&
> > +           ((st->id =3D=3D ID_AD7606_6) || (st->id =3D=3D ID_AD7606_4)=
))
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_scan_el_in5.dev_attr.attr ||
> > +           attr =3D=3D &iio_const_attr_in5_index.dev_attr.attr) &&
> > +           (st->id =3D=3D ID_AD7606_4))
> > +                   mode =3D 0;
> > +   else if ((attr =3D=3D &iio_scan_el_in4.dev_attr.attr ||
> > +           attr =3D=3D &iio_const_attr_in4_index.dev_attr.attr) &&
> > +           (st->id =3D=3D ID_AD7606_4))
> > +                   mode =3D 0;
> > +
> > +   return mode;
> > +}
> > +
> > +static struct attribute_group ad7606_scan_el_group =3D {
> > +   .name =3D "scan_elements",
> > +   .attrs =3D ad7606_scan_el_attrs,
> > +   .is_visible =3D ad7606_scan_el_attr_is_visible,
> > +};
> > +
> > +int ad7606_scan_from_ring(struct ad7606_state *st, unsigned ch)
> > +{
> > +   struct iio_ring_buffer *ring =3D st->indio_dev->ring;
> > +   int ret;
> > +   u16 *ring_data;
> > +
> > +   ring_data =3D kmalloc(ring->access.get_bytes_per_datum(ring),
> GFP_KERNEL);
> > +   if (ring_data =3D=3D NULL) {
> > +           ret =3D -ENOMEM;
> > +           goto error_ret;
> > +   }
> > +   ret =3D ring->access.read_last(ring, (u8 *) ring_data);
> > +   if (ret)
> > +           goto error_free_ring_data;
> > +
> > +   ret =3D ring_data[ch];
> > +
> > +error_free_ring_data:
> > +   kfree(ring_data);
> > +error_ret:
> > +   return ret;
> > +}
> > +
> > +/**
> > + * ad7606_ring_preenable() setup the parameters of the ring before
> enabling
> > + *
> > + * The complex nature of the setting of the nuber of bytes per datum
> is due
> > + * to this driver currently ensuring that the timestamp is stored at
> an 8
> > + * byte boundary.
> > + **/
> > +static int ad7606_ring_preenable(struct iio_dev *indio_dev)
> > +{
> > +   struct ad7606_state *st =3D indio_dev->dev_data;
> > +   struct iio_ring_buffer *ring =3D indio_dev->ring;
> > +   size_t d_size;
> > +
> > +   d_size =3D st->chip_info->num_channels *
> > +            st->chip_info->bits / 8 + sizeof(s64);
> > +
> > +   if (d_size % sizeof(s64))
> > +           d_size +=3D sizeof(s64) - (d_size % sizeof(s64));
> > +
> > +   if (ring->access.set_bytes_per_datum)
> > +           ring->access.set_bytes_per_datum(ring, d_size);
> > +
> > +   st->d_size =3D d_size;
> > +
> > +   return 0;
> > +}
> > +
> > +/**
> > + * ad7606_poll_func_th() th of trigger launched polling to ring
> buffer
> > + *
> > + **/
> > +static void ad7606_poll_func_th(struct iio_dev *indio_dev, s64 time)
> > +{
> > +   struct ad7606_state *st =3D indio_dev->dev_data;
> > +   gpio_set_value(st->pdata->gpio_convst, 1);
> > +
> > +   return;
> > +}
> > +/**
> > + * ad7606_poll_bh_to_ring() bh of trigger launched polling to ring
> buffer
> > + * @work_s:        the work struct through which this was scheduled
> > + *
> > + * Currently there is no option in this driver to disable the saving
> of
> > + * timestamps within the ring.
> > + * I think the one copy of this at a time was to avoid problems if
> the
> > + * trigger was set far too high and the reads then locked up the
> computer.
> > + **/
> > +static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
> > +{
> > +   struct ad7606_state *st =3D container_of(work_s, struct
> ad7606_state,
> > +                                           poll_work);
> > +   struct iio_dev *indio_dev =3D st->indio_dev;
> > +   struct iio_sw_ring_buffer *sw_ring =3D iio_to_sw_ring(indio_dev-
> >ring);
> > +   struct iio_ring_buffer *ring =3D indio_dev->ring;
> > +   s64 time_ns;
> > +   __u8 *buf;
> > +
> > +   /* Ensure only one copy of this function running at a time */
> > +   if (atomic_inc_return(&st->protect_ring) > 1)
> > +           return;
> > +
> > +   buf =3D kzalloc(st->d_size, GFP_KERNEL);
> > +   if (buf =3D=3D NULL)
> > +           return;
> > +
> > +   if (st->have_frstdata) {
> > +           st->bops->read_block(st->dev, 1, buf);
> > +           if (!gpio_get_value(st->pdata->gpio_frstdata)) {
> > +                   /* This should never happen */
> With that comment... The question is 'Does it?' If not why is this
> check here?  Some explanation needed!
> > +                   ad7606_reset(st);
> > +                   goto done;
> > +           }
> > +           st->bops->read_block(st->dev,
> > +                   st->chip_info->num_channels - 1, buf + 2);
> > +   } else {
> > +           st->bops->read_block(st->dev,
> > +                   st->chip_info->num_channels, buf);
> > +   }
> > +
> > +   time_ns =3D iio_get_time_ns();
> > +   memcpy(buf + st->d_size - sizeof(s64), &time_ns,
> sizeof(time_ns));
> > +
> > +   ring->access.store_to(&sw_ring->buf, buf, time_ns);
> > +done:
> > +   gpio_set_value(st->pdata->gpio_convst, 0);
> > +   kfree(buf);
> > +   atomic_dec(&st->protect_ring);
> > +}
> > +
> > +int ad7606_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> > +{
> > +   struct ad7606_state *st =3D indio_dev->dev_data;
> > +   int ret;
> > +
> > +   indio_dev->ring =3D iio_sw_rb_allocate(indio_dev);
> > +   if (!indio_dev->ring) {
> > +           ret =3D -ENOMEM;
> > +           goto error_ret;
> > +   }
> > +
> > +   /* Effectively select the ring buffer implementation */
> > +   iio_ring_sw_register_funcs(&indio_dev->ring->access);
> > +   ret =3D iio_alloc_pollfunc(indio_dev, NULL, &ad7606_poll_func_th);
> > +   if (ret)
> > +           goto error_deallocate_sw_rb;
> > +
> > +   /* Ring buffer functions - here trigger setup related */
> > +
> > +   indio_dev->ring->preenable =3D &ad7606_ring_preenable;
> > +   indio_dev->ring->postenable =3D &iio_triggered_ring_postenable;
> > +   indio_dev->ring->predisable =3D &iio_triggered_ring_predisable;
> > +   indio_dev->ring->scan_el_attrs =3D &ad7606_scan_el_group;
> > +
> > +   INIT_WORK(&st->poll_work, &ad7606_poll_bh_to_ring);
> > +
> > +   /* Flag that polled ring buffering is possible */
> > +   indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> > +   return 0;
> > +error_deallocate_sw_rb:
> > +   iio_sw_rb_free(indio_dev->ring);
> > +error_ret:
> > +   return ret;
> > +}
> > +
> > +void ad7606_ring_cleanup(struct iio_dev *indio_dev)
> > +{
> > +   /* ensure that the trigger has been detached */
> This does look suspiciously like a work around for a deficiency in
> the core. Is it?
>
> > +   if (indio_dev->trig) {
> > +           iio_put_trigger(indio_dev->trig);
> > +           iio_trigger_dettach_poll_func(indio_dev->trig,
> > +                                         indio_dev->pollfunc);
> > +   }
> > +   kfree(indio_dev->pollfunc);
> > +   iio_sw_rb_free(indio_dev->ring);
> > +}
> > diff --git a/drivers/staging/iio/adc/ad7606_spi.c
> b/drivers/staging/iio/adc/ad7606_spi.c
> > new file mode 100644
> > index 0000000..fb69bba
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad7606_spi.c
> > @@ -0,0 +1,133 @@
> > +/*
> > + * AD7606 SPI ADC driver
> > + *
> > + * Copyright 2011 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/types.h>
> > +#include <linux/err.h>
> > +#include "ad7606.h"
> > +
> > +#define MAX_SPI_FREQ_HZ            23500000        /* VDRIVE above 4.7=
5 V
> */
> > +
> > +static int ad7606_spi_read_block(struct device *dev,
> > +                            int count, void *buf)
> > +{
> > +   struct spi_device *spi =3D to_spi_device(dev);
> > +   int i, ret;
> > +   unsigned short *data =3D buf;
> > +
> > +   ret =3D spi_read(spi, (u8 *)buf, count * 2);
> > +   if (ret < 0) {
> > +           dev_err(&spi->dev, "SPI read error\n");
> > +           return ret;
> > +   }
> > +
> > +   for (i =3D 0; i < count; i++)
> > +           data[i] =3D be16_to_cpu(data[i]);
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct ad7606_bus_ops ad7606_spi_bops =3D {
> > +   .read_block     =3D ad7606_spi_read_block,
> > +};
> > +
> > +static int __devinit ad7606_spi_probe(struct spi_device *spi)
> > +{
> > +   struct ad7606_state *st;
> > +
> I'd as a general rule be cynical and say its the job of the board
> file writer to get this right, so could loose this test.  Guess
> there is no harm in being sure though.
> > +   /* don't exceed max specified SPI CLK frequency */
> > +   if (spi->max_speed_hz > MAX_SPI_FREQ_HZ) {
> > +           dev_err(&spi->dev, "SPI CLK %d Hz too fast\n",
> > +                   spi->max_speed_hz);
> > +           return -EINVAL;
> > +   }
> > +
> > +   st =3D ad7606_probe(&spi->dev, spi->irq, NULL,
> > +                      spi_get_device_id(spi)->driver_data,
> > +                      &ad7606_spi_bops);
> > +
> > +   if (IS_ERR(st))
> > +           return PTR_ERR(st);
> > +
> > +   spi_set_drvdata(spi, st);
> > +
> > +   return 0;
> > +}
> > +
> > +static int __devexit ad7606_spi_remove(struct spi_device *spi)
> > +{
> > +   struct ad7606_state *st =3D dev_get_drvdata(&spi->dev);
> > +
> > +   return ad7606_remove(st);
> > +}
> > +
> > +#ifdef CONFIG_PM
>
> These are identical for the two buses.  Admittedly they are trivial,
> but can we easily share them between them (i.e. move them into
> the core driver code?)
> > +static int ad7606_spi_suspend(struct device *dev)
> > +{
> > +   struct ad7606_state *st =3D dev_get_drvdata(dev);
> > +
> > +   ad7606_suspend(st);
> > +
> > +   return 0;
> > +}
> > +
> > +static int ad7606_spi_resume(struct device *dev)
> > +{
> > +   struct ad7606_state *st =3D dev_get_drvdata(dev);
> > +
> > +   ad7606_resume(st);
> > +
> > +   return 0;
> > +}
> > +
> > +static const struct dev_pm_ops ad7606_pm_ops =3D {
> > +   .suspend =3D ad7606_spi_suspend,
> > +   .resume  =3D ad7606_spi_resume,
> > +};
> > +#define AD7606_SPI_PM_OPS (&ad7606_pm_ops)
> > +
> > +#else
> > +#define AD7606_SPI_PM_OPS NULL
> > +#endif
> > +
> > +static const struct spi_device_id ad7606_id[] =3D {
> > +   {"ad7606-8", ID_AD7606_8},
> > +   {"ad7606-6", ID_AD7606_6},
> > +   {"ad7606-4", ID_AD7606_4},
> > +   {}
> > +};
> > +
> > +static struct spi_driver ad7606_driver =3D {
> > +   .driver =3D {
> > +           .name =3D "ad7606",
> > +           .bus =3D &spi_bus_type,
> > +           .owner =3D THIS_MODULE,
> > +           .pm    =3D AD7606_SPI_PM_OPS,
> > +   },
> > +   .probe =3D ad7606_spi_probe,
> > +   .remove =3D __devexit_p(ad7606_spi_remove),
> > +   .id_table =3D ad7606_id,
> > +};
> > +
> > +static int __init ad7606_spi_init(void)
> > +{
> > +   return spi_register_driver(&ad7606_driver);
> > +}
> > +module_init(ad7606_spi_init);
> > +
> > +static void __exit ad7606_spi_exit(void)
> > +{
> > +   spi_unregister_driver(&ad7606_driver);
> > +}
> > +module_exit(ad7606_spi_exit);
> > +
> > +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> > +MODULE_DESCRIPTION("Analog Devices AD7606 ADC");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("spi:ad7606-spi");
