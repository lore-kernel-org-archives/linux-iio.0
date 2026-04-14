Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F404622CBE6;
	Tue, 14 Apr 2026 18:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776192850; cv=none; b=P0NSGqJNj028ZGndzLCeba7IK1xUQ3PhuQ5fu22Vsm/M6dqdJJRqHsZhq0R0mIrW+OC2s4Fz8EnUQmIJUXBTfjoxOUm3Qrdu79H5paSYgYHEzBqaXLglz6PVlwaQwuRj7RXEVWxqW2IDwds+dK+NUpDhtcFbYCuNOBeqfXtB0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776192850; c=relaxed/simple;
	bh=LuQmmjJdwCVVG5v6DDGS4fNd3ICpGBA3E52fCo0Nw6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMZ5DSJAu1Yrq0daS7+m45GIFDLXP+5wwgoQFfN8NM7keI3pxq3tI/nf94wf626Pq011+Ref8APjEoYve/Y3LbGbH/XyO5vLOdrQGATFGqBphrmanl96BwICIFVKd2QBMG5j9DtP2deLur8NCFKZe/rsLXHpMBM3CeyAVc2mnuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nflHdoN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nflHdoN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E8DC2BCB5;
	Tue, 14 Apr 2026 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776192849;
	bh=LuQmmjJdwCVVG5v6DDGS4fNd3ICpGBA3E52fCo0Nw6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nflHdoN9bQkuLQsg04eH2YmDIfCrMTHPO/MK0tSjojaVi97RR/3J7v6rPyeRutbuw
	 fUP45nXA2G3gGJLnW7puA8/2v0FoKtFwqdktWjiP1i8X26jXdVYwiFMRf0DMPys7Dy
	 upopRI3IwtofZbHy6SWsMR03CHt4Dlhgc74Er67D4UNXmF4rFnf8migEdrip8+Np1h
	 2uJNVCWJpf00Z/2Vx7K/+IWbxag7+iUw12x+7Yyh0dDcf5cOQJSgT1u+C+heUcHli7
	 EWmwdCfs0M09mg4qBAsPR49U9jWJIlXZ9XrE9LDI6UuicQ61VP7mASv6NoS1T0vxH6
	 hGxO2NbeThDsQ==
Date: Tue, 14 Apr 2026 19:54:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <20260414195400.60d39158@jic23-huawei>
In-Reply-To: <20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
References: <20260410-dev_ad5706r-v7-0-af93a4caa186@analog.com>
	<20260410-dev_ad5706r-v7-2-af93a4caa186@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 14:48:17 +0800
Alexis Czezar Torreno <alexisczezar.torreno@analog.com> wrote:

> Add support for the Analog Devices AD5706R, a 4-channel 16-bit
> current output digital-to-analog converter with SPI interface.
> 
> Features:
>   - 4 independent DAC channels
>   - Hardware and software LDAC trigger
>   - Configurable output range
>   - PWM-based LDAC control
>   - Dither and toggle modes
>   - Dynamically configurable SPI speed
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> 
Hi Alexis,

A few little comments from me.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..026f871ce121cd63331b2a34da8879491b2d0f3c
> --- /dev/null
> +++ b/drivers/iio/dac/ad5706r.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD5706R 16-bit Current Output Digital to Analog Converter
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bits.h>
> +#include <linux/dev_printk.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/minmax.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
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

Trivial but I'd expect something called MAX_CODE to be GENMASK(15, 0)
not BIT(16). E.g. inclusive limit.

> +#define AD5706R_MULTIBYTE_REG_START	0x14
> +#define AD5706R_MULTIBYTE_REG_END	0x71
> +#define AD5706R_MAX_REG			0x77
> +#define AD5706R_SINGLE_BYTE_LEN		1
> +#define AD5706R_DOUBLE_BYTE_LEN		2

See below. I'm not sure these two defines bring us anything.

> +
> +struct ad5706r_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +
> +	u8 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buf[4];
> +};
> +
> +static int ad5706r_reg_len(unsigned int reg)
> +{
> +	if (reg >= AD5706R_MULTIBYTE_REG_START && reg <= AD5706R_MULTIBYTE_REG_END)
> +		return AD5706R_DOUBLE_BYTE_LEN;

What do the defines for 2 == 2-bytes and 1 == 1-byte bring us over using numbers
directly?  E.g.

	if (reg >= AD5706R_MULTIBYTE_REG_START && reg <= AD5706R_MULTIBYTE_REG_END)
		return 2;
	return 1;

> +
> +	return AD5706R_SINGLE_BYTE_LEN;
> +}
> +
> +static int ad5706r_regmap_write(void *context, const void *data, size_t count)
> +{
> +	struct ad5706r_state *st = context;
> +	unsigned int num_bytes, val;
> +	u16 reg;
> +
> +	if (count != 4)
> +		return -EINVAL;
> +
> +	reg = get_unaligned_be16(data);
> +	num_bytes = ad5706r_reg_len(reg);
> +
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.len = num_bytes + 2,
> +	};
> +
> +	val = get_unaligned_be32(data);
> +	put_unaligned_be32(val, &st->tx_buf[0]);
> +
> +	/* For single byte, copy the data to the correct position */
> +	if (num_bytes == AD5706R_SINGLE_BYTE_LEN)
> +		st->tx_buf[2] = st->tx_buf[3];

This does feel a bit odd vs using if / else if as you do in the read
case.  Also, same as above wrt to single bytes having a length of
1 meaning that just using a 1 might be easier to read.

> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}

> +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +	unsigned int reg;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!in_range(val, 0, AD5706R_DAC_MAX_CODE))

I'm not seeing a strong reason to use in_range() here (hopefully
I didn't suggest it in an earlier review ;)  It make sense when
we have a  val >= base && val < base + length. With base as 0
and MAX_CODE not 'obviously' from it's name being the length
(it only is becauset he base is 0) this seems odd.

		if (val < 0 || val >= AD5706R_DAC_MAX_CODE)
Though see above on MAX_CODE not being the maximum code...

> +			return -EINVAL;
> +
> +		reg = AD5706R_REG_DAC_INPUT_A_CH(chan->channel);
> +		return regmap_write(st->regmap, reg, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

