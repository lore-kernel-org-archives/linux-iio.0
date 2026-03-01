Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DDA1CD1E4;
	Sun,  1 Mar 2026 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371215; cv=none; b=mB7wgEW72gvoft2q4LvumCn2/OUCeULVP5VmNUNUQ9pDX2Gi/VG3mfagzjqrTQYZkNznetOsyD1ZDC4Io77gkwe+vJcSTBtApzUjtzHXlqqoXTTIIikxl1iHSuR+7jxMwjMYadFNdA7gHczr1AVFUflUcZrPrEIoj/3wTO4pffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371215; c=relaxed/simple;
	bh=gpngj2HAvgyPNEXXX+2KPhZl8mqWYg7VMQ7T7RLeJmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lACTSzV0hdSK9I2JlK2/rY0cH+q9bWyDKURp6YlYMFARe8QcX33kAZcZOEOoB5Kkw4xxYy8KWZIjDHNXQ3AS6w9kUnq9/cEn6zhhUgFLp+i5TMKmAKeMP11VstyQFgHqDRLDyHNNDLxxGH08ItMGB6h7cx0iC+JbrbY0gbDQd+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwRCF3Ru; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwRCF3Ru"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EBFC116C6;
	Sun,  1 Mar 2026 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772371214;
	bh=gpngj2HAvgyPNEXXX+2KPhZl8mqWYg7VMQ7T7RLeJmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nwRCF3RuqMYgxOOjzW7PtA67uVM2RPBz7aQGn6SYo7oBhTsB8kwjEeT0zOubQjrZm
	 hzEck+QTJfhUirpVrO7tEiTSkxcjHf+M+iNTGhl9Uz3P+GopPzOyDanue8OnEXc2cv
	 KL12eC4Jj6/aCPmKTNsk8mKKQhP7JDMogSJwEr+mEfAiI7ZHiBC5nm7gKHRwMeuaME
	 WoZKW9YkxBN1ZtEtHJuUXIQztNlD6uDLRLZj+hvKQiPoSIJCbsEsedTIFr4SIM9AkP
	 +o/rkYsV6I2GW5Yatc5GvCMYkKb1NEcRHZu9O4uriJECd91b89tLoGZ3liX/n9wePW
	 H7XDYlxlL2NQQ==
Date: Sun, 1 Mar 2026 13:20:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 2/8] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <20260301132004.3e00a53d@jic23-huawei>
In-Reply-To: <20260220-ad9910-iio-driver-v1-2-3b264aa48a10@analog.com>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
	<20260220-ad9910-iio-driver-v1-2-3b264aa48a10@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Feb 2026 16:46:06 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add the core AD9910 DDS driver infrastructure with single tone mode
> support. This includes SPI register access, profile management via
> GPIO pins, PLL/DAC configuration from firmware properties, and
> single tone frequency/phase/amplitude control through IIO channels.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Fairly superficial review below.

Obviously lots of open questions on this driver but I'm still
trying to get a basic understanding on what is here.

Thanks,

Jonathan



> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> new file mode 100644
> index 000000000000..82b817c05975
> --- /dev/null
> +++ b/drivers/iio/frequency/ad9910.c
> @@ -0,0 +1,931 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD9910 SPI DDS (Direct Digital Synthesizer) driver
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */

> +
> +/* Register addresses */
> +#define AD9910_REG_CFR1			0x00
> +#define AD9910_REG_CFR2			0x01
> +#define AD9910_REG_CFR3			0x02
> +#define AD9910_REG_AUX_DAC		0x03
> +#define AD9910_REG_IO_UPDATE_RATE	0x04
> +#define AD9910_REG_FTW			0x07
> +#define AD9910_REG_POW			0x08
> +#define AD9910_REG_ASF			0x09
> +#define AD9910_REG_MULTICHIP_SYNC	0x0A
> +#define AD9910_REG_DRG_LIMIT		0x0B
> +#define AD9910_REG_DRG_STEP		0x0C
> +#define AD9910_REG_DRG_RATE		0x0D
> +#define AD9910_REG_PROFILE0		0x0E
> +#define AD9910_REG_PROFILE1		0x0F
> +#define AD9910_REG_PROFILE2		0x10
> +#define AD9910_REG_PROFILE3		0x11
> +#define AD9910_REG_PROFILE4		0x12
> +#define AD9910_REG_PROFILE5		0x13
> +#define AD9910_REG_PROFILE6		0x14
> +#define AD9910_REG_PROFILE7		0x15
> +#define AD9910_REG_RAM			0x16
> +
> +#define AD9910_REG_NUM_CACHED		0x16

