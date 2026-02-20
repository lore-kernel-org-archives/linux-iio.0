Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019D53382EC;
	Fri, 20 Feb 2026 11:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585509; cv=none; b=Gxo8BZ6tAnNfEbaiFTHLRzbBjBXP5SoxKJVPTddOXejmGEKo4xaBh7utfKj8FmdunmUYyAwQijyw+kZaiHP3SNN+fctfcFm1Jqz9AE5ebJDEax+ARrKdN4Ns5xeEEHhdcYTxVKz2sq/Ck/l4MK+/QWLvZZrwmZWHYkssEr9wEMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585509; c=relaxed/simple;
	bh=EyASrblwRuoIRhf3qMO8oB6Buse1cw1nyRtXw6SnXZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s/c46/fcfZUIk14b2TpiENtxZMla3YoaWiZ7bUTj4DOyVQE25sa4vH2Q0PCndyKk6bKyOoFB7tdhSgX2y+TONMCEjDOfy9T41xlod/zQrWcFx8H+8Lt2mZX85XnesvCxlRPHJiEhHpe31Une1ceRLow8jHdyVmy7IkK2FeEE4Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frZxePja; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frZxePja"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EBFC116C6;
	Fri, 20 Feb 2026 11:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771585508;
	bh=EyASrblwRuoIRhf3qMO8oB6Buse1cw1nyRtXw6SnXZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=frZxePjazzVK7GKGkda4BmMbNywBgoZA/M6vbdPhQu9IXOdX+YQP1Ar55qmjPeeRG
	 ntru1usUDCoIPM0hPP41bc/B/UyXWjLSAxqaMRJa7mkVUNEqzs7G+00e6GbyklIkWV
	 uqUKxjVGdW6LxElWCedJaV6KKwkZIVoRdPeDjnpCrtSEhsls/vD787lTxugrbxDzVI
	 KLup56d7eScQpCXELisQEovS/WShpdeRqeB9P8JQtCklsTt6VF6qPHBlqFxD7l9Fkx
	 nQo1rmIQXaceDLkF9HS9t4lx3X242g1c8H6wVy7x5Rr9CwOMX4/E5ltnxXsYg2PTbF
	 ccis8E8lZSi+w==
Date: Fri, 20 Feb 2026 11:04:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Andy
 Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3] iio: dac: max5522: simplify probe with
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260220110459.2c11f1ff@jic23-huawei>
In-Reply-To: <20260216131714.90508-2-antoniu.miclaus@analog.com>
References: <20260216131714.90508-2-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Feb 2026 15:17:05 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call, caching
> the value at probe time.
> 
> The reference voltage for this DAC is a fixed hardware configuration
> that is not expected to change at runtime, so reading it once during
> probe and caching the millivolt value is sufficient.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Applied.  Thanks,

Jonathan

> ---
> Changes in v3:
>  - change vref_mV type from unsigned short to int to avoid potential
>    precision loss
>  - update commit message to clarify why caching voltage at probe is
>    sufficient
> 
>  drivers/iio/dac/max5522.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
> index 1b8fe6b8d26e..b52a9cc1da79 100644
> --- a/drivers/iio/dac/max5522.c
> +++ b/drivers/iio/dac/max5522.c
> @@ -14,6 +14,7 @@
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
> +#include <linux/units.h>
>  
>  #include <linux/iio/iio.h>
>  
> @@ -34,7 +35,7 @@ struct max5522_state {
>  	struct regmap *regmap;
>  	const struct max5522_chip_info *chip_info;
>  	unsigned short dac_cache[2];
> -	struct regulator *vrefin_reg;
> +	int vref_mV;
>  };
>  
>  #define MAX5522_CHANNEL(chan) {	\
> @@ -79,17 +80,13 @@ static int max5522_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long info)
>  {
>  	struct max5522_state *state = iio_priv(indio_dev);
> -	int ret;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
>  		*val = state->dac_cache[chan->channel];
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = regulator_get_voltage(state->vrefin_reg);
> -		if (ret < 0)
> -			return -EINVAL;
> -		*val = ret / 1000;
> +		*val = state->vref_mV;
>  		*val2 = 10;
>  		return IIO_VAL_FRACTIONAL_LOG2;
>  	default:
> @@ -147,16 +144,11 @@ static int max5522_spi_probe(struct spi_device *spi)
>  	if (!state->chip_info)
>  		return -EINVAL;
>  
> -	state->vrefin_reg = devm_regulator_get(&spi->dev, "vrefin");
> -	if (IS_ERR(state->vrefin_reg))
> -		return dev_err_probe(&spi->dev, PTR_ERR(state->vrefin_reg),
> -				     "Vrefin regulator not specified\n");
> -
> -	ret = regulator_enable(state->vrefin_reg);
> -	if (ret) {
> +	ret = devm_regulator_get_enable_read_voltage(&spi->dev, "vrefin");
> +	if (ret < 0)
>  		return dev_err_probe(&spi->dev, ret,
> -				     "Failed to enable vref regulators\n");
> -	}
> +				     "Failed to get vrefin regulator\n");
> +	state->vref_mV = ret / (MICRO / MILLI);
>  
>  	state->regmap = devm_regmap_init_spi(spi, &max5522_regmap_config);
>  

