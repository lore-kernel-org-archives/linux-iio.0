Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.01.1402031052220.9515@pmeerw.net>
References: <1391235462-32453-1-git-send-email-mranostay@gmail.com>
	<1391235462-32453-2-git-send-email-mranostay@gmail.com>
	<alpine.DEB.2.01.1402031052220.9515@pmeerw.net>
Date: Mon, 3 Feb 2014 20:01:56 -0800
Message-ID: <CAKzfze-FOORiVUEbN4RE2Lhr6JvOcM1vrP2XW_3-3L-z=8DMRQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] iio: Add AS3935 lightning sensor support
From: Matt Ranostay <mranostay@gmail.com>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Content-Type: multipart/alternative; boundary=089e0149ce3c8a419904f18cb302
List-ID: <linux-iio@vger.kernel.org>

--089e0149ce3c8a419904f18cb302
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Feb 3, 2014 at 2:10 AM, Peter Meerwald <pmeerw@pmeerw.net> wrote:

> Hello,
>
> > AS3935 chipset can detect lightning strikes and reports those back as
> > events and the estimated distance to the storm.
>
> couple of more comments:
>
> the AS3935 seems to support I2C and SPI, the driver supports SPI only;
> this should be noted somewhere
>
> Where is that best noted? Kconfig message and/or in the code?


> IIO already has a proximity channel which is somewhat similar;
> unfortunately, proximity is not really documented in sysfs-bus-iio
> (proximity seems to be unit-less so far)
>
> you propose to add a distance channel with unit of kilometers (which
> happens to make sense for the as3935 driver); probably distance should be
> meters, not kilometers
>
> sorry to bring this up so late: but what is the argument to have distance
> and not re-use proximity?
>

None really. IIO_PROXIMITY should that me in kilometers or better in
meters? I suspect the latter.


>
> some more comments inline below; you have only tested with nearby
> lightning? :)
>
> Ah yes would have had some interesting results in the summer months :)
Since it is winter I kinda have to hack a test together...