> +
> +#define AD9910_REG_PROFILE(x)		(AD9910_REG_PROFILE0 + (x))
> +#define AD9910_REG_HIGH32_FLAG		0x100
> +#define AD9910_REG_HIGH32_MSK		GENMASK_ULL(63, 32)
> +#define AD9910_REG_LOW32_MSK		GENMASK_ULL(31, 0)

I'd rather see the GENMASK_ULL inline for these so it is really obvious
what is going on.


> +struct ad9910_state {
> +	struct spi_device *spi;
> +	struct clk *refclk;
> +
> +	struct gpio_desc *gpio_pwdown;
> +	struct gpio_desc *gpio_update;
> +	struct gpio_descs *gpio_profile;
> +
> +	/* cached registers */
> +	union {
> +		u64 val64;
> +		u32 val32;
> +		u16 val16;
> +	} reg[AD9910_REG_NUM_CACHED];
> +
> +	/*
> +	 * Lock for accessing device registers and state variables.
Single line comment should be fine here.

> +	 */
> +	struct mutex lock;
> +
> +	struct ad9910_data data;
> +	u8 profile;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer
> +	 * buffers to live in their own cache lines.
> +	 */
> +	u8 buf[AD9910_SPI_MESSAGE_LEN_MAX] __aligned(IIO_DMA_MINALIGN);
> +};


> +static inline int ad9910_spi_read(struct ad9910_state *st, u8 reg, size_t len)
> +{
> +	st->buf[0] = AD9910_SPI_READ | (reg & AD9910_SPI_ADDR_MASK);

Use FIELD_PREP() for that reg & ... as then we don't have to care about the
shift of that mask (which I assume is 0).

> +	return spi_write_then_read(st->spi, &st->buf[0], 1,

I'd use a pair of buffers.  Tiny one for rx and the buf you have already for the
tx.  As you are using spi_write_then_read() neither has to be dma safe
(will be bounced anyway).  So the tx buffer can be on the stack.
I'm not that keen on the rx value having to be extracted from the storage
in st->buf[1] etc by the caller. I think it would be more elegant
to copy it out in here.


> +				   &st->buf[AD9910_SPI_DATA_IDX], len);
> +}
> +
> +static inline int ad9910_spi_write(struct ad9910_state *st, u8 reg, size_t len,
> +				   bool update)
> +{
> +	int ret;
> +
> +	st->buf[0] = reg & AD9910_SPI_ADDR_MASK;
> +	ret = spi_write(st->spi, st->buf, AD9910_SPI_DATA_IDX + len);

The buffers are small so you can just use spi_write_then_read() here with
no need for DMA safe buffers (rx length can be 0).


> +	if (!ret && update)
> +		return ad9910_io_update(st);
> +
> +	return ret;
> +}
> +
> +#define AD9910_REG_READ_FN(nb)						\
> +static inline int ad9910_reg##nb##_read(struct ad9910_state *st,	\
> +					u8 reg, u##nb * data)		\
> +{									\
> +	int ret;							\
> +									\
> +	ret = ad9910_spi_read(st, reg, sizeof(*data));			\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	*data = get_unaligned_be##nb(&st->buf[AD9910_SPI_DATA_IDX]);	\

with the suggested split of the buffer storage above (into tx and rx)
this can then be aligned data.

I'm not that keen on this set of macros but a triple regmap solution isn't
really clean either.

> +	return ret;							\
> +}
> +
> +AD9910_REG_READ_FN(16)
> +AD9910_REG_READ_FN(32)
> +AD9910_REG_READ_FN(64)

