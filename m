Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B8F3E4C86;
	Wed, 25 Mar 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450047; cv=none; b=usREeBPW15bBM8nD4+VnH4QLe4P9HEKX7Wu3M6L55N+uR4Rln5XsVd8Oq25HX7Nhci8bUhw6uo5p2Th6DUAGdvTY4IX05OA1qDYiguTLJhyIvMUnW+JNMDuEfW4kX/ASeShYtPuOO1Txvj4H8htpbRjvsJO1JqV9IFIkEVRGtwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450047; c=relaxed/simple;
	bh=/C6cB0+Xx+NDl68yR+mJudD4MBpP7mbYmW9+uHqkPW8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZFEUYOuYAPX2a+3l5TirGUyIdrCs0B4n17z6V0Oty9QNdGQ3pthUtMl5CtxDCtTqcQ5TOWZpgE7UMO+6+PakqjKJyiFP7qEY9SO4oy9wYIiEpu+ZPM7ruTcH2bBqsMXYdJtXdAIw506QTkyzzfrNw2is/2tGiu3e/PM/rosJfNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgqVY3yYLzHnGj3;
	Wed, 25 Mar 2026 22:46:45 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 123EE40571;
	Wed, 25 Mar 2026 22:47:21 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 14:47:20 +0000
Date: Wed, 25 Mar 2026 14:47:19 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Siratul Islam <email@sirat.me>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: Re: [PATCH v7 2/2] iio: proximity: add driver for ST VL53L1X ToF
 sensor
Message-ID: <20260325144719.00005a92@huawei.com>
In-Reply-To: <20260325063254.18062-3-email@sirat.me>
References: <20260325063254.18062-1-email@sirat.me>
	<20260325063254.18062-3-email@sirat.me>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Mar 2026 12:32:23 +0600
Siratul Islam <email@sirat.me> wrote:

> Add support for the STMicroelectronics VL53L1X Time-of-Flight
> ranging sensor with I2C interface.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Siratul Islam <email@sirat.me>

Hi Siratul,

I used this as a bit of an experiment as you'd +CC lkml and took a close
read of the feedback google's AI bot produced.
https://sashiko.dev/#/patchset/20260325063254.18062-1-email%40sirat.me

Be very careful when considering the output. There are some things
in here that are not true, or we don't generally defend against (like the
interrupt type related comments).

The iio_trigger_get() is (I think) a more general problem so ignore that
for your driver - will just be a tiny memory leak and stop the
module being easily unloaded.  I'll take a look at that one on a more general
basis. 

The regmap one is where these bots excel in that they sometimes go deeper
in analysis than a typical person focused on one driver.

The stuff on using standard devm_ wasn't from the bot and I think will make
things rather simpler.

Thanks,

Jonathan


> ---
>  MAINTAINERS                         |   1 +
>  drivers/iio/proximity/Kconfig       |  15 +
>  drivers/iio/proximity/Makefile      |   1 +
>  drivers/iio/proximity/vl53l1x-i2c.c | 795 ++++++++++++++++++++++++++++
>  4 files changed, 812 insertions(+)
>  create mode 100644 drivers/iio/proximity/vl53l1x-i2c.c
> 

> diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
> new file mode 100644
> index 000000000000..085bff04f5d9
> --- /dev/null
> +++ b/drivers/iio/proximity/vl53l1x-i2c.c

> +static void vl53l1x_power_off(void *priv)

See below. I'm not seeing a reason we need to handle this
in a driver specific way.

> +{
> +	struct vl53l1x_data *data = priv;
> +
> +	reset_control_assert(data->xshut_reset);
> +	regulator_disable(data->vdd_supply);
> +}
> +
> +static int vl53l1x_power_on(struct vl53l1x_data *data)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(data->vdd_supply);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(data->xshut_reset);
> +	if (ret) {
> +		regulator_disable(data->vdd_supply);
> +		return ret;
> +	}
> +	/*
> +	 * 1.2 ms max boot duration.
> +	 * Datasheet Section 3.6 "Power up and boot sequence".
> +	 */
> +	fsleep(1200);
> +
> +	return 0;
> +}
> +

> +
> +static int vl53l1x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct vl53l1x_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter,
> +				     I2C_FUNC_SMBUS_READ_I2C_BLOCK |
> +				     I2C_FUNC_SMBUS_BYTE_DATA))
Sashiko had an interesting comment on this...
https://sashiko.dev/#/patchset/20260325063254.18062-1-email%40sirat.me
(note in general be careful with this tools feedback, it has a significant
false positive rate!)

