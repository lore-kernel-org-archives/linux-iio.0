Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F0037EFF7;
	Tue,  5 May 2026 10:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777977929; cv=none; b=Ac6FING08E+TUYGtq4JqbN5KgwfnbRKvakb6RI3bXBqP96nCUdO0v/sd0rXIiVvuixbEkmoKbSkVQ8MXvZRH6/jLmRc6zTiB9NyUJPT463C5Z5p4JuDt1ebK0pQx2DFeNwggrYO467/YfHvOdikMuHOlXQnG8kd/hoRnxX+9N5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777977929; c=relaxed/simple;
	bh=lSwpDVhMUpi6wgbPhN2ZGNLModj0jwfd1oABGkw4AO4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ec7E4vdiQI24bmZAnWnI3PO9bAOWjBFV2ExrtIJhvRCvQRpLoqdH/qJLaKFsGrDbsS3Opeq6GlVGqPraruiMOxemlq6o5rq38OA6ZOMTXYsUTjQUrlDBtCSAtBWN1Vk6yqGg0lZ/dL/tie4ri19PqOPGNcMWsSdvB+8/OYjWAGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrt8gDu0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrt8gDu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518B9C2BCB4;
	Tue,  5 May 2026 10:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777977929;
	bh=lSwpDVhMUpi6wgbPhN2ZGNLModj0jwfd1oABGkw4AO4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zrt8gDu0eQc2CNWx/tRqQngR3+AQLjXVkcVC5hppjOE3A+GSsfykyJnG+iQxMIWbD
	 beuIYF9MR0eq3WnQG1UEEs5eAb4w5JkJ/4y/BvQzGXA3Qvdny4DSQ21jIBqRLNw7UV
	 R8eS1Hrt1u0O2c0gyBgd6J9Dvtnrk9xuOtHsTiGrO4/Jk0NaSULpqPWSqq+j4wcZdn
	 ndS7CzbV7y45wJcH9Gqled1PiPa6cWyw7IPiiUQ+sZqmJRwKUxrx+f8skfTUlyK2So
	 Yp4vJzFJvlHowyHcLDiAFHWfnN+ekzZ0mxlm7OW4MaMBS8WQmmemRI1i7ijnM29nzN
	 25vgDCEJMZlKQ==
Date: Tue, 5 May 2026 11:45:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V4 08/10] iio: imu: inv_icm42607: Add Wake on Movement
 for icm42607
Message-ID: <20260505114518.4af3c3ac@jic23-huawei>
In-Reply-To: <20260501221152.194251-9-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
	<20260501221152.194251-9-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  1 May 2026 17:11:47 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for wake on movement for the icm42607 driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
One general thing as a result of change in how runtime pm
calls the stuff to track when it was last busy that I probably
missed in earlier patches.

Otherwise minor stuff inline.

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> index d998d8c94eb9..d056c74dcbfe 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

> +static int inv_icm42607_accel_disable_wom(struct iio_dev *indio_dev)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +	struct device *pdev = regmap_get_device(st->map);
> +	int ret;
> +
> +	ret = _inv_icm42607_accel_disable_wom(indio_dev);
> +
> +	pm_runtime_mark_last_busy(pdev);
> +	pm_runtime_put_autosuspend(pdev);
Check for this throughout. The definition of pm_runtime_put_autosuspend() is
now:
static inline int pm_runtime_put_autosuspend(struct device *dev)
{
	pm_runtime_mark_last_busy(dev);
	return __pm_runtime_put_autosuspend(dev);
}
So drop all separate calls to mark_last_busy()
> +
> +	return ret;
> +}