> +
> +#define AD9910_EXT_INFO(_name, _ident, _shared) { \
> +	.name = _name, \
> +	.read = ad9910_ext_info_read, \
> +	.write = ad9910_ext_info_write, \
> +	.private = _ident, \
> +	.shared = _shared, \
> +}
For me this macro doesn't feel worthwhile. I'd rather see the assignments below
even if it takes a few more lines.

> +
> +static const struct iio_chan_spec_ext_info ad9910_shared_ext_info[] = {
> +	AD9910_EXT_INFO("profile", AD9910_PROFILE, IIO_SHARED_BY_TYPE),

This needs documentation as new ABI. That will make it easier to discuss
how this might otherwise be done.

Something in Documentation/ABI/testing/sysfs-bus-iio-ad9910


> +	AD9910_EXT_INFO("powerdown", AD9910_POWERDOWN, IIO_SHARED_BY_TYPE),
> +	{ },
No trailing comma as it terminates this array.

> +};


> +static int ad9910_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int ret;
> +	u64 tmp64;
> +	u32 tmp32;
> +	u16 tmp16;
> +	bool high32 = !!(reg & AD9910_REG_HIGH32_FLAG);

I'd use FIELD_GET() but not really important.

This splitting 64 bit registers in two for the debugfs read/write interface
needs to be documented somewhere.

> +
> +	reg &= ~AD9910_REG_HIGH32_FLAG;
> +	if (reg >= AD9910_REG_RAM)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (reg) {
> +	case AD9910_REG_DRG_LIMIT:
> +	case AD9910_REG_DRG_STEP:
> +	case AD9910_REG_PROFILE0:
> +	case AD9910_REG_PROFILE1:
> +	case AD9910_REG_PROFILE2:
> +	case AD9910_REG_PROFILE3:
> +	case AD9910_REG_PROFILE4:
> +	case AD9910_REG_PROFILE5:
> +	case AD9910_REG_PROFILE6:
> +	case AD9910_REG_PROFILE7:
> +		if (readval) {
> +			ret = ad9910_reg64_read(st, reg, &tmp64);
> +			if (ret < 0)
> +				return ret;
> +
> +			if (high32)
> +				*readval = upper_32_bits(tmp64);
> +			else
> +				*readval = lower_32_bits(tmp64);
> +		} else {
> +			tmp64 = st->reg[reg].val64;
> +			if (high32)
> +				FIELD_MODIFY(AD9910_REG_HIGH32_MSK, &tmp64, writeval);
> +			else
> +				FIELD_MODIFY(AD9910_REG_LOW32_MSK, &tmp64, writeval);
> +
> +			return ad9910_reg64_write(st, reg, tmp64, true);
> +		}
> +		break;
> +	case AD9910_REG_POW:
> +		if (!readval)
> +			return ad9910_reg16_write(st, reg, writeval, true);
> +
> +		ret = ad9910_reg16_read(st, reg, &tmp16);
> +		if (ret < 0)
> +			return ret;
> +		*readval = tmp16;
> +		break;
> +	default:
> +		if (!readval)
> +			return ad9910_reg32_write(st, reg, writeval, true);
> +
> +		ret = ad9910_reg32_read(st, reg, &tmp32);
> +		if (ret < 0)
> +			return ret;
> +		*readval = tmp32;
> +		break;
> +	}
> +
> +	return ret;
> +}

> +
> +static int ad9910_probe(struct spi_device *spi)
> +{
> +	struct reset_control *dev_rst, *io_rst;
> +	struct gpio_desc *io_rst_gpio;
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad9910_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	spi_set_drvdata(spi, indio_dev);

I'm not immediately spotting where this is used. If it is only needed
after some later patch, bring it in there.

> +
> +	st->refclk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(st->refclk))
> +		return dev_err_probe(dev, PTR_ERR(st->refclk),
> +				     "Failed to get reference clock\n");

...

> +
> +static const struct spi_device_id ad9910_id[] = {
> +	{"ad9910", 0},
> +	{}
	{ "ad9910" },
	{ }

Both because that's the preferred formatting for IIO and because
it's consistent with the of_device_id table below.

> +};
> +MODULE_DEVICE_TABLE(spi, ad9910_id);
> +
> +static const struct of_device_id ad9910_of_match[] = {
> +	{ .compatible = "adi,ad9910" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad9910_of_match);
>
