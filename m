Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF22EC083;
	Sun,  6 Sep 2026 00:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788654672; cv=none; b=cvnLXiVzcGX/0TjM+vLL/xUTN01P7y487CxDB0tYo2iGvHmLVArF5iFvYmBaA8KeoGRXNl5llYrdhuKMt6c0MXtQ9skhKdoq2K11ohGVV4vRoA/xwi0JwV8U4jN7dVg0v/GCun3v4wXG8fBJ6BRdgHdn6uXrJNf21O5ZdiLI3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788654672; c=relaxed/simple;
	bh=xl2U9WU+HaWAI959QKoHABWF9oBVuiE3oapXRNxn6Qc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=InViKi1sM/BNBe160STu4mkLaysTDejTPr55dbLZcxm0SDP0IZ5xnfdrYWVBMV4rjQlSDL3REXFUGNcvSsZCaPBm35NE2rb1wQIXUd9aHZJlI3KwO2jbw5iIwMre67qgmb+XctEYV+vBAHqT1s53zC+Q6ksAFMDomh7A7paWjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mcx+2aON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mcx+2aON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05441F00A3D;
	Sun,  6 Sep 2026 00:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788654671;
	bh=8C2w1hCEcDeQaFheEAWhGQD1Y9Qi/Y/2XP5xzCtl7xY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Mcx+2aONLNtmQhrOVct4c857PV/bBOHzYXOaWHD5DDsgqP5VJ+FVvpGPTCeTSV7+S
	 fKBaz9I02sU9RnhC5UQw3cFxZhkHk9RsXs75Asbv7RvlHrch8CuhTXvXqwe94h1ksP
	 qfA4dwbPH4EeF2XR993eaBl8rRJ/xVdD3aTYoRx3KWFkIQ/DR+UQNr2Uf8FoHeMhPc
	 R0HbCJPBW/a4VTnkUJyH/6cHQz4xkczv8DJMe2l39jWN2mzjv+DlzMDWvApnB8RpBv
	 NhjYRKAONld3tE8Thv1Ze0iPzA3QqNglyoEKtqNt5cgFbkDt6LecIJGFUU6mSMySoW
	 uxPmV+d/uTlrg==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] iio: light: add AS7343 multi-spectral sensor
 driver
From: Jonathan Cameron <jic23@kernel.org>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
 <521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
Date: Sun, 06 Sep 2026 01:30:39 +0100
Message-Id: <178865463956.3402141.11085158208427972814.b4-review@b4>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10790;
 i=jonathan.cameron@oss.qualcomm.com; h=from:subject:message-id;
 bh=xl2U9WU+HaWAI959QKoHABWF9oBVuiE3oapXRNxn6Qc=;
 b=owEBfwKA/ZANAwAKAVSFNJnE9BaIAcsmYgBqnLRIWW6oITkzykH2akwg814YBuC3KXvvU67av
 itZWHM77nGJAkUEAAEKAC8WIQRuKWazh4QGUpEmgbFUhTSZxPQWiAUCapy0SBEcamljMjNAa2Vy
 bmVsLm9yZwAKCRBUhTSZxPQWiGt5EACFSu8d6Uzw9HW6nSiA7N0r1b6Vcy4Ide8gp5458N8vmV8
 5ZXxipdFMEttQVU72TNw1406xJGWLkgVrPLU6TmO4M9I9OA5ydffliyzh4vyLqTjKD9S+LPjQj/
 HiZTT/6l7gm3UBLhyHAS1K4WNTOrtd3/EKDG4TNzDHOgnxDatHA4VZ80ivCx0cIaLmCbqUCf86D
 be58Ael6M5JBrMvOjZk0Zy5v2V+T9RhX7Z+8vSzCj3VZjHFjRHOqtAuLhiLd5Y4133V9BcfB9PH
 Bm+Gzj9zVe1Vzbi6xKZoJprn7qNgVGRdXLvUJclgMiUFpquY4zdhzFCUXOf0q1B8B7Jt6qu6Kve
 4rjpLIe8C70gUoD3mN/bcSTyIdcwAnp6cOLWBbWzlH+7BHksglbN3t2sqJMJyeUt91yyoy+kKsD
 2gWfWR0jVkxeq1m2j3/2PJ7i1ba1BgtAK9Hi1+pZKhS1P/9Tc+aHSLi9KDlkGn5W5+F+rP397E1
 3/UW3tHpL6gzNFJYydU+BU8btHUPJV+OkQ2R29xE+5Tqr30mwBrpe1zaFfENyxveXCkFxc8qoYK
 6Brmjudr20Q1sXV43reoTVaoc0Rh40Y4RWCflwfghrDdXO3aLOHQ1bMqO5krzOOrzQs2YMSkkSO
 fHS1MW0vnwrJNng2NrWML9PYizoM47pGZ1vQhNA==
