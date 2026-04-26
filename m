Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210521DE894;
	Sun, 26 Apr 2026 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777203758; cv=none; b=c72N0D4ntLXTNG5od3qTwWb6mRlrG3M45CrkaI3dztXvZ0cp+dVj27JLxnlwoW4kETmxnvNYP4wf44YUL0tgKQGOxC2c5F6yfvbgmHAxSLJtUMyHfQVIdqQhQ6PR4W0l4KUYV5QRTAjAojz8nQMYmadZlIejaDIGzSl1olgDZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777203758; c=relaxed/simple;
	bh=K/n2PJBYI3jQQZkrg48S/03UUmoG7V16gc/fvI167qM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3w8qEvWZEgUD7Qc9O7DN0tnWM14/FYCk0DiSic/emqNjcW0P8MPTw8omElI14gNqOY+EGsAafIh0g/kNC8xadoPHhYDq5U5D/ipFqcDgmPTGKChZeOI5jgSi4zstf+MRdwglypdgzeHXTogtHsrBmRJ1JAG7znCuZ5cLATWZ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nzb901Oq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nzb901Oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC67CC2BCAF;
	Sun, 26 Apr 2026 11:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777203757;
	bh=K/n2PJBYI3jQQZkrg48S/03UUmoG7V16gc/fvI167qM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nzb901OqQ4oySmq4Yk7BnUpGfB17eFjiw3ZQrVE/at93/snBXlZwLt6PLBc7Zu0cD
	 e0BXlBuFwyBNWSL1WW/T5igQns9Dd81wei12RMLRfzMKU95F8rXZ8rmM4PQdJbHw/K
	 DgTzYiilf5evIgcY/PGmeJzP6IX8404GdNgI049zLM958q6GyJ/UtVkg/+UvL+0rLN
	 NZOJnqMyScnwzUvfWTbRgTeJ/KV/vy/4R5uY7UovzygG366iAPQDI+T1tjXHg7YzOL
	 vKc3f3h+Ahi7Fnh6RVaMGn9e4UeBkYEihrq/cS7/RCB+dRKtebBr8xQiabp0ZovIqC
	 1sElI5+jgqk1Q==
Date: Sun, 26 Apr 2026 12:42:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v3 2/9] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <20260426124226.5e21458f@jic23-huawei>
In-Reply-To: <20260417-ad9910-iio-driver-v3-2-29b93712a228@analog.com>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
	<20260417-ad9910-iio-driver-v3-2-29b93712a228@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:17:31 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add the core AD9910 DDS driver infrastructure with single tone mode
> support. This includes SPI register access, profile management via GPIO
> pins, PLL/DAC configuration from firmware properties, and single tone
> frequency/phase/amplitude control through IIO attributes.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo

Minor stuff inline.  This looks pretty clean on the whole.
I'll leave ABI discussion for documentation patches.

Thanks,

Jonathan

> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> new file mode 100644
> index 000000000000..e9005037db1a
> --- /dev/null
> +++ b/drivers/iio/frequency/ad9910.c
...


