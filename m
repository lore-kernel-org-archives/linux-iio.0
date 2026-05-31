Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1974D8CE;
	Sun, 31 May 2026 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780231789; cv=none; b=o/nRjVo05fzYoeztpmTH4K+NWCD+hrUw8qUyFceIfcZxzJKSR0uPbmTcye/OX6ynIedSLWE1mDpPgMp6Ce95qBOZbX1Z224N+yiNG7t81pCeSQs45/6R5QXHcUIbRkNeQSvTca6zu7fvgrkx2HATGaHYkh0os9Hgs2qE/l95ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780231789; c=relaxed/simple;
	bh=5nV79P+9EglaPAg5nPezTmysnGPfiy1R3Kpp5WqIfmw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ClZaVKtIhh2eRyBmmF+MQ0jLK8OvA7TSstXS3MCSq97Bpk0pRyKsUqst0aqeEeRRgxN/xdma5d9KJXIz48FJtuhk0mgFuP+DbsV/jNIH3TbzS/b8XyXrImwcuJtcLmNde9YpK3AaLptxsUQ5ratYY61PtgLd92UQ4jKbnq+gL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/BQ7x0A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/BQ7x0A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CDE91F00893;
	Sun, 31 May 2026 12:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780231787;
	bh=0FQT6mOQRjHPoUHEtFPyGoBL6/gd6UgwcPgHmimCaC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d/BQ7x0AM6FYpvv7+jiRlmdnet8xq7jq37iFPAFIDu2ll7AjI+ZijVXMZBnVgvyr2
	 KpjMSnjcqvRrO7AGrjF5GFkbq7nSOKyIzicB5S6bBxeMpOjshpeE9z+pVWZOfmYJyn
	 8QZ1Wz4+R2KC1Z062DJSR8avWWwIvT7U3ehPHGtBM8PaOuDz/1TQZuuL77dHjQM6Ge
	 kW8wVHXkkAliFJKua8ycsmmeQgmRbFPmeiar9HDVKu1U9puzneD9U024dF7MP3DtG7
	 lsFqbK2USg2sbla2PVUUrY7bWOv2VQzY+kkhgsp1YhCzr/L4I3C/8Bxg6ZLCdTALL7
	 0vJqcqWR+l0Ew==
Date: Sun, 31 May 2026 13:49:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V9 09/11] iio: imu: inv_icm42607: Add IRQ for icm42607
Message-ID: <20260531134936.051e9824@jic23-huawei>
In-Reply-To: <20260530031739.109063-10-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
	<20260530031739.109063-10-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 22:17:36 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add IRQ support for the icm42607 driver.
Note I'm only calling out a few things sashiko commented on. Make sure
you verify any others are fixed or false positives.

https://sashiko.dev/#/patchset/20260530031739.109063-1-macroalpha82%40gmail.com

I didn't have anything non sashiko related to add to this patch.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 97 ++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 6b623fb679f3..3c91623dffb2 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +
> +static irqreturn_t inv_icm42607_irq_handler(int irq, void *_data)
> +{
> +	struct inv_icm42607_state *st = _data;
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int status;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &status);
> +	if (ret) {
> +		dev_err(dev, "Interrut status read error %d\n", ret);
> +		goto out_unlock;
> +	}
> +
> +	if (status & INV_ICM42607_INT_STATUS_FIFO_FULL)
> +		dev_warn(dev, "FIFO full data lost!\n");
> +
> +	if (status & INV_ICM42607_INT_STATUS_FIFO_THS) {
> +		mutex_unlock(&st->lock);
> +		ret = inv_icm42607_buffer_fifo_read(st, 0);
> +		if (ret) {
> +			dev_err(dev, "FIFO read error %d\n", ret);
> +			goto out_unlock;
Sashiko caught this one.

Lock isn't held.  This dance is horrible though.  Normally we avoid this
by having an unlocked variant of the inner function 
__inv_icm42607_buffer_fifo_read() and a locked wrapper without the underscores.
Or push the lock out of there in general and add a __must_hold() marking so
we can detect any paths that don't have the lock.

> +		}
> +
> +		mutex_lock(&st->lock);
> +		ret = inv_icm42607_buffer_fifo_parse(st);
> +		if (ret)
> +			dev_err(dev, "FIFO parsing error %d\n", ret);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);
> +	return IRQ_HANDLED;
> +}

> +
>  static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
>  {
>  	int ret;
> @@ -367,13 +452,18 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  {
>  	struct device *dev = regmap_get_device(regmap);
>  	struct inv_icm42607_state *st;
> -	int irq;
> +	int irq, irq_type;
> +	bool open_drain;
>  	int ret;
>  
>  	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
>  	if (irq < 0)
>  		return dev_err_probe(dev, irq, "Unable to get INT1 interrupt\n");
>  
> +	irq_type = irq_get_trigger_type(irq);
> +
> +	open_drain = device_property_read_bool(dev, "drive-open-drain");
> +
>  	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
>  	if (!st)
>  		return -ENOMEM;
> @@ -433,6 +523,11 @@ int inv_icm42607_core_probe(struct regmap *regmap,
>  	if (IS_ERR(st->indio_accel))
>  		return PTR_ERR(st->indio_accel);
>  
> +	/* Initialize interrupt handling */
> +	ret = inv_icm42607_irq_init(st, irq, irq_type, open_drain);

Sashiko asks some stuff about ordering wrt to this call. It is relatively
unusual to register an irq after the driver is exposed to userspace. Tends to
lead to potentially silly races.  Can we move it before device registration
and rely on presence checks to handle any interrupts that we see before those
iio devices are registered?


> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");

