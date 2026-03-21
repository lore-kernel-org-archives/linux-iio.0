Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAC2E5B21;
	Sat, 21 Mar 2026 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118358; cv=none; b=uQTJPUdUqqMNbXu7ZbP3Ao5E2jY63HUB7+/7ypNdctxjlcN7BXmMYSdHoAbR74RlFvHtVFaZaguL3jtpFxz2+Krj6X1dqL6FnU8NWovrbRoLGvTmZvswrMzQjD9WUzBr3wxE+ykFYLeNHBMU/sa+EoefCWee1qhRX3dtOGpCUWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118358; c=relaxed/simple;
	bh=AKvPHB6/e4oPBMB57bEGs3+OhYV7XS1yw/q0PLUIB3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hx8VUKSEqR0mf7uddqPkkom8zZaBZ6kOzPRGo+/sNAx3omfVoAIiJeIH1X2LKZW3xbzB+keEofIUGPwA3aoBxs4CEtM6jSvkE+AvtsXEeSGCNFnBl3Qi+vMXgFJ/C/cMrneQStNjME91PGYFjgGehOJKMkjsf9xey0dGHjcrYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuAtl9o5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuAtl9o5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF58FC19421;
	Sat, 21 Mar 2026 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774118358;
	bh=AKvPHB6/e4oPBMB57bEGs3+OhYV7XS1yw/q0PLUIB3s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BuAtl9o59uQ2hGX99UH5v2q4hdSNSXCXUeqgMHITzvVQNbfiHq/3HFbcXuf0iNSTw
	 GCCta+pUbWq9Rde47r3dgpZj9ZWRmqUbDjDo9Q2ufzzIlSyMInrZXPG02837E324eD
	 hvClY22fAGY5czLqWTsd6x8uuf8Mc9CemE4OhChpuUCIunzqq+TNnxuxpZZOIftMQP
	 uJ8nMiUMd9ra+lQsJ5LrO7gUMuZkH5hdNmOYuoKHyKud4NCryTARPNhRqHOkp1E+Kx
	 BqdZYLg5nAx7E6ORYEG05HqZgiF+fGtiEEJP61Vn3Y2k4T63ZYVOnfvZ4zOMcD5h9H
	 eAb3MXOM/86bw==
Date: Sat, 21 Mar 2026 18:39:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "David Lechner" <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: dac: ad5706r: Add support for AD5706R DAC
Message-ID: <20260321183909.45761710@jic23-huawei>
In-Reply-To: <20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
References: <20260318-dev_ad5706r-v3-0-5d078f41e988@analog.com>
	<20260318-dev_ad5706r-v3-2-5d078f41e988@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 13:13:36 +0800
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
> Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
> 
> ---
> Changes since v1:
>   - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
>   - Removed all custom ext_info sysfs attributes
>   - Simplified to basic raw read/write and read-only scale
>   - SPI read/write can handle multibyte registers
Hi Alexis,

I've tried not to overlap too much with other feedback.

Some comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..840ee7b6db2e05ea35b27ff776f0c5c8a961d9c1
> --- /dev/null
> +++ b/drivers/iio/dac/ad5706r.c

> +
> +struct ad5706r_state {
> +	struct spi_device *spi;
> +	struct mutex lock; /* Protects SPI transfers */
I assume it actually protects the buffers below. Where possible talk
about what 'data' is being protected. It's easier to reason about than
transfers which will be protected anyway by internal bus driver locking.

> +
> +	u8 tx_buf[4] __aligned(ARCH_DMA_MINALIGN);
> +	u8 rx_buf[2];
> +};
> +
> +static int ad5706r_reg_len(unsigned int reg)
> +{
> +	if (reg >= AD5706R_MULTIBYTE_REG_START && reg <= AD5706R_MULTIBYTE_REG_END)
> +		return AD5706R_DOUBLE_BYTE_LEN;
> +
> +	return AD5706R_SINGLE_BYTE_LEN;
> +}
> +
> +static int ad5706r_spi_write(struct ad5706r_state *st, u16 reg, u16 val)
> +{
> +	unsigned int num_bytes = ad5706r_reg_len(reg);
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.len = num_bytes + 2,
> +	};
> +
> +	put_unaligned_be16(reg, &st->tx_buf[0]);
> +
> +	if (num_bytes == 1)
> +		st->tx_buf[2] = val;
> +	else if (num_bytes == 2)
> +		put_unaligned_be16(val, &st->tx_buf[2]);
> +	else
> +		return -EINVAL;
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);

Even though you are writing only, consider using spi_write_then_read() here
as well. Might end up simpler and it works fine with an rx size of 0 and
NULL buffer for rx

> +}
> +
> +static int ad5706r_spi_read(struct ad5706r_state *st, u16 reg, u16 *val)
> +{
> +	unsigned int num_bytes = ad5706r_reg_len(reg);
> +	u16 cmd;
> +	int ret;
> +
> +	struct spi_transfer xfer[] = {
> +		{
> +			.tx_buf = st->tx_buf,
> +			.len = 2,
> +		},
> +		{
> +			.rx_buf = st->rx_buf,
> +			.len = num_bytes,
> +		},
> +	};
> +
> +	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
> +	put_unaligned_be16(cmd, &st->tx_buf[0]);
> +
> +	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));

Can you use spi_write_the_read()?
Has the added advantage that it bounces the data so doesn't need DMA safe.
Can also use more meaningful types like 
__be16 tx;
__be16 rx16;
u8 rx8;



> +	if (ret)
> +		return ret;
> +
> +	if (num_bytes == 1)
> +		*val = st->rx_buf[0];
> +	else if (num_bytes == 2)
> +		*val = get_unaligned_be16(st->rx_buf);
> +	else
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +	u16 reg_val;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		scoped_guard(mutex, &st->lock) {
Why?

	case IIO_CHAN_INFO_RAW: {
		guard(mutex)(&st->lock);

		ret = ....

		return IIO_VAL_INT;
	}

is easier to read and reduces the huge indent.

Only use scoped_guard() when you can't do it in a more readable fashion.

> +			ret = ad5706r_spi_read(st, AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel),
> +					       &reg_val);
> +
> +			if (ret)
> +				return ret;
> +
> +			*val = reg_val;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 50;
> +		*val2 = AD5706R_DAC_RESOLUTION;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	}
> +
I'd prefer an explicit
	defualt:
		return -EINVAL;
	}
to end the switch statement and make it clear within the switch that all other options
are errors.

> +	return -EINVAL;
> +}
> +
> +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ad5706r_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val >= AD5706R_DAC_MAX_CODE)
> +			return -EINVAL;
> +
> +		guard(mutex)(&st->lock);

What's the scope? add {} to the case block to make it clearly defined.


> +		return ad5706r_spi_write(st,
> +					 AD5706R_REG_DAC_INPUT_A_CH(chan->channel),
> +					 val);
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static const struct of_device_id ad5706r_of_match[] = {
> +	{ .compatible = "adi,ad5706r" },
> +	{}

As below.

> +};
> +MODULE_DEVICE_TABLE(of, ad5706r_of_match);
> +
> +static const struct spi_device_id ad5706r_id[] = {
> +	{ "ad5706r" },
> +	{}

Trivial style thing, but we've standardized on
	{ }
for IIO.  Had to pick one of the two choices and that one looked
nicer to me ;)

> +};
> +MODULE_DEVICE_TABLE(spi, ad5706r_id);


