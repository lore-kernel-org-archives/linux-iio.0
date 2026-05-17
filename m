Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710662AEE1;
	Sun, 17 May 2026 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029278; cv=none; b=MG/JIHsfafV6V3NnZCXHnG5lp+38McykI2eYWkEek+4ny+wYd0GYPsvX1OKLiO0kf/wOLPkbaqStkAIwtMSgmb6rJs8Ger1SNJe23yMBSsucSGqK2gSo4Y8L7q2vKldncAWthSv69SWdn/8fEG6azU6E73ibP51kVpfZFhkbzig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029278; c=relaxed/simple;
	bh=xoAgU/R3H9Ait+G/66AosmrNFjJwZKusNf070Da4HxM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A80UdeWKgNeRiaW7Xuy8evfpC//q9bZYfmnqJFr8ssWmKN/Gokj1f48TPcN868ClcYden+y6dHO7BsnRKYXdcIBcDZmuR3xdvmro9wo04xgU19xjWz06oPNLyibu+hHKYu/iu2FccCnAnQRH9h99tWWAZoWN51vFsZvhqiAExFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OaaItkPu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OaaItkPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827A1C2BCB0;
	Sun, 17 May 2026 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779029278;
	bh=xoAgU/R3H9Ait+G/66AosmrNFjJwZKusNf070Da4HxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OaaItkPusR4VH3Y1ax6Fa0eVyR0lggawk9obE7TjMKePsT4EMRMOJnpO32pHirgqQ
	 cytWTtYX9HZI0hZi/uuOpLQ3RH3jnMO85hwkB6wwMsHEYt0BaNDeqQPz2ULTApWJKi
	 IEoY9QtII6TnB/cFacb8U69Iz0xOGRLJKHiqcVEfSw+Qw48MUhroAv9W4gTXvjHhYi
	 wwSPsUYVi1/QZTv/BV1AB3uasT7VXz79z90olUG8K6psIZcwM+vX/Zlj/ijY06E7HV
	 ntROQhaRuH3LJrOlS2TfPop3yEPAIHhV44XXT0vJpQTBbfNJ7MtGQJdgEksCFyVves
	 EokVepeZ4pGog==
Date: Sun, 17 May 2026 15:47:45 +0100
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
Subject: Re: [PATCH RFC v4 03/10] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <20260517154745.5fbfcabf@jic23-huawei>
In-Reply-To: <20260508-ad9910-iio-driver-v4-3-d26bfd20ee3d@analog.com>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
	<20260508-ad9910-iio-driver-v4-3-d26bfd20ee3d@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 May 2026 18:00:19 +0100
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

A few really minor things from a fresh look through.

Jonathan

> diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
> new file mode 100644
> index 000000000000..c75f2ef178c2
> --- /dev/null
> +++ b/drivers/iio/frequency/ad9910.c

> +
> +static int ad9910_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	u64 tmp64;
> +	u32 tmp32;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			if (ad9910_sw_powerdown_get(st)) {
> +				*val = 0;
> +			} else {
> +				tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +				*val = (tmp32 == st->profile);
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
> +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		tmp64 *= st->data.sysclk_freq_hz;
> +		*val = tmp64 >> 32;
> +		*val2 = ((tmp64 & GENMASK_ULL(31, 0)) * MICRO) >> 32;

Why in this particular case have this outside the switch / case whereas in others
you do the full maths and set inside? I'd put it inside and not worry about slightly
long lines.

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
> +static int ad9910_setup(struct device *dev, struct ad9910_state *st,
> +			struct reset_control *dev_rst)
> +{
> +	int ret;
> +
> +	ret = reset_control_deassert(dev_rst);
> +	if (ret)
> +		return ret;
No need to sleep at all after bringing device out of reset?

Sashiko has reasonably been asking about this in other drivers. If there
is no period needed or it is so quick as to be irrelevant add a comment here.

> +
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR1,
> +				 AD9910_CFR1_SDIO_INPUT_ONLY_MSK, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, ad9910_sw_powerdown_action, st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR2,
> +				 AD9910_CFR2_AMP_SCALE_SINGLE_TONE_MSK |
> +				 AD9910_CFR2_SYNC_TIMING_VAL_DISABLE_MSK |
> +				 AD9910_CFR2_DRG_NO_DWELL_MSK |
> +				 AD9910_CFR2_DATA_ASM_HOLD_LAST_MSK |
> +				 AD9910_CFR2_SYNC_CLK_EN_MSK |
> +				 AD9910_CFR2_PDCLK_ENABLE_MSK, false);
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

