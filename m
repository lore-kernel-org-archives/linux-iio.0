Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BAE3A9620;
	Thu, 23 Apr 2026 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776967002; cv=none; b=ldloLzl5IVzKkg3C7P9vyOVHiajX0so9HNAB30/MYOD2Dug+BY0nj3SbC5YveQcArhyWXKAlJftsipARSTNjTJ5N7lChcAs+cWxJUt6RbPU6RPsdB4X/5UiAL6JDzqXf+O1Ah690LyPzbKP2IGgGcpMVJNMhkK2MSCWGpxjfmGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776967002; c=relaxed/simple;
	bh=yQpkTOp+6lAIN9jorcsCREiRudJEjOS61AFk1HgA9I8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7rY7HwrftrRg1yGKDln53fMhqKcPm3uZmPBC3Fpw/6ZzleR1dr2nmYxsz0RafQas6U/vA2pCZk3Vn8H14DLO15qtDlB0c10FIbDUkmVUflgt7+XpRfORu37AsoyPZ1uD9/KKxQDq0+TcmCFqvjIT1L8I0oDD7wLf87XXY4bARA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mkdjH/uv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkdjH/uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96176C2BCAF;
	Thu, 23 Apr 2026 17:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776967002;
	bh=yQpkTOp+6lAIN9jorcsCREiRudJEjOS61AFk1HgA9I8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mkdjH/uvqAWsmVHz6WLh0Ou5fB7TooF3DMF9CndprEOeHUmb7/7Br5fIXWDRJ/Wqp
	 ruxYsBLYhQX1gFcZZxnd1ZH4ykaGvmtTa0+xSLKzTcw4wMtHztJWfDvTtQwullfJT5
	 XG+2KZFd1wqGrCLgyH840XGtLGuB0qGmj3BIgsXSR/lflPmKUGTqFEfQEEMGic3o1h
	 a05FUiD4G0HZFzMFlSkVcFyk/daq+KDiJidaU1GMVbHc5ppaOXcg43Mqug8Io6okqs
	 VLTJLrTVuNI+ivippAsUEgb/4bBcZoR9Dg/eu4ZvW4O+h6qBoNNMonNvs1DTCfShBO
	 GjF0HRUiOL1hw==
Date: Thu, 23 Apr 2026 18:56:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 11/22] iio: dac: ad5686: fix ref bit initialization for
 single-channel parts
Message-ID: <20260423185631.7afc4deb@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-11-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-11-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:45 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> For single-channel parts the control register is used to enable the
> internal voltage reference and perform powerdown control. The reference
> enable bit position was ignored when writing the register at the probe
> function. This patch adds a control_sync() function that properly consumes
> the mask definitions with FIELD_PREP(). As further cleanup, the created
> functions and definitions are also used in ad5686_write_dac_powerdown().
> Some local variables ended up being unused (so removed) and
> st->use_internal_vref is initialized earlier in probe.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo,

Just one minor thing inline.

Thanks,

> @@ -65,8 +85,8 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  	bool readin;
>  	int ret;
>  	struct ad5686_state *st = iio_priv(indio_dev);
> -	unsigned int val, ref_bit_msk;
> -	u8 shift, address = 0;
> +	unsigned int val;
> +	u8 address = 0;
>  
>  	ret = kstrtobool(buf, &readin);
>  	if (ret)
> @@ -79,30 +99,26 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		shift = 9;
> -		ref_bit_msk = AD5310_REF_BIT_MSK;
> +		ret = ad5310_control_sync(st);
I'd add explicit error check and return here.
		if (ret)
			return ret;
>  		break;
>  	case AD5683_REGMAP:
> -		shift = 13;
> -		ref_bit_msk = AD5683_REF_BIT_MSK;
> +		ret = ad5683_control_sync(st);
and here.
>  		break;
>  	case AD5686_REGMAP:
> -		shift = 0;
> -		ref_bit_msk = 0;
>  		/* AD5674R/AD5679R have 16 channels and 2 powerdown registers */
> -		if (chan->channel > 0x7)
> +		val = st->pwr_down_mask & st->pwr_down_mode;
> +		if (chan->channel > 0x7) {
>  			address = 0x8;
> +			val = upper_16_bits(val);
> +		} else {
> +			val = lower_16_bits(val);
> +		}
> +		ret = st->write(st, AD5686_CMD_POWERDOWN_DAC, address, val);
and here.
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	val = ((st->pwr_down_mask & st->pwr_down_mode) << shift);
> -	if (!st->use_internal_vref)
> -		val |= ref_bit_msk;
> -
> -	ret = st->write(st, AD5686_CMD_POWERDOWN_DAC,
> -			address, val >> (address * 2));
>  
>  	return ret ? ret : len;
Then I think this just ends up as
	return len;

Adds a few lines of code, but makes it clear when we are exiting
early due to error and there is nothing else to do.

>  }


