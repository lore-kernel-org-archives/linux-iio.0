Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB20243956;
	Sun, 20 Sep 2026 00:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789863993; cv=none; b=oS0GaxpbckHyCKhRgLYl5tXKI0CSdtA/2yFrYKxYcUWW28ziQCoK/HsoCn8nuK9Q9AmWf5jrFAmBLCC2KqQt+1sgQKPS8/snQaNUi5bOVZVserp83sTujj/JC69GZLm5tRgzWXMh+8UDMv2ZypFRmqEd2y2YnJYyORv61/OU9Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789863993; c=relaxed/simple;
	bh=uLmvPUp87K7r0vGvD8ZD4IVYNriyJj+66xcneCBOS0o=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LuVQvB1LBVjqlKKmvOelpMNMZXeM/ZdxQtLhHIWcmDig4YhxOgWtapi5nxZqzJL+X8P+GjXqzMRRg+Zj2qRU1PIZeltYxsucoeQVk3WONdk/JR5XIh79b+XnZsRe/s95RKjZH+W7S0aOOWtVATH8tsny2rK74pvhKkyBQ+uYxYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0Tuu1vn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0Tuu1vn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D166E1F00893;
	Sun, 20 Sep 2026 00:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789863992;
	bh=PNtxMPBdA6D6F7+yKqIP1uS8LVqvhCrDZwDNAGGy/Dw=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=H0Tuu1vnosAtwMC7r9/HdIzmwOz69Xy8aclYQiOAj+eIHOCei7MlBwoK1LF5N6Yng
	 vkNCDcEXyP6P05FwlC+hIvMM9PwDg9j1K22WsuL5TttC/bomdOld2ewQKczTxZZthJ
	 KgOlY7hezhai9rSUjnHW6CJiYL3LlmFxjYnGOK134bfoQbRbo+2pd/wJDk6XVV9J5L
	 PTGTRY7qDRfh1m4H6ol6ELge4j7uvPklh1lJzW722BgyHOnp3+ZB4JaO098lo5KPWv
	 jDTnU2866EfmT98FJLIvvN0UUwWMWr/kj455C0qwAmKUvp36zL8uYAFBt75CzCODwD
	 wFi9sPTho/f3w==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shi Hao <i.shihao.999@gmail.com>, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260919235145.48273-3-marcus.yu.56@gmail.com>
References: <20260919235145.48273-1-marcus.yu.56@gmail.com>
 <20260919235145.48273-3-marcus.yu.56@gmail.com>
Date: Sun, 20 Sep 2026 01:26:11 +0100
Message-Id: <178986397173.706584.14464234266525982696.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7464;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=uLmvPUp87K7r0vGvD8ZD4IVYNriyJj+66xcneCBOS0o=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqrygzAZr8BViunxGyhfcH7UIvciP9dQgDhNbLW
 y1ZjHXsryKJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCaq8oMxEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiLmZD/0blpEXS9Wr5vPaJ2evT5K3coQlZBE2tRWK0yRurWuI+gl
 bGprbRUHt5O2objLtzQzShhCQwZkHFjiueLMkSbqvUhsVPYSe+TvQeHfwFvImsV7JUle6gvml9m
 mODe9beil1eD6ubnanyRK/ziFWkJGXANVF3Epkg/p5UhtGVDO8NuXxPe6ay+dazVyGOmJXrwBgc
 NV3LJG/OI46N3iPCfreYleGcLcgdp4Ta4xc5ZgLC9JhemFXFbXIrBtX32s+xz1qDvH1O/iisFip
 TFAAzvGKvl4ZTEg62Q1ZseHhS9DQuwUQcdLzbQWTRI8m6QZUeHaSBb2+LDvnwTI8qzOmVjBjV81
 /ga4VnkH+EspP9nNEKryHUcuJH43QYk7NEoIPLT4weuT8d7yJVCb4jGmk54cjA1KWw7qBPONaSF
 SzNgLkRbn5XHs+tpvH66u5cVDrbI7fwN0WoyOzKs8Yy3Ok3HUTPWCyphbt9DcIZ1mfYjXT1LvNQ
 gGVlObB7CEMQlUdFycncVdjk/fy0nLkhQ7spNQhnWTGYe7HeXtDMLldtd/UKSfjCQi5aY44bmGv
 fruk1izRgFlNc7oDqLYMHvMucJGw5/B+otc0la8f6MYE8OlgeqF9sSjLMCXBK0oA3jroDKjpzMN
 ESwzUTdKT0HYQlwbbVdl/s01ty+QkZjtwRbTOHw==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> Add a driver for the AMS AS7343 14-channel multi-spectral sensor.
> 
> The AS7343 is a 14-channel spectral sensor featuring 11 visible
> channels, 1 near-infrared channel, 1 clear channel (VIS), and 1
> flicker detection channel.
> 
> The driver exposes 12 spectral channels (11 visible light and 1
> near-infrared) via sysfs. Runtime PM is implemented to stop
> measurements when the device is suspended or torn down. Power is
> never cut (PON=1 always) to preserve register values.
> 
> Future patches will add configurable gain and integration time,
> interrupt support, buffered reads, VIS channel, and flicker
> detection.
> 
> Datasheet: https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>

FWIW I believe the sashiko feedback autosuspend is incorrect, but
probably good to sanity check that by proving device and just checking
the calls in dd.c are sufficient to put it to sleep after the auto
suspend time.

