Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC13164C7
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781081200; cv=none; b=l4tw0PWZs11lqM0U9VI9e3MWL2IKY0IeRsPoCJNAdcTVBDyBnIt65UyPMbkQMq2Zv8n2I5khhIfFh2dRjgKnKbA0Vr5iytrrk70CzEO7Qhq0zO+oU49Paxf5U1EyD95tD4VbIYCl2CZrsVdFuvyFe1Ul97hU6XNLuXB3hegh/XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781081200; c=relaxed/simple;
	bh=NeSx24dxZtQ9sy+qG7O9bCT4VY81zbpqh04/+x5duE0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d6YBkNW2nGicv1nbJms//lCM5RVomhMFjKAr7+VecUxmhq95Cb5Vpgu4xJ7mBhsq+dhAT5vQpS0XjoukZKxyuQcqHurDnj+VaFR7hx/EML2JZG7lWkILSSMYeaMjt/At4+T6t+I46tkBwTfF7aOrwqNTGJsk7UV57+HkojWVOuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1Ys3kQl; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Ys3kQl"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490cf322ed0so26070395e9.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 01:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781081195; x=1781685995; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vGs0I+e0AtbncbbLJ8DSGgGvhYB2wML/1SYfsR+hrvs=;
        b=a1Ys3kQl94Lv87Dzd1OpebprmA+jOlKGu2a/A4mqW7BToYQe8/B5ajmJKP9c/h+2pi
         Nz5sRj8BoRYl5GSZR3apw+NedklHos2AJ5GllAn2q5PkfzvyHS0Yl9Y2UMXESevLgLlf
         TveVcYVjcTLTTa2Yj8nKQ8cVpeROCyfAZ3AzZ9ouPyZuHs72olFPbdJyQSVHYevNCjfs
         k71d9bBTclfULXpN0fA4YchJo2C9b91cSjCS+fIfrYI4NZ13x5hfpACcDPQnU2enXA0W
         Znvwr+Rq4NGlIcXxkOJQjIwmHZg6R6RPPJ+5mrbMiVIgqjv7gA9b+572bd/TM/j496jC
         lxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781081195; x=1781685995;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vGs0I+e0AtbncbbLJ8DSGgGvhYB2wML/1SYfsR+hrvs=;
        b=msy1ITMcqCXsz8IFZ9pc4p0A7wmznoCEbdkh9vVIlM12HTxHj8UiclEyy/PVF8O7sR
         T1M1XCArqPl111ceELBETsKYOnvMa+nGsw4sJ8Z3/tiEVux/CaG//+rEd5doVSNNKZeB
         10qa7HjCr9DSxamYPHh2eauDHpyN5fTfObESphBRpfXs0Q43r+N4OYwN++ULkdA9lFYZ
         7n4nxx2Z4mfoUaBmewzzCIlpKwQllQOfNX8htibZVdmFXPxG+jJ4fdp6mreZgPssIOuq
         Gq1bnhCmrTrahy26Qc66Oo3Y0It+uBAOkbVp03PUa+go7/+VigQTDiIhgjhnS3yoJ/Eg
         1MrQ==
X-Gm-Message-State: AOJu0Yx3CW6OysAVKFzIfDwFskRYI/lmLnWb0vrjq6CZAkQL4lIiZ/XH
	KoXxoAY+sckd3Y6LsbmQRj/ukv/bFirt/IvLGFQ9CIfHgeP7Rhh/JXJW
X-Gm-Gg: Acq92OGxy3HW9K5ON7YJ66zYsu5FtjnF8NCcQ2lOTT/EhUZR2xbr9+mnI1ViSErMeKm
	ze24Q8JAdim/bZO/jJtRg6yRP2bPNxywwvOm/LEfUEAi8aiTfROpT4YVzaTXEmTfBIuXRI2vd3m
	WC7g7HKfx3erZ/CI0do4dzidSlYryUV3Wa10QyGMsbr1dzsSd2isDiYMr65fO12c6mxXG2lOMq0
	B41c2wilgpImQ3jkoF17VHZAIx7I6ob59ostew94WldWSip1vtMn8jhuX3q6b68z/lIaw4Nd8fF
	r1NnIfDUfXd+xHn6g1wVwckygOtK3mATSA6jYSLTyfJxQPwud3onRnm4C5S4wRohIDZpduWr3AW
	cNvfki77uKW6qAf3hK+imYTRFJXPpg/gyoCrTih76yiQSex7vGPJMqtOuhw6Sul0mnA5OxO3u4r
	D2zbYFHv5jLv8+iTBMcwWhbivmPLhnlM7tbXjglTMZ3K9lANZJBJkwU27dktze0YDeltsbOdpzc
	nIY8LDmkpI7
