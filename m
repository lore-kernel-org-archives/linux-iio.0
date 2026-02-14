Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBADB42A9D;
	Sat, 14 Feb 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771097366; cv=none; b=o0/NWKGmCVOwMUkhDmsed15+t+mPCBeA0c1Slgeyp01w6/O6BPE8jj4yhmJpf174fwsbSZu8kOWf5AMsogixxAR54g6ZZWL/AXoKQlqk2UAfiB6kceUyUnWuDo9HJ3LvVpqLLbIsq6mxZSq/eBRRbKiUjM0lSflWJ98WASaunl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771097366; c=relaxed/simple;
	bh=PfmnqNAlHSZ/4k30GimesBcUNUAIDI09APWGDbbwbRA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8K5SEsOz1QNlaAlxM35Vj/PI3A7wSkOLj2BYbSKYi6XBZfT+81XfN6qECwMPgrkgXhIF8fv6638gVmmk/OjzyelINW0VEokVvV7/DzsAtm2RS96sSGKo8Kedaou8hW/ffzp8f/5Z+YGBk4dXO3x0uFWGYtqClZ6srC86gjVHX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcMq+YE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcMq+YE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51BFC16AAE;
	Sat, 14 Feb 2026 19:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771097366;
	bh=PfmnqNAlHSZ/4k30GimesBcUNUAIDI09APWGDbbwbRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZcMq+YE8OjyaSFIxhRVtj2BF2M6CzUaMbilQOGP95OwhRXu5xQ9ERRHGgHsoxlm2T
	 EWFnjgxhe409kj+gKeHTy6J/u62tNu5W2Gwd2FCt+KOgPSBwSwRkWUjM95FbE9/R/B
	 tsvt8SiFKtU5gp/1Jr9W24prNIMSM5XJ3h7G0LXZi9EvtURqp6bXX4U24i3Bnqz72T
	 ZmU7R/vCYbmX6IDiaSvui02U5cTl4JizQXBdhKNPeLTrz+Vq7m0phj5pFZZmNyYfUv
	 Tke1APpY4UThkxEKn9hvyF0pLanoQSH+DhRI7KPEPs/qt5wi/K0t7a8oGpzmccUGTO
	 MQRygvB+cZu9w==
Date: Sat, 14 Feb 2026 19:29:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: dac: max5522: use
 devm_regulator_get_enable_read_voltage()
Message-ID: <20260214192918.6b0bc0a7@jic23-huawei>
In-Reply-To: <20260211081837.8169-1-antoniu.miclaus@analog.com>
References: <20260211081837.8169-1-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Feb 2026 10:18:27 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Simplify probe by using devm_regulator_get_enable_read_voltage() to
> get, enable and read the regulator voltage in a single call, caching
> the value at probe time.

Mention more on why it should be fine to assume this doesn't change
at runtime.

> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> Changes in v2:
>  - use vref_mV naming convention
>  - use (MICRO / MILLI) instead of 1000 for conversion
>  drivers/iio/dac/max5522.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
> index 1b8fe6b8d26e..459b333a84a0 100644
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
> +	unsigned short vref_mV;

Why a short?
Seems like the max you 'could' get is MAX_INT / 1000 which
will not fit in an unsigned short.

Probably easier to just go with unsigned int and save
the effort of reasonsing about it.

Or just use an int and don't even worry about the sign.

J

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