"Does this check needlessly reject pure I2C adapters?
The driver configures regmap with reg_bits = 16, which forces regmap to use
raw I2C transfers requiring I2C_FUNC_I2C. Checking for SMBUS_READ_I2C_BLOCK
might prevent the driver from loading on pure I2C adapters that can perfectly
support the device via regmap."

By by reading the comment is actually wrong, however... It did made me look.
With regbits == 16 & valbits == 8
The regmap code checks for I2C_FUNC_SMBUS_I2C_BLOCK
(and if not present fails).

So the I2C_FUNC_SMBUS_BYTE_DATA seems unused and
a broader check on both read and write versions of I2C_BLOCK seems
appropriate.

However, not a lot of point in checking it at all given regmap does
so for us. So I'd drop this check.

If anyone is bored, we should probably take a look to see if there
are other redundant (or wrong) calls for this.

There is another point about trigger references that might be
correct (but not unique to this driver so ignore it).  That warrants
some investigation - I'll take a look in near future.

> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->irq = client->irq;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &vl53l1x_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap),
> +				     "regmap initialization failed\n");
> +
> +	data->vdd_supply = devm_regulator_get(dev, "vdd");

I'm not sure if we had this discussion already but why do you need to keep vdd_supply
around?  Why not
	devm_regulator_get_enabled()?

Given you turn it on before reset and off afterwards and otherwise don't touch
it should end up as effectively the same as you have here.

I was expecting to see use of the regulator elsewhere, but seems not for now.
Note that if you do change this then rename the helpers to reflect they are
only doing reset handling.


> +	if (IS_ERR(data->vdd_supply))
> +		return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
> +				     "Unable to get VDD regulator\n");
> +
> +	/*
> +	 * XSHUT held low puts the chip in hardware standby. All register
> +	 * state is lost on de-assert so this is functionally a reset.
> +	 */
> +	data->xshut_reset = devm_reset_control_get_optional_exclusive(dev, NULL);

If you can switch to devm_regulator_get_enabled() this can I think be
	ret = devm_reset_control_get_optional_exclusive_deasserted()
removing the need to register the action to power off.

If you do that remember we still need the sleep after this call.

> +	if (IS_ERR(data->xshut_reset))
> +		return dev_err_probe(dev, PTR_ERR(data->xshut_reset),
> +				     "Cannot get reset control\n");
> +
> +	ret = vl53l1x_power_on(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to power on the chip\n");
> +
> +	ret = devm_add_action_or_reset(dev, vl53l1x_power_off, data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_chip_init(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = vl53l1x_set_distance_mode(data, VL53L1X_LONG);
> +	if (ret)
> +		return ret;
> +
> +	/* 50 ms timing budget (per ST Ultra Lite Driver) */
> +	ret = vl53l1x_set_timing_budget(data, 50);
> +	if (ret)
> +		return ret;
> +
> +	/* 50 ms inter-measurement period (per ST Ultra Lite Driver) */
> +	ret = vl53l1x_set_inter_measurement_ms(data, 50);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The hardware only supports "autonomous" continuous ranging mode.
> +	 * Start ranging here and leave it running for the lifetime of
> +	 * the device. Both direct reads and the buffer path rely on this.
> +	 */
> +	ret = vl53l1x_start_ranging(data);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, vl53l1x_stop_ranging_action, data);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "vl53l1x";
> +	indio_dev->info = &vl53l1x_info;
> +	indio_dev->channels = vl53l1x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(vl53l1x_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	if (client->irq) {
> +		struct iio_trigger *trig;
> +
> +		init_completion(&data->completion);
> +
> +		trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +					      iio_device_id(indio_dev));
> +		if (!trig)
> +			return -ENOMEM;
> +
> +		trig->ops = &vl53l1x_trigger_ops;
> +		iio_trigger_set_drvdata(trig, indio_dev);
> +		ret = devm_iio_trigger_register(dev, trig);
> +		if (ret)
> +			return ret;
> +
> +		indio_dev->trig = iio_trigger_get(trig);

So Sashiko had a comment on this that has me thinking.  Don't bother fixing it
in this driver as it true it's a common bug (and leaks a trigger structure).
I'll look into it.


> +
> +		ret = vl53l1x_configure_irq(dev, client->irq, indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> +						      &vl53l1x_trigger_handler,
> +						      NULL);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


