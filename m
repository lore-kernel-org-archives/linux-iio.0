Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4D6426ED.3090101@analog.com>
Date: Tue, 22 Feb 2011 22:13:17 +0100
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: michael.hennerich@analog.com
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO: ADC: New driver for the AD7298 8-channel SPI ADC
References: <1297692220-30306-1-git-send-email-michael.hennerich@analog.com> <4D63C965.8030309@cam.ac.uk>
In-Reply-To: <4D63C965.8030309@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On 02/22/2011 03:34 PM, Jonathan Cameron wrote:
> On 02/14/11 14:03, michael.hennerich@analog.com wrote:
>   
>> From: Michael Hennerich <michael.hennerich@analog.com>
>>
>> This patch adds support for the
>> AD7298:  8-Channel, 1MSPS, 12-Bit SAR ADC with Temperature Sensor
>> via SPI bus.
>>
>> This patch replaces the existing ad7298.c driver completely.
>> It was necessary since, the old driver did not comply with the
>> IIO ABI for such devices.
>>     
> Guess that's one approach to fixing up a driver!
> Anyhow, it's nice and clean now.
>   
Rewrite is sometimes easier than fix ;-)

> Couple of trivial points inline.  You may need some locking
> in the temperature read function, fix that or explain what
> I'm missing before sending on to Greg, the other bits are up
> to you.
>   
Good point.
> I see the original driver used a busy pin. For the record, could you
> also explain any disadvantages in this new one not doing that?
>   
Well the busy pin is only used to for on-die temperature measurements.
The busy time is pretty deterministic, wasting a GPIO or interrupt line
is pointless!
Sleep for at least 100us, does the job. I see no point what this task
could do useful otherwise,
since it would also result in a sleep.

Last but not least - this is a 8-Channel ADC, the temperature diode is
only the hard wired 9th channel,
with pretty limited use. The busy pin might be useful for none OS 8-bit
micro systems, but here
we simply put the task asleep.

