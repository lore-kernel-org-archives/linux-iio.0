Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F6390C90;
	Fri, 22 May 2026 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779454988; cv=none; b=J6N+faNYn4RtK3t1NvGvQvzDAbcQ2XXosqet4f3lyYUXjU9d/msaT+LFBQPN1RaoxF7d7UKqzdipiVlYIkcPW5DtOtUh50gccOj/gBmJxPTHYNaFfHJzwsNdd6vziPp0ruBzshmLv9iUEJxfswaiNuWESWPXVVhYMbRKF939N/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779454988; c=relaxed/simple;
	bh=icPR2sKfzi4yECyNcYYGKxJDBBevjl1Y7FRUTs4zIH8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pl8QNuiPe8tWFyoWb0HUzEeTT7iaFuzTk1KS6idWWcHdXZsPKOG9WsKaS3oJWP/6EYmfhWQnGBr9zY7pudfJf3Syig+28V4UCxTZcfJpS5Ht5H8wZaR/ElbjK6CpJRycw3olhY96FQHaVnMG6E2KLGBelnrnDNX8IfuLl3juVKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/KElBMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/KElBMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381251F000E9;
	Fri, 22 May 2026 13:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779454986;
	bh=sqD5iGBUDzbOWjAJkyeMBxvfUirt20hkDKhTn5GalBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G/KElBMoLxVZipvksseyucY8z/fSYf8stnFK6zNlhdFJFFIANCHFPk7HXVX0SjrkX
	 Fd6q228ma+gcPswtENN2+exVecPPbWyZoOJs/UZRbgI3glDgxP0NwKetj0fckZXVRs
	 QavdJxL1NYfU/9qBh4RcNYmCPlPllN8YY8bcnj+DDLc8FiV0I5HBCpwVGh2bknAzZj
	 i0m7ZTXX61Rk17/eVbqnABjj+od23lqBD87U2Sp++GxTvBCoHG/phhp1gwlBXvjVWq
	 aXu8lTFBnAcuPOAlI9FSfW24mSYVo1UTF1D+sa0TyFq2EHAbGg1kEc95QJTR68S3Cx
	 QiwgE4a3kxLlw==
Date: Fri, 22 May 2026 14:02:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Antoniu Miclaus" <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/8] iio: temperature: ltc2983: Use local device
 pointer consistently
Message-ID: <20260522140255.27445c41@jic23-huawei>
In-Reply-To: <20260521164323.770626-3-liviu.stan@analog.com>
References: <20260521164323.770626-1-liviu.stan@analog.com>
	<20260521164323.770626-3-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 19:42:55 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> Some functions define a local 'dev' pointer but still use bare
> '&st->spi->dev' in some code paths, and some don't have it at all.
> Replace bare references with the local pointer for consistency.
> 
> Signed-off-by: Liviu Stan <liviu.stan@analog.com>

Hi Liviu,

When doing this sort of change, one of the advantages is often that code lines
get shorter. So look at the lines touched and see if the wrapping remains
appropriate.

At least some of the cases I point out below already fitted on one line
under 80 chars but none the less they are now even shorter so that needs
tidying up.  Note that a few other cases are just over 80 chars.
Take a look at those and decide if readability is improved much by just
going a few characters over.  That line length isn't the hard rule it
used to be!

> ---
> Changes in v3:
> - Dropped the Fixes: tag
> - Fixed one remaining dev_dbg() call in __ltc2983_chan_assign_common()
>   that was still using the raw device pointer instead of the dev local
>   variable introduced by this patch
> 
>  drivers/iio/temperature/ltc2983.c | 83 +++++++++++++++++--------------
>  1 file changed, 47 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> index 67a09934c5bd..d9dcf3e86696 100644
> --- a/drivers/iio/temperature/ltc2983.c
> +++ b/drivers/iio/temperature/ltc2983.c
> @@ -351,10 +351,11 @@ static int __ltc2983_chan_assign_common(struct ltc2983_data *st,
>  					const struct ltc2983_sensor *sensor,
>  					u32 chan_val)
>  {
> +	struct device *dev = &st->spi->dev;
>  	u32 reg = LTC2983_CHAN_ASSIGN_ADDR(sensor->chan);
>  
>  	chan_val |= LTC2983_CHAN_TYPE(sensor->type);
> -	dev_dbg(&st->spi->dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
> +	dev_dbg(dev, "Assign reg:0x%04X, val:0x%08X\n", reg,
>  		chan_val);

chan_val easily fits on the line above now.  It actually did before
but given you are changing this lets tidy it up to;

	dev_dbg(dev, "Assign reg:0x%04X, val:0x%08X\n", reg, chan_val);


>  	st->chan_val = cpu_to_be32(chan_val);
>  	return regmap_bulk_write(st->regmap, reg, &st->chan_val,




> @@ -1222,11 +1229,12 @@ static int ltc2983_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct ltc2983_data *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
>  	int ret;
>  
>  	/* sanity check */
>  	if (chan->address >= st->num_channels) {
> -		dev_err(&st->spi->dev, "Invalid chan address:%ld",
> +		dev_err(dev, "Invalid chan address:%ld",
>  			chan->address);

		dev_err(dev, "Invalid chan address:%ld", chan->address);

>  		return -EINVAL;
>  	}

> @@ -1427,6 +1436,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
>  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  {
>  	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
> +	struct device *dev = &st->spi->dev;
>  	int ret;
>  
>  	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> @@ -1434,7 +1444,7 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
>  				       LTC2983_STATUS_UP(status) == 1, 25000,
>  				       25000 * 10);
>  	if (ret)
> -		return dev_err_probe(&st->spi->dev, ret,
> +		return dev_err_probe(dev, ret,
>  				     "Device startup timed out\n");

		return dev_err_probe(dev, ret, "Device startup timed out\n");


>  
>  	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
> @@ -1535,12 +1545,13 @@ static const struct  iio_info ltc2983_iio_info = {

> @@ -1589,10 +1600,10 @@ static int ltc2983_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> -	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
> +	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
>  			       IRQF_TRIGGER_RISING, st->info->name, st);
>  	if (ret)
> -		return dev_err_probe(&spi->dev, ret,
> +		return dev_err_probe(dev, ret,
>  				     "failed to request an irq\n");

		return dev_err_probe(dev, ret, "failed to request an irq\n");

Thanks,

Jonathan




>  