X-Developer-Key: i=jonathan.cameron@oss.qualcomm.com; a=openpgp;
 fpr=6E2966B387840652912681B154853499C4F41688

> This patch adds a driver for the AMS AS7343 14-channel multi-spectral
> sensor with I2C interface.
> 
> The driver exposes 12 spectral channels (11 visible + 1 near-infrared)
> via the IIO sysfs interface. Each channel's raw data is provided as a
> 16-bit little-endian unsigned integer.
> 
> Basic power management (suspend/resume) is supported. More complex
> features such as interrupt support and configurable gain/integration
> time will be added in future patches.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
Hi Chang Yu,

I've avoided too much duplication with Joshua's already pretty
thorough review so just a few additional comments inline.


> diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
> new file mode 100644
> index 000000000000..b620dd308380
> --- /dev/null
> +++ b/drivers/iio/light/as7343.c

...

> +
> +#define AS7343_DRV_NAME "as7343"
> +#define AS7343_DEVICE_ID 0x81

For now I'd just put that inline.  If you end up with additional
supported parts it will end up in a chip_info structure of some kind.

> +
> +/* AS7343 registers */
> +#define AS7343_REG_ID 0x5a
> +#define AS7343_REG_ENABLE 0x80
> +#define AS7343_REG_ATIME 0x81
> +#define AS7343_REG_CFG0 0xbf
> +#define AS7343_REG_CFG1 0xc6
> +#define AS7343_REG_CFG20 0xd6

It is useful practice to document a register address its fields
and their values all in one place. If you look at other drivers
we often do that using some indentiation. E.g.


This keeps the register map easy to read and the names all make
it very obvious if writes are to the wrong register or similar.

> +#define AS7343_REG_CONTROL 0xfa
> +#define AS7343_REG_ASTATUS 0x94


> +/* AS7343 data registers */
> +#define AS7343_REG_DATA_FZ 0x95
> +#define AS7343_REG_DATA_FY 0x97
> +#define AS7343_REG_DATA_FXL 0x99
> +#define AS7343_REG_DATA_NIR 0x9b
> +#define AS7343_REG_DATA_F2 0xa1
> +#define AS7343_REG_DATA_F3 0xa3
> +#define AS7343_REG_DATA_F4 0xa5
> +#define AS7343_REG_DATA_F6 0xa7
> +#define AS7343_REG_DATA_F1 0xad
> +#define AS7343_REG_DATA_F7 0xaf
> +#define AS7343_REG_DATA_F8 0xb1
> +#define AS7343_REG_DATA_F5 0xb3
> +#define AS7343_REG_MAX 0xff
> +
> +/* AS7343 register bit masks */
> +#define AS7343_ENABLE_PON BIT(0)
> +#define AS7343_ENABLE_SP_EN BIT(1)
> +#define AS7343_CFG0_REG_BANK BIT(4)
> +#define AS7343_CFG20_AUTO_SMUX GENMASK(6, 5)
> +#define AS7343_CONTROL_SW_RESET BIT(3)
> +#define AS7343_CFG1_AGAIN GENMASK(4, 0)
> +
> +/* AS7343 settings */
> +#define AS7343_INT_TIME 29 /* (29 + 1) * 2.87ms = 83.4ms */