>  static const int inv_icm42607_accel_scale_nano[][2] = {
>  	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
>  	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
> @@ -464,6 +650,9 @@ static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
>  		return ret;
>  
>  	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
> +	if (ret)

> +		return ret;
Blank line here as the two blocks aren't that closely related.
Helps readability (a tiny bit!)
> +	ret = inv_icm42607_accel_set_wom_threshold(st, st->apex.wom.value, val, val2);
>  	if (ret)
>  		return ret;
>  

> +
>  static const struct iio_info inv_icm42607_accel_info = {
>  	.read_raw = inv_icm42607_accel_read_raw,
>  	.write_raw = inv_icm42607_accel_write_raw,
> @@ -586,6 +885,10 @@ static const struct iio_info inv_icm42607_accel_info = {
>  	.update_scan_mode = inv_icm42607_accel_update_scan_mode,
>  	.hwfifo_set_watermark = inv_icm42607_accel_hwfifo_set_watermark,
>  	.hwfifo_flush_to_buffer = inv_icm42607_accel_hwfifo_flush,
> +	.read_event_config = inv_icm42607_accel_read_event_config,
> +	.write_event_config = inv_icm42607_accel_write_event_config,
> +	.read_event_value = inv_icm42607_accel_read_event_value,
> +	.write_event_value = inv_icm42607_accel_write_event_value,
>  };
>  
>  struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 5c2010d8256f..480fe1741a04 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

> +int inv_icm42607_disable_wom(struct inv_icm42607_state *st)
> +{
> +	int ret;
> +
> +	/* disable WoM interrupt */
> +	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INT_SOURCE1,
> +				INV_ICM42607_INT_SOURCE1_WOM_INT1_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* disable WoM hardware */
> +	return regmap_clear_bits(st->map, INV_ICM42607_REG_WOM_CONFIG,
> +				 INV_ICM42607_WOM_CONFIG_EN);
> +}
> +
> +

Single line only between functions. 

>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,

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
> +	if (st->apex.on) {
> +		unsigned int status2, status3;
> +
> +		/* read INT_STATUS2 and INT_STATUS3 in 1 operation */
> +		ret = regmap_bulk_read(st->map, INV_ICM42607_REG_INT_STATUS2, st->buffer, 2);
> +		if (ret)
> +			goto out_unlock;
> +		status2 = st->buffer[0];
> +		status3 = st->buffer[1];
> +		inv_icm42607_accel_handle_events(st->indio_accel, status2, status3,
> +						 st->timestamp.accel);
> +	}
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &status);
> +	if (ret)
> +		goto out_unlock;
> +
> +	if (status & INV_ICM42607_INT_STATUS_FIFO_FULL)
> +		dev_warn(dev, "FIFO full data lost!\n");
> +
> +	if (status & INV_ICM42607_INT_STATUS_FIFO_THS) {
> +		ret = inv_icm42607_buffer_fifo_read(st, 0);
> +		if (ret) {
> +			dev_err(dev, "FIFO read error %d\n", ret);
> +			goto out_unlock;
> +		}
> +		ret = inv_icm42607_buffer_fifo_parse(st);
> +		if (ret)
> +			dev_err(dev, "FIFO parsing error %d\n", ret);
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&st->lock);

Looks like suitable place for guard() and early returns.


> +	return IRQ_HANDLED;
> +}
> +
> +/**
> + * inv_icm42607_irq_init() - initialize int pin and interrupt handler
> + * @st:		driver internal state
> + * @irq:	irq number
> + * @irq_type:	irq trigger type
> + * @open_drain:	true if irq is open drain, false for push-pull
> + *
> + * Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42607_irq_init(struct inv_icm42607_state *st, int irq,
> +				int irq_type, bool open_drain)
> +{
> +	struct device *dev = regmap_get_device(st->map);
> +	unsigned int val = 0;
> +	int ret;
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_RISING:
> +	case IRQF_TRIGGER_HIGH:
> +		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_HIGH;
> +		break;
> +	default:
> +		val = INV_ICM42607_INT_CONFIG_INT1_ACTIVE_LOW;
> +		break;
> +	}
> +
> +	switch (irq_type) {
> +	case IRQF_TRIGGER_LOW:
> +	case IRQF_TRIGGER_HIGH:
> +		val |= INV_ICM42607_INT_CONFIG_INT1_LATCHED;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	if (!open_drain)
> +		val |= INV_ICM42607_INT_CONFIG_INT1_PUSH_PULL;
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_INT_CONFIG, val);
> +	if (ret)
> +		return ret;
> +
> +	irq_type |= IRQF_ONESHOT;
> +	return devm_request_threaded_irq(dev, irq, inv_icm42607_irq_timestamp,
> +					 inv_icm42607_irq_handler, irq_type,
> +					 st->name, st);
> +}
> +
>  static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
>  {
>  	int ret;
> @@ -387,7 +523,7 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
>  	struct device *dev = regmap_get_device(regmap);
>  	struct fwnode_handle *fwnode = dev_fwnode(dev);
>  	struct inv_icm42607_state *st;
> -	int irq;
> +	int irq, irq_type;
>  	bool open_drain;
>  	int ret;
>  
> @@ -402,6 +538,9 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
>  	if (irq < 0)
>  		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
>  
> +	irq_type = irq_get_trigger_type(irq);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_FALLING;
This is cut and pasted from elsewhere. The only reason we ever do this
is to paper over a driver that set the irq type unconditionally and we should
never have done that.  The problem in those historical cases is we don't know
if boards are relying on that behaviour. Hence this hack.

For new code just let the firmware set it up without the driver doing
anything to modify it.  Fine to read it here and fail to use the interrupt
if nothing is set.

>  	open_drain = device_property_read_bool(dev, "drive-open-drain");