> Thanks,
>
> Jonathan
>
>   
>> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
>>     
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
>   
>> ---
>>  drivers/staging/iio/adc/Kconfig       |    7 +-
>>  drivers/staging/iio/adc/Makefile      |    5 +-
>>  drivers/staging/iio/adc/ad7298.c      |  501 ---------------------------------
>>  drivers/staging/iio/adc/ad7298.h      |   87 ++++++
>>  drivers/staging/iio/adc/ad7298_core.c |  287 +++++++++++++++++++
>>  drivers/staging/iio/adc/ad7298_ring.c |  244 ++++++++++++++++
>>  6 files changed, 627 insertions(+), 504 deletions(-)
>>  delete mode 100644 drivers/staging/iio/adc/ad7298.c
>>  create mode 100644 drivers/staging/iio/adc/ad7298.h
>>  create mode 100644 drivers/staging/iio/adc/ad7298_core.c
>>  create mode 100644 drivers/staging/iio/adc/ad7298_ring.c
>>
>> diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/Kconfig
>> index 86869cd..34daf58 100644
>> --- a/drivers/staging/iio/adc/Kconfig
>> +++ b/drivers/staging/iio/adc/Kconfig
>> @@ -49,11 +49,14 @@ config AD7291
>>         temperature sensors.
>>
>>  config AD7298
>> -     tristate "Analog Devices AD7298 temperature sensor and ADC driver"
>> +     tristate "Analog Devices AD7298 ADC driver"
>>       depends on SPI
>>       help
>>         Say yes here to build support for Analog Devices AD7298
>> -       temperature sensors and ADC.
>> +       8 Channel ADC with temperature sensor.
>> +
>> +       To compile this driver as a module, choose M here: the
>> +       module will be called ad7298.
>>     
> Good. That description kind of emphasises the adc side more and explains what
> this is doing in IIO rather than hwmon.
>   
>>  config AD7314
>>       tristate "Analog Devices AD7314 temperature sensor driver"
>> diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc/Makefile
>> index 6f231a2..662e56f 100644
>> --- a/drivers/staging/iio/adc/Makefile
>> +++ b/drivers/staging/iio/adc/Makefile
>> @@ -19,10 +19,13 @@ ad7887-y := ad7887_core.o
>>  ad7887-$(CONFIG_IIO_RING_BUFFER) += ad7887_ring.o
>>  obj-$(CONFIG_AD7887) += ad7887.o
>>
>> +ad7298-y := ad7298_core.o
>> +ad7298-$(CONFIG_IIO_RING_BUFFER) += ad7298_ring.o
>> +obj-$(CONFIG_AD7298) += ad7298.o
>> +
>>  obj-$(CONFIG_AD7150) += ad7150.o
>>  obj-$(CONFIG_AD7152) += ad7152.o
>>  obj-$(CONFIG_AD7291) += ad7291.o
>> -obj-$(CONFIG_AD7298) += ad7298.o
>>  obj-$(CONFIG_AD7314) += ad7314.o
>>  obj-$(CONFIG_AD7745) += ad7745.o
>>  obj-$(CONFIG_AD7816) += ad7816.o
>> diff --git a/drivers/staging/iio/adc/ad7298.c b/drivers/staging/iio/adc/ad7298.c
>> deleted file mode 100644
>> index 1a080c9..0000000
>>     
> ....
>   
>> diff --git a/drivers/staging/iio/adc/ad7298.h b/drivers/staging/iio/adc/ad7298.h
>> new file mode 100644
>> index 0000000..3e11865
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7298.h
>> @@ -0,0 +1,87 @@
>> +/*
>> + * AD7298 SPI ADC driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#ifndef IIO_ADC_AD7298_H_
>> +#define IIO_ADC_AD7298_H_
>> +
>> +#define AD7298_WRITE (1 << 15) /* write to the control register */
>> +#define AD7298_REPEAT        (1 << 14) /* repeated conversion enable */
>>     
> Perhaps a single macro covering them all?
> #define AD7298_CH(x) (1 << (13 - x))
> where x is then 0 through 7
>   
>> +#define AD7298_CH0   (1 << 13) /* channel select */
>> +#define AD7298_CH1   (1 << 12) /* channel select */
>> +#define AD7298_CH2   (1 << 11) /* channel select */
>> +#define AD7298_CH3   (1 << 10) /* channel select */
>> +#define AD7298_CH4   (1 << 9) /* channel select */
>> +#define AD7298_CH5   (1 << 8) /* channel select */
>> +#define AD7298_CH6   (1 << 7) /* channel select */
>> +#define AD7298_CH7   (1 << 6) /* channel select */
>> +#define AD7298_TSENSE        (1 << 5) /* temperature conversion enable */
>> +#define AD7298_EXTREF        (1 << 2) /* external reference enable */
>> +#define AD7298_TAVG  (1 << 1) /* temperature sensor averaging enable */
>> +#define AD7298_PDD   (1 << 0) /* partial power down enable */
>> +
>> +#define AD7298_CH_MASK       (AD7298_CH0 | AD7298_CH1 | AD7298_CH2 | AD7298_CH3 | \
>> +                     AD7298_CH4 | AD7298_CH5 | AD7298_CH6 | AD7298_CH7)
>> +
>> +#define AD7298_MAX_CHAN              8
>> +#define AD7298_BITS          12
>> +#define AD7298_STORAGE_BITS  16
>> +#define AD7298_INTREF_mV     2500
>> +
>> +#define RES_MASK(bits)       ((1 << (bits)) - 1)
>> +
>> +/*
>> + * TODO: struct ad7298_platform_data needs to go into include/linux/iio
>> + */
>> +
>> +struct ad7298_platform_data {
>> +     /* External Vref voltage applied */
>> +     u16                             vref_mv;
>> +};
>> +
>> +struct ad7298_state {
>> +     struct iio_dev                  *indio_dev;
>> +     struct spi_device               *spi;
>> +     struct regulator                *reg;
>> +     struct work_struct              poll_work;
>> +     atomic_t                        protect_ring;
>> +     size_t                          d_size;
>> +     u16                             int_vref_mv;
>> +     unsigned                        ext_ref;
>>     
> Could put #ifdefs round the bits only used when the ring is enabled.
> Potential tiny saving in space, but more importantly makes it clear
> what is used where. Could put the other ring based bits in there as
> well I guess (and yes, we could do this in numerous drivers).  Maybe
> it isn't worth the hassle.
>   
>> +     struct spi_transfer             ring_xfer[10];
>> +     struct spi_transfer             scan_single_xfer[3];
>> +     struct spi_message              ring_msg;
>> +     struct spi_message              scan_single_msg;
>> +     /*
>> +      * DMA (thus cache coherency maintenance) requires the
>> +      * transfer buffers to live in their own cache lines.
>> +      */
>> +     unsigned short                  rx_buf[8] ____cacheline_aligned;
>> +     unsigned short                  tx_buf[2];
>> +};
>> +
>> +#ifdef CONFIG_IIO_RING_BUFFER
>> +int ad7298_scan_from_ring(struct ad7298_state *st, long ch);
>> +int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev);
>> +void ad7298_ring_cleanup(struct iio_dev *indio_dev);
>> +#else /* CONFIG_IIO_RING_BUFFER */
>> +static inline int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline int
>> +ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>> +{
>> +     return 0;
>> +}
>> +
>> +static inline void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>> +{
>> +}
>> +#endif /* CONFIG_IIO_RING_BUFFER */
>> +#endif /* IIO_ADC_AD7298_H_ */
>> diff --git a/drivers/staging/iio/adc/ad7298_core.c b/drivers/staging/iio/adc/ad7298_core.c
>> new file mode 100644
>> index 0000000..4d63bd2
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7298_core.c
>> @@ -0,0 +1,287 @@
>> +/*
>> + * AD7298 SPI ADC driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/workqueue.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/spi/spi.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/err.h>
>> +#include <linux/delay.h>
>> +
>> +#include "../iio.h"
>> +#include "../sysfs.h"
>> +#include "../ring_generic.h"
>> +#include "adc.h"
>> +
>> +#include "ad7298.h"
>> +
>> +static int ad7298_scan_direct(struct ad7298_state *st, unsigned ch)
>> +{
>> +     int ret;
>> +     st->tx_buf[0] = cpu_to_be16(AD7298_WRITE | st->ext_ref |
>> +                                (AD7298_CH0 >> ch));
>> +
>> +     ret = spi_sync(st->spi, &st->scan_single_msg);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return be16_to_cpu(st->rx_buf[0]);
>> +}
>> +
>> +static ssize_t ad7298_scan(struct device *dev,
>> +                         struct device_attribute *attr,
>> +                         char *buf)
>> +{
>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +     struct ad7298_state *st = dev_info->dev_data;
>> +     struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>> +     int ret;
>> +
>> +     mutex_lock(&dev_info->mlock);
>> +     if (iio_ring_enabled(dev_info))
>> +             ret = ad7298_scan_from_ring(st, this_attr->address);
>> +     else
>> +             ret = ad7298_scan_direct(st, this_attr->address);
>> +     mutex_unlock(&dev_info->mlock);
>> +
>> +     if (ret < 0)
>> +             return ret;
>> +
>> +     return sprintf(buf, "%d\n", ret & RES_MASK(AD7298_BITS));
>> +}
>> +
>> +static IIO_DEV_ATTR_IN_RAW(0, ad7298_scan, 0);
>> +static IIO_DEV_ATTR_IN_RAW(1, ad7298_scan, 1);
>> +static IIO_DEV_ATTR_IN_RAW(2, ad7298_scan, 2);
>> +static IIO_DEV_ATTR_IN_RAW(3, ad7298_scan, 3);
>> +static IIO_DEV_ATTR_IN_RAW(4, ad7298_scan, 4);
>> +static IIO_DEV_ATTR_IN_RAW(5, ad7298_scan, 5);
>> +static IIO_DEV_ATTR_IN_RAW(6, ad7298_scan, 6);
>> +static IIO_DEV_ATTR_IN_RAW(7, ad7298_scan, 7);
>> +
>> +static ssize_t ad7298_show_temp(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             char *buf)
>> +{
>> +     /* Driver currently only support internal vref */
>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +     struct ad7298_state *st = iio_dev_get_devdata(dev_info);
>> +     unsigned short tmp;
>> +     char sign;
>> +
>>     
> I guess we might want to make the TAVG bit controllable? As ever
> though, whoever wants this can add it later.
>   
>> +     tmp = cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
>> +                       AD7298_TAVG | st->ext_ref);
>> +
>>     
> Should you hold a lock here to prevent other reads being attempted?
>   
>> +     spi_write(st->spi, (u8 *)&tmp, 2);
>> +     tmp = 0;
>> +     spi_write(st->spi, (u8 *)&tmp, 2);
>> +     usleep_range(101, 1000); /* sleep > 100us */
>> +     spi_read(st->spi, (u8 *)&tmp, 2);
>> +
>> +     tmp = be16_to_cpu(tmp) & RES_MASK(AD7298_BITS);
>> +
>> +     /*
>> +      * One LSB of the ADC corresponds to 0.25 deg C.
>> +      * The temperature reading is in 12-bit twos complement format
>> +      */
>> +
>> +     if (tmp & (1 << (AD7298_BITS - 1))) {
>> +             tmp = (1 << AD7298_BITS) - tmp;
>> +             sign = '-';
>> +     } else {
>> +             sign = '+';
>> +     }
>> +
>> +     return sprintf(buf, "%c%d.%.2d\n", sign, tmp / 4, (tmp & 3) * 25);
>> +}
>> +
>> +static IIO_DEVICE_ATTR(temp, S_IRUGO, ad7298_show_temp, NULL, 0);
>>     
> should be temp0_input and in milli degrees Celcius.
> Sorry, need to match hwmon for this.  Also needs documentation.  Actually
> I hadn't previously noticed that hwmon uses milli degrees. Dratt, we may
> have to change our all the _scale parameters for _raw temp attributes
> to take that into account + update docs obviously.
>   
>> +
>> +static ssize_t ad7298_show_scale(struct device *dev,
>> +                             struct device_attribute *attr,
>> +                             char *buf)
>> +{
>> +     /* Driver currently only support internal vref */
>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +     struct ad7298_state *st = iio_dev_get_devdata(dev_info);
>> +     /* Corresponds to Vref / 2^(bits) */
>> +     unsigned int scale_uv = (st->int_vref_mv * 1000) >> AD7298_BITS;
>> +
>> +     return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
>> +}
>> +static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad7298_show_scale, NULL, 0);
>> +
>> +static ssize_t ad7298_show_name(struct device *dev,
>> +                              struct device_attribute *attr,
>> +                              char *buf)
>> +{
>> +     struct iio_dev *dev_info = dev_get_drvdata(dev);
>> +     struct ad7298_state *st = iio_dev_get_devdata(dev_info);
>> +
>> +     return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
>> +}
>> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad7298_show_name, NULL, 0);
>>     
> I'm guessing more devices are following using this driver. If not I'd
> advocate use of a const attr for this.
>   
>> +
>> +static struct attribute *ad7298_attributes[] = {
>> +     &iio_dev_attr_in0_raw.dev_attr.attr,
>> +     &iio_dev_attr_in1_raw.dev_attr.attr,
>> +     &iio_dev_attr_in2_raw.dev_attr.attr,
>> +     &iio_dev_attr_in3_raw.dev_attr.attr,
>> +     &iio_dev_attr_in4_raw.dev_attr.attr,
>> +     &iio_dev_attr_in5_raw.dev_attr.attr,
>> +     &iio_dev_attr_in6_raw.dev_attr.attr,
>> +     &iio_dev_attr_in7_raw.dev_attr.attr,
>> +     &iio_dev_attr_in_scale.dev_attr.attr,
>> +     &iio_dev_attr_temp.dev_attr.attr,
>> +     &iio_dev_attr_name.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static const struct attribute_group ad7298_attribute_group = {
>> +     .attrs = ad7298_attributes,
>> +};
>> +
>> +static int __devinit ad7298_probe(struct spi_device *spi)
>> +{
>> +     struct ad7298_platform_data *pdata = spi->dev.platform_data;
>> +     struct ad7298_state *st;
>> +     int ret;
>> +
>> +     st = kzalloc(sizeof(*st), GFP_KERNEL);
>> +     if (st == NULL) {
>> +             ret = -ENOMEM;
>> +             goto error_ret;
>> +     }
>> +
>> +     st->reg = regulator_get(&spi->dev, "vcc");
>> +     if (!IS_ERR(st->reg)) {
>> +             ret = regulator_enable(st->reg);
>> +             if (ret)
>> +                     goto error_put_reg;
>> +     }
>> +
>> +     spi_set_drvdata(spi, st);
>> +
>> +     atomic_set(&st->protect_ring, 0);
>> +     st->spi = spi;
>> +
>> +     st->indio_dev = iio_allocate_device();
>> +     if (st->indio_dev == NULL) {
>> +             ret = -ENOMEM;
>> +             goto error_disable_reg;
>> +     }
>> +
>> +     st->indio_dev->dev.parent = &spi->dev;
>> +     st->indio_dev->attrs = &ad7298_attribute_group;
>> +     st->indio_dev->dev_data = (void *)(st);
>> +     st->indio_dev->driver_module = THIS_MODULE;
>> +     st->indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> +     /* Setup default message */
>> +
>> +     st->scan_single_xfer[0].tx_buf = &st->tx_buf[0];
>> +     st->scan_single_xfer[0].len = 2;
>> +     st->scan_single_xfer[0].cs_change = 1;
>> +     st->scan_single_xfer[1].tx_buf = &st->tx_buf[1];
>> +     st->scan_single_xfer[1].len = 2;
>> +     st->scan_single_xfer[1].cs_change = 1;
>> +     st->scan_single_xfer[2].rx_buf = &st->rx_buf[0];
>> +     st->scan_single_xfer[2].len = 2;
>> +
>> +     spi_message_init(&st->scan_single_msg);
>> +     spi_message_add_tail(&st->scan_single_xfer[0], &st->scan_single_msg);
>> +     spi_message_add_tail(&st->scan_single_xfer[1], &st->scan_single_msg);
>> +     spi_message_add_tail(&st->scan_single_xfer[2], &st->scan_single_msg);
>> +
>> +     if (pdata && pdata->vref_mv) {
>> +             st->int_vref_mv = pdata->vref_mv;
>> +             st->ext_ref = AD7298_EXTREF;
>> +     } else {
>> +             st->int_vref_mv = AD7298_INTREF_mV;
>> +     }
>> +
>> +     ret = ad7298_register_ring_funcs_and_init(st->indio_dev);
>> +     if (ret)
>> +             goto error_free_device;
>> +
>> +     ret = iio_device_register(st->indio_dev);
>> +     if (ret)
>> +             goto error_free_device;
>> +
>> +     ret = iio_ring_buffer_register(st->indio_dev->ring, 0);
>> +     if (ret)
>> +             goto error_cleanup_ring;
>> +     return 0;
>> +
>> +error_cleanup_ring:
>> +     ad7298_ring_cleanup(st->indio_dev);
>> +     iio_device_unregister(st->indio_dev);
>> +error_free_device:
>> +     iio_free_device(st->indio_dev);
>> +error_disable_reg:
>> +     if (!IS_ERR(st->reg))
>> +             regulator_disable(st->reg);
>> +error_put_reg:
>> +     if (!IS_ERR(st->reg))
>> +             regulator_put(st->reg);
>> +     kfree(st);
>> +error_ret:
>> +     return ret;
>> +}
>> +
>> +static int ad7298_remove(struct spi_device *spi)
>> +{
>> +     struct ad7298_state *st = spi_get_drvdata(spi);
>> +     struct iio_dev *indio_dev = st->indio_dev;
>> +
>> +     iio_ring_buffer_unregister(indio_dev->ring);
>>     
> Might be my editor, but I think you have a weird spacing
> issue on the next line.
>   
>> +             ad7298_ring_cleanup(indio_dev);
>> +     iio_device_unregister(indio_dev);
>> +     if (!IS_ERR(st->reg)) {
>> +             regulator_disable(st->reg);
>> +             regulator_put(st->reg);
>> +     }
>> +     kfree(st);
>> +     return 0;
>> +}
>> +
>> +static const struct spi_device_id ad7298_id[] = {
>> +     {"ad7298", 0},
>> +     {}
>> +};
>> +
>> +static struct spi_driver ad7298_driver = {
>> +     .driver = {
>> +             .name   = "ad7298",
>> +             .bus    = &spi_bus_type,
>> +             .owner  = THIS_MODULE,
>> +     },
>> +     .probe          = ad7298_probe,
>> +     .remove         = __devexit_p(ad7298_remove),
>> +     .id_table       = ad7298_id,
>> +};
>> +
>> +static int __init ad7298_init(void)
>> +{
>> +     return spi_register_driver(&ad7298_driver);
>> +}
>> +module_init(ad7298_init);
>> +
>> +static void __exit ad7298_exit(void)
>> +{
>> +     spi_unregister_driver(&ad7298_driver);
>> +}
>> +module_exit(ad7298_exit);
>> +
>> +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
>> +MODULE_DESCRIPTION("Analog Devices AD7298 ADC");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_ALIAS("spi:ad7298");
>> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
>> new file mode 100644
>> index 0000000..15e0640
>> --- /dev/null
>> +++ b/drivers/staging/iio/adc/ad7298_ring.c
>> @@ -0,0 +1,244 @@
>> +/*
>> + * AD7298 SPI ADC driver
>> + *
>> + * Copyright 2011 Analog Devices Inc.
>> + *
>> + * Licensed under the GPL-2.
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/workqueue.h>
>> +#include <linux/device.h>
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/spi/spi.h>
>> +
>> +#include "../iio.h"
>> +#include "../ring_generic.h"
>> +#include "../ring_sw.h"
>> +#include "../trigger.h"
>> +#include "../sysfs.h"
>> +
>> +#include "ad7298.h"
>> +
>> +static IIO_SCAN_EL_C(in0, 0, 0, NULL);
>> +static IIO_SCAN_EL_C(in1, 1, 0, NULL);
>> +static IIO_SCAN_EL_C(in2, 2, 0, NULL);
>> +static IIO_SCAN_EL_C(in3, 3, 0, NULL);
>> +static IIO_SCAN_EL_C(in4, 4, 0, NULL);
>> +static IIO_SCAN_EL_C(in5, 5, 0, NULL);
>> +static IIO_SCAN_EL_C(in6, 6, 0, NULL);
>> +static IIO_SCAN_EL_C(in7, 7, 0, NULL);
>> +
>> +static IIO_CONST_ATTR(in_type, "u12/16") ;
>> +
>> +static struct attribute *ad7298_scan_el_attrs[] = {
>> +     &iio_scan_el_in0.dev_attr.attr,
>> +     &iio_const_attr_in0_index.dev_attr.attr,
>> +     &iio_scan_el_in1.dev_attr.attr,
>> +     &iio_const_attr_in1_index.dev_attr.attr,
>> +     &iio_scan_el_in2.dev_attr.attr,
>> +     &iio_const_attr_in2_index.dev_attr.attr,
>> +     &iio_scan_el_in3.dev_attr.attr,
>> +     &iio_const_attr_in3_index.dev_attr.attr,
>> +     &iio_scan_el_in4.dev_attr.attr,
>> +     &iio_const_attr_in4_index.dev_attr.attr,
>> +     &iio_scan_el_in5.dev_attr.attr,
>> +     &iio_const_attr_in5_index.dev_attr.attr,
>> +     &iio_scan_el_in6.dev_attr.attr,
>> +     &iio_const_attr_in6_index.dev_attr.attr,
>> +     &iio_scan_el_in7.dev_attr.attr,
>> +     &iio_const_attr_in7_index.dev_attr.attr,
>> +     &iio_const_attr_in_type.dev_attr.attr,
>> +     NULL,
>> +};
>> +
>> +static struct attribute_group ad7298_scan_el_group = {
>> +     .name = "scan_elements",
>> +     .attrs = ad7298_scan_el_attrs,
>> +};
>> +
>> +int ad7298_scan_from_ring(struct ad7298_state *st, long ch)
>> +{
>> +     struct iio_ring_buffer *ring = st->indio_dev->ring;
>> +     int ret;
>> +     u16 *ring_data;
>> +
>> +     if (!(ring->scan_mask & (1 << ch))) {
>> +             ret = -EBUSY;
>> +             goto error_ret;
>> +     }
>> +
>> +     ring_data = kmalloc(ring->access.get_bytes_per_datum(ring), GFP_KERNEL);
>> +     if (ring_data == NULL) {
>> +             ret = -ENOMEM;
>> +             goto error_ret;
>> +     }
>> +     ret = ring->access.read_last(ring, (u8 *) ring_data);
>> +     if (ret)
>> +             goto error_free_ring_data;
>> +
>> +     ret = be16_to_cpu(ring_data[ch]);
>> +
>> +error_free_ring_data:
>> +     kfree(ring_data);
>> +error_ret:
>> +     return ret;
>> +}
>> +
>> +/**
>> + * ad7298_ring_preenable() setup the parameters of the ring before enabling
>> + *
>> + * The complex nature of the setting of the nuber of bytes per datum is due
>> + * to this driver currently ensuring that the timestamp is stored at an 8
>> + * byte boundary.
>> + **/
>> +static int ad7298_ring_preenable(struct iio_dev *indio_dev)
>> +{
>> +     struct ad7298_state *st = indio_dev->dev_data;
>> +     struct iio_ring_buffer *ring = indio_dev->ring;
>> +     size_t d_size;
>> +     int i, m;
>> +     unsigned short command;
>> +
>> +     d_size = ring->scan_count *
>> +              (AD7298_STORAGE_BITS / 8) + sizeof(s64);
>> +
>> +     if (d_size % sizeof(s64))
>> +             d_size += sizeof(s64) - (d_size % sizeof(s64));
>> +
>> +     if (ring->access.set_bytes_per_datum)
>> +             ring->access.set_bytes_per_datum(ring, d_size);
>> +
>> +     st->d_size = d_size;
>> +
>> +     command = AD7298_WRITE | st->ext_ref;
>> +
>> +     for (i = 0, m = AD7298_CH0; i < AD7298_MAX_CHAN; i++, m >>= 1)
>> +             if (ring->scan_mask & (1 << i))
>> +                     command |= m;
>> +
>> +     st->tx_buf[0] = cpu_to_be16(command);
>> +
>> +     /* build spi ring message */
>> +     st->ring_xfer[0].tx_buf = &st->tx_buf[0];
>> +     st->ring_xfer[0].len = 2;
>> +     st->ring_xfer[0].cs_change = 1;
>> +     st->ring_xfer[1].tx_buf = &st->tx_buf[1];
>> +     st->ring_xfer[1].len = 2;
>> +     st->ring_xfer[1].cs_change = 1;
>> +
>> +     spi_message_init(&st->ring_msg);
>> +     spi_message_add_tail(&st->ring_xfer[0], &st->ring_msg);
>> +     spi_message_add_tail(&st->ring_xfer[1], &st->ring_msg);
>> +
>> +     for (i = 0; i < ring->scan_count; i++) {
>> +             st->ring_xfer[i + 2].rx_buf = &st->rx_buf[i];
>> +             st->ring_xfer[i + 2].len = 2;
>> +             st->ring_xfer[i + 2].cs_change = 1;
>> +             spi_message_add_tail(&st->ring_xfer[i + 2], &st->ring_msg);
>> +     }
>> +     /* make sure last transfer cs_change is not set */
>> +     st->ring_xfer[i + 1].cs_change = 0;
>> +
>> +     return 0;
>> +}
>> +
>> +/**
>> + * ad7298_poll_func_th() th of trigger launched polling to ring buffer
>> + *
>> + * As sampling only occurs on spi comms occuring, leave timestamping until
>> + * then.  Some triggers will generate their own time stamp.  Currently
>> + * there is no way of notifying them when no one cares.
>> + **/
>> +static void ad7298_poll_func_th(struct iio_dev *indio_dev, s64 time)
>> +{
>> +     struct ad7298_state *st = indio_dev->dev_data;
>> +
>> +     schedule_work(&st->poll_work);
>> +     return;
>> +}
>>     
> New line here please.
>   
>> +/**
>> + * ad7298_poll_bh_to_ring() bh of trigger launched polling to ring buffer
>> + * @work_s:  the work struct through which this was scheduled
>> + *
>> + * Currently there is no option in this driver to disable the saving of
>> + * timestamps within the ring.
>> + * I think the one copy of this at a time was to avoid problems if the
>> + * trigger was set far too high and the reads then locked up the computer.
>> + **/
>> +static void ad7298_poll_bh_to_ring(struct work_struct *work_s)
>> +{
>> +     struct ad7298_state *st = container_of(work_s, struct ad7298_state,
>> +                                               poll_work);
>> +     struct iio_dev *indio_dev = st->indio_dev;
>> +     struct iio_sw_ring_buffer *sw_ring = iio_to_sw_ring(indio_dev->ring);
>> +     struct iio_ring_buffer *ring = indio_dev->ring;
>> +     s64 time_ns;
>> +     __u16 buf[16];
>> +     int b_sent, i;
>> +
>> +     /* Ensure only one copy of this function running at a time */
>> +     if (atomic_inc_return(&st->protect_ring) > 1)
>> +             return;
>> +
>> +     b_sent = spi_sync(st->spi, &st->ring_msg);
>> +     if (b_sent)
>> +             goto done;
>> +
>> +     time_ns = iio_get_time_ns();
>> +
>> +     for (i = 0; i < ring->scan_count; i++)
>> +             buf[i] = be16_to_cpu(st->rx_buf[i]);
>> +
>> +     memcpy((u8 *)buf + st->d_size - sizeof(s64), &time_ns, sizeof(time_ns));
>> +     indio_dev->ring->access.store_to(&sw_ring->buf, (u8 *)buf, time_ns);
>> +done:
>> +     atomic_dec(&st->protect_ring);
>> +}
>> +
>> +int ad7298_register_ring_funcs_and_init(struct iio_dev *indio_dev)
>> +{
>> +     struct ad7298_state *st = indio_dev->dev_data;
>> +     int ret;
>> +
>> +     indio_dev->ring = iio_sw_rb_allocate(indio_dev);
>> +     if (!indio_dev->ring) {
>> +             ret = -ENOMEM;
>> +             goto error_ret;
>> +     }
>> +     /* Effectively select the ring buffer implementation */
>> +     iio_ring_sw_register_funcs(&indio_dev->ring->access);
>> +     ret = iio_alloc_pollfunc(indio_dev, NULL, &ad7298_poll_func_th);
>> +     if (ret)
>> +             goto error_deallocate_sw_rb;
>> +
>> +     /* Ring buffer functions - here trigger setup related */
>> +
>> +     indio_dev->ring->preenable = &ad7298_ring_preenable;
>> +     indio_dev->ring->postenable = &iio_triggered_ring_postenable;
>> +     indio_dev->ring->predisable = &iio_triggered_ring_predisable;
>> +     indio_dev->ring->scan_el_attrs = &ad7298_scan_el_group;
>> +
>> +     INIT_WORK(&st->poll_work, &ad7298_poll_bh_to_ring);
>> +
>> +     /* Flag that polled ring buffering is possible */
>> +     indio_dev->modes |= INDIO_RING_TRIGGERED;
>> +     return 0;
>> +error_deallocate_sw_rb:
>> +     iio_sw_rb_free(indio_dev->ring);
>> +error_ret:
>> +     return ret;
>> +}
>> +
>> +void ad7298_ring_cleanup(struct iio_dev *indio_dev)
>> +{
>> +     if (indio_dev->trig) {
>> +             iio_put_trigger(indio_dev->trig);
>> +             iio_trigger_dettach_poll_func(indio_dev->trig,
>> +                                           indio_dev->pollfunc);
>> +     }
>> +     kfree(indio_dev->pollfunc);
>> +     iio_sw_rb_free(indio_dev->ring);
>> +}
>>     
>   


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