> +struct ad9910_state {
> +	struct spi_device *spi;
> +	struct clk *refclk;
> +
> +	struct gpio_desc *gpio_pwdown;
> +	struct gpio_desc *gpio_update;
> +	struct gpio_descs *gpio_profile;
> +
> +	/* cached registers */
> +	union ad9910_reg reg[AD9910_REG_NUM_CACHED];
> +
> +	/* Lock for accessing device registers and state variables */
> +	struct mutex lock;
> +
> +	struct ad9910_data data;
> +	u8 profile;
> +
> +	union {
> +		__be64 be64;
> +		__be32 be32;
> +		__be16 be16;
> +	} rx_buf;
By tweaking the macros a little you should be able to use a suitably sized
__bexx on the stack instead of messing around with a union in here.
I think that'll end up simpler.

> +	/*
> +	 * RAM loading requires a reasonable amount of bytes, at the same time
> +	 * DMA capable SPI drivers requires the transfer buffers to live in
> +	 * their own cache lines.
> +	 */
> +	u8 tx_buf[AD9910_SPI_MESSAGE_LEN_MAX] __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +/**
> + * ad9910_rational_scale() - Perform scaling of input given a reference.
> + * @input: The input value to be scaled.
> + * @scale: The numerator of the scaling factor.
> + * @reference: The denominator of the scaling factor.
> + *
> + * Closest rounding with mul_u64_add_u64_div_u64
> + *
> + * Return: The scaled value.
> + */
> +#define ad9910_rational_scale(input, scale, reference) ({	\
> +	u64 _tmp = (reference);					\
> +	mul_u64_add_u64_div_u64(input, scale, _tmp >> 1, _tmp);	\

Why a macro?  I'd just do a helper function and let the compiler figure
out if it should inline.

> +})
> +
> +static int ad9910_io_update(struct ad9910_state *st)
> +{
> +	if (st->gpio_update) {
> +		gpiod_set_value_cansleep(st->gpio_update, 1);
> +		udelay(1);
> +		gpiod_set_value_cansleep(st->gpio_update, 0);
> +	}
> +
> +	return 0;
> +}
> +
> +static inline int ad9910_spi_read(struct ad9910_state *st, u8 reg, size_t len)
> +{
> +	st->tx_buf[0] = AD9910_SPI_READ_MSK |
> +			FIELD_PREP(AD9910_SPI_ADDR_MSK, reg);

Given spi_write_then_read() bounces everything might as well use a local u8 on
the stack for tx.

> +	return spi_write_then_read(st->spi, st->tx_buf, 1, &st->rx_buf, len);
> +}
> +
> +static inline int ad9910_spi_write(struct ad9910_state *st, u8 reg, size_t len,
> +				   bool update)
> +{
> +	int ret;
> +
> +	st->tx_buf[0] = FIELD_PREP(AD9910_SPI_ADDR_MSK, reg);
> +	ret = spi_write(st->spi, st->tx_buf, AD9910_SPI_DATA_IDX + len);
> +	if (!ret && update)
> +		return ad9910_io_update(st);
	if (ret)
		return ret;

	if (!update)
		return 0;

	return ad9910_io_update(st);

Takes more lines but easier to follow. Tweak the !update bit to go the 
other way if that makes more sense once more of this series is applied.

> +
> +	return ret;
> +}

