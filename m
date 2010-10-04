Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "greg@kroah.com"
	<greg@kroah.com>
Date: Mon, 4 Oct 2010 09:35:11 +0100
Subject: RE: [PATCH 1/2] staging: iio: adc: Enable driver support for ad799x
 AD converters
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712F0DB8A7A6@LIMKCMBX1.ad.analog.com>
References: <1285944112-25769-1-git-send-email-michael.hennerich@analog.com>
 <0680EC522D0CC943BC586913CF3768C003FF3B288D@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C003FF3B288D@dbde02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> From: Datta, Shubhrajyoti [mailto:shubhrajyoti@ti.com]
> > -----Original Message-----
> > From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> > owner@vger.kernel.org] On Behalf Of michael.hennerich@analog.com
> > Sent: Friday, October 01, 2010 8:12 PM
> > To: greg@kroah.com
> > Cc: linux-iio@vger.kernel.org; drivers@analog.com; jic23@cam.ac.uk;
> > Michael Hennerich
> > Subject: [PATCH 1/2] staging: iio: adc: Enable driver support for
> ad799x
> > AD converters
> >
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >
> > Driver for ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997 and
> > ad7998 multichannel ADC.
> >
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> > ---
> >  drivers/staging/iio/adc/Kconfig       |   20 +
> >  drivers/staging/iio/adc/Makefile      |    4 +
> >  drivers/staging/iio/adc/ad799x.h      |  157 ++++++
> >  drivers/staging/iio/adc/ad799x_core.c |  918
> > +++++++++++++++++++++++++++++++++
> >  drivers/staging/iio/adc/ad799x_ring.c |  246 +++++++++
> >  5 files changed, 1345 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/staging/iio/adc/ad799x.h
> >  create mode 100644 drivers/staging/iio/adc/ad799x_core.c
> >  create mode 100644 drivers/staging/iio/adc/ad799x_ring.c
> >
> > diff --git a/drivers/staging/iio/adc/Kconfig
> > b/drivers/staging/iio/adc/Kconfig
> > index 0835fbc..3ea4da8 100644
> > --- a/drivers/staging/iio/adc/Kconfig
> > +++ b/drivers/staging/iio/adc/Kconfig
> > @@ -26,3 +26,23 @@ config MAX1363_RING_BUFFER
> >       help
> >         Say yes here to include ring buffer support in the MAX1363
> >         ADC driver.
> > +
> > +config AD799X
> > +     tristate "Analog Devices AD799x ADC driver"
> > +     depends on I2C
> > +     select IIO_TRIGGER if IIO_RING_BUFFER
> > +     select AD799X_RING_BUFFER
> > +     help
> > +       Say yes here to build support for Analog Devices:
> > +       ad7991, ad7995, ad7999, ad7992, ad7993, ad7994, ad7997,
> ad7998
> > +       i2c analog to digital convertors (ADC). Provides direct
> access
> > +       via sysfs.
> > +
> > +config AD799X_RING_BUFFER
> > +     bool "Analog Devices AD799x: use ring buffer"
> > +     depends on AD799X
> > +     select IIO_RING_BUFFER
> > +     select IIO_SW_RING
> > +     help
> > +       Say yes here to include ring buffer support in the AD799X
> > +       ADC driver.
> > diff --git a/drivers/staging/iio/adc/Makefile
> > b/drivers/staging/iio/adc/Makefile
> > index 688510f..f4aa63a 100644
> > --- a/drivers/staging/iio/adc/Makefile
> > +++ b/drivers/staging/iio/adc/Makefile
> > @@ -6,3 +6,7 @@ max1363-y :=3D max1363_core.o
> >  max1363-y +=3D max1363_ring.o
> >
> >  obj-$(CONFIG_MAX1363) +=3D max1363.o
> > +
> > +ad799x-y :=3D ad799x_core.o
> > +ad799x-$(CONFIG_AD799X_RING_BUFFER) +=3D ad799x_ring.o
> > +obj-$(CONFIG_AD799X) +=3D ad799x.o
> > \ No newline at end of file
> > diff --git a/drivers/staging/iio/adc/ad799x.h
> > b/drivers/staging/iio/adc/ad799x.h
> > new file mode 100644
> > index 0000000..73f3ec5
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad799x.h
> > @@ -0,0 +1,157 @@
> > +/*
> > + * Copyright (C) 2010 Michael Hennerich, Analog Devices Inc.
> > + * Copyright (C) 2008-2010 Jonathan Cameron
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * ad799x.h
> > + */
> > +
> > +#ifndef _AD799X_H_
> > +#define  _AD799X_H_
> > +
> > +#define AD799X_CHANNEL_SHIFT                 4
> > +
> > +/*
> > + * AD7991, AD7995 and AD7999 defines
> > + */
> > +
> > +#define AD7991_REF_SEL                               0x08
> > +#define AD7991_FLTR                          0x04
> > +#define AD7991_BIT_TRIAL_DELAY                       0x02
> > +#define AD7991_SAMPLE_DELAY                  0x01
> > +
> > +/*
> > + * AD7992, AD7993, AD7994, AD7997 and AD7998 defines
> > + */
> > +
> > +#define AD7998_FLTR                          0x08
> > +#define AD7998_ALERT_EN                              0x04
> > +#define AD7998_BUSY_ALERT                    0x02
> > +#define AD7998_BUSY_ALERT_POL                        0x01
> > +
> > +#define AD7998_CONV_RES_REG                  0x0
> > +#define AD7998_ALERT_STAT_REG                        0x1
> > +#define AD7998_CONF_REG                              0x2
> > +#define AD7998_CYCLE_TMR_REG                 0x3
> > +#define AD7998_DATALOW_CH1_REG                       0x4
> > +#define AD7998_DATAHIGH_CH1_REG                      0x5
> > +#define AD7998_HYST_CH1_REG                  0x6
> > +#define AD7998_DATALOW_CH2_REG                       0x7
> > +#define AD7998_DATAHIGH_CH2_REG                      0x8
> > +#define AD7998_HYST_CH2_REG                  0x9
> > +#define AD7998_DATALOW_CH3_REG                       0xA
> > +#define AD7998_DATAHIGH_CH3_REG                      0xB
> > +#define AD7998_HYST_CH3_REG                  0xC
> > +#define AD7998_DATALOW_CH4_REG                       0xD
> > +#define AD7998_DATAHIGH_CH4_REG                      0xE
> > +#define AD7998_HYST_CH4_REG                  0xF
> > +
> > +#define AD7998_CYC_MASK                              0x7
> > +#define AD7998_CYC_DIS                               0x0
> > +#define AD7998_CYC_TCONF_32                  0x1
> > +#define AD7998_CYC_TCONF_64                  0x2
> > +#define AD7998_CYC_TCONF_128                 0x3
> > +#define AD7998_CYC_TCONF_256                 0x4
> > +#define AD7998_CYC_TCONF_512                 0x5
> > +#define AD7998_CYC_TCONF_1024                        0x6
> > +#define AD7998_CYC_TCONF_2048                        0x7
> > +
> > +#define AD7998_ALERT_STAT_CLEAR                      0xFF
> > +
> > +/*
> > + * AD7997 and AD7997 defines
> > + */
> > +
> > +#define AD7997_8_READ_SINGLE                 0x80
> > +#define AD7997_8_READ_SEQUENCE                       0x70
> > +
> > +enum {
> > +     ad7991,
> > +     ad7995,
> > +     ad7999,
> > +     ad7992,
> > +     ad7993,
> > +     ad7994,
> > +     ad7997,
> > +     ad7998
> > +};
> > +
> > +struct ad799x_state;
> > +
> > +/**
> > + * struct ad799x_chip_info - chip specifc information
> > + * @num_inputs:              number of physical inputs on chip
> > + * @bits:            accuracy of the adc in bits
> > + * @int_vref_mv:     the internal reference voltage
> > + * @monitor_mode:    whether the chip supports monitor interrupts
> > + * @default_config:  device default configuration
> > + * @dev_attrs:               pointer to the device attribute group
> > + * @scan_attrs:              pointer to the scan element attribute
> group
> > + * @event_attrs:     pointer to the monitor event attribute group
> > + * @ad799x_set_scan_mode: function pointer to the device specific
> mode
> > function
> > +
> > + */
> > +struct ad799x_chip_info {
> > +     u8                              num_inputs;
> > +     u8                              bits;
> > +     u16                             int_vref_mv;
> > +     bool                            monitor_mode;
> > +     u16                             default_config;
> > +     struct attribute_group          *dev_attrs;
> > +     struct attribute_group          *scan_attrs;
> > +     struct attribute_group          *event_attrs;
> > +     int (*ad799x_set_scan_mode)     (struct ad799x_state *st,
> > +                                     unsigned mask);
> > +};
> > +
> > +struct ad799x_state {
> > +     struct iio_dev                  *indio_dev;
> > +     struct i2c_client               *client;
> > +     const struct ad799x_chip_info   *chip_info;
> > +     struct work_struct              poll_work;
> > +     struct work_struct              work_thresh;
> > +     atomic_t                        protect_ring;
> > +     struct iio_trigger              *trig;
> > +     struct regulator                *reg;
> > +     s64                             last_timestamp;
> > +     u16                             int_vref_mv;
> > +     unsigned                        id;
> > +     char                            *name;
> > +     u16                             config;
> > +};
> > +
> > +/*
> > + * TODO: struct ad799x_platform_data needs to go into
> inlude/linux/iio
> > + */
> > +
> > +struct ad799x_platform_data {
> > +     u16                             vref_mv;
> > +};
> > +
> > +int ad799x_set_scan_mode(struct ad799x_state *st, unsigned mask);
> > +
> > +#ifdef CONFIG_AD799X_RING_BUFFER
> > +int ad799x_single_channel_from_ring(struct ad799x_state *st, long
> mask);
> > +int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev);
> > +void ad799x_ring_cleanup(struct iio_dev *indio_dev);
> > +#else /* CONFIG_AD799X_RING_BUFFER */
> > +int ad799x_single_channel_from_ring(struct ad799x_state *st, long
> mask)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> > +
> > +static inline int
> > +ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> > +{
> > +     return 0;
> > +}
> > +
> > +static inline void ad799x_ring_cleanup(struct iio_dev *indio_dev)
> > +{
> > +}
> > +#endif /* CONFIG_AD799X_RING_BUFFER */
> > +#endif /* _AD799X_H_ */
> > diff --git a/drivers/staging/iio/adc/ad799x_core.c
> > b/drivers/staging/iio/adc/ad799x_core.c
> > new file mode 100644
> > index 0000000..772c664
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad799x_core.c
> > @@ -0,0 +1,918 @@
> > +/*
> > + * iio/adc/ad799x.c
> > + * Copyright (C) 2010 Michael Hennerich, Analog Devices Inc.
> > + *
> > + * based on iio/adc/max1363
> > + * Copyright (C) 2008-2010 Jonathan Cameron
> > + *
> > + * based on linux/drivers/i2c/chips/max123x
> > + * Copyright (C) 2002-2004 Stefan Eletzhofer
> > + *
> > + * based on linux/drivers/acron/char/pcf8583.c
> > + * Copyright (C) 2000 Russell King
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * ad799x.c
> > + *
> > + * Support for ad7991, ad7995, ad7999, ad7992, ad7993, ad7994,
> ad7997,
> > + * ad7998 and similar chips.
> > + *
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/list.h>
> > +#include <linux/i2c.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/types.h>
> > +#include <linux/err.h>
> > +
> > +#include "../iio.h"
> > +#include "../sysfs.h"
> > +
> > +#include "../ring_generic.h"
> > +#include "adc.h"
> > +#include "ad799x.h"
> > +
> > +/*
> > + * ad799x register access by I2C
> > + */
> > +static int ad799x_i2c_read16(struct ad799x_state *st, u8 reg, u16
> *data)
> > +{
> > +     struct i2c_client *client =3D st->client;
> > +     int ret =3D 0;
> > +
> > +     ret =3D i2c_smbus_read_word_data(client, reg);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "I2C read error\n");
> > +             return ret;
> > +     }
> > +
> > +     *data =3D swab16((u16)ret);
> > +
> > +     return 0;
> > +}
> > +
> > +static int ad799x_i2c_read8(struct ad799x_state *st, u8 reg, u8
> *data)
> > +{
> > +     struct i2c_client *client =3D st->client;
> > +     int ret =3D 0;
> > +
> > +     ret =3D i2c_smbus_read_word_data(client, reg);
> > +     if (ret < 0) {
> > +             dev_err(&client->dev, "I2C read error\n");
> > +             return ret;
> > +     }
> > +
> > +     *data =3D ret;
> Ret is int and data is a char * . Do you think a type cast would be
> better.

Well - the case where ret may become negative is handled before.
However I should use i2c_smbus_read_byte_data here.
This code works just the same, since the AD799x repeats the last date.
Thanks for pointing out that section.
I'll add the cast.

> > +
> > +     return 0;
> > +}
> > +
> > +static int ad799x_i2c_write16(struct ad799x_state *st, u8 reg, u16
> data)
> > +{
> > +     struct i2c_client *client =3D st->client;
> > +     int ret =3D 0;
> > +
> > +     ret =3D i2c_smbus_write_word_data(client, reg, swab16(data));
> > +     if (ret < 0)
> > +             dev_err(&client->dev, "I2C write error\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static int ad799x_i2c_write8(struct ad799x_state *st, u8 reg, u8
> data)
> > +{
> > +     struct i2c_client *client =3D st->client;
> > +     int ret =3D 0;
> > +
> > +     ret =3D i2c_smbus_write_byte_data(client, reg, data);
> > +     if (ret < 0)
> > +             dev_err(&client->dev, "I2C write error\n");
> > +
> > +     return ret;
> > +}
> > +
> > +static int ad799x_scan_el_set_state(struct iio_scan_el *scan_el,
> > +                                    struct iio_dev *indio_dev,
> > +                                    bool state)
> > +{
> > +     struct ad799x_state *st =3D indio_dev->dev_data;
> > +     return ad799x_set_scan_mode(st, st->indio_dev->ring-
> >scan_mask);
> > +}
> > +
> > +/* Here we claim all are 16 bits. This currently does no harm and
> saves
> > + * us a lot of scan element listings */
> > +
> > +#define AD799X_SCAN_EL(number)
> \
> > +     IIO_SCAN_EL_C(in##number, number, 0, ad799x_scan_el_set_state);
> > +
> > +static AD799X_SCAN_EL(0);
> > +static AD799X_SCAN_EL(1);
> > +static AD799X_SCAN_EL(2);
> > +static AD799X_SCAN_EL(3);
> > +static AD799X_SCAN_EL(4);
> > +static AD799X_SCAN_EL(5);
> > +static AD799X_SCAN_EL(6);
> > +static AD799X_SCAN_EL(7);
> > +
> > +static ssize_t ad799x_show_precision(struct device *dev,
> > +                             struct device_attribute *attr,
> > +                             char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +     return sprintf(buf, "%d\n", st->chip_info->bits);
> > +}
> > +
> > +static IIO_DEVICE_ATTR(in_precision, S_IRUGO, ad799x_show_precision,
> > +                    NULL, 0);
> > +
> > +static int ad7991_5_9_set_scan_mode(struct ad799x_state *st,
> unsigned
> > mask)
> > +{
> > +     return i2c_smbus_write_byte(st->client,
> > +             st->config | (mask << AD799X_CHANNEL_SHIFT));
> > +}
> > +
> > +static int ad7992_3_4_set_scan_mode(struct ad799x_state *st,
> unsigned
> > mask)
> > +{
> > +     return ad799x_i2c_write8(st, AD7998_CONF_REG,
> > +             st->config | (mask << AD799X_CHANNEL_SHIFT));
> > +}
> > +
> > +static int ad7997_8_set_scan_mode(struct ad799x_state *st, unsigned
> mask)
> > +{
> > +     return ad799x_i2c_write16(st, AD7998_CONF_REG,
> > +             st->config | (mask << AD799X_CHANNEL_SHIFT));
> > +}
> > +
> > +int ad799x_set_scan_mode(struct ad799x_state *st, unsigned mask)
> > +{
> > +     int ret;
> > +
> > +     if (st->chip_info->ad799x_set_scan_mode !=3D NULL) {
> > +             ret =3D st->chip_info->ad799x_set_scan_mode(st, mask);
> > +             return (ret > 0) ? 0 : ret;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static ssize_t ad799x_read_single_channel(struct device *dev,
> > +                                struct device_attribute *attr,
> > +                                char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> > +     int ret =3D 0, len =3D 0;
> > +     u32 data ;
> > +     u16 rxbuf[1];
> > +     u8 cmd;
> > +     long mask;
> > +
> > +     mutex_lock(&dev_info->mlock);
> > +     mask =3D 1 << this_attr->address;
> > +     /* If ring buffer capture is occuring, query the buffer */
> > +     if (iio_ring_enabled(dev_info)) {
> > +             data =3D ad799x_single_channel_from_ring(st, mask);
> > +             if (data < 0) {
> > +                     ret =3D data;
> > +                     goto error_ret;
> > +             }
> > +     } else {
> > +             switch (st->id) {
> > +             case ad7991:
> > +             case ad7995:
> > +             case ad7999:
> > +                     cmd =3D st->config | (mask <<
> AD799X_CHANNEL_SHIFT);
> > +                     break;
> > +             case ad7992:
> > +             case ad7993:
> > +             case ad7994:
> > +                     cmd =3D mask << AD799X_CHANNEL_SHIFT;
> > +                     break;
> > +             case ad7997:
> > +             case ad7998:
> > +                     cmd =3D (this_attr->address <<
> > +                             AD799X_CHANNEL_SHIFT) |
> AD7997_8_READ_SINGLE;
> > +                     break;
> > +             default:
> > +                     cmd =3D 0;
> > +
> > +             }
> > +             ret =3D ad799x_i2c_read16(st, cmd, rxbuf);
> > +             if (ret < 0)
> > +                     goto error_ret;
> > +
> > +             data =3D rxbuf[0] & 0xFFF;
> > +     }
> > +
> > +     /* Pretty print the result */
> > +     len =3D sprintf(buf, "%u\n", data);
> > +
> > +error_ret:
> > +     mutex_unlock(&dev_info->mlock);
> > +     return ret ? ret : len;
> > +}
> > +
> > +static ssize_t ad799x_read_frequency(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +     int ret, len =3D 0;
> > +     u8 val;
> > +     ret =3D ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     val &=3D AD7998_CYC_MASK;
> > +
> > +     switch (val) {
> > +     case AD7998_CYC_DIS:
> > +             len =3D sprintf(buf, "0\n");
> > +             break;
> > +     case AD7998_CYC_TCONF_32:
> > +             len =3D sprintf(buf, "15625\n");
> > +             break;
> > +     case AD7998_CYC_TCONF_64:
> > +             len =3D sprintf(buf, "7812\n");
> > +             break;
> > +     case AD7998_CYC_TCONF_128:
> > +             len =3D sprintf(buf, "3906\n");
> > +             break;
> > +     case AD7998_CYC_TCONF_256:
> > +             len =3D sprintf(buf, "1953\n");
> > +             break;
> > +     case AD7998_CYC_TCONF_512:
> > +             len =3D sprintf(buf, "976\n");
> > +             break;
> > +     case AD7998_CYC_TCONF_1024:
> > +             len =3D sprintf(buf, "488\n");
> > +             break;
> > +     case AD7998_CYC_TCONF_2048:
> > +             len =3D sprintf(buf, "244\n");
> > +             break;
> > +     }
> > +     return len;
> > +}
> > +
> > +static ssize_t ad799x_write_frequency(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      const char *buf,
> > +                                      size_t len)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +     long val;
> > +     int ret;
> > +     u8 t;
> > +
> > +     ret =3D strict_strtol(buf, 10, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_lock(&dev_info->mlock);
> > +     ret =3D ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &t);
> > +     if (ret)
> > +             goto error_ret_mutex;
> > +     /* Wipe the bits clean */
> > +     t &=3D ~AD7998_CYC_MASK;
> > +
> > +     switch (val) {
> > +     case 15625:
> > +             t |=3D AD7998_CYC_TCONF_32;
> > +             break;
> > +     case 7812:
> > +             t |=3D AD7998_CYC_TCONF_64;
> > +             break;
> > +     case 3906:
> > +             t |=3D AD7998_CYC_TCONF_128;
> > +             break;
> > +     case 1953:
> > +             t |=3D AD7998_CYC_TCONF_256;
> > +             break;
> > +     case 976:
> > +             t |=3D AD7998_CYC_TCONF_512;
> > +             break;
> > +     case 488:
> > +             t |=3D AD7998_CYC_TCONF_1024;
> > +             break;
> > +     case 244:
> > +             t |=3D AD7998_CYC_TCONF_2048;
> > +             break;
> > +     case  0:
> > +             t |=3D AD7998_CYC_DIS;
> > +             break;
> > +     default:
> > +             ret =3D -EINVAL;
> > +             goto error_ret_mutex;
> > +     }
> > +
> > +     ret =3D ad799x_i2c_write8(st, AD7998_CYCLE_TMR_REG, t);
> > +
> > +error_ret_mutex:
> > +     mutex_unlock(&dev_info->mlock);
> > +
> > +     return ret ? ret : len;
> > +}
> > +
> > +
> > +static ssize_t ad799x_read_channel_config(struct device *dev,
> > +                                     struct device_attribute *attr,
> > +                                     char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +     struct iio_event_attr *this_attr =3D to_iio_event_attr(attr);
> > +
> > +     int ret;
> > +     u16 val;
> > +     ret =3D ad799x_i2c_read16(st, this_attr->mask, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     return sprintf(buf, "%d\n", val);
> > +}
> > +
> > +static ssize_t ad799x_write_channel_config(struct device *dev,
> > +                                      struct device_attribute *attr,
> > +                                      const char *buf,
> > +                                      size_t len)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +     struct iio_event_attr *this_attr =3D to_iio_event_attr(attr);
> > +
> > +     long val;
> > +     int ret;
> > +
> > +     ret =3D strict_strtol(buf, 10, &val);
> > +     if (ret)
> > +             return ret;
> > +
> > +     mutex_lock(&dev_info->mlock);
> > +     ret =3D ad799x_i2c_write16(st, this_attr->mask, val);
> > +     mutex_unlock(&dev_info->mlock);
> > +
> > +     return ret ? ret : len;
> > +}
> > +
> > +static void ad799x_interrupt_bh(struct work_struct *work_s)
> > +{
> > +     struct ad799x_state *st =3D container_of(work_s,
> > +             struct ad799x_state, work_thresh);
> > +     u8 status;
> > +     int i;
> > +
> > +     if (ad799x_i2c_read8(st, AD7998_ALERT_STAT_REG, &status))
> > +             goto err_out;
> > +
> > +     if (!status)
> > +             goto err_out;
> > +
> > +     ad799x_i2c_write8(st, AD7998_ALERT_STAT_REG,
> > AD7998_ALERT_STAT_CLEAR);
> > +
> > +     for (i =3D 0; i < 8; i++) {
> > +             if (status & (1 << i))
> > +                     iio_push_event(st->indio_dev, 0,
> > +                             i & 0x1 ?
> > +                             IIO_EVENT_CODE_IN_HIGH_THRESH(i >> 1) :
> > +                             IIO_EVENT_CODE_IN_LOW_THRESH(i >> 1),
> > +                             st->last_timestamp);
> > +     }
> > +
> > +err_out:
> > +     enable_irq(st->client->irq);
> > +}
> > +
> > +static int ad799x_interrupt(struct iio_dev *dev_info,
> > +             int index,
> > +             s64 timestamp,
> > +             int no_test)
> > +{
> > +     struct ad799x_state *st =3D dev_info->dev_data;
> > +
> > +     st->last_timestamp =3D timestamp;
> > +     schedule_work(&st->work_thresh);
> > +     return 0;
> > +}
> > +
> > +IIO_EVENT_SH(ad799x, &ad799x_interrupt);
> > +
> > +/* Direct read attribtues */
> > +static IIO_DEV_ATTR_IN_RAW(0, ad799x_read_single_channel, 0);
> > +static IIO_DEV_ATTR_IN_RAW(1, ad799x_read_single_channel, 1);
> > +static IIO_DEV_ATTR_IN_RAW(2, ad799x_read_single_channel, 2);
> > +static IIO_DEV_ATTR_IN_RAW(3, ad799x_read_single_channel, 3);
> > +static IIO_DEV_ATTR_IN_RAW(4, ad799x_read_single_channel, 4);
> > +static IIO_DEV_ATTR_IN_RAW(5, ad799x_read_single_channel, 5);
> > +static IIO_DEV_ATTR_IN_RAW(6, ad799x_read_single_channel, 6);
> > +static IIO_DEV_ATTR_IN_RAW(7, ad799x_read_single_channel, 7);
> > +
> > +static ssize_t ad799x_show_scale(struct device *dev,
> > +                             struct device_attribute *attr,
> > +                             char *buf)
> > +{
> > +     /* Driver currently only support internal vref */
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +     /* Corresponds to Vref / 2^(bits) */
> > +
> > +     if ((1 << (st->chip_info->bits + 1))
> > +         > st->int_vref_mv)
> > +             return sprintf(buf, "0.5\n");
> > +     else
> > +             return sprintf(buf, "%d\n",
> > +                     st->int_vref_mv >> st->chip_info->bits);
> > +}
> > +
> > +static IIO_DEVICE_ATTR(in_scale, S_IRUGO, ad799x_show_scale, NULL,
> 0);
> > +
> > +static ssize_t ad799x_show_name(struct device *dev,
> > +                              struct device_attribute *attr,
> > +                              char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad799x_state *st =3D iio_dev_get_devdata(dev_info);
> > +     return sprintf(buf, "%s\n", st->client->name);
> > +}
> > +
> > +static IIO_DEVICE_ATTR(name, S_IRUGO, ad799x_show_name, NULL, 0);
> > +
> > +static struct attribute *ad7991_5_9_3_4_device_attrs[] =3D {
> > +     &iio_dev_attr_in0_raw.dev_attr.attr,
> > +     &iio_dev_attr_in1_raw.dev_attr.attr,
> > +     &iio_dev_attr_in2_raw.dev_attr.attr,
> > +     &iio_dev_attr_in3_raw.dev_attr.attr,
> > +     &iio_dev_attr_name.dev_attr.attr,
> > +     &iio_dev_attr_in_scale.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +static struct attribute_group ad7991_5_9_3_4_dev_attr_group =3D {
> > +     .attrs =3D ad7991_5_9_3_4_device_attrs,
> > +};
> > +
> > +static struct attribute *ad7991_5_9_3_4_scan_el_attrs[] =3D {
> > +     &iio_scan_el_in0.dev_attr.attr,
> > +     &iio_const_attr_in0_index.dev_attr.attr,
> > +     &iio_scan_el_in1.dev_attr.attr,
> > +     &iio_const_attr_in1_index.dev_attr.attr,
> > +     &iio_scan_el_in2.dev_attr.attr,
> > +     &iio_const_attr_in2_index.dev_attr.attr,
> > +     &iio_scan_el_in3.dev_attr.attr,
> > +     &iio_const_attr_in3_index.dev_attr.attr,
> > +     &iio_dev_attr_in_precision.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group ad7991_5_9_3_4_scan_el_group =3D {
> > +     .name =3D "scan_elements",
> > +     .attrs =3D ad7991_5_9_3_4_scan_el_attrs,
> > +};
> > +
> > +static struct attribute *ad7992_device_attrs[] =3D {
> > +     &iio_dev_attr_in0_raw.dev_attr.attr,
> > +     &iio_dev_attr_in1_raw.dev_attr.attr,
> > +     &iio_dev_attr_name.dev_attr.attr,
> > +     &iio_dev_attr_in_scale.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +static struct attribute_group ad7992_dev_attr_group =3D {
> > +     .attrs =3D ad7992_device_attrs,
> > +};
> > +
> > +static struct attribute *ad7992_scan_el_attrs[] =3D {
> > +     &iio_scan_el_in0.dev_attr.attr,
> > +     &iio_const_attr_in0_index.dev_attr.attr,
> > +     &iio_scan_el_in1.dev_attr.attr,
> > +     &iio_const_attr_in1_index.dev_attr.attr,
> > +     &iio_dev_attr_in_precision.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group ad7992_scan_el_group =3D {
> > +     .name =3D "scan_elements",
> > +     .attrs =3D ad7992_scan_el_attrs,
> > +};
> > +
> > +static struct attribute *ad7997_8_device_attrs[] =3D {
> > +     &iio_dev_attr_in0_raw.dev_attr.attr,
> > +     &iio_dev_attr_in1_raw.dev_attr.attr,
> > +     &iio_dev_attr_in2_raw.dev_attr.attr,
> > +     &iio_dev_attr_in3_raw.dev_attr.attr,
> > +     &iio_dev_attr_in4_raw.dev_attr.attr,
> > +     &iio_dev_attr_in5_raw.dev_attr.attr,
> > +     &iio_dev_attr_in6_raw.dev_attr.attr,
> > +     &iio_dev_attr_in7_raw.dev_attr.attr,
> > +     &iio_dev_attr_name.dev_attr.attr,
> > +     &iio_dev_attr_in_scale.dev_attr.attr,
> > +     NULL
> > +};
> > +
> > +static struct attribute_group ad7997_8_dev_attr_group =3D {
> > +     .attrs =3D ad7997_8_device_attrs,
> > +};
> > +
> > +static struct attribute *ad7997_8_scan_el_attrs[] =3D {
> > +     &iio_scan_el_in0.dev_attr.attr,
> > +     &iio_const_attr_in0_index.dev_attr.attr,
> > +     &iio_scan_el_in1.dev_attr.attr,
> > +     &iio_const_attr_in1_index.dev_attr.attr,
> > +     &iio_scan_el_in2.dev_attr.attr,
> > +     &iio_const_attr_in2_index.dev_attr.attr,
> > +     &iio_scan_el_in3.dev_attr.attr,
> > +     &iio_const_attr_in3_index.dev_attr.attr,
> > +     &iio_scan_el_in4.dev_attr.attr,
> > +     &iio_const_attr_in4_index.dev_attr.attr,
> > +     &iio_scan_el_in5.dev_attr.attr,
> > +     &iio_const_attr_in5_index.dev_attr.attr,
> > +     &iio_scan_el_in6.dev_attr.attr,
> > +     &iio_const_attr_in6_index.dev_attr.attr,
> > +     &iio_scan_el_in7.dev_attr.attr,
> > +     &iio_const_attr_in7_index.dev_attr.attr,
> > +     &iio_dev_attr_in_precision.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group ad7997_8_scan_el_group =3D {
> > +     .name =3D "scan_elements",
> > +     .attrs =3D ad7997_8_scan_el_attrs,
> > +};
> > +
> > +IIO_EVENT_ATTR_SH(in0_thresh_low_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATALOW_CH1_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in0_thresh_high_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATAHIGH_CH1_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in0_thresh_both_hyst_raw,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_HYST_CH1_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in1_thresh_low_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATALOW_CH2_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in1_thresh_high_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATAHIGH_CH2_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in1_thresh_both_hyst_raw,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_HYST_CH2_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in2_thresh_low_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATALOW_CH3_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in2_thresh_high_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATAHIGH_CH3_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in2_thresh_both_hyst_raw,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_HYST_CH3_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in3_thresh_low_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATALOW_CH4_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in3_thresh_high_value,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_DATAHIGH_CH4_REG);
> > +
> > +IIO_EVENT_ATTR_SH(in3_thresh_both_hyst_raw,
> > +               iio_event_ad799x,
> > +               ad799x_read_channel_config,
> > +               ad799x_write_channel_config,
> > +               AD7998_HYST_CH4_REG);
> > +
> > +static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
> > +                           ad799x_read_frequency,
> > +                           ad799x_write_frequency);
> > +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("15625 7812 3906 1953 976 488
> 244
> > 0");
> > +
> > +static struct attribute *ad7993_4_7_8_event_attributes[] =3D {
> > +     &iio_event_attr_in0_thresh_low_value.dev_attr.attr,
> > +     &iio_event_attr_in0_thresh_high_value.dev_attr.attr,
> > +     &iio_event_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
> > +     &iio_event_attr_in1_thresh_low_value.dev_attr.attr,
> > +     &iio_event_attr_in1_thresh_high_value.dev_attr.attr,
> > +     &iio_event_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
> > +     &iio_event_attr_in2_thresh_low_value.dev_attr.attr,
> > +     &iio_event_attr_in2_thresh_high_value.dev_attr.attr,
> > +     &iio_event_attr_in2_thresh_both_hyst_raw.dev_attr.attr,
> > +     &iio_event_attr_in3_thresh_low_value.dev_attr.attr,
> > +     &iio_event_attr_in3_thresh_high_value.dev_attr.attr,
> > +     &iio_event_attr_in3_thresh_both_hyst_raw.dev_attr.attr,
> > +     &iio_dev_attr_sampling_frequency.dev_attr.attr,
> > +     &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group ad7993_4_7_8_event_attrs_group =3D {
> > +     .attrs =3D ad7993_4_7_8_event_attributes,
> > +};
> > +
> > +static struct attribute *ad7992_event_attributes[] =3D {
> > +     &iio_event_attr_in0_thresh_low_value.dev_attr.attr,
> > +     &iio_event_attr_in0_thresh_high_value.dev_attr.attr,
> > +     &iio_event_attr_in0_thresh_both_hyst_raw.dev_attr.attr,
> > +     &iio_event_attr_in1_thresh_low_value.dev_attr.attr,
> > +     &iio_event_attr_in1_thresh_high_value.dev_attr.attr,
> > +     &iio_event_attr_in1_thresh_both_hyst_raw.dev_attr.attr,
> > +     &iio_dev_attr_sampling_frequency.dev_attr.attr,
> > +     &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static struct attribute_group ad7992_event_attrs_group =3D {
> > +     .attrs =3D ad7992_event_attributes,
> > +};
> > +
> > +static const struct ad799x_chip_info ad799x_chip_info_tbl[] =3D {
> > +     [ad7991] =3D {
> > +             .num_inputs =3D 4,
> > +             .bits =3D 12,
> > +             .int_vref_mv =3D 4096,
> > +             .dev_attrs =3D &ad7991_5_9_3_4_dev_attr_group,
> > +             .scan_attrs =3D &ad7991_5_9_3_4_scan_el_group,
> > +             .ad799x_set_scan_mode =3D ad7991_5_9_set_scan_mode,
> > +     },
> > +     [ad7995] =3D {
> > +             .num_inputs =3D 4,
> > +             .bits =3D 10,
> > +             .int_vref_mv =3D 1024,
> > +             .dev_attrs =3D &ad7991_5_9_3_4_dev_attr_group,
> > +             .scan_attrs =3D &ad7991_5_9_3_4_scan_el_group,
> > +             .ad799x_set_scan_mode =3D ad7991_5_9_set_scan_mode,
> > +     },
> > +     [ad7999] =3D {
> > +             .num_inputs =3D 4,
> > +             .bits =3D 10,
> > +             .int_vref_mv =3D 1024,
> > +             .dev_attrs =3D &ad7991_5_9_3_4_dev_attr_group,
> > +             .scan_attrs =3D &ad7991_5_9_3_4_scan_el_group,
> > +             .ad799x_set_scan_mode =3D ad7991_5_9_set_scan_mode,
> > +     },
> > +     [ad7992] =3D {
> > +             .num_inputs =3D 2,
> > +             .bits =3D 12,
> > +             .int_vref_mv =3D 4096,
> > +             .monitor_mode =3D true,
> > +             .default_config =3D AD7998_ALERT_EN,
> > +             .dev_attrs =3D &ad7992_dev_attr_group,
> > +             .scan_attrs =3D &ad7992_scan_el_group,
> > +             .event_attrs =3D &ad7992_event_attrs_group,
> > +             .ad799x_set_scan_mode =3D ad7992_3_4_set_scan_mode,
> > +     },
> > +     [ad7993] =3D {
> > +             .num_inputs =3D 4,
> > +             .bits =3D 10,
> > +             .int_vref_mv =3D 1024,
> > +             .monitor_mode =3D true,
> > +             .default_config =3D AD7998_ALERT_EN,
> > +             .dev_attrs =3D &ad7991_5_9_3_4_dev_attr_group,
> > +             .scan_attrs =3D &ad7991_5_9_3_4_scan_el_group,
> > +             .event_attrs =3D &ad7993_4_7_8_event_attrs_group,
> > +             .ad799x_set_scan_mode =3D ad7992_3_4_set_scan_mode,
> > +     },
> > +     [ad7994] =3D {
> > +             .num_inputs =3D 4,
> > +             .bits =3D 12,
> > +             .int_vref_mv =3D 4096,
> > +             .monitor_mode =3D true,
> > +             .default_config =3D AD7998_ALERT_EN,
> > +             .dev_attrs =3D &ad7991_5_9_3_4_dev_attr_group,
> > +             .scan_attrs =3D &ad7991_5_9_3_4_scan_el_group,
> > +             .event_attrs =3D &ad7993_4_7_8_event_attrs_group,
> > +             .ad799x_set_scan_mode =3D ad7992_3_4_set_scan_mode,
> > +     },
> > +     [ad7997] =3D {
> > +             .num_inputs =3D 8,
> > +             .bits =3D 10,
> > +             .int_vref_mv =3D 1024,
> > +             .monitor_mode =3D true,
> > +             .default_config =3D AD7998_ALERT_EN,
> > +             .dev_attrs =3D &ad7997_8_dev_attr_group,
> > +             .scan_attrs =3D &ad7997_8_scan_el_group,
> > +             .event_attrs =3D &ad7993_4_7_8_event_attrs_group,
> > +             .ad799x_set_scan_mode =3D ad7997_8_set_scan_mode,
> > +     },
> > +     [ad7998] =3D {
> > +             .num_inputs =3D 8,
> > +             .bits =3D 12,
> > +             .int_vref_mv =3D 4096,
> > +             .monitor_mode =3D true,
> > +             .default_config =3D AD7998_ALERT_EN,
> > +             .dev_attrs =3D &ad7997_8_dev_attr_group,
> > +             .scan_attrs =3D &ad7997_8_scan_el_group,
> > +             .event_attrs =3D &ad7993_4_7_8_event_attrs_group,
> > +             .ad799x_set_scan_mode =3D ad7997_8_set_scan_mode,
> > +     },
> > +};
> > +
> > +static int __devinit ad799x_probe(struct i2c_client *client,
> > +                                const struct i2c_device_id *id)
> > +{
> > +     int ret, regdone =3D 0;
> > +     struct ad799x_platform_data *pdata =3D client->dev.platform_data;
> > +     struct ad799x_state *st =3D kzalloc(sizeof(*st), GFP_KERNEL);
> > +     if (st =3D=3D NULL) {
> > +             ret =3D -ENOMEM;
> > +             goto error_ret;
> > +     }
> > +
> > +     /* this is only used for device removal purposes */
> > +     i2c_set_clientdata(client, st);
> > +
> > +     atomic_set(&st->protect_ring, 0);
> > +     st->id =3D id->driver_data;
> > +     st->chip_info =3D &ad799x_chip_info_tbl[st->id];
> > +     st->config =3D st->chip_info->default_config;
> > +
> > +     /* TODO: Add pdata options for filtering and bit delay */
> > +
> > +     if (pdata)
> > +             st->int_vref_mv =3D pdata->vref_mv;
> > +     else
> > +             st->int_vref_mv =3D st->chip_info->int_vref_mv;
> > +
> > +     st->reg =3D regulator_get(&client->dev, "vcc");
> > +     if (!IS_ERR(st->reg)) {
> > +             ret =3D regulator_enable(st->reg);
> > +             if (ret)
> > +                     goto error_put_reg;
> > +     }
> > +     st->client =3D client;
> > +
> > +     st->indio_dev =3D iio_allocate_device();
> > +     if (st->indio_dev =3D=3D NULL) {
> > +             ret =3D -ENOMEM;
> > +             goto error_disable_reg;
> > +     }
> > +
> > +     /* Estabilish that the iio_dev is a child of the i2c device */
> > +     st->indio_dev->dev.parent =3D &client->dev;
> > +     st->indio_dev->attrs =3D st->chip_info->dev_attrs;
> > +     st->indio_dev->event_attrs =3D st->chip_info->event_attrs;
> > +
> > +     st->indio_dev->dev_data =3D (void *)(st);
> > +     st->indio_dev->driver_module =3D THIS_MODULE;
> > +     st->indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +     st->indio_dev->num_interrupt_lines =3D 1;
> > +
> > +     ret =3D ad799x_set_scan_mode(st, 0);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     ret =3D ad799x_register_ring_funcs_and_init(st->indio_dev);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     ret =3D iio_device_register(st->indio_dev);
> > +     if (ret)
> > +             goto error_cleanup_ring;
> > +     regdone =3D 1;
> > +
> > +     ret =3D iio_ring_buffer_register(st->indio_dev->ring, 0);
> > +     if (ret)
> > +             goto error_cleanup_ring;
> > +
> > +     if (client->irq > 0 && st->chip_info->monitor_mode) {
> > +             INIT_WORK(&st->work_thresh, ad799x_interrupt_bh);
> > +
> > +             ret =3D iio_register_interrupt_line(client->irq,
> > +                             st->indio_dev,
> > +                             0,
> > +                             IRQF_TRIGGER_FALLING,
> > +                             client->name);
> > +             if (ret)
> > +                     goto error_cleanup_ring;
> > +
> > +             /*
> > +              * The event handler list element refer to
> iio_event_ad799x.
> > +              * All event attributes bind to the same event handler.
> > +              * So, only register event handler once.
> > +              */
> > +             iio_add_event_to_list(&iio_event_ad799x,
> > +                             &st->indio_dev->interrupts[0]-
> >ev_list);
> > +     }
> > +
> > +     return 0;
> > +error_cleanup_ring:
> > +     ad799x_ring_cleanup(st->indio_dev);
> > +error_free_device:
> > +     if (!regdone)
>
> Where is regdone populated if it is always 1 we may remove the check.

Regdone is only set in case iio_device_register() succeeds.


> > +             iio_free_device(st->indio_dev);
> > +     else
> > +             iio_device_unregister(st->indio_dev);
> > +error_disable_reg:
> > +     if (!IS_ERR(st->reg))
> > +             regulator_disable(st->reg);
> > +error_put_reg:
> > +     if (!IS_ERR(st->reg))
> > +             regulator_put(st->reg);
> > +     kfree(st);
> > +error_ret:
> > +     return ret;
> > +}
> > +
> > +static __devexit int ad799x_remove(struct i2c_client *client)
> > +{
> > +     struct ad799x_state *st =3D i2c_get_clientdata(client);
> > +     struct iio_dev *indio_dev =3D st->indio_dev;
> > +
> > +     if (client->irq > 0 && st->chip_info->monitor_mode)
> > +             iio_unregister_interrupt_line(indio_dev, 0);
> > +
> > +     iio_ring_buffer_unregister(indio_dev->ring);
> > +     ad799x_ring_cleanup(indio_dev);
> > +     iio_device_unregister(indio_dev);
> > +     if (!IS_ERR(st->reg)) {
> > +             regulator_disable(st->reg);
> > +             regulator_put(st->reg);
> > +     }
> > +     kfree(st);
> > +
> > +     return 0;
> > +}
> > +
> > +static const struct i2c_device_id ad799x_id[] =3D {
> > +     { "ad7991", ad7991 },
> > +     { "ad7995", ad7995 },
> > +     { "ad7999", ad7999 },
> > +     { "ad7992", ad7992 },
> > +     { "ad7993", ad7993 },
> > +     { "ad7994", ad7994 },
> > +     { "ad7997", ad7997 },
> > +     { "ad7998", ad7998 },
> > +     {}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, ad799x_id);
> > +
> > +static struct i2c_driver ad799x_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "ad799x",
> > +     },
> > +     .probe =3D ad799x_probe,
> > +     .remove =3D __devexit_p(ad799x_remove),
> > +     .id_table =3D ad799x_id,
> > +};
> > +
> > +static __init int ad799x_init(void)
> > +{
> > +     return i2c_add_driver(&ad799x_driver);
> > +}
> > +
> > +static __exit void ad799x_exit(void)
> > +{
> > +     i2c_del_driver(&ad799x_driver);
> > +}
> > +
> > +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> > +MODULE_DESCRIPTION("Analog Devices AD799x ADC");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("i2c:ad799x");
> > +
> > +module_init(ad799x_init);
> > +module_exit(ad799x_exit);
> > diff --git a/drivers/staging/iio/adc/ad799x_ring.c
> > b/drivers/staging/iio/adc/ad799x_ring.c
> > new file mode 100644
> > index 0000000..0f2041a
> > --- /dev/null
> > +++ b/drivers/staging/iio/adc/ad799x_ring.c
> > @@ -0,0 +1,246 @@
> > +/*
> > + * Copyright (C) 2010 Michael Hennerich, Analog Devices Inc.
> > + * Copyright (C) 2008-2010 Jonathan Cameron
> > + *
> > + * This program is free software; you can redistribute it and/or
> modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * ad799x_ring.c
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/device.h>
> > +#include <linux/slab.h>
> > +#include <linux/kernel.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/list.h>
> > +#include <linux/i2c.h>
> > +#include <linux/bitops.h>
> > +
> > +#include "../iio.h"
> > +#include "../ring_generic.h"
> > +#include "../ring_sw.h"
> > +#include "../trigger.h"
> > +#include "../sysfs.h"
> > +
> > +#include "ad799x.h"
> > +
> > +int ad799x_single_channel_from_ring(struct ad799x_state *st, long
> mask)
> > +{
> > +     unsigned long numvals;
> > +     int count =3D 0, ret;
> > +     u16 *ring_data;
> > +     if (!(st->indio_dev->ring->scan_mask & mask)) {
> > +             ret =3D -EBUSY;
> > +             goto error_ret;
> > +     }
> > +     numvals =3D st->indio_dev->ring->scan_count;
> > +
> > +     ring_data =3D kmalloc(numvals*2, GFP_KERNEL);
> > +     if (ring_data =3D=3D NULL) {
> > +             ret =3D -ENOMEM;
> > +             goto error_ret;
> > +     }
> > +     ret =3D st->indio_dev->ring->access.read_last(st->indio_dev-
> >ring,
> > +                                             (u8 *) ring_data);
> > +     if (ret)
> > +             goto error_free_ring_data;
> > +     /* Need a count of channels prior to this one */
> > +     mask >>=3D 1;
> > +     while (mask) {
> > +             if (mask & st->indio_dev->ring->scan_mask)
> > +                     count++;
> > +             mask >>=3D 1;
> > +     }
> > +
> > +     ret =3D be16_to_cpu(ring_data[count]) & 0xFFF;
> > +
> > +error_free_ring_data:
> > +     kfree(ring_data);
> > +error_ret:
> > +     return ret;
> > +}
> > +
> > +/**
> > + * ad799x_ring_preenable() setup the parameters of the ring before
> > enabling
> > + *
> > + * The complex nature of the setting of the nuber of bytes per datum
> is
> > due
> > + * to this driver currently ensuring that the timestamp is stored at
> an 8
> > + * byte boundary.
> > + **/
> > +static int ad799x_ring_preenable(struct iio_dev *indio_dev)
> > +{
> > +     struct ad799x_state *st =3D indio_dev->dev_data;
> > +     size_t d_size;
> > +     unsigned long numvals;
> > +
> > +     /*
> > +      * Need to figure out the current mode based upon the requested
> > +      * scan mask in iio_dev
> > +      */
> > +
> > +     if (st->id =3D=3D ad7997 || st->id =3D=3D ad7998)
> > +             ad799x_set_scan_mode(st, st->indio_dev->ring-
> >scan_mask);
> > +
> > +     numvals =3D st->indio_dev->ring->scan_count;
> > +
> > +     if (indio_dev->ring->access.set_bytes_per_datum) {
> > +             d_size =3D numvals*2 + sizeof(s64);
> > +             if (d_size % 8)
> > +                     d_size +=3D 8 - (d_size % 8);
> > +             indio_dev->ring->access.set_bytes_per_datum(indio_dev-
> >ring,
> > +                                                         d_size);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +/**
> > + * ad799x_poll_func_th() th of trigger launched polling to ring
> buffer
> > + *
> > + * As sampling only occurs on i2c comms occuring, leave timestamping
> > until
> > + * then.  Some triggers will generate their own time stamp.
> Currently
> > + * there is no way of notifying them when no one cares.
> > + **/
> > +static void ad799x_poll_func_th(struct iio_dev *indio_dev, s64 time)
> > +{
> > +     struct ad799x_state *st =3D indio_dev->dev_data;
> > +
> > +     schedule_work(&st->poll_work);
> > +
> > +     return;
> > +}
> > +/**
> > + * ad799x_poll_bh_to_ring() bh of trigger launched polling to ring
> buffer
> > + * @work_s:  the work struct through which this was scheduled
> > + *
> > + * Currently there is no option in this driver to disable the saving
> of
> > + * timestamps within the ring.
> > + * I think the one copy of this at a time was to avoid problems if
> the
> > + * trigger was set far too high and the reads then locked up the
> > computer.
> > + **/
> > +static void ad799x_poll_bh_to_ring(struct work_struct *work_s)
> > +{
> > +     struct ad799x_state *st =3D container_of(work_s, struct
> ad799x_state,
> > +                                               poll_work);
> > +     struct iio_dev *indio_dev =3D st->indio_dev;
> > +     struct iio_sw_ring_buffer *ring =3D iio_to_sw_ring(indio_dev-
> >ring);
> > +     s64 time_ns;
> > +     __u8 *rxbuf;
> > +     int b_sent;
> > +     size_t d_size;
> > +     u8 cmd;
> > +
> > +     unsigned long numvals =3D st->indio_dev->ring->scan_count;
> > +
> > +     /* Ensure the timestamp is 8 byte aligned */
> > +     d_size =3D numvals*2 + sizeof(s64);
> > +
> > +     if (d_size % sizeof(s64))
> > +             d_size +=3D sizeof(s64) - (d_size % sizeof(s64));
> > +
> > +     /* Ensure only one copy of this function running at a time */
> > +     if (atomic_inc_return(&st->protect_ring) > 1)
> > +             return;
> > +
> > +     /* Monitor mode prevents reading. Whilst not currently
> implemented
> > +      * might as well have this test in here in the meantime as it
> does
> > +      * no harm.
> > +      */
> > +     if (numvals =3D=3D 0)
> > +             return;
> > +
> > +     rxbuf =3D kmalloc(d_size, GFP_KERNEL);
> > +     if (rxbuf =3D=3D NULL)
> > +             return;
> > +
> > +     switch (st->id) {
> > +     case ad7991:
> > +     case ad7995:
> > +     case ad7999:
> > +             cmd =3D st->config | (st->indio_dev->ring->scan_mask <<
> > +                     AD799X_CHANNEL_SHIFT);
> > +             break;
> > +     case ad7992:
> > +     case ad7993:
> > +     case ad7994:
> > +             cmd =3D (st->indio_dev->ring->scan_mask <<
> > +                     AD799X_CHANNEL_SHIFT) | AD7998_CONV_RES_REG;
> > +             break;
> > +     case ad7997:
> > +     case ad7998:
> > +             cmd =3D AD7997_8_READ_SEQUENCE | AD7998_CONV_RES_REG;
> > +             break;
> > +     default:
> > +             cmd =3D 0;
> > +     }
> > +
> > +     b_sent =3D i2c_smbus_read_i2c_block_data(st->client,
> > +                     cmd, numvals*2, rxbuf);
> > +     if (b_sent < 0)
> > +             goto done;
> > +
> > +     time_ns =3D iio_get_time_ns();
> > +
> > +     memcpy(rxbuf + d_size - sizeof(s64), &time_ns,
> sizeof(time_ns));
> > +
> > +     indio_dev->ring->access.store_to(&ring->buf, rxbuf, time_ns);
> > +done:
> > +     kfree(rxbuf);
> > +     atomic_dec(&st->protect_ring);
> > +}
> > +
> > +
> > +int ad799x_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> > +{
> > +     struct ad799x_state *st =3D indio_dev->dev_data;
> > +     int ret =3D 0;
> > +
> > +     indio_dev->ring =3D iio_sw_rb_allocate(indio_dev);
> > +     if (!indio_dev->ring) {
> > +             ret =3D -ENOMEM;
> > +             goto error_ret;
> > +     }
> > +     /* Effectively select the ring buffer implementation */
> > +     iio_ring_sw_register_funcs(&st->indio_dev->ring->access);
> > +     indio_dev->pollfunc =3D kzalloc(sizeof(*indio_dev->pollfunc),
> > GFP_KERNEL);
> > +     if (indio_dev->pollfunc =3D=3D NULL) {
> > +             ret =3D -ENOMEM;
> > +             goto error_deallocate_sw_rb;
> > +     }
> > +     /* Configure the polling function called on trigger interrupts
> */
> > +     indio_dev->pollfunc->poll_func_main =3D &ad799x_poll_func_th;
> > +     indio_dev->pollfunc->private_data =3D indio_dev;
> > +
> > +     /* Ring buffer functions - here trigger setup related */
> > +
> > +     indio_dev->ring->preenable =3D &ad799x_ring_preenable;
> > +     indio_dev->ring->postenable =3D &iio_triggered_ring_postenable;
> > +     indio_dev->ring->predisable =3D &iio_triggered_ring_predisable;
> > +
> > +     INIT_WORK(&st->poll_work, &ad799x_poll_bh_to_ring);
> > +
> > +     indio_dev->ring->scan_el_attrs =3D st->chip_info->scan_attrs;
> > +
> > +     /* Flag that polled ring buffering is possible */
> > +     indio_dev->modes |=3D INDIO_RING_TRIGGERED;
> > +     return 0;
> > +error_deallocate_sw_rb:
> > +     iio_sw_rb_free(indio_dev->ring);
> > +error_ret:
> > +     return ret;
> > +}
> > +
> > +void ad799x_ring_cleanup(struct iio_dev *indio_dev)
> > +{
> > +     /* ensure that the trigger has been detached */
> > +     if (indio_dev->trig) {
> > +             iio_put_trigger(indio_dev->trig);
> > +             iio_trigger_dettach_poll_func(indio_dev->trig,
> > +                                           indio_dev->pollfunc);
> > +     }
> > +     kfree(indio_dev->pollfunc);
> > +     iio_sw_rb_free(indio_dev->ring);
> > +}
> > --
> > 1.6.0.2
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-iio"
> in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