X-Received: by 2002:a05:600c:529b:b0:48e:6db3:ff2e with SMTP id 5b1f17b1804b1-490c4e0219emr333241345e9.15.1781081195038;
        Wed, 10 Jun 2026 01:46:35 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c1149sm482668185e9.4.2026.06.10.01.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:46:34 -0700 (PDT)
Message-ID: <cd335556e16408bb8d3fa42cd30650b94ca1f28b.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: dac: Add AD5529R DAC driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner	
 <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, 
 Andy Shevchenko	 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel	 <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan	 <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil
	 <jan.sun97@gmail.com>
Date: Wed, 10 Jun 2026 09:47:40 +0100
In-Reply-To: <20260609-ad5529r-driver-v4-2-2e4c02234a1a@analog.com>
References: <20260609-ad5529r-driver-v4-0-2e4c02234a1a@analog.com>
	 <20260609-ad5529r-driver-v4-2-2e4c02234a1a@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-09 at 17:00 +0200, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
>=20
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---

Nothing to add in addition to Andy's comment. With:

* Sashiko point fixed
* And the excess of parenthesis that Andy pointed out

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

(The rest is up to you and Andy :))

> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/Kconfig=C2=A0=C2=A0 |=C2=A0 17 ++
> =C2=A0drivers/iio/dac/Makefile=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/dac/ad5529r.c | 517 +++++++++++++++++++++++++++++++++++=
+++++++++++
> =C2=A04 files changed, 536 insertions(+)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 320e84765ce6..143714e27d51 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1513,6 +1513,7 @@ L:	linux-iio@vger.kernel.org
> =C2=A0S:	Supported
> =C2=A0W:	https://ez.analog.com/linux-software-drivers
> =C2=A0F:	Documentation/devicetree/bindings/iio/dac/adi,ad5529r.yaml
> +F:	drivers/iio/dac/ad5529r.c
> =C2=A0
> =C2=A0ANALOG DEVICES INC AD5706R DRIVER
> =C2=A0M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 657c68e75542..bb1d59889a2a 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -134,6 +134,23 @@ config AD5449
> =C2=A0	=C2=A0 To compile this driver as a module, choose M here: the
> =C2=A0	=C2=A0 module will be called ad5449.
> =C2=A0
> +config AD5529R
> +	tristate "Analog Devices AD5529R High Voltage DAC driver"
> +	depends on SPI_MASTER
> +	select REGMAP_SPI
> +	help
> +	=C2=A0 Say yes here to build support for Analog Devices AD5529R
> +	=C2=A0 16-Channel, 12-Bit/16-Bit, 40V High Voltage Precision Digital to=
 Analog