> +static int ad9910_set_dac_current(struct ad9910_state *st, bool update)
> +{
> +	u32 fsc_code;
> +
> +	/* FSC = (86.4 / Rset) * (1 + CODE/256) where Rset = 10k ohms */
> +	fsc_code = DIV_ROUND_CLOSEST(st->data.dac_output_current, 90) - 96;
> +	fsc_code &= 0xFFU;

Given it's so small why is the U helpful? It's not going to get sign extended
anyway (unless I need more coffee).

> +
> +	return ad9910_reg32_write(st, AD9910_REG_AUX_DAC, fsc_code, update);
> +}
> +
> +static int ad9910_set_sysclk_freq(struct ad9910_state *st, u32 freq_hz,
> +				  bool update)
> +{
> +	u32 sysclk_freq_hz, refclk_freq_hz = clk_get_rate(st->refclk);
> +	u32 tmp32, vco_sel;
> +	int ret;
> +
> +	if (st->data.pll_enabled) {
> +		if (refclk_freq_hz < AD9910_PLL_IN_MIN_FREQ_HZ ||
> +		    refclk_freq_hz > AD9910_PLL_IN_MAX_FREQ_HZ) {
> +			dev_err(&st->spi->dev,

Use a local struct device as several copies of this in the function.

> +				"REF_CLK frequency %u Hz is out of PLL input range\n",
> +				refclk_freq_hz);
> +			return -ERANGE;
> +		}
> +
> +		tmp32 = DIV_ROUND_CLOSEST(freq_hz, refclk_freq_hz);
> +		tmp32 = clamp(tmp32, AD9910_PLL_MIN_N, AD9910_PLL_MAX_N);
> +		sysclk_freq_hz = refclk_freq_hz * tmp32;
> +
> +		if (sysclk_freq_hz < AD9910_PLL_OUT_MIN_FREQ_HZ ||
> +		    sysclk_freq_hz > AD9910_PLL_OUT_MAX_FREQ_HZ) {
> +			dev_err(&st->spi->dev,
> +				"PLL output frequency %u Hz is out of range\n",
> +				sysclk_freq_hz);
> +			return -ERANGE;
> +		}
> +
> +		if (sysclk_freq_hz <= AD9910_VCO0_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 0;
> +		else if (sysclk_freq_hz <= AD9910_VCO1_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 1;
> +		else if (sysclk_freq_hz <= AD9910_VCO2_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 2;
> +		else if (sysclk_freq_hz <= AD9910_VCO3_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 3;
> +		else if (sysclk_freq_hz <= AD9910_VCO4_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 4;
> +		else
> +			vco_sel = 5;
> +
> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR3,
> +					  AD9910_CFR3_N_MSK | AD9910_CFR3_VCO_SEL_MSK,
> +					  FIELD_PREP(AD9910_CFR3_N_MSK, tmp32) |
> +					  FIELD_PREP(AD9910_CFR3_VCO_SEL_MSK, vco_sel),
> +					  update);
> +		if (ret)
> +			return ret;
> +	} else {
> +		tmp32 = DIV_ROUND_CLOSEST(refclk_freq_hz, freq_hz);
> +		tmp32 = clamp(tmp32, 1, 2);
> +		sysclk_freq_hz = refclk_freq_hz / tmp32;
> +		tmp32 = FIELD_PREP(AD9910_CFR3_REFCLK_DIV_BYPASS_MSK, tmp32 % 2);
> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR3,
> +					  AD9910_CFR3_REFCLK_DIV_BYPASS_MSK,
> +					  tmp32, update);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->data.sysclk_freq_hz = sysclk_freq_hz;
> +
> +	return 0;
> +}

> +
> +static int ad9910_powerdown_set(struct ad9910_state *st, bool enable)

I'd just put the gpio call in line.
If not rename this a little as at one place where this is used I thought
it was checking if it was set rather than setting it.  set_powerdown
would be fine.

> +{
> +	return gpiod_set_value_cansleep(st->gpio_pwdown, enable);
> +}
> +
> +static ssize_t ad9910_ext_info_read(struct iio_dev *indio_dev,
> +				    uintptr_t private,
> +				    const struct iio_chan_spec *chan,
> +				    char *buf)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (private) {
> +	case AD9910_POWERDOWN:
> +		val = !!FIELD_GET(AD9910_CFR1_SOFT_POWER_DOWN_MSK,
> +				  st->reg[AD9910_REG_CFR1].val32);

I think Linus came out against the magic !! a few years ago in favour
of a ternary.  Whilst we have a lot of !! in IIO ? 1 : 0; is probably
the slightly better way to go.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +static ssize_t ad9910_ext_info_write(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     const struct iio_chan_spec *chan,
> +				     const char *buf, size_t len)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +

Why this blank line?

> +	u32 val32;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &val32);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (private) {
> +	case AD9910_POWERDOWN:
> +		val32 = val32 ? AD9910_CFR1_SOFT_POWER_DOWN_MSK : 0;
> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
> +					  AD9910_CFR1_SOFT_POWER_DOWN_MSK,
> +					  val32, true);
> +		break;

I'd prefer a check here on ret then unconditional return of len below.
It's nice to know on error path that nothing else is to be done. Tends to
scale better as code grows.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret ?: len;
> +}
> +
> +#define AD9910_EXT_INFO_TMPL(_name, _ident, _shared, _fn_desc) { \
> +	.name = _name, \
> +	.read = ad9910_ ## _fn_desc ## _read, \
> +	.write = ad9910_ ## _fn_desc ## _write, \
> +	.private = _ident, \
> +	.shared = _shared, \
> +}
> +
> +#define AD9910_EXT_INFO(_name, _ident, _shared) \
> +	AD9910_EXT_INFO_TMPL(_name, _ident, _shared, ext_info)
> +
> +static const struct iio_chan_spec_ext_info ad9910_phy_ext_info[] = {
> +	AD9910_EXT_INFO("powerdown", AD9910_POWERDOWN, IIO_SEPARATE),

I haven't checked yet, but if any of these macros are only used once or
twice, just squash the definition inline.  Every time these are used
they mean looking at what the implementation is.  If there are loads
of uses then fair enough.

> +	{ }
> +};
> +
> +#define AD9910_PROFILE_CHAN(idx) {				\
> +	.type = IIO_ALTVOLTAGE,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = AD9910_CHANNEL_PROFILE_ ## idx,		\
> +	.address = AD9910_CHAN_IDX_PROFILE_ ## idx,		\
> +	.scan_index = -1,					\

Normally we only bring .scan_index in at all on adding buffered / chrdev
support.  So I'd drop it for now as it ends up being confusing to
indicate a channel is not being used with the buffered interface that
doesn't exist (yet)


> +	.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |	\
> +			      BIT(IIO_CHAN_INFO_FREQUENCY) |	\
> +			      BIT(IIO_CHAN_INFO_PHASE) |	\
> +			      BIT(IIO_CHAN_INFO_SCALE),		\
> +}
> +
> +static const struct iio_chan_spec ad9910_channels[] = {
> +	[AD9910_CHAN_IDX_PHY] = {
> +		.type = IIO_ALTVOLTAGE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = AD9910_CHANNEL_PHY,
> +		.address = AD9910_CHAN_IDX_PHY,
> +		.scan_index = -1,

As above.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.ext_info = ad9910_phy_ext_info,
> +	},
> +	[AD9910_CHAN_IDX_PROFILE_0] = AD9910_PROFILE_CHAN(0),
> +	[AD9910_CHAN_IDX_PROFILE_1] = AD9910_PROFILE_CHAN(1),
> +	[AD9910_CHAN_IDX_PROFILE_2] = AD9910_PROFILE_CHAN(2),
> +	[AD9910_CHAN_IDX_PROFILE_3] = AD9910_PROFILE_CHAN(3),
> +	[AD9910_CHAN_IDX_PROFILE_4] = AD9910_PROFILE_CHAN(4),
> +	[AD9910_CHAN_IDX_PROFILE_5] = AD9910_PROFILE_CHAN(5),
> +	[AD9910_CHAN_IDX_PROFILE_6] = AD9910_PROFILE_CHAN(6),
> +	[AD9910_CHAN_IDX_PROFILE_7] = AD9910_PROFILE_CHAN(7),
> +};
> +
> +static int ad9910_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	u64 tmp64;
> +	u32 tmp32;

Similar to the write_raw() comment below. If you can give these
more useful names than tmp that would be good.

> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = (chan->channel - AD9910_CHANNEL_PROFILE_0);

No need for brackets on that one - particularly as it is locally inconsistent.

> +			*val = (tmp32 == st->profile);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp32 = FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
> +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		tmp64 = (u64)tmp32 * st->data.sysclk_freq_hz;
> +		*val = tmp64 >> 32;
> +		*val2 = ((tmp64 & GENMASK_ULL(31, 0)) * MICRO) >> 32;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_PHASE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_POW_MSK,
> +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> +			tmp32 = (tmp64 * AD9910_MAX_PHASE_MICRORAD) >> 16;
> +			*val = tmp32 / MICRO;
> +			*val2 = tmp32 % MICRO;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_ASF_MSK,
> +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> +			*val = 0;
> +			*val2 = tmp64 * MICRO >> 14;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PHY:
> +			*val = st->data.sysclk_freq_hz;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad9910_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	u64 tmp64;
> +	u32 tmp32;

Seems tmp32 is always some type of index, perhaps we can
use naming to reflect that?

> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			if (!val) {
> +				if (tmp32 != st->profile)
> +					return 0;
> +
> +				tmp32 = (tmp32 + 1) % AD9910_NUM_PROFILES;

This is a little odd looking. Perhaps a comment on why we are rolling by 1?

> +			}
> +
> +			return ad9910_profile_set(st, tmp32);
> +		default:


> +
> +static int ad9910_debugfs_reg_read(struct ad9910_state *st, bool high32,
> +				   unsigned int reg, unsigned int *readval)
> +{
> +	union ad9910_reg tmp;
> +	int ret;
> +
> +	switch (reg) {
> +	case AD9910_REG_DRG_LIMIT:
> +	case AD9910_REG_DRG_STEP:
> +	case AD9910_REG_PROFILE0 ... AD9910_REG_PROFILE7:
> +		ret = ad9910_reg64_read(st, reg, &tmp.val64);
> +		if (ret)
> +			return ret;
> +		*readval = high32 ? upper_32_bits(tmp.val64) :
> +				    lower_32_bits(tmp.val64);
> +		return 0;
> +	case AD9910_REG_POW:
> +		ret = ad9910_reg16_read(st, reg, &tmp.val16);
> +		if (ret)
> +			return ret;
> +		*readval = tmp.val16;
> +		return 0;
> +	default:
> +		ret = ad9910_reg32_read(st, reg, &tmp.val32);
> +		if (ret)
> +			return ret;
> +		*readval = tmp.val32;
> +		return 0;
> +	}
> +}
> +
> +static int ad9910_debugfs_reg_write(struct ad9910_state *st, bool high32,
> +				    unsigned int reg, unsigned int writeval)
> +{
> +	switch (reg) {
> +	case AD9910_REG_DRG_LIMIT:
> +	case AD9910_REG_DRG_STEP:
> +	case AD9910_REG_PROFILE0 ... AD9910_REG_PROFILE7:
> +		if (high32)
> +			return ad9910_reg64_update(st, reg, GENMASK_ULL(63, 32),
> +						   FIELD_PREP(GENMASK_ULL(63, 32), writeval),
> +						   true);
> +
> +		return ad9910_reg64_update(st, reg, GENMASK_ULL(31, 0),
> +					   writeval, true);
> +	case AD9910_REG_POW:
> +		return ad9910_reg16_write(st, reg, writeval, true);
> +	default:
> +		return ad9910_reg32_write(st, reg, writeval, true);
> +	}
> +}
> +
> +static int ad9910_debugfs_reg_access(struct iio_dev *indio_dev,
> +				     unsigned int reg, unsigned int writeval,
> +				     unsigned int *readval)
> +{
> +	bool high32 = FIELD_GET(AD9910_REG_HIGH32_FLAG_MSK, reg);
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +
> +	/*
> +	 * REG_HIGH32_FLAG is only used for regiter access to indicate upper 32
> +	 * bits of 64-bit registers. It is a workaround for debugfs_reg_access()
> +	 * limitation which only supports 32-bit values.

Feels like we should just fix this rather than papering over it.
Add a new callback to the the core to handle larger registers and then
use it here. I'm not a huge fan of the debugfs interface in general
but given we have it, why not make it work for ever use case?


> +	 */
> +	reg &= ~AD9910_REG_HIGH32_FLAG_MSK;
> +	if (reg >= AD9910_REG_RAM)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return ad9910_debugfs_reg_read(st, high32, reg, readval);
> +	else
> +		return ad9910_debugfs_reg_write(st, high32, reg, writeval);
> +}

> +static int ad9910_cfg_sysclk(struct ad9910_state *st, bool update)
> +{
> +	u32 tmp32, cfr3 = AD9910_CFR3_OPEN_MSK;

Don't mix declarations with assignment with those that don't assign.

It isn't great for readability.

> +
> +	cfr3 |= AD9910_CFR3_VCO_SEL_MSK |
> +		FIELD_PREP(AD9910_CFR3_DRV0_MSK, st->data.refclk_out_drv);
> +
> +	if (st->data.pll_enabled) {
> +		tmp32 = st->data.pll_charge_pump_current - AD9910_ICP_MIN_uA;
> +		tmp32 = DIV_ROUND_CLOSEST(tmp32, AD9910_ICP_STEP_uA);
> +		cfr3 |= FIELD_PREP(AD9910_CFR3_ICP_MSK, tmp32) |
> +			AD9910_CFR3_PLL_EN_MSK;
> +	} else {
> +		cfr3 |= AD9910_CFR3_REFCLK_DIV_RESETB_MSK |
> +			AD9910_CFR3_PFD_RESET_MSK;
> +	}
> +	st->reg[AD9910_REG_CFR3].val32 = cfr3;
> +
> +	return ad9910_set_sysclk_freq(st, AD9910_PLL_OUT_MAX_FREQ_HZ, update);
> +}
> +
> +static int ad9910_parse_fw(struct ad9910_state *st)
> +{
> +	static const char * const refclk_out_drv0[] = {
> +		"disabled", "low", "medium", "high",
> +	};
> +	struct device *dev = &st->spi->dev;
> +	u32 tmp;
> +	int ret;
> +
> +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> +	if (st->data.pll_enabled) {
> +		tmp = AD9910_ICP_MIN_uA;
> +		device_property_read_u32(dev, "adi,charge-pump-current-microamp", &tmp);
> +		if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> +			return dev_err_probe(dev, -ERANGE,
> +					     "invalid charge pump current %u\n", tmp);
> +		st->data.pll_charge_pump_current = tmp;
> +
> +		st->data.refclk_out_drv = AD9910_REFCLK_OUT_DRV_DISABLED;
Given the array stuff means you aren't reading directly into here having this
preset to default doesn't make much sense - instead I'd have this as...
> +		ret = device_property_match_property_string(dev,
> +							    "adi,refclk-out-drive-strength",
> +							    refclk_out_drv0,
> +							    ARRAY_SIZE(refclk_out_drv0));
> +		if (ret >= 0)

		if (ret < 0)
			st->data.refclk_out_drv = AD9910_REFCLK_OUT_DRV_DISABLED;
		else
			st->data.refclk_out_drv = ret;



> +			st->data.refclk_out_drv = ret;
> +	}
> +
> +	tmp = AD9910_DAC_IOUT_DEFAULT_uA;
> +	device_property_read_u32(dev, "adi,dac-output-current-microamp", &tmp);
> +	if (tmp < AD9910_DAC_IOUT_MIN_uA || tmp > AD9910_DAC_IOUT_MAX_uA)
> +		return dev_err_probe(dev, -ERANGE,
> +				     "Invalid DAC output current %u uA\n", tmp);
> +	st->data.dac_output_current = tmp;
> +
> +	return 0;
> +}
> +
> +static int ad9910_setup(struct ad9910_state *st, struct reset_control *dev_rst)
> +{
> +	u32 reg32;
> +	int ret;
> +
> +	ret = reset_control_deassert(dev_rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR1,
> +				 AD9910_CFR1_SDIO_INPUT_ONLY_MSK, false);
> +	if (ret)
> +		return ret;

I assume this is the the point where the stuff undone in ad9910_release()
is set as soft powerdown is cleared.

If so, it's here that you should be registering the devm action,
or you should be undoing this in any error path later in this function
so that it has no side effects.

> +
> +	reg32 = AD9910_CFR2_AMP_SCALE_SINGLE_TONE_MSK |
> +		AD9910_CFR2_SYNC_TIMING_VAL_DISABLE_MSK |
> +		AD9910_CFR2_DRG_NO_DWELL_MSK |
> +		AD9910_CFR2_DATA_ASM_HOLD_LAST_MSK |
> +		AD9910_CFR2_SYNC_CLK_EN_MSK |
> +		AD9910_CFR2_PDCLK_ENABLE_MSK;
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR2, reg32, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_cfg_sysclk(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_set_dac_current(st, false);
> +	if (ret)
> +		return ret;
> +
> +	return ad9910_io_update(st);
> +}
> +
> +static void ad9910_release(void *data)
> +{
> +	struct ad9910_state *st = data;
> +
> +	if (!ad9910_powerdown_set(st, true))
> +		return;
> +
> +	ad9910_reg32_update(st, AD9910_REG_CFR1,
> +			    AD9910_CFR1_SOFT_POWER_DOWN_MSK,
> +			    AD9910_CFR1_SOFT_POWER_DOWN_MSK,
> +			    true);
> +}
> +
> +static int ad9910_probe(struct spi_device *spi)
> +{
> +	static const char * const supplies[] = {
> +		"dvdd-io33", "avdd33", "dvdd18", "avdd18",
> +	};
> +	struct reset_control *dev_rst;
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
> +	st->refclk = devm_clk_get_enabled(dev, "ref_clk");
> +	if (IS_ERR(st->refclk))
> +		return dev_err_probe(dev, PTR_ERR(st->refclk),
> +				     "Failed to get reference clock\n");
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies), supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "ad9910";
> +	indio_dev->info = &ad9910_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad9910_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad9910_channels);
> +
> +	dev_rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(dev_rst))
> +		return dev_err_probe(dev, PTR_ERR(dev_rst),
> +				     "failed to get device reset control\n");
> +
> +	/*
> +	 * The IO RESET pin is not used in this driver, as we assume that all
> +	 * SPI transfers are complete, but if it is wired up, we need to make
> +	 * sure it is not floating. We can use either a reset controller or a
> +	 * GPIO for this.
> +	 */
> +	io_rst_gpio = devm_gpiod_get_optional(dev, "io-reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(io_rst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(io_rst_gpio),
> +				     "failed to get io reset gpio\n");
> +
> +	st->gpio_pwdown = devm_gpiod_get_optional(dev, "powerdown",
> +						  GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_pwdown))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_pwdown),
> +				     "failed to get powerdown gpio\n");

So at this point you've powered up the chip.  That's fine but I think
the matching power down (assuming the unwind of this doesn't do it - 
and I think it doesn't?) is not registered until you add the
ad9910_release devm action below.  It should be immediately after this
- hence it needs it's own devm action.


> +
> +	st->gpio_update = devm_gpiod_get_optional(dev, "update", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_update))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_update),
> +				     "failed to get update gpio\n");
> +
> +	st->gpio_profile = devm_gpiod_get_array_optional(dev, "profile",
> +							 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_profile))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_profile),
> +				     "failed to get profile gpios\n");
> +
> +	ret = ad9910_parse_fw(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_setup(st, dev_rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "device setup failed\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad9910_release, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to add release action\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