Sashiko generally seems not to spot that probe is special in this
regard.  Probably doesn't help that there are quite a few drivers
that do have the handling it suggests, presumably because humans
didn't know it was special either ;)

A couple of follow up comments inline.  This is coming together
nicely so I think we are down to tiny details now.

Jonathan

>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0c08e634bf4..9496280903d9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1460,6 +1460,7 @@ M:	Chang Yu <marcus.yu.56@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/ams,as7343.yaml
> +F:	drivers/iio/light/as7343.c
>  
>  AMT (Automatic Multicast Tunneling)
>  M:	Taehee Yoo <ap420073@gmail.com>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index 462fff1ddef2..d0dea4f3113b 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -152,6 +152,17 @@ config AS73211
>  	 This driver can also be built as a module.  If so, the module
>  	 will be called as73211.
>  
> +config AS7343
> +	tristate "AMS AS7343 14-Channel Multi-Spectral Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	 Say Y here to build support for the AMS AS7343 14-channel
> +	 multi-spectral sensor.
> +
> +	 To compile this driver as a module, choose M here: the module will
> +	 be called as7343.
> +
>  config BH1745
>  	tristate "ROHM BH1745 colour sensor"
>  	depends on I2C

> diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
> new file mode 100644
> index 000000000000..c079e0c6aa70
> --- /dev/null
> +++ b/drivers/iio/light/as7343.c


> +
> +/*
> + * Integration time is calculated as (ATIME + 1) * ((ASTEP + 1) * 2.78us).
> + * ATIME must be between 0 and 255, inclusive
> + * ASTEP must be between 0 and 65534, inclusive
> + */
> +static inline u8 as7343_atime_steps(unsigned int step)
> +{
> +	BUILD_BUG_ON(step < 1 || step > 256);

Whilst for now this is fine as you aren't making these controllable,
I would make them runtime checks just to make a future change to
make these userspce adjustable easier to make.

That will complicate the code a little but give less churn in the
longer term.

> +	return step - 1;
> +}
> +
> +static inline u16 as7343_astep_x2780ns(unsigned int n)
> +{
> +	BUILD_BUG_ON(n < 1 || n > 65535);

Same here.

> +	return n - 1;
> +}
> +


...

> +static int as7343_setup_device(struct device *dev, struct as7343_data *data)
> +{
> +	struct regmap *map = data->regmap;
> +	unsigned int val;
> +	__le16 step;
> +	int ret;
> +
> +	/* Power on */
> +	ret = regmap_set_bits(map, AS7343_ENABLE_REG, AS7343_ENABLE_PON);

If the regulators are fixed supplies and as such we haven't just
turned the power on here and device hasn't just taken default values,
could the previously driver / firmware / whatever have left us
using bank 1.  If so would that power on call do anything?

It's common to have a few control registers on a device accessible
from every bank, but that doesn't seem to be the case here. Though
given it won't work otherwise, I'm assuming it is the case for
CFG0 despite it being at an address of greater than 0x80!
As such expect to see first call being one to get the device using bank 0.

> +	if (ret)
> +		return ret;
> +
> +	/* Need to set REG_BANK to 1 before we can access ID */
> +	ret = regmap_update_bits(map, AS7343_CFG0_REG, AS7343_CFG0_REG_BANK,
> +				 FIELD_PREP(AS7343_CFG0_REG_BANK, 1));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(map, AS7343_ID, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != 0x81)
> +		dev_info(dev, "Unknown device ID: %x\n", val);
> +
> +	ret = regmap_update_bits(map, AS7343_CFG0_REG, AS7343_CFG0_REG_BANK,
> +				 FIELD_PREP(AS7343_CFG0_REG_BANK, 0));
> +	if (ret)
> +		return ret;
> +
> +	/* Configure the SMUX to readout all channels */
> +	ret = regmap_update_bits(map, AS7343_CFG20_REG, AS7343_CFG20_AUTO_SMUX,
> +				 FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
> +					    AS7343_CFG20_AUTO_SMUX_READOUT_ALL));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Setting a 600 * 2.78us * 30 = 50ms integration time as the default
> +	 * for now.
> +	 */
> +	step = cpu_to_le16(as7343_astep_x2780ns(600));
> +	ret = regmap_bulk_write(map, AS7343_ASTEP_REG, &step, sizeof(step));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(map, AS7343_ATIME_REG, as7343_atime_steps(30));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(map, AS7343_CFG1_REG, AS7343_CFG1_AGAIN,
> +				  FIELD_PREP(AS7343_CFG1_AGAIN,
> +					     AS7343_CFG1_AGAIN_X256));
> +}

...

> +static int as7343_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct as7343_data *data;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	regmap = devm_regmap_init_i2c(client, &as7343_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +
> +	ret = devm_mutex_init(dev, &data->mutex);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "as7343";
> +	indio_dev->info = &as7343_info;
> +	indio_dev->channels = as7343_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as7343_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return ret;
> +
> +	ret = as7343_setup_device(dev, data);
> +	if (ret)
> +		return ret;
> +
> +	/* Start measurements */
> +	ret = regmap_set_bits(regmap, AS7343_ENABLE_REG, AS7343_ENABLE_SP_EN);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, 3000);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	ret = devm_add_action_or_reset(dev, as7343_suspend_action, dev);

Why here?  Neither of the two calls immediately above have anything to
do with what this is unwinding?  I think this should logically be
before the pm_runtime_set_autosuspend_delay() call so that is
is clearly matched with the regmap one above that.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
