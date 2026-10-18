Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9550219E8;
	Sun, 18 Oct 2026 20:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792355292; cv=none; b=fxwCACUSdV2PODxepxSnIx4Sx1LHNxFND9tir7U1TT2w8//zM9fTamsASuDwso9ZtLLJDUDLfF89ir/iS0JmrVTkNx1T9Jvbqtgtx3PFqmhEjBv9V7tw8SOI8oaZlT7BCKFFmi08/IsqpE7x21jpx42Uos2xKNInJcEJ4uDxWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792355292; c=relaxed/simple;
	bh=J9IVS5efFFKGr9PGCmzNzTr2Gw4Gv5D3gwbgx4Nxcjg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5Ktl0Gu4WMX/LBIMhxkFjii37i0Jsxof5skHYU/5i7n8DNZWvOQ2jYGTdSnoAz7L/jLWzlam2q8oKCBbZAvRRwf1ima/siX0KkRA00EQtq0Ix7SlCF1eyvVBd7vZDvoeFEARnlxfA8VasWdHiLSNmBIrHetGiBijFOSS5F68qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hn4OJZHh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hn4OJZHh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4712F1F000C4;
	Sun, 18 Oct 2026 20:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792355290;
	bh=XOdzxlFo4O/mE3DrpCKdQUzsR+eeTUaRX0CAP6j6DRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hn4OJZHhyBCEnrSJY+6eUP/4WdFxT8SgFiHYKlZCbmdNkC+lhyaCs+g3VhALDuBmy
	 h7ucN7T3tabV7P1ZA1PkdJQErbFlwIZCyF5cnKztuSItPVxcZU+D27N854eWY85PUi
	 yH0xMW9NTTFLEYgdjbpjX3eWBrAM57J4NrLybbcz/CmbhFl9HIiPWNxKbIrERBVGLV
	 Uz7fB+uNb9ox810I4fG1DIKkuR9feQfgk3SvWnIZj29oFHReincwYNPtRcXvnpASsi
	 wJaPJbEpDcI8S+BtQ5sCpTcJOVmALBkYImf3GC3vacyVEOsIOkHid/J6WVz8naCbKd
	 7Xch4liVDyaiw==
Date: Sun, 18 Oct 2026 21:28:04 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux@analog.com
Subject: Re: [PATCH] staging: iio: adc: ad7816: remove obsolete driver
Message-ID: <20261018212804.2b3c79fb@jic23-hlaptop>
In-Reply-To: <aszw2nRYy3mqm_dE@nsa>
References: <20261006115119.1416-1-joshua.crofts1@gmail.com>
	<aszw2nRYy3mqm_dE@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 15:41:42 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Tue, Oct 06, 2026 at 11:51:19AM +0000, Joshua Crofts wrote:
> > The AD7816 driver has been in staging for 16 years and hasn't seen any
> > significant improvements for it to mature out of staging.
> >=20
> > Additionally, the AD7816/AD7817/AD7818 have been obsolete for ~11 years.

AD7817 is marked production.
https://www.analog.com/en/products/ad7817.html

That's the only reason I didn't drop this last time I checked the
staging parts. =20
Still Nuno acked, so bye bye driver :)

Applied.


