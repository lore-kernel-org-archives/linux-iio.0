Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F923BE16E
	for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774436516; cv=none; b=Luk7bwoTXUxW7uhWc9fq4Dv1EXoz7dB2gRSWF+Uu1KdqH4dniLTKFOVRnzLp+e2ZXxh8FVYw1XkbWCarJYlYBL6UH31ipkbGCETBi3hnC1kCej3v7voHgtryifVG0CM5JBBahb/fJGx2MPEDpqvN5a1Xo3oiPFkkJZ2I1Sm1Ijo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774436516; c=relaxed/simple;
	bh=cig6sPdMQIkhTTtCcrsqWIpzCRGJ5kA8tX/p0P6Yo20=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pm2iiNi0MXAjGc9Gt39IBN852z79f7rUFD2YUJXz3IMdJPm0chkAusup+jQRA0pVxIjWKrrbwx1ITJVPKYHdjDWElWjgOUe1NX+6/3/sDHLH4JLTQPOkaWxQPspkG2RltwBSpR51IQSCjxE+YPVxOZYlMdmNjqol5apGaHjU6FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPhieP6S; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPhieP6S"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b87970468so1038913f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 25 Mar 2026 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774436513; x=1775041313; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2CmYpByYPZGX4g9nqhPAYqXEmVxCeRwCQg1UHu6Jr9s=;
        b=TPhieP6SQhw2sy7V84ELwhFcyzmNua9Ic6KTAK/H1E7QAqqW4BNhkCqdPBfjWUgHXX
         0R6TfOXOi7+T5iLH7bYjiH61Jg5F0WYa6Y1yVNbKWDVJjjj6ndbUozj8GO5gEbIiGKw+
         9H5ln6GboOl68rFgymt2YrAXO3zZ3cE0dvnAGPZCP+Biy+9wrDtZ92dl0iOf8qIpRdJN
         BwuFkJajcyIMJTSFnl+rJTQdJZ2bH2o8NSXpcYYjHUEp8vGuEiDk7TzmBjCbj4Wmw7Np
         lq6pooptU9EHlhm01sjyFhcqcKsZxHjA+kyxw1PWKDD09kTmInBJOax+0CmCmNA1oAgw
         Ia4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774436513; x=1775041313;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2CmYpByYPZGX4g9nqhPAYqXEmVxCeRwCQg1UHu6Jr9s=;
        b=I/+t1fMyb3NdJC7KbsEhwcWyGh6naOuqlq45T/86Tx4fPv/WYGPavHY7rNObkJ9MoB
         gZG53uBIpBAO0XVF5k+/+cxjLui+o0q7Uu5UNxBm962dQ1MMgdcdkQArIJZ0LhLVtsC8
         OZfcEHae7kAf9gRKxv8RVWtp9Gy3a0nSVivch1tFlHjR+vJrjPO/yC77COnfCTzDrEJQ
         6djLu0hue4FhnwExJUa9jVRr+UBpWxot1efhB787ZZhjvu7hzCP3o/7hfmuo02xtB31L
         5+YlwPytzsZQJNXKaX0sw+HZ3BB+LUySXE0kIHvx9rWkUPU1rfZgKDQRhB8f6UZS+GpH
         L/vA==
X-Gm-Message-State: AOJu0YwOn0jrXxWFBslJqcDt1eR+CbWS1//SIlnkcUQazSh41PS+6T9V
	xKyPsc909IUBUqprGRk3jNnHmGMbWB9A1MOUFu7XyGuIfN8lRffOa6xd
X-Gm-Gg: ATEYQzyoHcos4UpzT9sHwD6g2SxZuylp06tV/cfTKjf2KEYNcLMMUnDYhD4RN9cNXR5
	3UCTn15cicjCny8Wi+maal4HhfqL9CNvm8oFl+1/pyB++4vYemxtLv4dhq9U2hJEajhF9nftct9
	WNQ3MA+HBOjR9JcoERl+U/iEv+V/y/eEgw5jehSFCZqGDMdcoR8JqVID/xOTQ4gQmcfB3pKzbTf
	A3ZQ1Lycg1u4ysZvXAD5EO4VLP+Ep3aHOQzt0TNVmm+XmB+LLMrHzJ17nmdQhaLMLOGqIpzfj6J
	axbZRf5UQSX0lL/PsK2LIpq7kkywZ5BSrSdMECP/4LZ1qCC/b6/kQnaU43SWpGXXHUeVWzTierx
	t+5ILk7AJiePRznYj47I6ZpAHbwertDqBpcZSbWIuAiEQ7iwgWdBhlLkP+qG1w2tDO2ZlESE7AD
	h7Emp6H+bqa7JBFZtQO8ZiVhYfD6BxVR8=
