Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899CF28DC4;
	Sun, 31 May 2026 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780219191; cv=none; b=rFUWzO9XNolZiB54F6o9lN88v9uLH0R+5MFcNE7Gr4O1C3Tozm4H8sQnDDJUbBuGWvo4JkcC+rMiZpEv576OUa0c23PlTER2kOAuMOZgj/XL/ICa5Sogc6P2pYjlHQX0by1BpJWNhtlmwwca5wSIdvfuiBi4/gTok/858LoE5Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780219191; c=relaxed/simple;
	bh=lTEpupCz5e95lRZWgUEXfpYEgtxSnXd2Ve9l5g+7Phs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DjvoKI2upwOsOLA2tA7T+BrnijksOZvkrWGsYIA368iCCnA/Jf7SyYlGQqkagsbdpOrvPr0S+AV/TTtsCt3g5C2GKad9NrtDabJuW9/k0/buillXEndTki5GqldHFeKapJe/5SvTIKg9ZjwLy3NClH52nr0K7252Aph9c/AH6pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctDZva64; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctDZva64"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA801F00893;
	Sun, 31 May 2026 09:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780219190;
	bh=aXJv1A77oBAbTzc3e+FGYuA1HxWRloPUHzc9/wp5C+4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ctDZva64JtLhdZJWQ9ETV8Ssgl2l/1EPFDvBjVBowW5zK7IEZyRnj+OflGQMv792W
	 lSw0y8sWJEZavDfk7SK9A/QCK1pJsnOGudOwkgnu5GHz8bfU0QrWFigYT0MMsyEobL
	 f7l8OBEXsziZlVl/PaznjqoWptnillXpzU36lVafBjhFqG0oiSxWbbQ7GmapnQ4zLU
	 +h+nP6fIjgnnoKSBRq9OsjWNTJUycnQzEgwwtkys5WH3qYk8WPP28GARsS1K7yjULz
	 cIHuy4ciJyzCvppHjIaKetg7ur0jxMf1IrEcpiVh66TlzCslsc9GpJD7Np7cAIU1dy
	 Y/NLwTuDkcO9w==
Date: Sun, 31 May 2026 10:19:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi
 Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: veml3328: add support for new device
Message-ID: <20260531101940.037d1d7a@jic23-huawei>
In-Reply-To: <20260530-veml3328-v3-2-dd562eaee8d9@gmail.com>
References: <20260530-veml3328-v3-0-dd562eaee8d9@gmail.com>
	<20260530-veml3328-v3-2-dd562eaee8d9@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 May 2026 19:06:47 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Add support for the Vishay VEML3328 RGB/IR light sensor communicating
> via I2C (SMBus compatible).
> 
> Also add a new entry for said driver into Kconfig and Makefile.
> 
> Assisted-by: Gemini:3.1-Pro
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Hi Joshua,

I didn't find anything extras so this is just some more explanation for
the Sashiko comments.

Give we are approaching the end of the cycle, feel free to do a new version
quicker than normal if you are sure on what needs changing.

Jonathan

> diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
> new file mode 100644
> index 000000000000..1def67fd9b51
> --- /dev/null
> +++ b/drivers/iio/light/veml3328.c

> +static int veml3328_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct veml3328_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	unsigned int reg_val;
> +	int it_inx, gain_inx;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(regmap, chan->address, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_val;
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
> +		if (it_inx >= ARRAY_SIZE(veml3328_it_times))
> +			return -EINVAL;
> +
> +		*val = veml3328_it_times[it_inx][0];
> +		*val2 = veml3328_it_times[it_inx][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
> +		gain_inx = FIELD_GET(VEML3328_CONF_GAIN_MASK, reg_val);
> +
> +		if (it_inx >= ARRAY_SIZE(veml3328_it_times) || gain_inx >= 4)
> +			return -EINVAL;
> +
> +		/* Stride by 2 through the flattened array to match (val, val2) */
> +		*val = veml3328_scale_vals[it_inx][gain_inx * 2];
> +		*val2 = veml3328_scale_vals[it_inx][gain_inx * 2 + 1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml3328_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type, int *length,
> +			       long mask)
> +{
> +	struct veml3328_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int reg_val;
> +	int ret, it_inx;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*length = ARRAY_SIZE(veml3328_it_times) * 2;
> +		*vals = (const int *)veml3328_it_times;
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +
> +	case IIO_CHAN_INFO_SCALE:

Under the hood, like all the cleanup.h magic, this instantiates a local
variable - the cleanup scope is tided to that and scope for switch statements
is a funny thing - it's not per case, but rather the whole switch.
Hence need to add {} to define the scope for this case block.

Otherwise you enter this switch via another path and the local variable
is unassigned, but the __free() that cleans it up is set. Hence you get
a use of undefined variable.

> +		PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
> +		if (it_inx >= ARRAY_SIZE(veml3328_it_times))
> +			return -EINVAL;
> +
> +		*length = 8;
> +		*vals = (const int *)veml3328_scale_vals[it_inx];
> +		*type = IIO_VAL_INT_PLUS_MICRO;
> +		return IIO_AVAIL_LIST;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int veml3328_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct veml3328_data *data = iio_priv(indio_dev);
> +	struct regmap *regmap = data->regmap;
> +	struct device *dev = regmap_get_device(regmap);
> +	unsigned int reg_val;
> +	int i, it_inx;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		for (i = 0; i < ARRAY_SIZE(veml3328_it_times); i++) {
> +			if (veml3328_it_times[i][1] == val2)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(veml3328_it_times))
> +			return -EINVAL;
> +
> +		return regmap_update_bits(regmap, VEML3328_REG_CONF,
> +					  VEML3328_CONF_IT_MASK,
> +					  FIELD_PREP(VEML3328_CONF_IT_MASK, i));
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = regmap_read(regmap, VEML3328_REG_CONF, &reg_val);

Hmm. The comment made by sashiko on this is also possibly correct.
The write to INT_TIME can race with the write to INFO_SCALE.  Whilst that's
not a normal use model (one thread would typically set up all the parameters)
you could end up with picking a scale based on an int time that isn't the current
one. I'd just throw a guard(mutex)(&data->lock) above this whole switch so we don't have
to think about it. (and a mutex in data, plus initialization etc).


> +		if (ret)
> +			return ret;
> +
> +		it_inx = FIELD_GET(VEML3328_CONF_IT_MASK, reg_val);
> +		if (it_inx >= ARRAY_SIZE(veml3328_it_times))
> +			return -EINVAL;
> +
> +		for (i = 0; i < 4; i++) {
> +			if (val == veml3328_scale_vals[it_inx][i * 2] &&
> +			    val2 == veml3328_scale_vals[it_inx][i * 2 + 1])
> +				break;
> +		}
> +
> +		if (i == 4)
> +			return -EINVAL;
> +
> +		return regmap_update_bits(regmap, VEML3328_REG_CONF,
> +					  VEML3328_CONF_GAIN_MASK,
> +					  FIELD_PREP(VEML3328_CONF_GAIN_MASK, i));
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info veml3328_info = {
> +	.read_raw = veml3328_read_raw,
> +	.write_raw = veml3328_write_raw,
> +	.read_avail = veml3328_read_avail,
> +};
> +
> +static int veml3328_probe(struct i2c_client *client)
> +{

> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);

As per other thread check this results in power down.
If it doesn't, try moving autosupend calls after devm_pm_runtime_enable()
and see if that is enough.  Otherwise, you can either manipulate the counters
or I think just call pm_runtime_idle() to force it off immediately.


> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