> >=20
> > Remove the entire adc/ subdirectory and references to it as this is the
> > only driver in it.
> >=20
> > Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> > ---
> > If people want to use the AD7816, Analog Devices have their own fork of
> > the kernel where the driver is present [1]. =20
>=20
> Just note that we do update the kernel so the removal will come to us
> :). Anyways, the part is indeed marked as obsolete so I'm not expecting
> any effort for updating the driver and remove it out of staging. So, fine
> by me. If any customers shouts, we can add the driver back in our fork
> (or add proper support for it) - but odds are low
>=20
> So it is only fair to ack this:
>=20
> Acked-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
> >=20
> > Also, I don't see a point in keeping the driver for newcomers to
> > practice on, as all mechanical changes (checkpatch, cocci) have been
> > applied.
> >=20
> > [1] https://github.com/analogdevicesinc/linux/blob/main/drivers/staging=
/iio/adc/ad7816.c
> > ---
> >  drivers/staging/iio/Kconfig      |   1 -
> >  drivers/staging/iio/Makefile     |   1 -
> >  drivers/staging/iio/adc/Kconfig  |  18 --
> >  drivers/staging/iio/adc/Makefile |   6 -
> >  drivers/staging/iio/adc/ad7816.c | 464 -------------------------------
> >  5 files changed, 490 deletions(-)
> >  delete mode 100644 drivers/staging/iio/adc/Kconfig
> >  delete mode 100644 drivers/staging/iio/adc/Makefile
> >  delete mode 100644 drivers/staging/iio/adc/ad7816.c
> >=20
> > diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
> > index bf6addf2974f..58d6859e039a 100644
> > --- a/drivers/staging/iio/Kconfig
> > +++ b/drivers/staging/iio/Kconfig
> > @@ -5,7 +5,6 @@
> >  menu "IIO staging drivers"
> >  	depends on IIO
> > =20
> > -source "drivers/staging/iio/adc/Kconfig"
> >  source "drivers/staging/iio/addac/Kconfig"
> >  source "drivers/staging/iio/frequency/Kconfig"
> >  source "drivers/staging/iio/impedance-analyzer/Kconfig"
> > diff --git a/drivers/staging/iio/Makefile b/drivers/staging/iio/Makefile
> > index 739e4cbf9a7a..7768c4a8d278 100644
> > --- a/drivers/staging/iio/Makefile
> > +++ b/drivers/staging/iio/Makefile
> > @@ -3,7 +3,6 @@
> >  # Makefile for the industrial I/O core.
> >  #
> > =20
> > -obj-y +=3D adc/
> >  obj-y +=3D addac/
> >  obj-y +=3D frequency/
> >  obj-y +=3D impedance-analyzer/
> > diff --git a/drivers/staging/iio/adc/Kconfig b/drivers/staging/iio/adc/=
Kconfig
> > deleted file mode 100644
> > index 2f0d6cf048d2..000000000000
> > --- a/drivers/staging/iio/adc/Kconfig
> > +++ /dev/null
> > @@ -1,18 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0
> > -#
> > -# ADC drivers
> > -#
> > -menu "Analog to digital converters"
> > -
> > -config AD7816
> > -	tristate "Analog Devices AD7816/7/8 temperature sensor and ADC driver"
> > -	depends on SPI
> > -	depends on GPIOLIB || COMPILE_TEST
> > -	help
> > -	  Say yes here to build support for Analog Devices AD7816/7/8
> > -	  temperature sensors and ADC.
> > -
> > -	  To compile this driver as a module, choose M here: the
> > -	  module will be called ad7816.
> > -
> > -endmenu
> > diff --git a/drivers/staging/iio/adc/Makefile b/drivers/staging/iio/adc=
/Makefile
> > deleted file mode 100644
> > index 1e2a94c4db84..000000000000
> > --- a/drivers/staging/iio/adc/Makefile
> > +++ /dev/null
> > @@ -1,6 +0,0 @@
> > -# SPDX-License-Identifier: GPL-2.0
> > -#
> > -# Makefile for industrial I/O ADC drivers
> > -#
> > -
> > -obj-$(CONFIG_AD7816) +=3D ad7816.o
> > diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc=
/ad7816.c
> > deleted file mode 100644
> > index 2a15d7598abb..000000000000
> > --- a/drivers/staging/iio/adc/ad7816.c
> > +++ /dev/null
> > @@ -1,464 +0,0 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > -/*
> > - * AD7816 digital temperature sensor driver supporting AD7816/7/8
> > - *
> > - * Copyright 2010 Analog Devices Inc.
> > - */
> > -
> > -#include <linux/cleanup.h>
> > -#include <linux/device.h>
> > -#include <linux/gpio/consumer.h>
> > -#include <linux/interrupt.h>
> > -#include <linux/kernel.h>
> > -#include <linux/list.h>
> > -#include <linux/module.h>
> > -#include <linux/mutex.h>
> > -#include <linux/slab.h>
> > -#include <linux/spi/spi.h>
> > -#include <linux/sysfs.h>
> > -
> > -#include <linux/iio/events.h>
> > -#include <linux/iio/iio.h>
> > -#include <linux/iio/sysfs.h>
> > -
> > -/*
> > - * AD7816 config masks
> > - */
> > -#define AD7816_FULL			0x1
> > -#define AD7816_PD			0x2
> > -#define AD7816_CS_MASK			0x7
> > -#define AD7816_CS_MAX			0x4
> > -
> > -/*
> > - * AD7816 temperature masks
> > - */
> > -#define AD7816_VALUE_OFFSET		6
> > -#define AD7816_BOUND_VALUE_BASE		0x8
> > -#define AD7816_BOUND_VALUE_MIN		-95
> > -#define AD7816_BOUND_VALUE_MAX		152
> > -#define AD7816_TEMP_FLOAT_OFFSET	2
> > -#define AD7816_TEMP_FLOAT_MASK		0x3
> > -
> > -/*
> > - * struct ad7816_chip_info - chip specific information
> > - */
> > -
> > -struct ad7816_chip_info {
> > -	kernel_ulong_t id;
> > -	struct spi_device *spi_dev;
> > -	struct gpio_desc *rdwr_pin;
> > -	struct gpio_desc *convert_pin;
> > -	struct gpio_desc *busy_pin;
> > -	struct mutex lock; /* protect device state during SPI transfers */
> > -	u8  oti_data[AD7816_CS_MAX + 1];
> > -	u8  channel_id;	/* 0 always be temperature */
> > -	u8  mode;
> > -};
> > -
> > -enum ad7816_type {
> > -	ID_AD7816,
> > -	ID_AD7817,
> > -	ID_AD7818,
> > -};
> > -
> > -/*
> > - * ad7816 data access by SPI
> > - */
> > -static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
> > -{
> > -	struct spi_device *spi_dev =3D chip->spi_dev;
> > -	int ret;
> > -	__be16 buf;
> > -
> > -	guard(mutex)(&chip->lock);
> > -
> > -	gpiod_set_value(chip->rdwr_pin, 1);
> > -	gpiod_set_value(chip->rdwr_pin, 0);
> > -	ret =3D spi_write_then_read(spi_dev, &chip->channel_id, sizeof(chip->=
channel_id), NULL, 0);
> > -	if (ret < 0) {
> > -		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> > -		return ret;
> > -	}
> > -	gpiod_set_value(chip->rdwr_pin, 1);
> > -
> > -	if (chip->mode =3D=3D AD7816_PD) { /* operating mode 2 */
> > -		gpiod_set_value(chip->convert_pin, 1);
> > -		gpiod_set_value(chip->convert_pin, 0);
> > -	} else { /* operating mode 1 */
> > -		gpiod_set_value(chip->convert_pin, 0);
> > -		gpiod_set_value(chip->convert_pin, 1);
> > -	}
> > -
> > -	if (chip->id =3D=3D ID_AD7816 || chip->id =3D=3D ID_AD7817) {
> > -		while (gpiod_get_value(chip->busy_pin))
> > -			cpu_relax();
> > -	}
> > -
> > -	gpiod_set_value(chip->rdwr_pin, 0);
> > -	gpiod_set_value(chip->rdwr_pin, 1);
> > -	ret =3D spi_write_then_read(spi_dev, NULL, 0, &buf, sizeof(buf));
> > -	if (ret < 0) {
> > -		dev_err(&spi_dev->dev, "SPI data read error\n");
> > -		return ret;
> > -	}
> > -
> > -	*data =3D be16_to_cpu(buf);
> > -
> > -	return ret;
> > -}
> > -
> > -static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
> > -{
> > -	struct spi_device *spi_dev =3D chip->spi_dev;
> > -	int ret;
> > -
> > -	guard(mutex)(&chip->lock);
> > -
> > -	gpiod_set_value(chip->rdwr_pin, 1);
> > -	gpiod_set_value(chip->rdwr_pin, 0);
> > -	ret =3D spi_write_then_read(spi_dev, &data, sizeof(data), NULL, 0);
> > -	if (ret < 0)
> > -		dev_err(&spi_dev->dev, "SPI oti data write error\n");
> > -
> > -	return ret;
> > -}
> > -
> > -static ssize_t ad7816_show_mode(struct device *dev,
> > -				struct device_attribute *attr,
> > -				char *buf)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > -
> > -	if (chip->mode)
> > -		return sysfs_emit(buf, "power-save\n");
> > -	return sysfs_emit(buf, "full\n");
> > -}
> > -
> > -static ssize_t ad7816_store_mode(struct device *dev,
> > -				 struct device_attribute *attr,
> > -				 const char *buf,
> > -				 size_t len)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > -
> > -	guard(mutex)(&chip->lock);
> > -
> > -	if (strcmp(buf, "full") =3D=3D 0) {
> > -		gpiod_set_value(chip->rdwr_pin, 1);
> > -		chip->mode =3D AD7816_FULL;
> > -	} else {
> > -		gpiod_set_value(chip->rdwr_pin, 0);
> > -		chip->mode =3D AD7816_PD;
> > -	}
> > -
> > -	return len;
> > -}
> > -
> > -static IIO_DEVICE_ATTR(mode, 0644,
> > -		ad7816_show_mode,
> > -		ad7816_store_mode,
> > -		0);
> > -
> > -static ssize_t ad7816_show_available_modes(struct device *dev,
> > -					   struct device_attribute *attr,
> > -					   char *buf)
> > -{
> > -	return sysfs_emit(buf, "full\npower-save\n");
> > -}
> > -
> > -static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_mo=
des,
> > -			NULL, 0);
> > -
> > -static ssize_t ad7816_show_channel(struct device *dev,
> > -				   struct device_attribute *attr,
> > -				   char *buf)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > -
> > -	return sysfs_emit(buf, "%d\n", chip->channel_id);
> > -}
> > -
> > -static ssize_t ad7816_store_channel(struct device *dev,
> > -				    struct device_attribute *attr,
> > -				    const char *buf,
> > -				    size_t len)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > -	unsigned long data;
> > -	int ret;
> > -
> > -	ret =3D kstrtoul(buf, 10, &data);
> > -	if (ret)
> > -		return ret;
> > -
> > -	if (data > AD7816_CS_MAX && data !=3D AD7816_CS_MASK) {
> > -		dev_err(&chip->spi_dev->dev, "Invalid channel id %lu for %s.\n",
> > -			data, indio_dev->name);
> > -		return -EINVAL;
> > -	} else if (strcmp(indio_dev->name, "ad7818") =3D=3D 0 && data > 1) {
> > -		dev_err(&chip->spi_dev->dev,
> > -			"Invalid channel id %lu for ad7818.\n", data);
> > -		return -EINVAL;
> > -	} else if (strcmp(indio_dev->name, "ad7816") =3D=3D 0 && data > 0) {
> > -		dev_err(&chip->spi_dev->dev,
> > -			"Invalid channel id %lu for ad7816.\n", data);
> > -		return -EINVAL;
> > -	}
> > -
> > -	guard(mutex)(&chip->lock);
> > -
> > -	chip->channel_id =3D data;
> > -
> > -	return len;
> > -}
> > -
> > -static IIO_DEVICE_ATTR(channel, 0644,
> > -		ad7816_show_channel,
> > -		ad7816_store_channel,
> > -		0);
> > -
> > -static ssize_t ad7816_show_value(struct device *dev,
> > -				 struct device_attribute *attr,
> > -				 char *buf)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > -	u16 data;
> > -	s8 value;
> > -	int ret;
> > -
> > -	ret =3D ad7816_spi_read(chip, &data);
> > -	if (ret)
> > -		return -EIO;
> > -
> > -	data >>=3D AD7816_VALUE_OFFSET;
> > -
> > -	if (chip->channel_id =3D=3D 0) {
> > -		value =3D (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
> > -		data &=3D AD7816_TEMP_FLOAT_MASK;
> > -		if (value < 0)
> > -			data =3D BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
> > -		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
> > -	}
> > -	return sysfs_emit(buf, "%u\n", data);
> > -}
> > -
> > -static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
> > -
> > -static struct attribute *ad7816_attributes[] =3D {
> > -	&iio_dev_attr_available_modes.dev_attr.attr,
> > -	&iio_dev_attr_mode.dev_attr.attr,
> > -	&iio_dev_attr_channel.dev_attr.attr,
> > -	&iio_dev_attr_value.dev_attr.attr,
> > -	NULL,
> > -};
> > -
> > -static const struct attribute_group ad7816_attribute_group =3D {
> > -	.attrs =3D ad7816_attributes,
> > -};
> > -
> > -/*
> > - * temperature bound events
> > - */
> > -
> > -#define IIO_EVENT_CODE_AD7816_OTI IIO_UNMOD_EVENT_CODE(IIO_TEMP,	\
> > -						       0,		\
> > -						       IIO_EV_TYPE_THRESH, \
> > -						       IIO_EV_DIR_FALLING)
> > -
> > -static irqreturn_t ad7816_event_handler(int irq, void *private)
> > -{
> > -	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
> > -		       iio_get_time_ns(private));
> > -	return IRQ_HANDLED;
> > -}
> > -
> > -static ssize_t ad7816_show_oti(struct device *dev,
> > -			       struct device_attribute *attr,
> > -			       char *buf)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > -	int value;
> > -
> > -	if (chip->channel_id > AD7816_CS_MAX) {
> > -		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
> > -		return -EINVAL;
> > -	} else if (chip->channel_id =3D=3D 0) {
> > -		value =3D AD7816_BOUND_VALUE_MIN +
> > -			(chip->oti_data[chip->channel_id] -
> > -			AD7816_BOUND_VALUE_BASE);
> > -		return sysfs_emit(buf, "%d\n", value);
> > -	}
> > -	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
> > -}
> > -
> > -static inline ssize_t ad7816_set_oti(struct device *dev,
> > -				     struct device_attribute *attr,
> > -				     const char *buf,
> > -				     size_t len)
> > -{
> > -	struct iio_dev *indio_dev =3D dev_to_iio_dev(dev);
> > -	struct ad7816_chip_info *chip =3D iio_priv(indio_dev);
> > -	long value;
> > -	u8 data;
> > -	int ret;
> > -
> > -	ret =3D kstrtol(buf, 10, &value);
> > -	if (ret)
> > -		return ret;
> > -
> > -	if (chip->channel_id > AD7816_CS_MAX) {
> > -		dev_err(dev, "Invalid oti channel id %d.\n", chip->channel_id);
> > -		return -EINVAL;
> > -	} else if (chip->channel_id =3D=3D 0) {
> > -		if (value < AD7816_BOUND_VALUE_MIN ||
> > -		    value > AD7816_BOUND_VALUE_MAX)
> > -			return -EINVAL;
> > -
> > -		data =3D (u8)(value - AD7816_BOUND_VALUE_MIN +
> > -			AD7816_BOUND_VALUE_BASE);
> > -	} else {
> > -		if (value < AD7816_BOUND_VALUE_BASE || value > 255)
> > -			return -EINVAL;
> > -
> > -		data =3D (u8)value;
> > -	}
> > -
> > -	ret =3D ad7816_spi_write(chip, data);
> > -	if (ret)
> > -		return -EIO;
> > -
> > -	chip->oti_data[chip->channel_id] =3D data;
> > -
> > -	return len;
> > -}
> > -
> > -static IIO_DEVICE_ATTR(oti, 0644,
> > -		       ad7816_show_oti, ad7816_set_oti, 0);
> > -
> > -static struct attribute *ad7816_event_attributes[] =3D {
> > -	&iio_dev_attr_oti.dev_attr.attr,
> > -	NULL,
> > -};
> > -
> > -static const struct attribute_group ad7816_event_attribute_group =3D {
> > -	.attrs =3D ad7816_event_attributes,
> > -	.name =3D "events",
> > -};
> > -
> > -static const struct iio_info ad7816_info =3D {
> > -	.attrs =3D &ad7816_attribute_group,
> > -	.event_attrs =3D &ad7816_event_attribute_group,
> > -};
> > -
> > -/*
> > - * device probe and remove
> > - */
> > -
> > -static int ad7816_probe(struct spi_device *spi_dev)
> > -{
> > -	struct ad7816_chip_info *chip;
> > -	struct iio_dev *indio_dev;
> > -	int i, ret;
> > -
> > -	indio_dev =3D devm_iio_device_alloc(&spi_dev->dev, sizeof(*chip));
> > -	if (!indio_dev)
> > -		return -ENOMEM;
> > -	chip =3D iio_priv(indio_dev);
> > -
> > -	ret =3D devm_mutex_init(&spi_dev->dev, &chip->lock);
> > -	if (ret)
> > -		return ret;
> > -
> > -	chip->spi_dev =3D spi_dev;
> > -	for (i =3D 0; i <=3D AD7816_CS_MAX; i++)
> > -		chip->oti_data[i] =3D 203;
> > -
> > -	chip->id =3D spi_get_device_id(spi_dev)->driver_data;
> > -	chip->rdwr_pin =3D devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_OUT_HI=
GH);
> > -	if (IS_ERR(chip->rdwr_pin)) {
> > -		ret =3D PTR_ERR(chip->rdwr_pin);
> > -		dev_err(&spi_dev->dev, "Failed to request rdwr GPIO: %d\n",
> > -			ret);
> > -		return ret;
> > -	}
> > -	chip->convert_pin =3D devm_gpiod_get(&spi_dev->dev, "convert",
> > -					   GPIOD_OUT_HIGH);
> > -	if (IS_ERR(chip->convert_pin)) {
> > -		ret =3D PTR_ERR(chip->convert_pin);
> > -		dev_err(&spi_dev->dev, "Failed to request convert GPIO: %d\n",
> > -			ret);
> > -		return ret;
> > -	}
> > -	if (chip->id =3D=3D ID_AD7816 || chip->id =3D=3D ID_AD7817) {
> > -		chip->busy_pin =3D devm_gpiod_get(&spi_dev->dev, "busy",
> > -						GPIOD_IN);
> > -		if (IS_ERR(chip->busy_pin)) {
> > -			ret =3D PTR_ERR(chip->busy_pin);
> > -			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> > -				ret);
> > -			return ret;
> > -		}
> > -	}
> > -
> > -	indio_dev->name =3D spi_get_device_id(spi_dev)->name;
> > -	indio_dev->info =3D &ad7816_info;
> > -	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > -
> > -	if (spi_dev->irq) {
> > -		/* Only low trigger is supported in ad7816/7/8 */
> > -		ret =3D devm_request_threaded_irq(&spi_dev->dev, spi_dev->irq,
> > -						NULL,
> > -						&ad7816_event_handler,
> > -						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> > -						indio_dev->name,
> > -						indio_dev);
> > -		if (ret)
> > -			return ret;
> > -	}
> > -
> > -	ret =3D devm_iio_device_register(&spi_dev->dev, indio_dev);
> > -	if (ret)
> > -		return ret;
> > -
> > -	dev_info(&spi_dev->dev, "%s temperature sensor and ADC registered.\n",
> > -		 indio_dev->name);
> > -
> > -	return 0;
> > -}
> > -
> > -static const struct of_device_id ad7816_of_match[] =3D {
> > -	{ .compatible =3D "adi,ad7816", },
> > -	{ .compatible =3D "adi,ad7817", },
> > -	{ .compatible =3D "adi,ad7818", },
> > -	{ }
> > -};
> > -MODULE_DEVICE_TABLE(of, ad7816_of_match);
> > -
> > -static const struct spi_device_id ad7816_id[] =3D {
> > -	{ .name =3D "ad7816", .driver_data =3D ID_AD7816 },
> > -	{ .name =3D "ad7817", .driver_data =3D ID_AD7817 },
> > -	{ .name =3D "ad7818", .driver_data =3D ID_AD7818 },
> > -	{ }
> > -};
> > -
> > -MODULE_DEVICE_TABLE(spi, ad7816_id);
> > -
> > -static struct spi_driver ad7816_driver =3D {
> > -	.driver =3D {
> > -		.name =3D "ad7816",
> > -		.of_match_table =3D ad7816_of_match,
> > -	},
> > -	.probe =3D ad7816_probe,
> > -	.id_table =3D ad7816_id,
> > -};
> > -module_spi_driver(ad7816_driver);
> > -
> > -MODULE_AUTHOR("Sonic Zhang <sonic.zhang@analog.com>");
> > -MODULE_DESCRIPTION("Analog Devices AD7816/7/8 digital temperature sens=
or driver");
> > -MODULE_LICENSE("GPL v2");
> > --=20
> > 2.47.3
> >  =20