X-Received: by 2002:a05:6000:2483:b0:43b:4aba:8f4f with SMTP id ffacd0b85a97d-43b88a8ead2mr4271739f8f.45.1774436512571;
        Wed, 25 Mar 2026 04:01:52 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64703c27sm46296280f8f.18.2026.03.25.04.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 04:01:52 -0700 (PDT)
Message-ID: <1920a90a223c1394004d269895df54eee720125a.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron	 <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=	
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring	
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 25 Mar 2026 11:02:38 +0000
In-Reply-To: <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
	 <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-03-18 at 13:13 +0800, Alexis Czezar Torreno wrote:
> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
>=20
> Features:
> =C2=A0 - 4 independent DAC channels
> =C2=A0 - Hardware and software LDAC trigger
> =C2=A0 - Configurable output range
> =C2=A0 - PWM-based LDAC control
> =C2=A0 - Dither and toggle modes
> =C2=A0 - Dynamically configurable SPI speed
>=20
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
>=20
> ---

Not sure if everyone is aware of this but AI review in:

https://sashiko.dev/#/patchset/20260318-dev_ad5706r-v3-0-5d078f41e988%40ana=
log.com

The DMA comment is an interesting one. Likely it needs improvement in the r=
eview-prompt repo given
it's one of those case we know what we're doing (at least we think we know =
:)).=C2=A0Still has a point
in that IIO_DMA_MINALIGN should be used.

At some point we need to add some IIO specific bits :)

- Nuno S=C3=A1