> +	=C2=A0 Converter.
> +
> +	=C2=A0 The device features multiple output voltage ranges from -20V to =
+20V,
> +	=C2=A0 built-in 4.096V voltage reference, and digital functions includi=
ng
> +	=C2=A0 toggle, dither, and ramp modes. Supports both 12-bit and 16-bit
> +	=C2=A0 resolution variants.
> +
> +	=C2=A0 To compile this driver as a module, choose M here: the
> +	=C2=A0 module will be called ad5529r.
> +
> =C2=A0config AD5592R_BASE
> =C2=A0	tristate
> =C2=A0
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 003431798498..f35e060b3643 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_AD5446) +=3D ad5446.o
> =C2=A0obj-$(CONFIG_AD5446_SPI) +=3D ad5446-spi.o
> =C2=A0obj-$(CONFIG_AD5446_I2C) +=3D ad5446-i2c.o
> =C2=A0obj-$(CONFIG_AD5449) +=3D ad5449.o
> +obj-$(CONFIG_AD5529R) +=3D ad5529r.o
> =C2=A0obj-$(CONFIG_AD5592R_BASE) +=3D ad5592r-base.o
> =C2=A0obj-$(CONFIG_AD5592R) +=3D ad5592r.o
> =C2=A0obj-$(CONFIG_AD5593R) +=3D ad5593r.o
> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..d2d0287d0f95
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c
> @@ -0,0 +1,517 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD5529R Digital-to-Analog Converter Driver
> + * 16-Channel, 12/16-Bit, 40V High Voltage Precision DAC
> + *
> + * Copyright 2026 Analog Devices Inc.
> + * Author: Janani Sunil <janani.sunil@analog.com>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +
> +#define AD5529R_REG_INTERFACE_CONFIG_A		0x00
> +#define AD5529R_REG_DEVICE_CONFIG		0x02
> +#define AD5529R_REG_CHIP_GRADE			0x06
> +#define AD5529R_REG_SCRATCH_PAD			0x0A
> +#define AD5529R_REG_SPI_REVISION		0x0B
> +#define AD5529R_REG_VENDOR_H			0x0D
> +#define AD5529R_REG_STREAM_MODE			0x0E
> +#define AD5529R_REG_INTERFACE_STATUS_A		0x11
> +#define AD5529R_REG_MULTI_DAC_CH_SEL		0x14
> +#define AD5529R_REG_OUT_RANGE_BASE		0x3C
> +#define AD5529R_REG_OUT_RANGE(ch)		(AD5529R_REG_OUT_RANGE_BASE + (ch)
> * 2)
> +#define AD5529R_REG_DAC_INPUT_A_BASE		0x148
> +#define AD5529R_REG_DAC_INPUT_A(ch)		(AD5529R_REG_DAC_INPUT_A_BASE +
> (ch) * 2)
> +#define AD5529R_REG_DAC_DATA_READBACK_BASE	0x16A
> +#define AD5529R_REG_TSENS_ALERT_FLAG		0x18C
> +#define AD5529R_REG_TSENS_SHTD_FLAG		0x18E
> +#define AD5529R_REG_FUNC_BUSY			0x1A0
> +#define AD5529R_REG_REF_SEL			0x1A2
> +#define AD5529R_REG_INIT_CRC_ERR_STAT		0x1A4
> +#define AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC	0x1A8
> +
> +#define=C2=A0=C2=A0 AD5529R_INTERFACE_CONFIG_A_SW_RESET	(BIT(7) | BIT(0)=
)
> +#define=C2=A0=C2=A0 AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION	BIT(5)
> +#define=C2=A0=C2=A0 AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE	BIT(4)
> +#define=C2=A0=C2=A0 AD5529R_REF_SEL_INTERNAL_REF		BIT(0)
> +#define=C2=A0=C2=A0 AD5529R_MAX_REGISTER			0x232
> +#define=C2=A0=C2=A0 AD5529R_8BIT_REG_MAX			0x13
> +#define=C2=A0=C2=A0 AD5529R_SPI_READ_FLAG			0x80
> +
> +struct ad5529r_model_data {
> +	const char *model_name;
> +	unsigned int resolution;
> +	const struct iio_chan_spec *channels;
> +	unsigned int num_channels;
> +};
> +
> +#define AD5529R_DAC_CHANNEL(chan, bits) {			\
> +	.type =3D IIO_VOLTAGE,					\
> +	.indexed =3D 1,						\
> +	.output =3D 1,						\
> +	.channel =3D (chan),					\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |		\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_SCALE) |	\
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BIT(IIO_CHAN_INFO_OFFSET),	\
> +	.scan_type =3D {						\
> +		.format =3D 'u',					\
> +		.realbits =3D (bits),				\
> +		.storagebits =3D 16,				\
> +	},							\
> +}
> +
> +static const char * const ad5529r_supply_names[] =3D {
> +	"vdd",
> +	"avdd",
> +	"hvdd",
> +};
> +
> +static const struct iio_chan_spec ad5529r_channels_16bit[] =3D {
> +	AD5529R_DAC_CHANNEL(0, 16),
> +	AD5529R_DAC_CHANNEL(1, 16),
> +	AD5529R_DAC_CHANNEL(2, 16),
> +	AD5529R_DAC_CHANNEL(3, 16),
> +	AD5529R_DAC_CHANNEL(4, 16),
> +	AD5529R_DAC_CHANNEL(5, 16),
> +	AD5529R_DAC_CHANNEL(6, 16),
> +	AD5529R_DAC_CHANNEL(7, 16),
> +	AD5529R_DAC_CHANNEL(8, 16),
> +	AD5529R_DAC_CHANNEL(9, 16),
> +	AD5529R_DAC_CHANNEL(10, 16),
> +	AD5529R_DAC_CHANNEL(11, 16),
> +	AD5529R_DAC_CHANNEL(12, 16),
> +	AD5529R_DAC_CHANNEL(13, 16),
> +	AD5529R_DAC_CHANNEL(14, 16),
> +	AD5529R_DAC_CHANNEL(15, 16),
> +};
> +
> +static const struct iio_chan_spec ad5529r_channels_12bit[] =3D {
> +	AD5529R_DAC_CHANNEL(0, 12),
> +	AD5529R_DAC_CHANNEL(1, 12),
> +	AD5529R_DAC_CHANNEL(2, 12),
> +	AD5529R_DAC_CHANNEL(3, 12),
> +	AD5529R_DAC_CHANNEL(4, 12),
> +	AD5529R_DAC_CHANNEL(5, 12),
> +	AD5529R_DAC_CHANNEL(6, 12),
> +	AD5529R_DAC_CHANNEL(7, 12),
> +	AD5529R_DAC_CHANNEL(8, 12),
> +	AD5529R_DAC_CHANNEL(9, 12),
> +	AD5529R_DAC_CHANNEL(10, 12),
> +	AD5529R_DAC_CHANNEL(11, 12),
> +	AD5529R_DAC_CHANNEL(12, 12),
> +	AD5529R_DAC_CHANNEL(13, 12),
> +	AD5529R_DAC_CHANNEL(14, 12),
> +	AD5529R_DAC_CHANNEL(15, 12),
> +};
> +
> +static const struct ad5529r_model_data ad5529r_16bit_model_data =3D {
> +	.model_name =3D "ad5529r-16",
> +	.resolution =3D 16,
> +	.channels =3D ad5529r_channels_16bit,
> +	.num_channels =3D ARRAY_SIZE(ad5529r_channels_16bit),
> +};
> +
> +static const struct ad5529r_model_data ad5529r_12bit_model_data =3D {
> +	.model_name =3D "ad5529r-12",
> +	.resolution =3D 12,
> +	.channels =3D ad5529r_channels_12bit,
> +	.num_channels =3D ARRAY_SIZE(ad5529r_channels_12bit),
> +};
> +
> +enum ad5529r_output_range {
> +	AD5529R_RANGE_0V_5V,
> +	AD5529R_RANGE_0V_10V,
> +	AD5529R_RANGE_0V_20V,
> +	AD5529R_RANGE_0V_40V,
> +	AD5529R_RANGE_NEG5V_5V,
> +	AD5529R_RANGE_NEG10V_10V,
> +	AD5529R_RANGE_NEG15V_15V,
> +	AD5529R_RANGE_NEG20V_20V,
> +};
> +
> +static const s32 ad5529r_output_ranges_mv[8][2] =3D {
> +	[AD5529R_RANGE_0V_5V] =3D { 0, 5000 },
> +	[AD5529R_RANGE_0V_10V] =3D { 0, 10000 },
> +	[AD5529R_RANGE_0V_20V] =3D { 0, 20000 },
> +	[AD5529R_RANGE_0V_40V] =3D { 0, 40000 },
> +	[AD5529R_RANGE_NEG5V_5V] =3D { -5000, 5000 },
> +	[AD5529R_RANGE_NEG10V_10V] =3D { -10000, 10000 },
> +	[AD5529R_RANGE_NEG15V_15V] =3D { -15000, 15000 },
> +	[AD5529R_RANGE_NEG20V_20V] =3D { -20000, 20000 },
> +};
> +
> +struct ad5529r_state {
> +	struct spi_device *spi;
> +	const struct ad5529r_model_data *model_data;
> +	struct regmap *regmap_8bit;
> +	struct regmap *regmap_16bit;
> +	enum ad5529r_output_range output_range_idx[16];
> +};
> +
> +static const struct regmap_range ad5529r_8bit_readable_ranges[] =3D {
> +	regmap_reg_range(AD5529R_REG_INTERFACE_CONFIG_A, AD5529R_REG_CHIP_GRADE=
),
> +	regmap_reg_range(AD5529R_REG_SCRATCH_PAD, AD5529R_REG_VENDOR_H),
> +	regmap_reg_range(AD5529R_REG_STREAM_MODE, AD5529R_REG_INTERFACE_STATUS_=
A),
> +};
> +
> +static const struct regmap_range ad5529r_16bit_readable_ranges[] =3D {
> +	regmap_reg_range(AD5529R_REG_MULTI_DAC_CH_SEL,
> AD5529R_REG_INIT_CRC_ERR_STAT),
> +	regmap_reg_range(AD5529R_REG_MULTI_DAC_HOTPATH_SW_LDAC,
> AD5529R_MAX_REGISTER),
> +};
> +
> +static const struct regmap_access_table ad5529r_8bit_readable_table =3D =
{
> +	.yes_ranges =3D ad5529r_8bit_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(ad5529r_8bit_readable_ranges),
> +};
> +
> +static const struct regmap_access_table ad5529r_16bit_readable_table =3D=
 {
> +	.yes_ranges =3D ad5529r_16bit_readable_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(ad5529r_16bit_readable_ranges),
> +};
> +
> +static const struct regmap_range ad5529r_8bit_read_only_ranges[] =3D {
> +	regmap_reg_range(AD5529R_REG_DEVICE_CONFIG, AD5529R_REG_CHIP_GRADE),
> +	regmap_reg_range(AD5529R_REG_SPI_REVISION, AD5529R_REG_VENDOR_H),
> +};
> +
> +static const struct regmap_range ad5529r_16bit_read_only_ranges[] =3D {
> +	regmap_reg_range(AD5529R_REG_DAC_DATA_READBACK_BASE,
> +			 (AD5529R_REG_DAC_DATA_READBACK_BASE + 15 * 2)),
> +	regmap_reg_range(AD5529R_REG_TSENS_ALERT_FLAG,
> AD5529R_REG_TSENS_SHTD_FLAG),
> +	regmap_reg_range(AD5529R_REG_FUNC_BUSY, AD5529R_REG_FUNC_BUSY),
> +	regmap_reg_range(AD5529R_REG_INIT_CRC_ERR_STAT,
> AD5529R_REG_INIT_CRC_ERR_STAT),
> +};
> +
> +static const struct regmap_access_table ad5529r_8bit_writeable_table =3D=
 {
> +	.no_ranges =3D ad5529r_8bit_read_only_ranges,
> +	.n_no_ranges =3D ARRAY_SIZE(ad5529r_8bit_read_only_ranges),
> +};
> +
> +static const struct regmap_access_table ad5529r_16bit_writeable_table =
=3D {
> +	.no_ranges =3D ad5529r_16bit_read_only_ranges,
> +	.n_no_ranges =3D ARRAY_SIZE(ad5529r_16bit_read_only_ranges),
> +};
> +
> +static const struct regmap_config ad5529r_regmap_8bit_config =3D {
> +	.name =3D "ad5529r-8bit",
> +	.reg_bits =3D 16,
> +	.val_bits =3D 8,
> +	.max_register =3D AD5529R_8BIT_REG_MAX,
> +	.read_flag_mask =3D AD5529R_SPI_READ_FLAG,
> +	.rd_table =3D &ad5529r_8bit_readable_table,
> +	.wr_table =3D &ad5529r_8bit_writeable_table,
> +};
> +
> +static const struct regmap_config ad5529r_regmap_16bit_config =3D {
> +	.name =3D "ad5529r-16bit",
> +	.reg_bits =3D 16,
> +	.val_bits =3D 16,
> +	.max_register =3D AD5529R_MAX_REGISTER,
> +	.read_flag_mask =3D AD5529R_SPI_READ_FLAG,
> +	.val_format_endian =3D REGMAP_ENDIAN_LITTLE,
> +	.rd_table =3D &ad5529r_16bit_readable_table,
> +	.wr_table =3D &ad5529r_16bit_writeable_table,
> +	.reg_stride =3D 2,
> +};
> +
> +static struct regmap *ad5529r_get_regmap(struct ad5529r_state *st,
> +					 unsigned int reg)
> +{
> +	if (reg <=3D AD5529R_8BIT_REG_MAX)
> +		return st->regmap_8bit;
> +
> +	return st->regmap_16bit;
> +}
> +
> +static int ad5529r_reset(struct ad5529r_state *st)
> +{
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret =3D reset_control_deassert(rst);
> +		if (ret)
> +			return ret;
> +	} else {
> +		ret =3D regmap_write(st->regmap_8bit,
> AD5529R_REG_INTERFACE_CONFIG_A,
> +				=C2=A0=C2=A0 AD5529R_INTERFACE_CONFIG_A_SW_RESET);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/*
> +	 * Wait 10 ms for digital initialization to complete.
> +	 * Per datasheet, Interface Status A register NOT_READY_ERR bit is
> +	 * set if SPI transactions are attempted before digital initialization
> +	 * completes.
> +	 */
> +	fsleep(10000);
> +
> +	return regmap_write(st->regmap_8bit, AD5529R_REG_INTERFACE_CONFIG_A,
> +			=C2=A0=C2=A0=C2=A0 AD5529R_INTERFACE_CONFIG_A_SDO_ENABLE |
> +			=C2=A0=C2=A0=C2=A0 AD5529R_INTERFACE_CONFIG_A_ADDR_ASCENSION);
> +}
> +
> +static int ad5529r_read_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0 int *val, int *val2, long mask)
> +{
> +	struct ad5529r_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_addr, reg_val_h;
> +	int ret, range_idx, span_mv;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/*
> +		 * Read from DAC_INPUT_A register rather than DAC_DATA_READBACK.
> +		 * The DAC operates in transparent mode and directly reflects
> +		 * whatever value is written to the INPUT_A register.
> +		 */
> +		reg_addr =3D AD5529R_REG_DAC_INPUT_A(chan->channel);
> +		ret =3D regmap_read(st->regmap_16bit, reg_addr, &reg_val_h);
> +		if (ret)
> +			return ret;
> +
> +		*val =3D reg_val_h;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		range_idx =3D st->output_range_idx[chan->channel];
> +
> +		span_mv =3D ad5529r_output_ranges_mv[range_idx][1] -
> +			=C2=A0 ad5529r_output_ranges_mv[range_idx][0];
> +		*val =3D span_mv;
> +		*val2 =3D st->model_data->resolution;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		range_idx =3D st->output_range_idx[chan->channel];
> +
> +		if (ad5529r_output_ranges_mv[range_idx][0] < 0)
> +			*val =3D -(1 << (st->model_data->resolution - 1));
> +		else
> +			*val =3D 0;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5529r_write_raw(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_chan_spec const *chan,
> +			=C2=A0=C2=A0=C2=A0=C2=A0 int val, int val2, long mask)
> +{
> +	struct ad5529r_state *st =3D iio_priv(indio_dev);
> +	unsigned int reg_addr;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > GENMASK(st->model_data->resolution - 1, 0))
> +			return -EINVAL;
> +
> +		reg_addr =3D AD5529R_REG_DAC_INPUT_A(chan->channel);
> +
> +		return regmap_write(st->regmap_16bit, reg_addr, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5529r_find_output_range(const s32 *vals)
> +{
> +	for (unsigned int i =3D 0; i < ARRAY_SIZE(ad5529r_output_ranges_mv); i+=
+) {
> +		if (vals[0] =3D=3D ad5529r_output_ranges_mv[i][0] * 1000 &&
> +		=C2=A0=C2=A0=C2=A0 vals[1] =3D=3D ad5529r_output_ranges_mv[i][1] * 100=
0)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5529r_parse_channel_ranges(struct device *dev,
> +					struct ad5529r_state *st)
> +{
> +	int ret, range_idx;
> +	u32 ch;
> +	s32 vals[2];
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		range_idx =3D AD5529R_RANGE_0V_5V;
> +
> +		ret =3D fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Missing reg property in channel
> node\n");
> +
> +		if (ch >=3D 16)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid channel number: %u\n", ch);
> +
> +		/* Read u32 property into s32 to handle negative voltage ranges */
> +		if (!fwnode_property_read_u32_array(child,
> +						=C2=A0=C2=A0=C2=A0 "adi,output-range-microvolt",
> +						=C2=A0=C2=A0=C2=A0 (u32 *)vals,
> ARRAY_SIZE(vals))) {
> +			range_idx =3D ad5529r_find_output_range(vals);
> +			if (range_idx < 0)
> +				return dev_err_probe(dev, range_idx,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid range [%d %d] for ch
> %u\n",
> +						=C2=A0=C2=A0=C2=A0=C2=A0 vals[0], vals[1], ch);
> +		}
> +
> +		st->output_range_idx[ch] =3D range_idx;
> +		ret =3D regmap_write(st->regmap_16bit,
> +				=C2=A0=C2=A0 AD5529R_REG_OUT_RANGE(ch), range_idx);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to configure range for ch
> %u\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ch);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad5529r_reg_access(struct iio_dev *indio_dev,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int reg,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int writeval,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *readval)
> +{
> +	struct ad5529r_state *st =3D iio_priv(indio_dev);
> +
> +	if (readval)
> +		return regmap_read(ad5529r_get_regmap(st, reg), reg, readval);
> +
> +	return regmap_write(ad5529r_get_regmap(st, reg), reg, writeval);
> +}
> +
> +static const struct iio_info ad5529r_info =3D {
> +	.read_raw =3D ad5529r_read_raw,
> +	.write_raw =3D ad5529r_write_raw,
> +	.debugfs_reg_access =3D ad5529r_reg_access,
> +};
> +
> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5529r_state *st;
> +	bool external_vref;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +
> +	st->spi =3D spi;
> +
> +	st->model_data =3D spi_get_device_match_data(spi);
> +	if (!st->model_data)
> +		return dev_err_probe(dev, -EINVAL, "Failed to identify device
> variant\n");
> +
> +	ret =3D devm_regulator_bulk_get_enable(dev,
> ARRAY_SIZE(ad5529r_supply_names),
> +					=C2=A0=C2=A0=C2=A0=C2=A0 ad5529r_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get and enable regulators\n");
> +
> +	ret =3D devm_regulator_get_enable_optional(dev, "hvss");
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get and enable hvss regulator\n"=
);
> +
> +	/*
> +	 * The datasheet mentions a 4.096V external reference for correct
> +	 * operation.
> +	 */
> +	ret =3D devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret && ret !=3D -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get and enable vref regulator\n"=
);
> +
> +	external_vref =3D ret !=3D -ENODEV;
> +
> +	st->regmap_8bit =3D devm_regmap_init_spi(spi, &ad5529r_regmap_8bit_conf=
ig);
> +	if (IS_ERR(st->regmap_8bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize 8-bit regmap\n");
> +
> +	st->regmap_16bit =3D devm_regmap_init_spi(spi,
> &ad5529r_regmap_16bit_config);
> +	if (IS_ERR(st->regmap_16bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize 16-bit regmap\n");
> +
> +	ret =3D ad5529r_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> +
> +	ret =3D regmap_assign_bits(st->regmap_16bit, AD5529R_REG_REF_SEL,
> +				 AD5529R_REF_SEL_INTERNAL_REF,
> +				 external_vref ? 0 :
> AD5529R_REF_SEL_INTERNAL_REF);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to configure reference\n");
> +
> +	ret =3D ad5529r_parse_channel_ranges(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D st->model_data->model_name;
> +	indio_dev->info =3D &ad5529r_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D st->model_data->channels;
> +	indio_dev->num_channels =3D st->model_data->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id ad5529r_of_match[] =3D {
> +	{ .compatible =3D "adi,ad5529r-16", .data =3D &ad5529r_16bit_model_data=
 },
> +	{ .compatible =3D "adi,ad5529r-12", .data =3D &ad5529r_12bit_model_data=
 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad5529r_of_match);
> +
> +static const struct spi_device_id ad5529r_id[] =3D {
> +	{
> +		.name =3D "ad5529r-16",
> +		.driver_data =3D (kernel_ulong_t)&ad5529r_16bit_model_data,
> +	},
> +	{
> +		.name =3D "ad5529r-12",
> +		.driver_data =3D (kernel_ulong_t)&ad5529r_12bit_model_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad5529r_id);
> +
> +static struct spi_driver ad5529r_driver =3D {
> +	.driver =3D {
> +		.name =3D "ad5529r",
> +		.of_match_table =3D ad5529r_of_match,
> +	},
> +	.probe =3D ad5529r_probe,
> +	.id_table =3D ad5529r_id,
> +};
> +module_spi_driver(ad5529r_driver);
> +
> +MODULE_AUTHOR("Janani Sunil <janani.sunil@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5529R 12/16-bit DAC driver");
> +MODULE_LICENSE("GPL");