Implement this as a function to do the maths and take the input in
usecs.  Then you can call that with 83400 as the parameter to set the
default value.  Why this default?

> +#define AS7343_GAIN 7 /* 64x gain */

This is a field value, so naming should refect that.
AS7343_CFG1_AGAIN_X64 or something like that. May well make sense
to just specify all the possible field values by define - or replace
them with function given they are powers of 2 I think (be it -1 as
the first one.


> +#define AS7343_AUTO_CHANNEL_READOUT 3 /* Automatic all-channel readout */
This is a field value in AS7343_CFG20_AUTO_SMUX so naming
should reflect that.
or something like that.

> +
> +/* AS7343 scan indices */
> +#define AS7343_SCAN_INDEX_F1 0
> +#define AS7343_SCAN_INDEX_F2 1
> +#define AS7343_SCAN_INDEX_FZ 2
> +#define AS7343_SCAN_INDEX_F3 3
> +#define AS7343_SCAN_INDEX_F4 4
> +#define AS7343_SCAN_INDEX_FY 5
> +#define AS7343_SCAN_INDEX_F5 6
> +#define AS7343_SCAN_INDEX_FXL 7
> +#define AS7343_SCAN_INDEX_F6 8
> +#define AS7343_SCAN_INDEX_F7 9
> +#define AS7343_SCAN_INDEX_F8 10
> +#define AS7343_SCAN_INDEX_NIR 11
> +#define AS7343_SCAN_INDEX_TS 12
Probably an enum is appropriate.  Not used for now though so drop.
> +
> +#define AS7343_SCAN_MASK_ALL                                      \
> +	(BIT(AS7343_SCAN_INDEX_F1) | BIT(AS7343_SCAN_INDEX_F2) |  \
> +	 BIT(AS7343_SCAN_INDEX_FZ) | BIT(AS7343_SCAN_INDEX_F3) |  \
> +	 BIT(AS7343_SCAN_INDEX_F4) | BIT(AS7343_SCAN_INDEX_FY) |  \
> +	 BIT(AS7343_SCAN_INDEX_F5) | BIT(AS7343_SCAN_INDEX_FXL) | \
> +	 BIT(AS7343_SCAN_INDEX_F6) | BIT(AS7343_SCAN_INDEX_F7) |  \
> +	 BIT(AS7343_SCAN_INDEX_F8) | BIT(AS7343_SCAN_INDEX_NIR))
> +
> +static const unsigned long as7343_scan_masks[] = { AS7343_SCAN_MASK_ALL, 0 };

As below. This should only come in when or if you add buffered
data capture. Today it is meaningless so tremove it and the MASK_ALL
definition.

> +
> +#define AS7343_CHAN(_chan) \
> +	{ \
> +	.type = IIO_INTENSITY, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.address = AS7343_REG_DATA_##_chan, \
> +	.extend_name = __stringify(_chan), \

No for this - we no longer use extend_name.  It was a terrible bit
of ABI design a long time back.  Instead use channel labels to provide
in_intensityX_label with a suitable string.

> +	.scan_index = AS7343_SCAN_INDEX_##_chan, \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_LE, \
> +	}, \
You aren't implementing any buffered stuff so you definitely
aren't using all of this scan stuff. 
Only specify values of things that you actually use.
> +}
> +
> +static const struct iio_chan_spec as7343_channels[] = {
> +	AS7343_CHAN(F1),
> +	AS7343_CHAN(F2),
> +	AS7343_CHAN(FZ),
> +	AS7343_CHAN(F3),
> +	AS7343_CHAN(F4),
> +	AS7343_CHAN(FY),
> +	AS7343_CHAN(F5),
> +	AS7343_CHAN(FXL),
> +	AS7343_CHAN(F6),
> +	AS7343_CHAN(F7),
> +	AS7343_CHAN(F8),
> +	AS7343_CHAN(NIR),


> +	IIO_CHAN_SOFT_TIMESTAMP(AS7343_SCAN_INDEX_TS),
> +};