> p.
>
> > ---
> >  .../ABI/testing/sysfs-bus-iio-distance-as3935      |  19 +
> >  drivers/iio/Kconfig                                |   1 +
> >  drivers/iio/Makefile                               |   1 +
> >  drivers/iio/distance/Kconfig                       |  19 +
> >  drivers/iio/distance/Makefile                      |   6 +
> >  drivers/iio/distance/as3935.c                      | 438
> +++++++++++++++++++++
> >  6 files changed, 484 insertions(+)
> >  create mode 100644
> Documentation/ABI/testing/sysfs-bus-iio-distance-as3935
> >  create mode 100644 drivers/iio/distance/Kconfig
> >  create mode 100644 drivers/iio/distance/Makefile
> >  create mode 100644 drivers/iio/distance/as3935.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-as3935
> b/Documentation/ABI/testing/sysfs-bus-iio-distance-as3935
> > new file mode 100644
> > index 0000000..cf9a67c
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-as3935
> > @@ -0,0 +1,19 @@
> > +What         /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > +Date:                January 2014
> > +KernelVersion:       3.15
> > +Contact:     Matt Ranostay <mranostay@gmail.com>
> > +Description:
> > +             Get the current distance in kilometers of storm
> > +             0    = no storm activity
> > +             1    = storm overhead
> > +             1-40 = distance in kilometers
> > +             63   = out of range
> > +
> > +What         /sys/bus/iio/devices/iio:deviceX/gain_boost
> > +Date:                January 2014
> > +KernelVersion:       3.15
> > +Contact:     Matt Ranostay <mranostay@gmail.com>
> > +Description:
> > +             Show or set the gain boost of the amp, from 0-31 range.
> > +             18 = indoors (default)
> > +             14 = outdoors
> > diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> > index 5dd0e12..5164a68 100644
> > --- a/drivers/iio/Kconfig
> > +++ b/drivers/iio/Kconfig
> > @@ -63,6 +63,7 @@ source "drivers/iio/adc/Kconfig"
> >  source "drivers/iio/amplifiers/Kconfig"
> >  source "drivers/iio/common/Kconfig"
> >  source "drivers/iio/dac/Kconfig"
> > +source "drivers/iio/distance/Kconfig"
> >  source "drivers/iio/frequency/Kconfig"
> >  source "drivers/iio/gyro/Kconfig"
> >  source "drivers/iio/humidity/Kconfig"
> > diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> > index 887d390..1574731 100644
> > --- a/drivers/iio/Makefile
> > +++ b/drivers/iio/Makefile
> > @@ -16,6 +16,7 @@ obj-y += adc/
> >  obj-y += amplifiers/
> >  obj-y += common/
> >  obj-y += dac/
> > +obj-y += distance/
> >  obj-y += gyro/
> >  obj-y += frequency/
> >  obj-y += humidity/
> > diff --git a/drivers/iio/distance/Kconfig b/drivers/iio/distance/Kconfig
> > new file mode 100644
> > index 0000000..8a2404c
> > --- /dev/null
> > +++ b/drivers/iio/distance/Kconfig
> > @@ -0,0 +1,19 @@
> > +#
> > +# Distance sensors
> > +#
> > +
> > +menu "Lightning sensors"
> > +
> > +config AS3935
> > +     tristate "AS3935 Franklin lightning sensor"
> > +     select IIO_BUFFER
> > +     select IIO_TRIGGERED_BUFFER
> > +     depends on SPI
> > +     help
> > +      If you say yes here you get support for the Austrian Microsystems
> > +      AS3935 lightning detection sensor.
> > +
> > +      This driver can also be built as a module. If so, the module
> > +      will be called as3935.
> > +
> > +endmenu
> > diff --git a/drivers/iio/distance/Makefile
> b/drivers/iio/distance/Makefile
> > new file mode 100644
> > index 0000000..f63b70d
> > --- /dev/null
> > +++ b/drivers/iio/distance/Makefile
> > @@ -0,0 +1,6 @@
> > +#
> > +# Makefile for IIO distance sensors
> > +#
> > +
> > +# When adding new entries keep the list in alphabetical order
> > +obj-$(CONFIG_AS3935)         += as3935.o
> > diff --git a/drivers/iio/distance/as3935.c
> b/drivers/iio/distance/as3935.c
> > new file mode 100644
> > index 0000000..ea00cd1
> > --- /dev/null
> > +++ b/drivers/iio/distance/as3935.c
> > @@ -0,0 +1,438 @@
> > +/*
> > + * as3935.c - Support for AS3935 Franklin lightning sensor
> > + *
> > + * Copyright (C) 2014 Matt Ranostay <mranostay@gmail.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> > + * GNU General Public License for more details.
> > + *
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/delay.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/mutex.h>
> > +#include <linux/err.h>
> > +#include <linux/irq.h>
> > +#include <linux/gpio.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/of_gpio.h>
> > +
> > +
> > +#define AS3935_AFE_GAIN              0x00
> > +#define AS3935_AFE_MASK              0x3F
> > +#define AS3935_AFE_GAIN_MAX  0x1F
> > +#define AS3935_AFE_PWR_BIT   (1<<0)
> > +
> > +#define AS3935_INT           0x03
> > +#define AS3935_INT_MASK              0x07
> > +#define AS3935_EVENT_INT     (1<<3)
> > +#define AS3935_NOISE_INT     (1<<0)
>
> you could use BIT(3), BIT(0) etc.
>
> > +
> > +#define AS3935_DATA          0x07
> > +#define AS3935_DATA_MASK     0x1F
> > +
> > +#define AS3935_TUNE_CAP              0x08
> > +#define AS3935_CALIBRATE     0x3D
> > +
> > +#define AS3935_WRITE_DATA    (0x1 << 15)
> > +#define AS3935_READ_DATA     (0x1 << 14)
> > +#define AS3935_ADDRESS(x)    (x << 8)
> > +
> > +struct as3935_state {
> > +     struct spi_device *spi;
> > +     struct iio_trigger *trig;
> > +     struct mutex lock;
> > +     struct delayed_work work;
> > +
> > +     u8 tune_cap;
> > +};
> > +
> > +static const struct iio_chan_spec as3935_channels[] = {
> > +     {
> > +             .type           = IIO_DISTANCE,
> > +             .info_mask_separate =
> > +                     BIT(IIO_CHAN_INFO_RAW),
> > +             .scan_index     = 0,
> > +             .scan_type = {
> > +                     .sign           = 'u',
> > +                     .realbits       = 8,
>
> realbits should be 6
> DATA_MASK should be 0x3f, not 0x1f
>

Fixed in next spin.


>
> > +                     .storagebits    = 8,
> > +             },
> > +     },
> > +     IIO_CHAN_SOFT_TIMESTAMP(1),
> > +};
> > +
> > +static int as3935_read(struct as3935_state *st, unsigned int reg, int
> *val)
> > +{
> > +     u8 tx, rx;
> > +     int ret;
> > +
> > +     struct spi_transfer xfers[] = {
> > +             {
> > +                     .tx_buf = &tx,
> > +                     .bits_per_word = 8,
> > +                     .len = 1,
> > +             }, {
> > +                     .rx_buf = &rx,
> > +                     .bits_per_word = 8,
> > +                     .len = 1,
> > +             },
> > +     };
> > +     tx = (AS3935_READ_DATA | AS3935_ADDRESS(reg)) >> 8;
> > +
> > +     ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> > +     *val = rx;
> > +
> > +     return ret;
> > +};
> > +
> > +static int as3935_write(struct as3935_state *st,
> > +                             unsigned int reg,
> > +                             unsigned int val)
> > +{
> > +     u8 buf[2];
> > +
> > +     buf[0] = AS3935_WRITE_DATA | AS3935_ADDRESS(reg) >> 8;
> > +     buf[1] = val;
> > +
> > +     return spi_write(st->spi, (u8 *) &buf, 2);
> > +};
> > +
> > +static ssize_t as3935_gain_boost_show(struct device *dev,
> > +                             struct device_attribute *attr,
> > +                             char *buf)
> > +{
> > +     struct as3935_state *st = iio_priv(dev_to_iio_dev(dev));
> > +     int val, ret;
> > +
> > +     ret = as3935_read(st, AS3935_AFE_GAIN, &val);
> > +     if (ret)
> > +             return ret;
> > +     val = (val & AS3935_AFE_MASK) >> 1;
> > +
> > +     return sprintf(buf, "%d\n", val);
> > +};
> > +
> > +static ssize_t as3935_gain_boost_store(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     const char *buf, size_t len)
> > +{
> > +     struct as3935_state *st = iio_priv(dev_to_iio_dev(dev));
> > +     unsigned long val;
> > +     int ret;
> > +
> > +     ret = kstrtoul((const char *) buf, 10, &val);
> > +     if (ret)
> > +             return -EINVAL;
> > +
> > +     if (val > AS3935_AFE_GAIN_MAX)
> > +             return -EINVAL;
> > +
> > +     as3935_write(st, AS3935_AFE_GAIN, val << 1);
> > +
> > +     return len;
> > +};
> > +
> > +static IIO_DEVICE_ATTR(gain_boost, S_IRUGO | S_IWUSR,
> > +     as3935_gain_boost_show, as3935_gain_boost_store, 0);
> > +
> > +
> > +static struct attribute *as3935_attributes[] = {
> > +     &iio_dev_attr_gain_boost.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group as3935_attribute_group = {
> > +     .attrs = as3935_attributes,
> > +};
> > +
> > +static int as3935_read_raw(struct iio_dev *indio_dev,
> > +                        struct iio_chan_spec const *chan,
> > +                        int *val,
> > +                        int *val2,
> > +                        long m)
> > +{
> > +     struct as3935_state *st = iio_priv(indio_dev);
> > +     int ret;
> > +
> > +     if (m != IIO_CHAN_INFO_RAW)
> > +             return -EINVAL;
> > +
> > +     *val2 = 0;
> > +     ret = as3935_read(st, AS3935_DATA, val);
> > +     if (ret)
> > +             return ret;
> > +     return IIO_VAL_INT;
> > +}
> > +
> > +static const struct iio_info as3935_info = {
> > +     .driver_module = THIS_MODULE,
> > +     .attrs = &as3935_attribute_group,
> > +     .read_raw = &as3935_read_raw,
> > +};
> > +
> > +static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_ops
> = {
> > +     .postenable = &iio_triggered_buffer_postenable,
> > +     .predisable = &iio_triggered_buffer_predisable,
> > +};
> > +
> > +static irqreturn_t as3935_trigger_handler(int irq, void *private)
> > +{
> > +     struct iio_poll_func *pf = private;
> > +     struct iio_dev *indio_dev = pf->indio_dev;
> > +     struct as3935_state *st = iio_priv(indio_dev);
> > +     int val, ret;
> > +
> > +     ret = as3935_read(st, AS3935_DATA, &val);
> > +     if (ret)
> > +             goto err_read;
> > +     val &= AS3935_DATA_MASK;
> > +     iio_push_to_buffers_with_timestamp(indio_dev, &val,
> iio_get_time_ns());
> > +err_read:
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +};
> > +
> > +static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
> > +     .owner = THIS_MODULE,
> > +};
> > +
> > +static void as3935_event_work(struct work_struct *work)
> > +{
> > +     struct as3935_state *st;
> > +     struct spi_device *spi;
> > +     int val;
> > +
> > +     st = container_of(work, struct as3935_state, work.work);
> > +     spi = st->spi;
> > +
> > +     as3935_read(st, AS3935_INT, &val);
> > +     val &= AS3935_INT_MASK;
> > +
> > +     switch (val) {
> > +     case AS3935_EVENT_INT:
> > +             iio_trigger_poll(st->trig, 0);
> > +             break;
> > +     case AS3935_NOISE_INT:
> > +             dev_warn(&spi->dev, "noise level is too high");
> > +             break;
> > +     }
> > +};
> > +
> > +static irqreturn_t as3935_interrupt_handler(int irq, void *private)
> > +{
> > +     struct iio_dev *indio_dev = private;
> > +     struct as3935_state *st = iio_priv(indio_dev);
> > +
> > +     cancel_delayed_work(&st->work);
> > +     schedule_delayed_work(&st->work, jiffies_to_msecs(3));
> > +     return IRQ_HANDLED;
> > +}
> > +
> > +static void calibrate_as3935(struct as3935_state *st)
> > +{
> > +     mutex_lock(&st->lock);
> > +
> > +     /* mask disturber interrupt bit */
> > +     as3935_write(st, AS3935_INT, 1 << 5);
> > +
> > +     as3935_write(st, AS3935_CALIBRATE, 0x96);
> > +     as3935_write(st, AS3935_TUNE_CAP, 1 << 5 | st->tune_cap);
> > +
> > +     mdelay(2);
> > +     as3935_write(st, AS3935_TUNE_CAP, st->tune_cap);
> > +
> > +     mutex_unlock(&st->lock);
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +static int as3935_suspend(struct spi_device *spi, pm_message_t msg)
> > +{
> > +     struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +     struct as3935_state *st = iio_priv(indio_dev);
> > +     int val, ret;
> > +
> > +     mutex_lock(&st->lock);
> > +     ret = as3935_read(st, AS3935_AFE_GAIN, &val);
> > +     if (ret)
> > +             return ret;
> > +     val |= AS3935_AFE_PWR_BIT;
> > +
> > +     ret = as3935_write(st, AS3935_AFE_GAIN, val);
> > +     mutex_unlock(&st->lock);
> > +     return ret;
> > +}
> > +
> > +static int as3935_resume(struct spi_device *spi)
> > +{
> > +     struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +     struct as3935_state *st = iio_priv(indio_dev);
> > +     int val, ret;
> > +
> > +     mutex_lock(&st->lock);
> > +     ret = as3935_read(st, AS3935_AFE_GAIN, &val);
> > +     if (ret)
> > +             return ret;
> > +     val &= ~AS3935_AFE_PWR_BIT;
> > +     ret = as3935_write(st, AS3935_AFE_GAIN, val);
> > +     mutex_unlock(&st->lock);
> > +     return ret;
> > +}
> > +#else
> > +#define as3935_suspend       NULL
> > +#define as3935_resume        NULL
> > +#endif
> > +
> > +static int as3935_probe(struct spi_device *spi)
> > +{
> > +     struct iio_dev *indio_dev;
> > +     struct iio_trigger *trig;
> > +     struct as3935_state *st;
> > +     struct device_node *np = spi->dev.of_node;
> > +     int ret;
> > +
> > +     /* Be sure lightning event interrupt */
> > +     if (!spi->irq) {
> > +             dev_err(&spi->dev, "unable to get event interrupt\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(st));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +
> > +     st = iio_priv(indio_dev);
> > +     st->spi = spi;
> > +     st->tune_cap = 0;
> > +
> > +     spi_set_drvdata(spi, indio_dev);
> > +     mutex_init(&st->lock);
> > +     INIT_DELAYED_WORK(&st->work, as3935_event_work);
> > +
> > +     ret = of_property_read_u8(np, "ams,tune-cap", &st->tune_cap);
> > +     if (ret) {
> > +             st->tune_cap = 0;
> > +             dev_warn(&spi->dev,
> > +                     "no tune-cap set, defaulting to %d", st->tune_cap);
> > +     }
> > +
> > +     if (st->tune_cap > 15) {
> > +             dev_err(&spi->dev,
> > +                     "wrong tune-cap setting of %d\n", st->tune_cap);
> > +             return -EINVAL;
> > +     }
> > +
> > +     indio_dev->dev.parent = &spi->dev;
> > +     indio_dev->name = spi_get_device_id(spi)->name;
> > +     indio_dev->channels = as3935_channels;
> > +     indio_dev->num_channels = ARRAY_SIZE(as3935_channels);
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > +     indio_dev->info = &as3935_info;
> > +
> > +     trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d",
> > +                                   indio_dev->name, indio_dev->id);
> > +
> > +     if (!trig)
> > +             return -ENOMEM;
> > +
> > +     st->trig = trig;
> > +     trig->dev.parent = indio_dev->dev.parent;
> > +     iio_trigger_set_drvdata(trig, indio_dev);
> > +     trig->ops = &iio_interrupt_trigger_ops;
> > +
> > +     ret = iio_trigger_register(trig);
> > +     if (ret) {
> > +             dev_err(&spi->dev, "failed to register trigger\n");
> > +             return ret;
> > +     }
> > +
> > +     ret = iio_triggered_buffer_setup(indio_dev, NULL,
> > +                                     &as3935_trigger_handler,
> > +                                     &iio_triggered_buffer_setup_ops);
> > +
> > +     if (ret) {
> > +             dev_err(&spi->dev, "cannot setup iio trigger\n");
> > +             goto unregister_trigger;
> > +     }
> > +
> > +     calibrate_as3935(st);
> > +
> > +     ret = devm_request_irq(&spi->dev, spi->irq,
> > +                             &as3935_interrupt_handler,
> > +                             IRQF_TRIGGER_RISING,
> > +                             dev_name(&spi->dev),
> > +                             indio_dev);
> > +
> > +     if (ret) {
> > +             dev_err(&spi->dev, "unable to request irq\n");
> > +             goto unregister_trigger;
> > +     }
> > +
> > +     ret = iio_device_register(indio_dev);
> > +     if (ret < 0) {
> > +             dev_err(&spi->dev, "unable to register device\n");
> > +             goto unregister_trigger;
> > +     }
> > +
> > +     return 0;
> > +
> > +unregister_trigger:
> > +     iio_trigger_unregister(st->trig);
> > +     iio_triggered_buffer_cleanup(indio_dev);
> > +
> > +     return ret;
> > +};
> > +
> > +static int as3935_remove(struct spi_device *spi)
> > +{
> > +     struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > +     struct as3935_state *st = iio_priv(indio_dev);
> > +
> > +     iio_trigger_unregister(st->trig);
> > +     iio_triggered_buffer_cleanup(indio_dev);
> > +     iio_device_unregister(indio_dev);
> > +
> > +     return 0;
> > +};
> > +
> > +static const struct spi_device_id as3935_id[] = {
> > +     {"as3935", 0},
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(spi, as3935_id);
> > +
> > +static struct spi_driver as3935_driver = {
> > +     .driver = {
> > +             .name   = "as3935",
> > +             .owner  = THIS_MODULE,
> > +     },
> > +     .probe          = as3935_probe,
> > +     .remove         = as3935_remove,
> > +     .id_table       = as3935_id,
> > +     .suspend        = as3935_suspend,
> > +     .resume         = as3935_resume,
> > +};
> > +module_spi_driver(as3935_driver);
> > +
> > +MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
> > +MODULE_DESCRIPTION("AS3935 lightning sensor");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("spi:as3935");
> >
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
>

--089e0149ce3c8a419904f18cb302
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><br><div class=3D"gmail_quo=
te">On Mon, Feb 3, 2014 at 2:10 AM, Peter Meerwald <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:pmeerw@pmeerw.net" target=3D"_blank">pmeerw@pmeerw.net</a>&=
gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hello,<br>
<div class=3D"im"><br>
&gt; AS3935 chipset can detect lightning strikes and reports those back as<=
br>
&gt; events and the estimated distance to the storm.<br>
<br>
</div>couple of more comments:<br>
<br>
the AS3935 seems to support I2C and SPI, the driver supports SPI only;<br>
this should be noted somewhere<br>
<br></blockquote><div>Where is that best noted? Kconfig message and/or in t=
he code?</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
IIO already has a proximity channel which is somewhat similar;<br>
unfortunately, proximity is not really documented in sysfs-bus-iio<br>
(proximity seems to be unit-less so far)<br>
<br>
you propose to add a distance channel with unit of kilometers (which<br>
happens to make sense for the as3935 driver); probably distance should be<b=
r>
meters, not kilometers<br>
<br>
sorry to bring this up so late: but what is the argument to have distance<b=
r>
and not re-use proximity?<br></blockquote><div><br></div><div>None really. =
IIO_PROXIMITY should that me in kilometers or better in meters? I suspect t=
he latter.</div><div>=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

<br>
some more comments inline below; you have only tested with nearby<br>
lightning? :)<br>
<br></blockquote><div>Ah yes would have had some interesting results in the=
 summer months :)=A0</div><div>Since it is winter I kinda have to hack a te=
