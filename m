Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662ABF513;
	Sat,  7 Feb 2026 16:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770482625; cv=none; b=EXzPpiaVGuTKoQAB3Rx3Ouz2VZJbAkjXBXryoV8doySH7ZZOGdtK8q68Yz1yJn/0GTFRaO/cSBYyDizze3waK9blChjGZDLTzb8byG8TD1gvWTEiexIOsKZydacV4DiMTTsD9gXRX5HN9HK/ZAZUNS2cWH9A2kmqfTpuEyC09rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770482625; c=relaxed/simple;
	bh=Axy4xoxt6KBeuhKTrrSBHiBupfnCUJJYBVb3gDBu7q0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fAAEOhLFyxBtNu7CWE/4ZpNyRetEY5ovP/OPwuPFuCGRg54CWBwAhl4LtQXwxBFoZfaDdqhJIGOSmBOi7fxmRBWPFWViwNrj2Qw2E6Hs08PfTXCwJLy5tKRH+/k9RrTblUXkgS3+iPY8vs74AlE64RgMJ3RwjAeP8e6PN/mgwoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGSwa3G5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGSwa3G5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CE07C116D0;
	Sat,  7 Feb 2026 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770482625;
	bh=Axy4xoxt6KBeuhKTrrSBHiBupfnCUJJYBVb3gDBu7q0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aGSwa3G5CAEYMJwyPRLY6nZ5m3HFcnCuOjqjlCm35ekZy8bLDSHEp7ysLadn77i12
	 RDHvuETw+UtDgtmlHbBbNF0sYE9VB/8mYcwB0vsdpW2Yaq7RXLYktcVvC3JA691hPh
	 /SJf056oQXFo7u+D7c2tnWj0d9QfqBgqSn3xKOQ+nQnBo0yFT31lqeOS6n9XpnJFuX
	 0JeCDuLR8bh2skAqbW/LX/2goozsu/+myxXpMoXnCNUAPiMrJDxI7HGZcRWg01cb6d
	 vopfyp5Uyc4jbJRIWIDiKQxoFE3fkVokk0f+BDGmsphluzfNIn/sq5v/wpm+J86U2g
	 FpQCqiefpdgZg==
Date: Sat, 7 Feb 2026 16:43:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Message-ID: <20260207164335.72ddf049@jic23-huawei>
In-Reply-To: <20260201-cm36686-v1-2-4949a2a9ba63@gmail.com>
References: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
	<20260201-cm36686-v1-2-4949a2a9ba63@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 01 Feb 2026 19:03:49 +0200
Erikas Bitovtas <xerikasxx@gmail.com> wrote:

> This driver adds the initial support for the Capella cm36686
> ambient light and proximity sensor and cm36672p proximity sensor.
> 
> Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
Hi Erikas

Welcome to IIO.
A few comments from me to supplement existing review from David.
There may be some overlap!

Jonathan



> diff --git a/drivers/iio/light/cm36686.c b/drivers/iio/light/cm36686.c
> new file mode 100644
> index 000000000000..eb108af7226d
> --- /dev/null
> +++ b/drivers/iio/light/cm36686.c

> +/* PS_CONF3 */
> +#define CM36686_PS_SMART_PERS_ENABLE	BIT(4)
> +
> +#define CM36686_LED_I			GENMASK(10, 8)
> +
> +/* INT_FLAG */
> +#define CM36686_PS_IF			GENMASK(9, 8)
Use field names that incorporate the register and that they are masks

#define CM36686_INT_FLAG_PS_IF_MASK		GENMASK(9, 8)

That way it is easy to see they are being written to the right register.

> +
> +/* Default values */
> +#define CM36686_ALS_ENABLE		0x00
> +#define CM36686_PS_DR_1_320		FIELD_PREP(CM36686_PS_DR, 3)
> +#define CM36686_PS_PERS_2		FIELD_PREP(CM36686_PS_PERS, 1)
> +#define CM36686_PS_IT_2_5T		FIELD_PREP(CM36686_PS_IT, 3)
> +#define CM36686_LED_I_100		FIELD_PREP(CM36686_LED_I, 2)
I'd just put the FIELD_PREP() calls inline rather than having these macros
for defaults.  Looks like the values being written maybe want defines.
Not obvious 2 means 100 as per this last one for instance.


> +enum {
> +	CM36686_SUPPLY_VDD,
> +	CM36686_SUPPLY_VDDIO,
> +	CM36686_SUPPLY_VLED,
> +	CM36686_SUPPLY_NUM,
I'm not sure this enum really helps as you just
enable them all in one go anyway. Just use indexes there.

> +};
> +
> +static const int cm36686_als_it_times[][2] = {
> +	{0, 80000},
> +	{0, 160000},
> +	{0, 320000},
> +	{0, 640000}
> +};
> +
> +static const int cm36686_ps_it_times[][2] = {
> +	{0, 320},
> +	{0, 480},
> +	{0, 640},
> +	{0, 800},
> +	{0, 960},
> +	{0, 1120},
> +	{0, 1280},
> +	{0, 2560}
	{ 0, 2560 },
preferred style for these.

> +};