> Changes since v1:
> =C2=A0 - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
> =C2=A0 - Removed all custom ext_info sysfs attributes
> =C2=A0 - Simplified to basic raw read/write and read-only scale
> =C2=A0 - SPI read/write can handle multibyte registers
> ---
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0 |=C2=A0 10 +++
> =C2=A0drivers/iio/dac/Makefile=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ad5706r.c | 222 +++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 234 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 17a3d2d45fccb9cd3c93fd35666fb85d17d53cde..3d7bd98b4d1b55836e40687a9=
a3ac9f4935a8acb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1502,6 +1502,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
> +F:	drivers/iio/dac/ad5706r.c
> =C2=A0
> =C2=A0ANALOG DEVICES INC AD7091R DRIVER
> =C2=A0M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index db9f5c711b3df90641f017652fbbef594cc1627d..8ccbdf6dfbca8640a47bf05b4=
afc6b4bf90a7e26 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -178,6 +178,16 @@ config AD5624R_SPI
> =C2=A0	=C2=A0 Say yes here to build support for Analog Devices AD5624R, A=
D5644R and
> =C2=A0	=C2=A0 AD5664R converters (DAC). This driver uses the common SPI i=
nterface.
> =C2=A0
> +config AD5706R
> +	tristate "Analog Devices AD5706R DAC driver"
> +	depends on SPI
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD5706R 4-chann=
el,
> +	=C2=A0 16-bit current output DAC.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called ad5706r.
> +
> =C2=A0config AD9739A
> =C2=A0	tristate "Analog Devices AD9739A RF DAC spi driver"
> =C2=A0	depends on SPI
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 2a80bbf4e80ad557da79ed916027cedff286984b..0034317984985035f7987a744=
899924bfd4612e3 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_AD5449) +=3D ad5449.o
> =C2=A0obj-$(CONFIG_AD5592R_BASE) +=3D ad5592r-base.o
> =C2=A0obj-$(CONFIG_AD5592R) +=3D ad5592r.o
> =C2=A0obj-$(CONFIG_AD5593R) +=3D ad5593r.o
> +obj-$(CONFIG_AD5706R) +=3D ad5706r.o
> =C2=A0obj-$(CONFIG_AD5755) +=3D ad5755.o
> =C2=A0obj-$(CONFIG_AD5758) +=3D ad5758.o
> =C2=A0obj-$(CONFIG_AD5761) +=3D ad5761.o
> diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..840ee7b6db2e05ea35b27ff77=
6f0c5c8a961d9c1
> --- /dev/null
> +++ b/drivers/iio/dac/ad5706r.c
> @@ -0,0 +1,222 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD5706R 16-bit Current Output Digital to Analog Converter
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +
> +/* SPI frame layout */
> +#define AD5706R_RD_MASK			BIT(15)
> +#define AD5706R_ADDR_MASK		GENMASK(11, 0)
> +
> +/* Registers */
> +#define AD5706R_REG_DAC_INPUT_A_CH(x)		(0x60 + ((x) * 2))
> +#define AD5706R_REG_DAC_DATA_READBACK_CH(x)	(0x68 + ((x) * 2))
> +
> +#define AD5706R_DAC_RESOLUTION		16
> +#define AD5706R_DAC_MAX_CODE		BIT(16)
> +#define AD5706R_MULTIBYTE_REG_START	0x14
> +#define AD5706R_MULTIBYTE_REG_END	0x71
> +#define AD5706R_SINGLE_BYTE_LEN		1
> +#define AD5706R_DOUBLE_BYTE_LEN		2
> +
> +struct ad5706r_state {
> +	struct spi_device *spi;
> +	struct mutex lock; /* Protects SPI transfers */
> +
> +	u8 tx_buf[4] __aligned(ARCH_DMA_MINALIGN);
> +	u8 rx_buf[2];
> +};
> +
> +static int ad5706r_reg_len(unsigned int reg)
> +{
> +	if (reg >=3D AD5706R_MULTIBYTE_REG_START && reg <=3D AD5706R_MULTIBYTE_=
REG_END)
> +		return AD5706R_DOUBLE_BYTE_LEN;
> +
> +	return AD5706R_SINGLE_BYTE_LEN;
> +}
> +
> +static int ad5706r_spi_write(struct ad5706r_state *st, u16 reg, u16 val)
> +{
> +	unsigned int num_bytes =3D ad5706r_reg_len(reg);
> +	struct spi_transfer xfer =3D {
> +		.tx_buf =3D st->tx_buf,
> +		.len =3D num_bytes + 2,
> +	};
> +
> +	put_unaligned_be16(reg, &st->tx_buf[0]);
> +
> +	if (num_bytes =3D=3D 1)
> +		st->tx_buf[2] =3D val;
> +	else if (num_bytes =3D=3D 2)
> +		put_unaligned_be16(val, &st->tx_buf[2]);
> +	else
> +		return -EINVAL;
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}
> +
> +static int ad5706r_spi_read(struct ad5706r_state *st, u16 reg, u16 *val)
> +{
> +	unsigned int num_bytes =3D ad5706r_reg_len(reg);
> +	u16 cmd;
> +	int ret;
> +
> +	struct spi_transfer xfer[] =3D {
> +		{
> +			.tx_buf =3D st->tx_buf,
> +			.len =3D 2,
> +		},
> +		{
> +			.rx_buf =3D st->rx_buf,
> +			.len =3D num_bytes,
> +		},
> +	};
> +
> +	cmd =3D AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> +	put_unaligned_be16(cmd, &st->tx_buf[0]);
> +
> +	ret =3D spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
> +	if (ret)
> +		return ret;
> +
> +	if (num_bytes =3D=3D 1)
> +		*val =3D st->rx_buf[0];
> +	else if (num_bytes =3D=3D 2)
> +		*val =3D get_unaligned_be16(st->rx_buf);
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int *val,
> +			=C2=A0=C2=A0=C2=A0 int *val2, long mask)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &st->lock) {
> +			ret =3D ad5706r_spi_read(st, AD5706R_REG_DAC_DATA_READBACK_CH(chan-
> >channel),
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &reg_val);
> +
> +			if (ret)
> +				return ret;
> +
> +			*val =3D reg_val;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val =3D 50;
> +		*val2 =3D AD5706R_DAC_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan, int val,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int val2, long mask)
> +{
> +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val >=3D AD5706R_DAC_MAX_CODE)
> +			return -EINVAL;
> +
> +		guard(mutex)(&st->lock);
> +		return ad5706r_spi_write(st,
> +					 AD5706R_REG_DAC_INPUT_A_CH(chan->channel),
> +					 val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ad5706r_info =3D {
> +	.read_raw =3D ad5706r_read_raw,
> +	.write_raw =3D ad5706r_write_raw,
> +};
> +
> +#define AD5706R_CHAN(_channel) {				\
> +	.type =3D IIO_CURRENT,					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE),	\
> +	.output =3D 1,						\
> +	.indexed =3D 1,						\
> +	.channel =3D _channel,					\
> +}
> +
> +static const struct iio_chan_spec ad5706r_channels[] =3D {
> +	AD5706R_CHAN(0),
> +	AD5706R_CHAN(1),
> +	AD5706R_CHAN(2),
> +	AD5706R_CHAN(3),
> +};
> +
> +static int ad5706r_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad5706r_state *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->spi =3D spi;
> +
> +	ret =3D devm_mutex_init(&spi->dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D "ad5706r";
> +	indio_dev->info =3D &ad5706r_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D ad5706r_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(ad5706r_channels);
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad5706r_of_match[] =3D {
> +	{ .compatible =3D "adi,ad5706r" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ad5706r_of_match);
> +
> +static const struct spi_device_id ad5706r_id[] =3D {
> +	{ "ad5706r" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad5706r_id);
> +
> +static struct spi_driver ad5706r_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad5706r",
> +		.of_match_table =3D ad5706r_of_match,
> +	},
> +	.probe =3D ad5706r_probe,
> +	.id_table =3D ad5706r_id,
> +};
> +module_spi_driver(ad5706r_driver);
> +
> +MODULE_AUTHOR("Alexis Czezar Torreno <alexisczezar.torreno@analog.com>")=
;
> +MODULE_DESCRIPTION("AD5706R 16-bit Current Output DAC driver");
> +MODULE_LICENSE("GPL");
