Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "Datta, Shubhrajyoti" <shubhrajyoti@ti.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Drivers <Drivers@analog.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 3 Dec 2010 10:42:31 +0000
Subject: RE: [RFC 3/3] IIO: DDS: AD9833 / AD9834 driver
Message-ID: <544AC56F16B56944AEC3BD4E3D591771312F08227A@LIMKCMBX1.ad.analog.com>
References: <1291292489-32362-1-git-send-email-michael.hennerich@analog.com>
 <1291292489-32362-4-git-send-email-michael.hennerich@analog.com>
 <0680EC522D0CC943BC586913CF3768C0041390DDE7@dbde02.ent.ti.com>
In-Reply-To: <0680EC522D0CC943BC586913CF3768C0041390DDE7@dbde02.ent.ti.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> Datta, Shubhrajyoti wrote on 2010-12-02:
> > -----Original Message-----
> > From: linux-iio-owner@vger.kernel.org [mailto:linux-iio-
> > owner@vger.kernel.org] On Behalf Of michael.hennerich@analog.com
> > Sent: Thursday, December 02, 2010 5:51 PM
> > To: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org
> > Cc: drivers@analog.com; jic23@cam.ac.uk; device-drivers-
> > devel@blackfin.uclinux.org; Michael Hennerich
> > Subject: [RFC 3/3] IIO: DDS: AD9833 / AD9834 driver
> >
> > From: Michael Hennerich <michael.hennerich@analog.com>
> >
> > Example driver using the proposed ABI
> >
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > ---
> >  drivers/staging/iio/dds/Kconfig  |    7 +
> >  drivers/staging/iio/dds/Makefile |    1 +
> >  drivers/staging/iio/dds/ad9834.c |  483
> > ++++++++++++++++++++++++++++++++++++++
> >  drivers/staging/iio/dds/ad9834.h |  112 +++++++++
> >  4 files changed, 603 insertions(+), 0 deletions(-)
> >  create mode 100644 drivers/staging/iio/dds/ad9834.c
> >  create mode 100644 drivers/staging/iio/dds/ad9834.h
> >
> > diff --git a/drivers/staging/iio/dds/Kconfig
> > b/drivers/staging/iio/dds/Kconfig
> > index 7969be2..4c9cce3 100644
> > --- a/drivers/staging/iio/dds/Kconfig
> > +++ b/drivers/staging/iio/dds/Kconfig
> > @@ -17,6 +17,13 @@ config AD9832
> >         Say yes here to build support for Analog Devices DDS chip
> >         ad9832 and ad9835, provides direct access via sysfs.
> >
> > +config AD9834
> > +     tristate "Analog Devices ad9833/4/ driver"
> > +     depends on SPI
> > +     help
> > +       Say yes here to build support for Analog Devices DDS chip
> > +       AD9833 and AD9834, provides direct access via sysfs.
> > +
> >  config AD9850
> >       tristate "Analog Devices ad9850/1 driver"
> >       depends on SPI
> > diff --git a/drivers/staging/iio/dds/Makefile
> > b/drivers/staging/iio/dds/Makefile
> > index 6f274ac..1477461 100644
> > --- a/drivers/staging/iio/dds/Makefile
> > +++ b/drivers/staging/iio/dds/Makefile
> > @@ -4,6 +4,7 @@
> >
> >  obj-$(CONFIG_AD5930) +=3D ad5930.o
> >  obj-$(CONFIG_AD9832) +=3D ad9832.o
> > +obj-$(CONFIG_AD9834) +=3D ad9834.o
> >  obj-$(CONFIG_AD9850) +=3D ad9850.o
> >  obj-$(CONFIG_AD9852) +=3D ad9852.o
> >  obj-$(CONFIG_AD9910) +=3D ad9910.o
> > diff --git a/drivers/staging/iio/dds/ad9834.c
> > b/drivers/staging/iio/dds/ad9834.c
> > new file mode 100644
> > index 0000000..eb1fabf
> > --- /dev/null
> > +++ b/drivers/staging/iio/dds/ad9834.c
> > @@ -0,0 +1,483 @@
> > +/*
> > + * AD9834 SPI DAC driver
> > + *
> > + * Copyright 2010 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2 or later.
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/device.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/list.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/err.h>
> > +#include <asm/div64.h>
> > +
> > +#include "../iio.h"
> > +#include "../sysfs.h"
> > +#include "dds.h"
> > +
> > +#include "ad9834.h"
> > +
> > +static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned
> long
> > fout)
> > +{
> > +     unsigned long long freqreg =3D (u64) fout * (u64) (1 <<
> > AD9834_FREQ_BITS);
> > +     do_div(freqreg, mclk);
> > +     return freqreg;
> > +}
> > +
> > +static int ad9834_write_frequency(struct ad9834_state *st,
> > +                               unsigned long addr, unsigned long
> fout)
> > +{
> > +     unsigned long regval;
> > +
> > +     if (fout > (st->mclk / 2))
> > +             return -EINVAL;
> > +
> > +     regval =3D ad9834_calc_freqreg(st->mclk, fout);
> > +
> > +     st->freq_data[0] =3D cpu_to_be16(addr | (regval &
> > +                                    RES_MASK(AD9834_FREQ_BITS /
> 2)));
> > +     st->freq_data[1] =3D cpu_to_be16(addr | ((regval >>
> > +                                    (AD9834_FREQ_BITS / 2)) &
> > +                                    RES_MASK(AD9834_FREQ_BITS /
> 2)));
> > +
> > +     return spi_sync(st->spi, &st->freq_msg);;
> > +}
> > +
> > +static int ad9834_write_phase(struct ad9834_state *st,
> > +                               unsigned long addr, unsigned long
> phase)
> > +{
> > +     if (phase > (1 << AD9834_PHASE_BITS))
> > +             return -EINVAL;
> > +     st->data =3D cpu_to_be16(addr | phase);
> > +
> > +     return spi_sync(st->spi, &st->msg);
> > +}
> > +
> > +static ssize_t ad9834_write(struct device *dev,
> > +             struct device_attribute *attr,
> > +             const char *buf,
> > +             size_t len)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad9834_state *st =3D dev_info->dev_data;
> > +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> > +     int ret;
> > +     long val;
> > +
> > +     ret =3D strict_strtol(buf, 10, &val);
> > +     if (ret)
> > +             goto error_ret;
> Could we do some bounds check.
The functions called with val as argument from the switch cases below, do
some bound checking, where necessary.
It's questionable whether these simple enable switch cases, should return w=
ith
error if someone writes something other than 0 or 1.
> > +
> > +     mutex_lock(&dev_info->mlock);
> > +     switch (this_attr->address) {
> > +     case AD9834_REG_FREQ0:
> > +     case AD9834_REG_FREQ1:
> > +             ret =3D ad9834_write_frequency(st, this_attr->address,
> val);
> > +             break;
> > +     case AD9834_REG_PHASE0:
> > +     case AD9834_REG_PHASE1:
> > +             ret =3D ad9834_write_phase(st, this_attr->address, val);
> > +             break;
> > +
> > +     case AD9834_OPBITEN:
> > +             if (st->control & AD9834_MODE) {
> > +                     ret =3D -EINVAL;  /* AD9843 reserved mode */
> > +                     break;
> > +             }
> > +
> > +             if (val)
> > +                     st->control &=3D ~AD9834_OPBITEN;
> > +             else
> > +                     st->control |=3D AD9834_OPBITEN;
> > +             st->data =3D cpu_to_be16(AD9834_REG_CMD | st->control);
> > +             ret =3D spi_sync(st->spi, &st->msg);
> > +             break;
> > +
> > +     case AD9834_PIN_SW:
> > +             if (val)
> > +                     st->control |=3D AD9834_PIN_SW;
> > +             else
> > +                     st->control &=3D ~AD9834_PIN_SW;
> > +             st->data =3D cpu_to_be16(AD9834_REG_CMD | st->control);
> > +             ret =3D spi_sync(st->spi, &st->msg);
> > +             break;
> > +     case AD9834_FSEL:
> > +     case AD9834_PSEL:
> > +             if (val =3D=3D 0)
> > +                     st->control &=3D ~(this_attr->address |
> AD9834_PIN_SW);
> > +             else if (val =3D=3D 1) {
> > +                     st->control |=3D this_attr->address;
> > +                     st->control &=3D ~AD9834_PIN_SW;
> > +             } else {
> > +                     ret =3D -EINVAL;
> > +                     break;
> > +             }
> > +             st->data =3D cpu_to_be16(AD9834_REG_CMD | st->control);
> > +             ret =3D spi_sync(st->spi, &st->msg);
> > +             break;
> > +     case AD9834_RESET:
> > +             if (val)
> > +                     st->control |=3D AD9834_RESET;
> > +             else
> > +                     st->control &=3D ~AD9834_RESET;
> > +             st->data =3D cpu_to_be16(AD9834_REG_CMD | st->control);
> > +             ret =3D spi_sync(st->spi, &st->msg);
> > +             break;
> > +     default:
> > +             ret =3D -ENODEV;
> > +     }
> > +     mutex_unlock(&dev_info->mlock);
> > +
> > +error_ret:
> > +     return ret ? ret : len;
> > +}
> > +
> > +static ssize_t ad9834_store_wavetype(struct device *dev,
> > +                              struct device_attribute *attr,
> > +                              const char *buf,
> > +                              size_t len)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad9834_state *st =3D dev_info->dev_data;
> > +     struct iio_dev_attr *this_attr =3D to_iio_dev_attr(attr);
> > +     int ret =3D 0;
> > +     bool is_ad9833 =3D st->devid =3D=3D ID_AD9833;
> > +
> > +     mutex_lock(&dev_info->mlock);
> > +
> > +     switch (this_attr->address) {
> > +     case 0:
> > +             if (sysfs_streq(buf, "sine")) {
> > +                     st->control &=3D ~AD9834_MODE;
> > +                     if (is_ad9833)
> > +                             st->control &=3D ~AD9834_OPBITEN;
> > +             } else if (sysfs_streq(buf, "triangle")) {
> > +                     if (is_ad9833) {
> > +                             st->control &=3D ~AD9834_OPBITEN;
> > +                             st->control |=3D AD9834_MODE;
> > +                     } else if (st->control & AD9834_OPBITEN) {
> > +                             ret =3D -EINVAL;  /* AD9843 reserved mode
> */
> > +                     } else {
> > +                             st->control |=3D AD9834_MODE;
> > +                     }
> > +             } else if (is_ad9833 && sysfs_streq(buf, "square")) {
> > +                     st->control &=3D ~AD9834_MODE;
> > +                     st->control |=3D AD9834_OPBITEN;
> > +             } else {
> > +                     ret =3D -EINVAL;
> > +             }
> > +
> > +             break;
> > +     case 1:
> > +             if (sysfs_streq(buf, "square") &&
> > +                     !(st->control & AD9834_MODE)) {
> > +                     st->control &=3D ~AD9834_MODE;
> > +                     st->control |=3D AD9834_OPBITEN;
> > +             } else {
> > +                     ret =3D -EINVAL;
> > +             }
> > +             break;
> > +     default:
> > +             ret =3D -EINVAL;
> > +             break;
> > +     }
> > +
> > +     if (!ret) {
> > +             st->data =3D cpu_to_be16(AD9834_REG_CMD | st->control);
> > +             ret =3D spi_sync(st->spi, &st->msg);
> > +     }
> > +             mutex_unlock(&dev_info->mlock);
> > +
> > +     return ret ? ret : len;
> > +}
> > +
> > +static ssize_t ad9834_show_name(struct device *dev,
> > +                              struct device_attribute *attr,
> > +                              char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad9834_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +     return sprintf(buf, "%s\n", spi_get_device_id(st->spi)->name);
> > +}
> > +static IIO_DEVICE_ATTR(name, S_IRUGO, ad9834_show_name, NULL, 0);
> > +
> > +static ssize_t ad9834_show_out0_available_wavetypes(struct device
> *dev,
> > +                                             struct device_attribute
> *attr,
> > +                                             char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad9834_state *st =3D iio_dev_get_devdata(dev_info);
> > +     char *str;
> > +
> > +     if (st->devid =3D=3D ID_AD9833)
> > +             str =3D "sine triangle square";
> > +     else if (st->control & AD9834_OPBITEN)
> > +             str =3D "sine";
> > +     else
> > +             str =3D "sine triangle";
> > +
> > +     return sprintf(buf, "%s\n", str);
> > +}
> > +
> > +
> > +static IIO_DEVICE_ATTR(dds0_out0_available_wavetypes, S_IRUGO,
> > +                    ad9834_show_out0_available_wavetypes, NULL, 0);
> > +
> > +static ssize_t ad9834_show_out1_available_wavetypes(struct device
> *dev,
> > +                                             struct device_attribute
> *attr,
> > +                                             char *buf)
> > +{
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad9834_state *st =3D iio_dev_get_devdata(dev_info);
> > +     char *str;
> > +
> > +     if (st->control & AD9834_MODE)
> > +             str =3D "";
> > +     else
> > +             str =3D "square";
> > +
> > +     return sprintf(buf, "%s\n", str);
> > +}
> > +
> > +static IIO_DEVICE_ATTR(dds0_out1_available_wavetypes, S_IRUGO,
> > +                    ad9834_show_out1_available_wavetypes, NULL, 0);
> > +
> > +/**
> > + * see dds.h for further information
> > + */
> > +
> > +
> > +static IIO_DEV_ATTR_FREQ(0, 0, ad9834_write, AD9834_REG_FREQ0);
> > +static IIO_DEV_ATTR_FREQ(0, 1, ad9834_write, AD9834_REG_FREQ1);
> > +static IIO_DEV_ATTR_FREQSYMBOL(0, ad9834_write, AD9834_FSEL);
> > +static IIO_CONST_ATTR_FREQ_SCALE(0, "1"); /* 1Hz */
> > +
> > +static IIO_DEV_ATTR_PHASE(0, 0, ad9834_write, AD9834_REG_PHASE0);
> > +static IIO_DEV_ATTR_PHASE(0, 1, ad9834_write, AD9834_REG_PHASE1);
> > +static IIO_DEV_ATTR_PHASESYMBOL(0, ad9834_write, AD9834_PSEL);
> > +static IIO_CONST_ATTR_PHASE_SCALE(0, "0.0015339808"); /* 2PI/2^12
> rad*/
> > +
> > +static IIO_DEV_ATTR_PINCONTROL_EN(0, ad9834_write, AD9834_PIN_SW);
> > +static IIO_DEV_ATTR_OUT_DISABLE(0, ad9834_write, AD9834_RESET);
> > +static IIO_DEV_ATTR_OUTY_DISABLE(0, 1, ad9834_write,
> AD9834_OPBITEN);
> > +static IIO_DEV_ATTR_OUT_WAVETYPE(0, 0, ad9834_store_wavetype, 0);
> > +static IIO_DEV_ATTR_OUT_WAVETYPE(0, 1, ad9834_store_wavetype, 1);
> > +
> > +static struct attribute *ad9834_attributes[] =3D {
> > +     &iio_dev_attr_dds0_freq0.dev_attr.attr,
> > +     &iio_dev_attr_dds0_freq1.dev_attr.attr,
> > +     &iio_const_attr_dds0_freq_scale.dev_attr.attr,
> > +     &iio_dev_attr_dds0_phase0.dev_attr.attr,
> > +     &iio_dev_attr_dds0_phase1.dev_attr.attr,
> > +     &iio_const_attr_dds0_phase_scale.dev_attr.attr,
> > +     &iio_dev_attr_dds0_pincontrol_en.dev_attr.attr,
> > +     &iio_dev_attr_dds0_freqsymbol.dev_attr.attr,
> > +     &iio_dev_attr_dds0_phasesymbol.dev_attr.attr,
> > +     &iio_dev_attr_dds0_out_disable.dev_attr.attr,
> > +     &iio_dev_attr_dds0_out1_disable.dev_attr.attr,
> > +     &iio_dev_attr_dds0_out0_wavetype.dev_attr.attr,
> > +     &iio_dev_attr_dds0_out1_wavetype.dev_attr.attr,
> > +     &iio_dev_attr_dds0_out0_available_wavetypes.dev_attr.attr,
> > +     &iio_dev_attr_dds0_out1_available_wavetypes.dev_attr.attr,
> > +     &iio_dev_attr_name.dev_attr.attr,
> > +     NULL,
> > +};
> > +
> > +static mode_t ad9834_attr_is_visible(struct kobject *kobj,
> > +                                  struct attribute *attr, int n)
> > +{
> > +     struct device *dev =3D container_of(kobj, struct device, kobj);
> > +     struct iio_dev *dev_info =3D dev_get_drvdata(dev);
> > +     struct ad9834_state *st =3D iio_dev_get_devdata(dev_info);
> > +
> > +     mode_t mode =3D attr->mode;
> > +
> > +     if (st->devid =3D=3D ID_AD9834)
> > +             return mode;
> > +
> > +     if ((attr =3D=3D &iio_dev_attr_dds0_out1_disable.dev_attr.attr) |=
|
> > +             (attr =3D=3D
> &iio_dev_attr_dds0_out1_wavetype.dev_attr.attr) ||
> > +             (attr =3D=3D
> > +
> &iio_dev_attr_dds0_out1_available_wavetypes.dev_attr.attr))
> > +             mode =3D 0;
> > +
> > +     return mode;
> > +}
> > +
> > +static const struct attribute_group ad9834_attribute_group =3D {
> > +     .attrs =3D ad9834_attributes,
> > +     .is_visible =3D ad9834_attr_is_visible,
> > +};
> > +
> > +static int __devinit ad9834_probe(struct spi_device *spi)
> > +{
> > +     struct ad9834_platform_data *pdata =3D spi->dev.platform_data;
> > +     struct ad9834_state *st;
> > +     int ret;
> > +
> > +     if (!pdata) {
> > +             dev_dbg(&spi->dev, "no platform data?\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     st =3D kzalloc(sizeof(*st), GFP_KERNEL);
> > +     if (st =3D=3D NULL) {
> > +             ret =3D -ENOMEM;
> > +             goto error_ret;
> > +     }
> > +
> > +     st->reg =3D regulator_get(&spi->dev, "vcc");
> > +     if (!IS_ERR(st->reg)) {
> > +             ret =3D regulator_enable(st->reg);
> > +             if (ret)
> > +                     goto error_put_reg;
> > +     }
> > +
> > +     st->mclk =3D pdata->mclk;
> > +
> > +     spi_set_drvdata(spi, st);
> > +
> > +     st->spi =3D spi;
> > +     st->devid =3D spi_get_device_id(spi)->driver_data;
> > +
> > +     st->indio_dev =3D iio_allocate_device();
> > +     if (st->indio_dev =3D=3D NULL) {
> > +             ret =3D -ENOMEM;
> > +             goto error_disable_reg;
> > +     }
> > +
> > +     st->indio_dev->dev.parent =3D &spi->dev;
> > +     st->indio_dev->attrs =3D &ad9834_attribute_group;
> > +     st->indio_dev->dev_data =3D (void *)(st);
> > +     st->indio_dev->driver_module =3D THIS_MODULE;
> > +     st->indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +
> > +     /* Setup default messages */
> > +
> > +     st->xfer.tx_buf =3D &st->data;
> > +     st->xfer.len =3D 2;
> > +
> > +     spi_message_init(&st->msg);
> > +     spi_message_add_tail(&st->xfer, &st->msg);
> > +
> > +     st->freq_xfer[0].tx_buf =3D &st->freq_data[0];
> > +     st->freq_xfer[0].len =3D 2;
> > +     st->freq_xfer[0].cs_change =3D 1;
> > +     st->freq_xfer[1].tx_buf =3D &st->freq_data[1];
> > +     st->freq_xfer[1].len =3D 2;
> > +
> > +     spi_message_init(&st->freq_msg);
> > +     spi_message_add_tail(&st->freq_xfer[0], &st->freq_msg);
> > +     spi_message_add_tail(&st->freq_xfer[1], &st->freq_msg);
> > +
> > +     st->control =3D AD9834_B28 | AD9834_RESET;
> > +
> > +     if (!pdata->en_div2)
> > +             st->control |=3D AD9834_DIV2;
> > +
> > +     if (!pdata->en_signbit_msb_out && (st->devid =3D=3D ID_AD9834))
> > +             st->control |=3D AD9834_SIGN_PIB;
> > +
> > +     st->data =3D cpu_to_be16(AD9834_REG_CMD | st->control);
> > +     ret =3D spi_sync(st->spi, &st->msg);
> > +     if (ret) {
> > +             dev_err(&spi->dev, "device init failed\n");
> > +             goto error_free_device;
> > +     }
> > +
> > +     ret =3D ad9834_write_frequency(st, AD9834_REG_FREQ0, pdata-
> >freq0);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     ret =3D ad9834_write_frequency(st, AD9834_REG_FREQ1, pdata-
> >freq1);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     ret =3D ad9834_write_phase(st, AD9834_REG_PHASE0, pdata->phase0);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     ret =3D ad9834_write_phase(st, AD9834_REG_PHASE1, pdata->phase1);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     st->control &=3D ~AD9834_RESET;
> > +     st->data =3D cpu_to_be16(AD9834_REG_CMD | st->control);
> > +     ret =3D spi_sync(st->spi, &st->msg);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     ret =3D iio_device_register(st->indio_dev);
> > +     if (ret)
> > +             goto error_free_device;
> > +
> > +     return 0;
> > +
> > +error_free_device:
> > +     iio_free_device(st->indio_dev);
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
> > +static int ad9834_remove(struct spi_device *spi)
> Could we consider __devexit here
Good catch.
> > +{
> > +     struct ad9834_state *st =3D spi_get_drvdata(spi);
> > +     struct iio_dev *indio_dev =3D st->indio_dev;
> > +
> > +     iio_device_unregister(indio_dev);
> > +     if (!IS_ERR(st->reg)) {
> > +             regulator_disable(st->reg);
> > +             regulator_put(st->reg);
> > +     }
> > +     kfree(st);
> > +     return 0;
> > +}
> > +
> > +static const struct spi_device_id ad9834_id[] =3D {
> > +     {"ad9833", ID_AD9833},
> > +     {"ad9834", ID_AD9834},
> > +     {}
> > +};
> > +
> > +static struct spi_driver ad9834_driver =3D {
> > +     .driver =3D {
> > +             .name   =3D "ad9834",
> > +             .bus    =3D &spi_bus_type,
> > +             .owner  =3D THIS_MODULE,
> > +     },
> > +     .probe          =3D ad9834_probe,
> > +     .remove         =3D __devexit_p(ad9834_remove),
> > +     .id_table       =3D ad9834_id,
> > +};
> > +
> > +static int __init ad9834_init(void)
> > +{
> > +     return spi_register_driver(&ad9834_driver);
> > +}
> > +module_init(ad9834_init);
> > +
> > +static void __exit ad9834_exit(void)
> > +{
> > +     spi_unregister_driver(&ad9834_driver);
> > +}
> > +module_exit(ad9834_exit);
> > +
> > +MODULE_AUTHOR("Michael Hennerich <hennerich@blackfin.uclinux.org>");
> > +MODULE_DESCRIPTION("Analog Devices AD9833/AD9834 DDS");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("spi:ad9834");
> > diff --git a/drivers/staging/iio/dds/ad9834.h
> > b/drivers/staging/iio/dds/ad9834.h
> > new file mode 100644
> > index 0000000..0fc3b88
> > --- /dev/null
> > +++ b/drivers/staging/iio/dds/ad9834.h
> > @@ -0,0 +1,112 @@
> > +/*
> > + * AD9834 SPI DDS driver
> > + *
> > + * Copyright 2010 Analog Devices Inc.
> > + *
> > + * Licensed under the GPL-2 or later.
> > + */
> > +#ifndef IIO_DDS_AD9834_H_
> > +#define IIO_DDS_AD9834_H_
> > +
> > +/* Registers */
> > +
> > +#define AD9834_REG_CMD               (0 << 14)
> > +#define AD9834_REG_FREQ0     (1 << 14)
> > +#define AD9834_REG_FREQ1     (2 << 14)
> > +#define AD9834_REG_PHASE0    (6 << 13)
> > +#define AD9834_REG_PHASE1    (7 << 13)
> > +
> > +/* Command Control Bits */
> > +
> > +#define AD9834_B28           (1 << 13)
> > +#define AD9834_HLB           (1 << 12)
> > +#define AD9834_FSEL          (1 << 11)
> > +#define AD9834_PSEL          (1 << 10)
> > +#define AD9834_PIN_SW                (1 << 9)
> > +#define AD9834_RESET         (1 << 8)
> > +#define AD9834_SLEEP1                (1 << 7)
> > +#define AD9834_SLEEP12               (1 << 6)
> > +#define AD9834_OPBITEN               (1 << 5)
> > +#define AD9834_SIGN_PIB              (1 << 4)
> > +#define AD9834_DIV2          (1 << 3)
> > +#define AD9834_MODE          (1 << 1)
> > +
> > +#define AD9834_FREQ_BITS     28
> > +#define AD9834_PHASE_BITS    12
> > +
> > +#define RES_MASK(bits)       ((1 << (bits)) - 1)
> > +
> > +/**
> > + * struct ad9834_state - driver instance specific data
> > + * @indio_dev:               the industrial I/O device
> > + * @spi:             spi_device
> > + * @reg:             supply regulator
> > + * @mclk:            external master clock
> > + * @control:         cached control word
> > + * @xfer:            default spi transfer
> > + * @msg:             default spi message
> > + * @freq_xfer:               tuning word spi transfer
> > + * @freq_msg:                tuning word spi message
> > + * @data:            spi transmit buffer
> > + * @freq_data:               tuning word spi transmit buffer
> > + */
> > +
> > +struct ad9834_state {
> > +     struct iio_dev                  *indio_dev;
> > +     struct spi_device               *spi;
> > +     struct regulator                *reg;
> > +     unsigned int                    mclk;
> > +     unsigned short                  control;
> > +     unsigned short                  devid;
> > +     struct spi_transfer             xfer;
> > +     struct spi_message              msg;
> > +     struct spi_transfer             freq_xfer[2];
> > +     struct spi_message              freq_msg;
> > +
> > +     /*
> > +      * DMA (thus cache coherency maintenance) requires the
> > +      * transfer buffers to live in their own cache lines.
> > +      */
> > +     unsigned short                  data ____cacheline_aligned;
> > +     unsigned short                  freq_data[2] ;
> > +};
> > +
> > +
> > +/*
> > + * TODO: struct ad7887_platform_data needs to go into
> include/linux/iio
> > + */
> > +
> > +/**
> > + * struct ad9834_platform_data - platform specific information
> > + * @mclk:            master clock in Hz
> > + * @freq0:           power up freq0 tuning word in Hz
> > + * @freq1:           power up freq1 tuning word in Hz
> > + * @phase0:          power up phase0 value [0..4095] correlates with
> > 0..2PI
> > + * @phase1:          power up phase1 value [0..4095] correlates with
> > 0..2PI
> > + * @en_div2:         digital output/2 is passed to the SIGN BIT OUT
> pin
> > + * @en_signbit_msb_out:      the MSB (or MSB/2) of the DAC data is
> > connected to the
> > + *                   SIGN BIT OUT pin. en_div2 controls whether it
> is the MSB
> > + *                   or MSB/2 that is output. if
> en_signbit_msb_out=3Dfalse,
> > + *                   the on-board comparator is connected to SIGN
> BIT OUT
> > + */
> > +
> > +struct ad9834_platform_data {
> > +     unsigned int            mclk;
> > +     unsigned int            freq0;
> > +     unsigned int            freq1;
> > +     unsigned short          phase0;
> > +     unsigned short          phase1;
> > +     bool                    en_div2;
> > +     bool                    en_signbit_msb_out;
> > +};
> > +
> > +/**
> > + * ad9834_supported_device_ids:
> > + */
> > +
> > +enum ad9834_supported_device_ids {
> > +     ID_AD9833,
> > +     ID_AD9834,
> > +};
> > +
> > +#endif /* IIO_DDS_AD9834_H_ */
> > --
> > 1.6.0.2

Datta,

Thanks for your review.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
