Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F419D33F58C;
	Thu, 23 Apr 2026 18:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968997; cv=none; b=W7W/z37EMOFxodLdMEpPA4XiquEWqAl4mUv4V0QR7YgdtexIp8jXfE/3YEF7aI1mzvNFJBFdq1isUV4nKSxgFIBfJeIoBYVeJBYZnKGz8IjE6eajyJYCxvBadpKdqvysNhZSs7+mNKjJiRiz0gxuE9RyCqi6C9e1iTcLuPv4ulo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968997; c=relaxed/simple;
	bh=og2Mhrn3UwDxY80jvGybGg57YuBrZGkZEwU50M5itvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lY/69KrQe+kFaKNjWtGePqtvwvOa/bylsVF1ZvRvVSs73DzA7GQXhAimAdViUHxLbYUbLvT9QMOIJMf1cxUaoR7IkbatjGbNmeXWZhN9+TwISwNeMaPQhjhvp1t9tETvmj1aSvA2Om9emNtiXhvZPwYw2IpF8+5R/THxYLbKWTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiCtB1q/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiCtB1q/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA42C2BCAF;
	Thu, 23 Apr 2026 18:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968996;
	bh=og2Mhrn3UwDxY80jvGybGg57YuBrZGkZEwU50M5itvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XiCtB1q/QWqBxWng6xL1k/YXOkvf6jS6b5Tb7kFVnY+nblyx4dyhWq8njb/oGvyNO
	 YzQelAyLEkIN5jQQggSWYpUxmQcDVJNmChDwppmTahB9Q28hZiYL3jxZoayMC5zr8f
	 HD1YAlhVL9vwpLmCFvXLyanNJC0NhBnrj2FESCHRa0b79MK5OqD/mP6m6wkJlaSQLv
	 wlu5SPkUnP5nGMx+nJDKuBEbgq9JK4Dt16M5xb6Tn9mCmGTzxTIaTX4rDDfvDW1dOr
	 4/D9f28ZeYduKl2HnOs7MKPaZnnJVq8eP9+e6anwPZgHzmLcx6cZ2WCCJrY0tAkSfR
	 QFTH0xv/p4JHQ==
Date: Thu, 23 Apr 2026 19:29:45 +0100
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
Subject: Re: [PATCH 22/22] iio: dac: ad5686: add gain control support
Message-ID: <20260423192945.2be798a0@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-22-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-22-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:56 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Most of the supported devices rely on a GAIN pin to control a 2x
> multiplier applied to the output voltage. Other devices, e.g. the
> single-channel ones, provides a gain control through a bit field in the
> control register. Some designs might have the GAIN pin hardwired to
> VDD/VLOGIC or GND, which would still be fine for this patch, that allows
> the scale property to be configurable with two available options. In
> read_raw() and write_raw() implementations mutex guards are used to allow
> early returns.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Minor stuff inline.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5686.c | 110 +++++++++++++++++++++++++++++++++++++++--------
>  drivers/iio/dac/ad5686.h |   8 ++++
>  2 files changed, 101 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index bec951afe8d0..adbf62848697 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c

>  static inline int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
> @@ -163,20 +167,25 @@ static int ad5686_read_raw(struct iio_dev *indio_dev,
>  	struct ad5686_state *st = iio_priv(indio_dev);
>  	int ret;
>  
> +	guard(mutex)(&st->lock);
As below. I'd break out the guard() usage as a precusor cleanup patch.

> +
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> -		mutex_lock(&st->lock);
>  		ret = ad5686_read(st, chan->address);
> -		mutex_unlock(&st->lock);
>  		if (ret < 0)
>  			return ret;
>  		*val = (ret >> chan->scan_type.shift) &
>  			GENMASK(chan->scan_type.realbits - 1, 0);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = st->vref_mv;
> -		*val2 = chan->scan_type.realbits;
> -		return IIO_VAL_FRACTIONAL_LOG2;
> +		if (st->double_scale) {
> +			*val = st->scale_avail[2];
> +			*val2 = st->scale_avail[3];
> +		} else {
> +			*val = st->scale_avail[0];
> +			*val2 = st->scale_avail[1];
> +		}
> +		return IIO_VAL_INT_PLUS_NANO;
>  	}
>  	return -EINVAL;
>  }
> @@ -188,28 +197,77 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
>  			    long mask)
>  {
>  	struct ad5686_state *st = iio_priv(indio_dev);
> -	int ret;
> +
> +	guard(mutex)(&st->lock);
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		if (!in_range(val, 0, 1 << chan->scan_type.realbits))
>  			return -EINVAL;
>  
> -		mutex_lock(&st->lock);
> -		ret = ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> -				   chan->address, val << chan->scan_type.shift);
> -		mutex_unlock(&st->lock);

As Andy pointed out, move this switch to guard() magic earlier in series.


> -		break;
> -	default:
> -		ret = -EINVAL;
> -	}
> +		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> +				    chan->address, val << chan->scan_type.shift);
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val == st->scale_avail[0] && val2 == st->scale_avail[1])
> +			st->double_scale = false;
> +		else if (val == st->scale_avail[2] && val2 == st->scale_avail[3])
> +			st->double_scale = true;
> +		else
> +			return -EINVAL;
>  
> -	return ret;
> +		switch (st->chip_info->regmap_type) {
> +		case AD5310_REGMAP:
> +			return ad5310_control_sync(st);
> +		case AD5683_REGMAP:
> +			return ad5683_control_sync(st);
> +		case AD5686_REGMAP:
> +			gpiod_set_value_cansleep(st->gain_gpio, st->double_scale);
> +			return 0;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
>