> +static const struct iio_chan_spec_ext_info cm36686_ext_info[] = {
> +	{
> +		.name = "nearlevel",
> +		.shared = IIO_SEPARATE,
> +		.read = cm36686_read_near_level,
> +	},
> +	{}
	{ }

> +};

> +
>
> +
> +static void cm36686_shutdown(void *data)
> +{
> +	struct cm36686_data *chip = data;
> +	struct i2c_client *client = chip->client;
> +	int ret, als_shutdown, ps_shutdown;
> +
> +	als_shutdown = chip->als_conf | CM36686_ALS_SD;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_ALS_CONF,
> +					als_shutdown);

If I'm not missing anything, it would be easy to convert this driver
to regmap + enable regcache.  At that point you can use the rich
set of registration RMW functions in there and avoid need to do
your own caching like you have in als_conf / ps_conf etc.

> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to shutdown ALS");
> +
> +	ps_shutdown = chip->ps_conf[CM36686_PS_CONF1] | CM36686_PS_SD;
> +
> +	ret = i2c_smbus_write_word_data(client, CM36686_REG_PS_CONF1,
> +					ps_shutdown);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to shutdown PS");
> +
> +	ret = regulator_bulk_disable(ARRAY_SIZE(chip->supplies), chip->supplies);
> +	if (ret < 0)
> +		dev_err(&client->dev, "Failed to disable regulators");
> +}
> +
> +static int cm36686_probe(struct i2c_client *client)
> +{
I'd have
	struct device *dev = &client->dev;
just because it gets used a lot in probe.

> +	struct iio_dev *indio_dev;
> +	struct cm36686_data *chip;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev,
> +					  sizeof(struct cm36686_data));

sizeof(*chip)
is more compact and directly relates to us getting that space in 
chip = iio_priv() just below.

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);
Keep declarations to the top of functions unless we are using
cleanup.h stuff or there is some other strong reason we can't.

Otherwise, this should move to getting the structs directly as David
called out.

> +
> +	const struct cm36686_chip_info *info =
> +		&cm36686_chip_info_tbl[id->driver_data];
> +
> +	ret = i2c_smbus_read_byte_data(client, CM36686_REG_ID_FLAG);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret, "Failed to read device ID");
> +
> +	if (ret != CM36686_DEVICE_ID)
> +		return dev_err_probe(&client->dev, -ENODEV, "Device not recognized!");
As David said already, we don't error out on this in modern drivers
because of DT fallback compatibles.  We have a long tail of old
drivers that do still check this and error out that really want updating.

> +
> +	i2c_set_clientdata(client, indio_dev);

Used?

> +	chip->client = client;
> +	ret = devm_mutex_init(&client->dev, &chip->lock);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +		       "Failed to initialize mutex");
I'm fairly sure that can only fail with -ENOMEM due to the devres bit
failing and in that case we don't print messages with dev_err_probe()
anyway so you can drop this print.

> +
> +	chip->supplies[CM36686_SUPPLY_VDD].supply = "vdd";
> +	chip->supplies[CM36686_SUPPLY_VDDIO].supply = "vddio";
> +	chip->supplies[CM36686_SUPPLY_VLED].supply = "vled";
> +
> +	ret = devm_regulator_bulk_get(&client->dev,
> +		ARRAY_SIZE(chip->supplies), chip->supplies);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to enable regulators");
> +
> +	ret = devm_add_action_or_reset(&client->dev, cm36686_shutdown, chip);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to set shutdown action");
> +
> +	ret = cm36686_setup(chip);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to set up registers");
> +
> +	indio_dev->name = info->name;
> +	indio_dev->channels = info->channels;
> +	indio_dev->num_channels = info->num_channels;
> +	indio_dev->info = &cm36686_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					cm36686_irq_handler,
> +					IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +					indio_dev->name, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to request irq");
> +
> +	ret = devm_iio_device_register(&client->dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Failed to register iio device");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id cm36686_id[] = {
> +	{ "cm36686", CM36686 },
> +	{ "cm36672p", CM36672P },
> +	{}
As below.

> +};
> +
> +MODULE_DEVICE_TABLE(i2c, cm36686_id);
> +
> +static const struct of_device_id cm36686_of_match[] = {
> +	{ .compatible = "capella,cm36686" },
> +	{ .compatible = "capella,cm36672p" },
> +	{}
Really trivial style preference for IIO of
	{ }

A while back I wanted to have a consistent answer to how we
should format these and pretty much randomly selected that
one..

> +};
> +MODULE_DEVICE_TABLE(of, cm36686_of_match);