...

> +struct as7343_data {
> +	struct i2c_client *client;

Not used that I can see - so drop client from this.

> +	struct regmap *regmap;
> +};
> +
> +static int as7343_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	unsigned int low, high;
> +	unsigned int unused;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		/* Reading ASTATUS latches all data registers to this read.

Wrong comment style - see all the other IIO drivers.
Note only net and a few other places use this style in the kernel.

> +		 * We don't care about the returned saturation/gain status for
> +		 * now.
> +		 */
> +		ret = regmap_read(data->regmap, AS7343_REG_ASTATUS, &unused);
> +		if (ret < 0)
As below, for regmap calls prefer
		if (ret)
			return ret;
			
> +			return ret;
> +
> +		ret = regmap_read(data->regmap, chan->address, &low);
> +		if (ret < 0)
> +			return ret;


> +		ret = regmap_read(data->regmap, chan->address + 1, &high);
> +		if (ret < 0)
> +			return ret;

No option to do a bulk read?  I'd rather see one of those combined
with an appropriate endian conversion. The datasheet mentions auto
increment so that regmap_bulk_read() should just work I think.

> +		*val = (high << 8) | low;
> +		return IIO_VAL_INT;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


...

> +static const struct regmap_config as7343_regmap_config = {
> +	.name = "as7343",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = AS7343_REG_MAX,
> +	.reg_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +	.cache_type = REGCACHE_NONE,

It is a big enough register map that it may make sense to use
regcache and provide all the info on what is volatile etc.

> +};
> +
> +static int as7343_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct as7343_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &as7343_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;

This rings alarm bells given you also have a regmap.  Turns
out you don't use it - so drop this from data.

> +	data->regmap = regmap;
> +
> +	indio_dev->name = AS7343_DRV_NAME;

Use the string directly here. There is no particular reason it should
be the same as the driver naming, so I'd much rather see what the
value is here.

> +	indio_dev->info = &as7343_info;
> +	indio_dev->channels = as7343_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(as7343_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = as7343_scan_masks;

This is only relevant if you are doing buffered outputs, which
you aren't. So it's unused. Remove it.
> +
> +	ret = devm_regulator_get_enable(&client->dev, "vdd");
> +	if (ret < 0)
> +		return ret;
> +	/* Power on */
> +	ret = regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
> +			      AS7343_ENABLE_PON);
> +	if (ret < 0)

regmap only uses 0 for sucess and negative for failure, so
where they are regmap calls I'd prefer
	if (ret)
		return ret;

That makes some places where you can do
	return regmap*();
at the end of a function the same as all the places you have
to check it before carrying on.

> +		return ret;
> +

...

> +static int as7343_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct as7343_data *data = iio_priv(indio_dev);

As below.

> +
> +	return regmap_clear_bits(data->regmap, AS7343_REG_ENABLE,
> +				 AS7343_ENABLE_SP_EN);
> +}
> +
> +static int as7343_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

	struct iio_dev *indio_dev = dev_get_drvdata(dev);

Whilst a little odd given you use i2c_set_clientdata() to set it up
this pattern is well enough known by reviewers that we do it
this way anyway to sae on complexity of going backwards and forwards
via the i2c client.

> +	struct as7343_data *data = iio_priv(indio_dev);
> +
> +	return regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
> +			       AS7343_ENABLE_SP_EN);
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(as7343_pm_ops, as7343_suspend, as7343_resume);


> +};
> +MODULE_DEVICE_TABLE(i2c, as7343_id);
> +
> +static struct i2c_driver as7343_driver = {
> +	.driver = {
> +		.name           = AS7343_DRV_NAME,

As above, just put the string here.  Only use macros for things
like this when they help readability or enforce necessary matching
between multiple locations.

-- 
Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