st together...</div><div>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

p.<br>
<div><div class=3D"h5"><br>
&gt; ---<br>
&gt; =A0.../ABI/testing/sysfs-bus-iio-distance-as3935 =A0 =A0 =A0| =A019 +<=
br>
&gt; =A0drivers/iio/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0| =A0 1 +<br>
&gt; =A0drivers/iio/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 | =A0 1 +<br>
&gt; =A0drivers/iio/distance/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | =A019 +<br>
&gt; =A0drivers/iio/distance/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 6 +<br>
&gt; =A0drivers/iio/distance/as3935.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| 438 +++++++++++++++++++++<br>
&gt; =A06 files changed, 484 insertions(+)<br>
&gt; =A0create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-distance=
-as3935<br>
&gt; =A0create mode 100644 drivers/iio/distance/Kconfig<br>
&gt; =A0create mode 100644 drivers/iio/distance/Makefile<br>
&gt; =A0create mode 100644 drivers/iio/distance/as3935.c<br>
&gt;<br>
&gt; diff --git a/Documentation/ABI/testing/sysfs-bus-iio-distance-as3935 b=
/Documentation/ABI/testing/sysfs-bus-iio-distance-as3935<br>
&gt; new file mode 100644<br>
&gt; index 0000000..cf9a67c<br>
&gt; --- /dev/null<br>
&gt; +++ b/Documentation/ABI/testing/sysfs-bus-iio-distance-as3935<br>
&gt; @@ -0,0 +1,19 @@<br>
&gt; +What =A0 =A0 =A0 =A0 /sys/bus/iio/devices/iio:deviceX/in_distance_raw=
<br>
&gt; +Date: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0January 2014<br>
&gt; +KernelVersion: =A0 =A0 =A0 3.15<br>
&gt; +Contact: =A0 =A0 Matt Ranostay &lt;<a href=3D"mailto:mranostay@gmail.=
com">mranostay@gmail.com</a>&gt;<br>
&gt; +Description:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 Get the current distance in kilometers of st=
orm<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 0 =A0 =A0=3D no storm activity<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 1 =A0 =A0=3D storm overhead<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 1-40 =3D distance in kilometers<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 63 =A0 =3D out of range<br>
&gt; +<br>
&gt; +What =A0 =A0 =A0 =A0 /sys/bus/iio/devices/iio:deviceX/gain_boost<br>
&gt; +Date: =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0January 2014<br>
&gt; +KernelVersion: =A0 =A0 =A0 3.15<br>
&gt; +Contact: =A0 =A0 Matt Ranostay &lt;<a href=3D"mailto:mranostay@gmail.=
com">mranostay@gmail.com</a>&gt;<br>
&gt; +Description:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 Show or set the gain boost of the amp, from =
0-31 range.<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 18 =3D indoors (default)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 14 =3D outdoors<br>
&gt; diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig<br>
&gt; index 5dd0e12..5164a68 100644<br>
&gt; --- a/drivers/iio/Kconfig<br>
&gt; +++ b/drivers/iio/Kconfig<br>
&gt; @@ -63,6 +63,7 @@ source &quot;drivers/iio/adc/Kconfig&quot;<br>
&gt; =A0source &quot;drivers/iio/amplifiers/Kconfig&quot;<br>
&gt; =A0source &quot;drivers/iio/common/Kconfig&quot;<br>
&gt; =A0source &quot;drivers/iio/dac/Kconfig&quot;<br>
&gt; +source &quot;drivers/iio/distance/Kconfig&quot;<br>
&gt; =A0source &quot;drivers/iio/frequency/Kconfig&quot;<br>
&gt; =A0source &quot;drivers/iio/gyro/Kconfig&quot;<br>
&gt; =A0source &quot;drivers/iio/humidity/Kconfig&quot;<br>
&gt; diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile<br>
&gt; index 887d390..1574731 100644<br>
&gt; --- a/drivers/iio/Makefile<br>
&gt; +++ b/drivers/iio/Makefile<br>
&gt; @@ -16,6 +16,7 @@ obj-y +=3D adc/<br>
&gt; =A0obj-y +=3D amplifiers/<br>
&gt; =A0obj-y +=3D common/<br>
&gt; =A0obj-y +=3D dac/<br>
&gt; +obj-y +=3D distance/<br>
&gt; =A0obj-y +=3D gyro/<br>
&gt; =A0obj-y +=3D frequency/<br>
&gt; =A0obj-y +=3D humidity/<br>
&gt; diff --git a/drivers/iio/distance/Kconfig b/drivers/iio/distance/Kconf=
ig<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8a2404c<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/distance/Kconfig<br>
&gt; @@ -0,0 +1,19 @@<br>
&gt; +#<br>
&gt; +# Distance sensors<br>
&gt; +#<br>
&gt; +<br>
&gt; +menu &quot;Lightning sensors&quot;<br>
&gt; +<br>
&gt; +config AS3935<br>
&gt; + =A0 =A0 tristate &quot;AS3935 Franklin lightning sensor&quot;<br>
&gt; + =A0 =A0 select IIO_BUFFER<br>
&gt; + =A0 =A0 select IIO_TRIGGERED_BUFFER<br>
&gt; + =A0 =A0 depends on SPI<br>
&gt; + =A0 =A0 help<br>
&gt; + =A0 =A0 =A0If you say yes here you get support for the Austrian Micr=
osystems<br>
&gt; + =A0 =A0 =A0AS3935 lightning detection sensor.<br>
&gt; +<br>
&gt; + =A0 =A0 =A0This driver can also be built as a module. If so, the mod=
ule<br>
&gt; + =A0 =A0 =A0will be called as3935.<br>
&gt; +<br>
&gt; +endmenu<br>
&gt; diff --git a/drivers/iio/distance/Makefile b/drivers/iio/distance/Make=
file<br>
&gt; new file mode 100644<br>
&gt; index 0000000..f63b70d<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/distance/Makefile<br>
&gt; @@ -0,0 +1,6 @@<br>
&gt; +#<br>
&gt; +# Makefile for IIO distance sensors<br>
&gt; +#<br>
&gt; +<br>
&gt; +# When adding new entries keep the list in alphabetical order<br>
&gt; +obj-$(CONFIG_AS3935) =A0 =A0 =A0 =A0 +=3D as3935.o<br>
&gt; diff --git a/drivers/iio/distance/as3935.c b/drivers/iio/distance/as39=
35.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..ea00cd1<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/iio/distance/as3935.c<br>
&gt; @@ -0,0 +1,438 @@<br>
&gt; +/*<br>
&gt; + * as3935.c - Support for AS3935 Franklin lightning sensor<br>
&gt; + *<br>
&gt; + * Copyright (C) 2014 Matt Ranostay &lt;<a href=3D"mailto:mranostay@g=
mail.com">mranostay@gmail.com</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License as published =
by<br>
&gt; + * the Free Software Foundation; either version 2 of the License, or<=
br>
&gt; + * (at your option) any later version.<br>
&gt; + *<br>
&gt; + * This program is distributed in the hope that it will be useful,<br=
>
&gt; + * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
&gt; + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the<br>
&gt; + * GNU General Public License for more details.<br>
&gt; + *<br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/module.h&gt;<br>
&gt; +#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/interrupt.h&gt;<br>
&gt; +#include &lt;linux/delay.h&gt;<br>
&gt; +#include &lt;linux/workqueue.h&gt;<br>
&gt; +#include &lt;linux/mutex.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +#include &lt;linux/irq.h&gt;<br>
&gt; +#include &lt;linux/gpio.h&gt;<br>
&gt; +#include &lt;linux/spi/spi.h&gt;<br>
&gt; +#include &lt;linux/iio/iio.h&gt;<br>
&gt; +#include &lt;linux/iio/sysfs.h&gt;<br>
&gt; +#include &lt;linux/iio/trigger.h&gt;<br>
&gt; +#include &lt;linux/iio/trigger_consumer.h&gt;<br>
&gt; +#include &lt;linux/iio/buffer.h&gt;<br>
&gt; +#include &lt;linux/iio/triggered_buffer.h&gt;<br>
&gt; +#include &lt;linux/pm_runtime.h&gt;<br>
&gt; +#include &lt;linux/of_gpio.h&gt;<br>
&gt; +<br>
&gt; +<br>
&gt; +#define AS3935_AFE_GAIN =A0 =A0 =A0 =A0 =A0 =A0 =A00x00<br>
&gt; +#define AS3935_AFE_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A00x3F<br>
&gt; +#define AS3935_AFE_GAIN_MAX =A00x1F<br>
&gt; +#define AS3935_AFE_PWR_BIT =A0 (1&lt;&lt;0)<br>
&gt; +<br>
&gt; +#define AS3935_INT =A0 =A0 =A0 =A0 =A0 0x03<br>
&gt; +#define AS3935_INT_MASK =A0 =A0 =A0 =A0 =A0 =A0 =A00x07<br>
&gt; +#define AS3935_EVENT_INT =A0 =A0 (1&lt;&lt;3)<br>
&gt; +#define AS3935_NOISE_INT =A0 =A0 (1&lt;&lt;0)<br>
<br>
</div></div>you could use BIT(3), BIT(0) etc.<br>
<div><div class=3D"h5"><br>
&gt; +<br>
&gt; +#define AS3935_DATA =A0 =A0 =A0 =A0 =A00x07<br>
&gt; +#define AS3935_DATA_MASK =A0 =A0 0x1F<br>
&gt; +<br>
&gt; +#define AS3935_TUNE_CAP =A0 =A0 =A0 =A0 =A0 =A0 =A00x08<br>
&gt; +#define AS3935_CALIBRATE =A0 =A0 0x3D<br>
&gt; +<br>
&gt; +#define AS3935_WRITE_DATA =A0 =A0(0x1 &lt;&lt; 15)<br>
&gt; +#define AS3935_READ_DATA =A0 =A0 (0x1 &lt;&lt; 14)<br>
&gt; +#define AS3935_ADDRESS(x) =A0 =A0(x &lt;&lt; 8)<br>
&gt; +<br>
&gt; +struct as3935_state {<br>
&gt; + =A0 =A0 struct spi_device *spi;<br>
&gt; + =A0 =A0 struct iio_trigger *trig;<br>
&gt; + =A0 =A0 struct mutex lock;<br>
&gt; + =A0 =A0 struct delayed_work work;<br>
&gt; +<br>
&gt; + =A0 =A0 u8 tune_cap;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_chan_spec as3935_channels[] =3D {<br>
&gt; + =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D IIO_DISTANCE,<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .info_mask_separate =3D<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BIT(IIO_CHAN_INFO_RAW),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .scan_index =A0 =A0 =3D 0,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .scan_type =3D {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sign =A0 =A0 =A0 =A0 =A0 =
=3D &#39;u&#39;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .realbits =A0 =A0 =A0 =3D 8,=
<br>
<br>
</div></div>realbits should be 6<br>
DATA_MASK should be 0x3f, not 0x1f<br></blockquote><div><br></div><div>Fixe=
d in next spin.</div><div>=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .storagebits =A0 =A0=3D 8,<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 },<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 IIO_CHAN_SOFT_TIMESTAMP(1),<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int as3935_read(struct as3935_state *st, unsigned int reg, int=
 *val)<br>
&gt; +{<br>
&gt; + =A0 =A0 u8 tx, rx;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 struct spi_transfer xfers[] =3D {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .tx_buf =3D &amp;tx,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bits_per_word =3D 8,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 1,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }, {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .rx_buf =3D &amp;rx,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .bits_per_word =3D 8,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .len =3D 1,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 },<br>
&gt; + =A0 =A0 };<br>
&gt; + =A0 =A0 tx =3D (AS3935_READ_DATA | AS3935_ADDRESS(reg)) &gt;&gt; 8;<=
br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D spi_sync_transfer(st-&gt;spi, xfers, ARRAY_SIZE(xfer=
s));<br>
&gt; + =A0 =A0 *val =3D rx;<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int as3935_write(struct as3935_state *st,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int=
 reg,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int=
 val)<br>
&gt; +{<br>
&gt; + =A0 =A0 u8 buf[2];<br>
&gt; +<br>
&gt; + =A0 =A0 buf[0] =3D AS3935_WRITE_DATA | AS3935_ADDRESS(reg) &gt;&gt; =
8;<br>
&gt; + =A0 =A0 buf[1] =3D val;<br>
&gt; +<br>
&gt; + =A0 =A0 return spi_write(st-&gt;spi, (u8 *) &amp;buf, 2);<br>
&gt; +};<br>
&gt; +<br>
&gt; +static ssize_t as3935_gain_boost_show(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devic=
e_attribute *attr,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)<b=
r>
&gt; +{<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(dev_to_iio_dev(dev));<b=
r>
&gt; + =A0 =A0 int val, ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D as3935_read(st, AS3935_AFE_GAIN, &amp;val);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 val =3D (val &amp; AS3935_AFE_MASK) &gt;&gt; 1;<br>
&gt; +<br>
&gt; + =A0 =A0 return sprintf(buf, &quot;%d\n&quot;, val);<br>
&gt; +};<br>
&gt; +<br>
&gt; +static ssize_t as3935_gain_boost_store(struct device *dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 struct device_attribute *attr,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 const char *buf, size_t len)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(dev_to_iio_dev(dev));<b=
r>
&gt; + =A0 =A0 unsigned long val;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D kstrtoul((const char *) buf, 10, &amp;val);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 if (val &gt; AS3935_AFE_GAIN_MAX)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 as3935_write(st, AS3935_AFE_GAIN, val &lt;&lt; 1);<br>
&gt; +<br>
&gt; + =A0 =A0 return len;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static IIO_DEVICE_ATTR(gain_boost, S_IRUGO | S_IWUSR,<br>
&gt; + =A0 =A0 as3935_gain_boost_show, as3935_gain_boost_store, 0);<br>
&gt; +<br>
&gt; +<br>
&gt; +static struct attribute *as3935_attributes[] =3D {<br>
&gt; + =A0 =A0 &amp;iio_dev_attr_gain_boost.dev_attr.attr,<br>
&gt; + =A0 =A0 NULL,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static struct attribute_group as3935_attribute_group =3D {<br>
&gt; + =A0 =A0 .attrs =3D as3935_attributes,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int as3935_read_raw(struct iio_dev *indio_dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct iio_chan_spec =
const *chan,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *val,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int *val2,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0long m)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(indio_dev);<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 if (m !=3D IIO_CHAN_INFO_RAW)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 *val2 =3D 0;<br>
&gt; + =A0 =A0 ret =3D as3935_read(st, AS3935_DATA, val);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 return IIO_VAL_INT;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static const struct iio_info as3935_info =3D {<br>
&gt; + =A0 =A0 .driver_module =3D THIS_MODULE,<br>
&gt; + =A0 =A0 .attrs =3D &amp;as3935_attribute_group,<br>
&gt; + =A0 =A0 .read_raw =3D &amp;as3935_read_raw,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_buffer_setup_ops iio_triggered_buffer_setup_o=
ps =3D {<br>
&gt; + =A0 =A0 .postenable =3D &amp;iio_triggered_buffer_postenable,<br>
&gt; + =A0 =A0 .predisable =3D &amp;iio_triggered_buffer_predisable,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static irqreturn_t as3935_trigger_handler(int irq, void *private)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_poll_func *pf =3D private;<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D pf-&gt;indio_dev;<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(indio_dev);<br>
&gt; + =A0 =A0 int val, ret;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D as3935_read(st, AS3935_DATA, &amp;val);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto err_read;<br>
&gt; + =A0 =A0 val &amp;=3D AS3935_DATA_MASK;<br>
&gt; + =A0 =A0 iio_push_to_buffers_with_timestamp(indio_dev, &amp;val, iio_=
get_time_ns());<br>
&gt; +err_read:<br>
&gt; + =A0 =A0 iio_trigger_notify_done(indio_dev-&gt;trig);<br>
&gt; +<br>
&gt; + =A0 =A0 return IRQ_HANDLED;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct iio_trigger_ops iio_interrupt_trigger_ops =3D {<b=
r>
&gt; + =A0 =A0 .owner =3D THIS_MODULE,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void as3935_event_work(struct work_struct *work)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct as3935_state *st;<br>
&gt; + =A0 =A0 struct spi_device *spi;<br>
&gt; + =A0 =A0 int val;<br>
&gt; +<br>
&gt; + =A0 =A0 st =3D container_of(work, struct as3935_state, work.work);<b=
r>
&gt; + =A0 =A0 spi =3D st-&gt;spi;<br>
&gt; +<br>
&gt; + =A0 =A0 as3935_read(st, AS3935_INT, &amp;val);<br>
&gt; + =A0 =A0 val &amp;=3D AS3935_INT_MASK;<br>
&gt; +<br>
&gt; + =A0 =A0 switch (val) {<br>
&gt; + =A0 =A0 case AS3935_EVENT_INT:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 iio_trigger_poll(st-&gt;trig, 0);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 case AS3935_NOISE_INT:<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&amp;spi-&gt;dev, &quot;noise level=
 is too high&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt; + =A0 =A0 }<br>
&gt; +};<br>
&gt; +<br>
&gt; +static irqreturn_t as3935_interrupt_handler(int irq, void *private)<b=
r>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D private;<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(indio_dev);<br>
&gt; +<br>
&gt; + =A0 =A0 cancel_delayed_work(&amp;st-&gt;work);<br>
&gt; + =A0 =A0 schedule_delayed_work(&amp;st-&gt;work, jiffies_to_msecs(3))=
;<br>
&gt; + =A0 =A0 return IRQ_HANDLED;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void calibrate_as3935(struct as3935_state *st)<br>
&gt; +{<br>
&gt; + =A0 =A0 mutex_lock(&amp;st-&gt;lock);<br>
&gt; +<br>
&gt; + =A0 =A0 /* mask disturber interrupt bit */<br>
&gt; + =A0 =A0 as3935_write(st, AS3935_INT, 1 &lt;&lt; 5);<br>
&gt; +<br>
&gt; + =A0 =A0 as3935_write(st, AS3935_CALIBRATE, 0x96);<br>
&gt; + =A0 =A0 as3935_write(st, AS3935_TUNE_CAP, 1 &lt;&lt; 5 | st-&gt;tune=
_cap);<br>
&gt; +<br>
&gt; + =A0 =A0 mdelay(2);<br>
&gt; + =A0 =A0 as3935_write(st, AS3935_TUNE_CAP, st-&gt;tune_cap);<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_unlock(&amp;st-&gt;lock);<br>
&gt; +}<br>
&gt; +<br>
&gt; +#ifdef CONFIG_PM_SLEEP<br>
&gt; +static int as3935_suspend(struct spi_device *spi, pm_message_t msg)<b=
r>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D spi_get_drvdata(spi);<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(indio_dev);<br>
&gt; + =A0 =A0 int val, ret;<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_lock(&amp;st-&gt;lock);<br>
&gt; + =A0 =A0 ret =3D as3935_read(st, AS3935_AFE_GAIN, &amp;val);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 val |=3D AS3935_AFE_PWR_BIT;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D as3935_write(st, AS3935_AFE_GAIN, val);<br>
&gt; + =A0 =A0 mutex_unlock(&amp;st-&gt;lock);<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int as3935_resume(struct spi_device *spi)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D spi_get_drvdata(spi);<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(indio_dev);<br>
&gt; + =A0 =A0 int val, ret;<br>
&gt; +<br>
&gt; + =A0 =A0 mutex_lock(&amp;st-&gt;lock);<br>
&gt; + =A0 =A0 ret =3D as3935_read(st, AS3935_AFE_GAIN, &amp;val);<br>
&gt; + =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 val &amp;=3D ~AS3935_AFE_PWR_BIT;<br>
&gt; + =A0 =A0 ret =3D as3935_write(st, AS3935_AFE_GAIN, val);<br>
&gt; + =A0 =A0 mutex_unlock(&amp;st-&gt;lock);<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +#else<br>
&gt; +#define as3935_suspend =A0 =A0 =A0 NULL<br>
&gt; +#define as3935_resume =A0 =A0 =A0 =A0NULL<br>
&gt; +#endif<br>
&gt; +<br>
&gt; +static int as3935_probe(struct spi_device *spi)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev;<br>
&gt; + =A0 =A0 struct iio_trigger *trig;<br>
&gt; + =A0 =A0 struct as3935_state *st;<br>
&gt; + =A0 =A0 struct device_node *np =3D spi-&gt;dev.of_node;<br>
&gt; + =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 /* Be sure lightning event interrupt */<br>
&gt; + =A0 =A0 if (!spi-&gt;irq) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev, &quot;unable to ge=
t event interrupt\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 indio_dev =3D devm_iio_device_alloc(&amp;spi-&gt;dev, sizeof=
(st));<br>
&gt; + =A0 =A0 if (!indio_dev)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
&gt; +<br>
&gt; + =A0 =A0 st =3D iio_priv(indio_dev);<br>
&gt; + =A0 =A0 st-&gt;spi =3D spi;<br>
&gt; + =A0 =A0 st-&gt;tune_cap =3D 0;<br>
&gt; +<br>
&gt; + =A0 =A0 spi_set_drvdata(spi, indio_dev);<br>
&gt; + =A0 =A0 mutex_init(&amp;st-&gt;lock);<br>
&gt; + =A0 =A0 INIT_DELAYED_WORK(&amp;st-&gt;work, as3935_event_work);<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D of_property_read_u8(np, &quot;ams,tune-cap&quot;, &a=
mp;st-&gt;tune_cap);<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 st-&gt;tune_cap =3D 0;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&amp;spi-&gt;dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;no tune-cap set, defau=
lting to %d&quot;, st-&gt;tune_cap);<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 if (st-&gt;tune_cap &gt; 15) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;wrong tune-cap setting=
 of %d\n&quot;, st-&gt;tune_cap);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 indio_dev-&gt;dev.parent =3D &amp;spi-&gt;dev;<br>
