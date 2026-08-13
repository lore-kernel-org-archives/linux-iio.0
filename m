Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E3322A1C;
	Thu, 13 Aug 2026 01:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786583085; cv=none; b=ba/wzbeh8h3iNL++Db3M5ROk2qjhOJlucXCfAvHYakSiZHsuEh0YTm0DAThVfzd5neWsohwe412Yf2VxJ2L95WCN4YAzWuu4fx4Iat0Ry+YKweA+MgQdGNt2c6NFSg1Mvr4o+8Ol2o/KfiCPZKQ6eI4OanDLOiMgtWBdFLepgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786583085; c=relaxed/simple;
	bh=Lehd5Q6L+3q59vEJjcPIYc11C8i248KdhOdOu4/3cU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwHcmuIYCHhXpxJ1LxXaMa6E8MUlQWlSPmM0fBQxzEdaEeVBBkzKu/KFaKLT8yjZDyZ523C4RJc7J0cEV7U39/sojCfJYHRSlcsJKFCvZHkZeaTyeSntW27EyheIv9lgKawpF8Vto/+NwCzPLGT+Efr511WHLTgCcmLPCx+4zvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqvwOjae; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqvwOjae"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22F921F00A3A;
	Thu, 13 Aug 2026 01:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786583083;
	bh=4OyBhEt0r5lq8AT8n6cCJkvLoQuBHbAledxIBsbg8bM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mqvwOjae5zFlbOQLgb1/rorX2i5YbsA6BtyETHemLgX+5xrAYz15qJVKqxRKtAnvT
	 PahfH8zY4AhBK7PxJVN1pwRxLg4Tkce9/wNaJH9BbOoVKu+lR9HYaEJkUPwPFIrGNK
	 fCoFF/Q8P8X2wHu9fQlX7exAgiCA/zY4Vm3jK/0nPWMl6ZgT/AZMuscWEMZn2K9kcR
	 DtXhHLOic8Bp/7muvAkFd2q0KxwYigBb5ogaLZk9jzsAI2xjzKVEUJBh0QDLqKCMMM
	 eOyefXvlxKLy7393FEDI95wjRUCHyGPxqJAk5e2WUKTbNoMxU5ADSsk1aMwoDbMugp
	 /x0VBi3/dFFSg==
Date: Thu, 13 Aug 2026 02:04:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] iio: light: add support for veml6031x00 ALS
 series
Message-ID: <20260813020429.54031688@jic23-huawei>
In-Reply-To: <20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
References: <20260812-veml6031x00-v6-0-7eef6e4ce290@gmail.com>
	<20260812-veml6031x00-v6-2-7eef6e4ce290@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 22:27:41 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.
> 
> This first implementation provides basic functionality (measurement
> configuration, raw reads and ID validation) and defines the different
> register regions in preparation for extended features in the subsequent
> patches of the series.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Hi Javier,

A few minor things inline

Thanks,

Jonathan

> diff --git a/drivers/iio/light/veml6031x00.c b/drivers/iio/light/veml6031x00.c
> new file mode 100644
> index 000000000000..021bf726c60b
> --- /dev/null
> +++ b/drivers/iio/light/veml6031x00.c

> +
> +static const struct iio_chan_spec veml6031x00_channels[] = {
> +	{
> +		.type = IIO_LIGHT,
> +		.address = VEML6031X00_REG_ALS_L,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_INT_TIME) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_INT_TIME) |
> +						BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_INTENSITY,
> +		.address = VEML6031X00_REG_IR_L,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_LIGHT_IR,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}

Trailing comma.  Maybe we'll add more after this and they will fit on one line.
Yeah it's a stretch but generally always add comma unless it is a specific
terminating entry.

> +};


> +static int veml6031x00_validate_part_id(struct veml6031x00_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int part_id, ret;
> +	__le16 regval;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6031X00_REG_ID_L, &regval,
> +			       sizeof(regval));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(regval);
> +	if (part_id != data->chip->part_id)
> +		dev_info(dev, "Unknown ID %04x\n", part_id);

This will trigger on unknown or unexpected ID (i.e one we know about
but not the one firmware indicated we should expect).  I'd rephrase
to include that.

> +
> +	return 0;
> +}

> +static int veml6031x00_probe(struct i2c_client *i2c)
> +{
> +	struct device *dev = &i2c->dev;
> +	struct veml6031x00_data *data;
> +	struct iio_dev *iio;
> +	int ret;
> +
> +	iio = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!iio)
> +		return -ENOMEM;
> +
> +	data = iio_priv(iio);
> +	i2c_set_clientdata(i2c, iio);
> +
> +	data->chip = i2c_get_match_data(i2c);
> +	if (!data->chip)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get chip data\n");
> +
> +	data->regmap = devm_regmap_init_i2c(i2c, &veml6031x00_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "Failed to set regmap\n");
> +
> +	iio->name = data->chip->name;
> +	iio->channels = veml6031x00_channels;
> +	iio->num_channels = ARRAY_SIZE(veml6031x00_channels);
> +	iio->modes = INDIO_DIRECT_MODE;
> +	iio->info = &veml6031x00_info;
> +
> +	ret = devm_mutex_init(dev, &data->scale_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = veml6031x00_regfield_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regfield\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	/* The device starts in power down mode by default */
> +	ret = veml6031x00_set_power(data, true);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on the device\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6031x00_als_shutdown_action, data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add shutdown action\n");
> +
> +	pm_runtime_set_autosuspend_delay(dev, 2000);
> +	pm_runtime_use_autosuspend(dev);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
> +
> +	pm_runtime_get_noresume(dev);
> +
> +	ret = veml6031x00_validate_part_id(data);
> +	if (ret)
> +		goto err_pm_put;
> +
> +	ret = veml6031x00_hw_init(iio);
> +	if (ret)
> +		goto err_pm_put;
> +
> +	pm_runtime_put_autosuspend(dev);

This and the get_noresume() above smell like they are probably here to ensure
a 1->0 transition for the runtime pm reference count and hence kick off the timer
for autosuspend.   That shouldn't be necessary as there is code in the driver
core to try a suspend. Look for pm_request_idle() calls in drivers/base/dd.c

Note that we've had sashiko give what we have concluded in the past are false
positives on this dance being required.  
Given you have device to hand, just probe it and check if it suspends.

I haven't quite had the nerve to yet post a series removing this dance from
drivers I can't test!

> +
> +	ret = devm_iio_device_register(dev, iio);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register iio device\n");
> +
> +	return 0;
> +
> +err_pm_put:
> +	pm_runtime_put_noidle(dev);
> +	return ret;
> +}