&gt; + =A0 =A0 indio_dev-&gt;name =3D spi_get_device_id(spi)-&gt;name;<br>
&gt; + =A0 =A0 indio_dev-&gt;channels =3D as3935_channels;<br>
&gt; + =A0 =A0 indio_dev-&gt;num_channels =3D ARRAY_SIZE(as3935_channels);<=
br>
&gt; + =A0 =A0 indio_dev-&gt;modes =3D INDIO_DIRECT_MODE;<br>
&gt; + =A0 =A0 indio_dev-&gt;info =3D &amp;as3935_info;<br>
&gt; +<br>
&gt; + =A0 =A0 trig =3D devm_iio_trigger_alloc(&amp;spi-&gt;dev, &quot;%s-d=
ev%d&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
indio_dev-&gt;name, indio_dev-&gt;id);<br>
&gt; +<br>
&gt; + =A0 =A0 if (!trig)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
&gt; +<br>
&gt; + =A0 =A0 st-&gt;trig =3D trig;<br>
&gt; + =A0 =A0 trig-&gt;dev.parent =3D indio_dev-&gt;dev.parent;<br>
&gt; + =A0 =A0 iio_trigger_set_drvdata(trig, indio_dev);<br>
&gt; + =A0 =A0 trig-&gt;ops =3D &amp;iio_interrupt_trigger_ops;<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D iio_trigger_register(trig);<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev, &quot;failed to re=
gister trigger\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 return ret;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D iio_triggered_buffer_setup(indio_dev, NULL,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &amp;as3935_trigger_handler,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 &amp;iio_triggered_buffer_setup_ops);<br>
&gt; +<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev, &quot;cannot setup=
 iio trigger\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto unregister_trigger;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 calibrate_as3935(st);<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D devm_request_irq(&amp;spi-&gt;dev, spi-&gt;irq,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &amp;as3935_=
interrupt_handler,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 IRQF_TRIGGER=
_RISING,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&am=
p;spi-&gt;dev),<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 indio_dev);<=
br>
&gt; +<br>
&gt; + =A0 =A0 if (ret) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev, &quot;unable to re=
quest irq\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto unregister_trigger;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 ret =3D iio_device_register(indio_dev);<br>
&gt; + =A0 =A0 if (ret &lt; 0) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;spi-&gt;dev, &quot;unable to re=
gister device\n&quot;);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 goto unregister_trigger;<br>
&gt; + =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +<br>
&gt; +unregister_trigger:<br>
&gt; + =A0 =A0 iio_trigger_unregister(st-&gt;trig);<br>
&gt; + =A0 =A0 iio_triggered_buffer_cleanup(indio_dev);<br>
&gt; +<br>
&gt; + =A0 =A0 return ret;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static int as3935_remove(struct spi_device *spi)<br>
&gt; +{<br>
&gt; + =A0 =A0 struct iio_dev *indio_dev =3D spi_get_drvdata(spi);<br>
&gt; + =A0 =A0 struct as3935_state *st =3D iio_priv(indio_dev);<br>
&gt; +<br>
&gt; + =A0 =A0 iio_trigger_unregister(st-&gt;trig);<br>
&gt; + =A0 =A0 iio_triggered_buffer_cleanup(indio_dev);<br>
&gt; + =A0 =A0 iio_device_unregister(indio_dev);<br>
&gt; +<br>
&gt; + =A0 =A0 return 0;<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct spi_device_id as3935_id[] =3D {<br>
&gt; + =A0 =A0 {&quot;as3935&quot;, 0},<br>
&gt; + =A0 =A0 {},<br>
&gt; +};<br>
&gt; +MODULE_DEVICE_TABLE(spi, as3935_id);<br>
&gt; +<br>
&gt; +static struct spi_driver as3935_driver =3D {<br>
&gt; + =A0 =A0 .driver =3D {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D &quot;as3935&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,<br>
&gt; + =A0 =A0 },<br>
&gt; + =A0 =A0 .probe =A0 =A0 =A0 =A0 =A0=3D as3935_probe,<br>
&gt; + =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D as3935_remove,<br>
&gt; + =A0 =A0 .id_table =A0 =A0 =A0 =3D as3935_id,<br>
&gt; + =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D as3935_suspend,<br>
&gt; + =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D as3935_resume,<br>
&gt; +};<br>
&gt; +module_spi_driver(as3935_driver);<br>
&gt; +<br>
&gt; +MODULE_AUTHOR(&quot;Matt Ranostay &lt;<a href=3D"mailto:mranostay@gma=
il.com">mranostay@gmail.com</a>&gt;&quot;);<br>
&gt; +MODULE_DESCRIPTION(&quot;AS3935 lightning sensor&quot;);<br>
&gt; +MODULE_LICENSE(&quot;GPL&quot;);<br>
&gt; +MODULE_ALIAS(&quot;spi:as3935&quot;);<br>
&gt;<br>
<br>
--<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">Peter Meerwald<b=
r>
<a href=3D"tel:%2B43-664-2444418" value=3D"+436642444418">+43-664-2444418</=
a>=A0(mobile)<br>
</font></span></blockquote></div><br></div></div>

--089e0149ce3c8a419904f18cb302--
