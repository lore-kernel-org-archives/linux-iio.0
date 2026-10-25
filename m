Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971278;
	b=ize687a5Bb0iwCRXs928HDcQhjHRrFwW+QaO6p51M+Zo7SZKbV/I6PkOssdb8z1qH66e
	 Bs+1bVvFKCJXL2V4iuyxyD1VXXWyuRCO6gp2WwDwAgc+Sxfyk1Bk/HDUuTnwDPMoJlvzf
	 4XJUKh2irwHvOaqqXXgJUUBLiOMeFPIec6ExDTLAAdRcu0WcxXMojbSFlTS0eovh8pV8z
	 Qiq5o/pYB7+B5UDRVxtP2Sg2KCwqRqUVXNumeBLEQLDbYVlMTCu5atCs9XohcYXiLyAjh
	 JE0D2pIrqKV81E86WTEjT15zl3dKdu3gXhcVcoTBH39f+tKb9V8c4y4ALPVD7NBA3Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971278;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=jgxLF4l7tIp925U7psgjt2bmZePZKVTyZDOvhrKzpXc=;
	b=TtUT5i8GxEUiu3iCpZOsFOwiy/EVilX0zWXJ/8toHOSrN5oM9OKtyrG/mpuw3mCNpQWd
	 SUrUzb7gh1nQ0j//B5fQerczM0fjVTz9FOVbHOsf8rG+tIVoxHSZDSTItvAHJhF6Hq464
	 o5vL4rr0VC44GO0c5nybQJQnzY4u+HXyFKcN7h1oVKJzuh4DuJC78UXZX7ZxKyiF8XW+R
	 Ot7RVFr48FFJzAabyR8m+Zg+sQSCip6xpJdhD8mXDg5crDOguz6d3egCm9zS7x9JprQHR
	 OA8y83yk0tdeL6oi5mwzgbmg+oXKWpoBj5xDDoxh/YB1edEeEifTeSbufBFu1X3GQ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5hyTFGs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D291606A31A;
	Sun, 25 Oct 2026 23:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G5hyTFGs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 457A71F01825;
	Sun, 25 Oct 2026 23:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971277;
	bh=jgxLF4l7tIp925U7psgjt2bmZePZKVTyZDOvhrKzpXc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G5hyTFGs3ZzX8kTTDfNhUNxQdNV9cOrBlQmymKN5xHla9mYCJGyQHaHvH0cnfzOz/
	 t7nD1+ejhvtdQ7r3w3vVmGhQvfjjqu1UFoUNXK6lyWtp26h3YlbwyJ0PVykSsScvKL
	 BX+EkALA7iy7Pn1tZojJ9rOUnhsuspet81iUBFygSxE/K69rcNJ0ehqlMpvsHKo7mR
	 xLfN0fXBxA6SJdMqH7vbFUgbkxypzvvPE7BNlDEylpFvU/iEPpu5DYrquRhZ1wTKcB
	 KWNidCZN6qDMLSwEFhjZzd4MZHKcHuUbnCAIinTwpE6MvYeI0QFEuGOt7S96ZIgwmb
	 qDvgR/P/MUOuw==
Date: Sun, 25 Oct 2026 23:34:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>, Andy
 Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?=
 =?UTF-8?B?Zw==?= <u.kleine-koenig@baylibre.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: adc: ti-ads1298: add ADS1299 support
Message-ID: <20261025233429.23b02702@jic23-hlaptop>
In-Reply-To: <20261024231335.280955-7-stephanbrrs8@gmail.com>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
	<20261024231335.280955-7-stephanbrrs8@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 20:13:35 -0300
Stephan Costa Barros <stephanbrrs8@gmail.com> wrote:

> The ADS1299, ADS1299-6 and ADS1299-4 are 8, 6 and 4-channel, 24-bit
> biopotential ADCs for EEG. They share the register map, the commands
> and the data format of the ADS129x, and differ in:
> 
> - the PGA gains, 1, 2, 4, 6, 8, 12 and 24;
> - the data rates, f_CLK / 2^(7 + DR) with no HR bit, from 16 kSPS to
>   250 SPS, and the oversampling ratio, 64 * 2^DR;
> - the internal reference, a fixed 4.5 V, and the reserved bits 6:5 of
>   CONFIG3;
> - the ID register, which holds the channel count in bits 1:0;
> - the register map, which ends at CONFIG4;
> - the inputs, which are shorted out of reset.
> 
> Add the chip info for the ADS1299, and connect the inputs of every
> channel at init, which changes nothing on the ADS129x, whose inputs are
> already connected out of reset. The channel count is read from the ID
> register, so ti,ads1299 also serves the ADS1299-4 and ADS1299-6 through
> their fallback.
> 
> For both families, enable the DVDD supply when the device tree gives
> one, and hold PWDN asserted, like RESET, until the supplies and the
> clock are up. Nothing changes for a device tree that has neither.
> 
> Tested on an ADS1299 with a Raspberry Pi 4.
> 
> Signed-off-by: Stephan Costa Barros <stephanbrrs8@gmail.com>
Hi Stephan

A few things in here feel like they should be in precursor
patches because the implication is they apply just as much
to improving support for the ads1298 as they do for the
new device.

Thanks

Jonathan

> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 5ad543bdf..e0cea23b1 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c

> @@ -354,6 +361,15 @@ static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
>  		return -EINVAL;
>  
>  	factor = (rate >> info->dr_shift) / val;
> +
> +	if (!info->has_hr) {
> +		/* The slowest rate at or above val, or the lowest of all */
> +		cfg = factor ? min(ilog2(factor), ADS1298_LOWEST_DR) : 0;
> +
> +		return regmap_update_bits(priv->regmap, ADS1298_REG_CONFIG1,
> +					  ADS1298_MASK_CONFIG1_DR, cfg);
> +	}
> +
>  	if (factor >= BIT(ADS1298_LOWEST_DR + 1))
>  		cfg = ADS1298_LOWEST_DR; /* Lowest rate, in LP mode */
>  	else if (factor)
> @@ -772,6 +788,43 @@ static int ads1298_parse_id(struct iio_dev *indio_dev, unsigned int id)
>  	return 0;
>  }
>  
> +/* The ADS1299 has no WCT registers */
> +static const struct regmap_config ads1299_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.reg_read = ads1298_reg_read,
> +	.reg_write = ads1298_reg_write,
> +	.max_register = ADS1298_REG_CONFIG4,
> +	.wr_table = &ads1298_regmap_writeable,
> +	.volatile_table = &ads1298_regmap_volatile,
> +	.cache_type = REGCACHE_MAPLE,
> +};
> +
> +static int ads1299_parse_id(struct iio_dev *indio_dev, unsigned int id)
> +{
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +	struct device *dev = &priv->spi->dev;
> +	unsigned int nu_ch;
> +
> +	nu_ch = FIELD_GET(ADS1299_MASK_ID_CHANNELS, id);
> +	/* 0, 1 and 2 are 4, 6 and 8 channels; 3 is reserved */
> +	if (FIELD_GET(ADS1299_MASK_ID_DEVICE, id) != ADS1299_ID_DEVICE ||
> +	    nu_ch > 2)
> +		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", id);
How do backwards compatible parts with fallback compatible of ads1299 work?

Generally we don't reject on simply an who am I value mismatch.
Note the existing driver may need relaxing on that point - we used
to do this before DT maitainers pointed out what it broke!

> +	indio_dev->num_channels = 4 + 2 * nu_ch;
> +
> +	/* TI sells the 8-channel part as plain ADS1299 */
> +	if (indio_dev->num_channels == ADS1298_MAX_CHANNELS)
> +		indio_dev->name = "ads1299";
> +	else
> +		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads1299-%u",
> +						 indio_dev->num_channels);
> +	if (!indio_dev->name)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
>  static const u8 ads1298_gains[] = { 6, 1, 2, 3, 4, 8, 12 };
>  
>  static const struct ads1298_chip_info ads1298_chip_info = {
> @@ -787,10 +840,24 @@ static const struct ads1298_chip_info ads1298_chip_info = {
>  	.config3_reserved = ADS1298_MASK_CONFIG3_RESERVED,
>  };
>  
> +static const u8 ads1299_gains[] = { 1, 2, 4, 6, 8, 12, 24 };
> +
> +static const struct ads1298_chip_info ads1299_chip_info = {
> +	.parse_id = ads1299_parse_id,
> +	.regmap_config = &ads1299_regmap_config,
> +	.gains = ads1299_gains,
> +	.num_gains = ARRAY_SIZE(ads1299_gains),
> +	.dr_shift = 7,
> +	.osr_base = 64,
> +	.vref_mv = 4500,
> +	.config3_reserved = ADS1299_MASK_CONFIG3_RESERVED,
> +};
> +
>  static int ads1298_init(struct iio_dev *indio_dev)
>  {
>  	struct ads1298_private *priv = iio_priv(indio_dev);
>  	unsigned int val;
> +	unsigned int i;
>  	int ret;
>  
>  	/* Device initializes into RDATAC mode, which we don't want */
> @@ -822,6 +889,16 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  	if (!priv->reg_vref)
>  		msleep(ADS1298_REF_START_UP_MS);
>  
> +	/* The ADS1299 comes out of reset with its inputs shorted */

What is the case for the ADS1298 - is this just harmless or does
that have similar behavior?

> +	for (i = 0; i < indio_dev->num_channels; i++) {

	for (unsigned int i = 0;...

> +		ret = regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),
> +					 ADS1298_MASK_CH_MUX,
> +					 FIELD_PREP(ADS1298_MASK_CH_MUX,
> +						    ADS1298_MUX_NORMAL));
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -830,6 +907,7 @@ static int ads1298_probe(struct spi_device *spi)
>  	struct ads1298_private *priv;
>  	struct iio_dev *indio_dev;
>  	struct device *dev = &spi->dev;
> +	struct gpio_desc *powerdown_gpio;
>  	struct gpio_desc *reset_gpio;
>  	unsigned long clk_rate;
>  	int ret;
> @@ -844,12 +922,18 @@ static int ads1298_probe(struct spi_device *spi)
>  	if (!priv->chip_info)
>  		return -ENODEV;
>  
> -	/* Reset to be asserted before enabling clock and power */
> +	/* Reset and power-down to be asserted before enabling clock and power */
>  	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>  	if (IS_ERR(reset_gpio))
>  		return dev_err_probe(dev, PTR_ERR(reset_gpio),
>  				     "Cannot get reset GPIO\n");
>  
> +	powerdown_gpio = devm_gpiod_get_optional(dev, "powerdown",

Given this is not limited to the new part, perhaps this should
be a separate feature first added for the ads1298 and just
adopted here?

> +						 GPIOD_OUT_HIGH);
> +	if (IS_ERR(powerdown_gpio))
> +		return dev_err_probe(dev, PTR_ERR(powerdown_gpio),
> +				     "Cannot get powerdown GPIO\n");
> +
>  	priv->reg_avdd = devm_regulator_get(dev, "avdd");
>  	if (IS_ERR(priv->reg_avdd))
>  		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> @@ -863,6 +947,10 @@ static int ads1298_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	ret = devm_regulator_get_enable_optional(dev, "dvdd");

As above. If this is general for both devices, introduce it
for the existing parts in a patch that is before adding the new
device support.

> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "Failed to enable dvdd regulator\n");
> +
>  	/* VREF can be supplied externally, otherwise use internal reference */
>  	priv->reg_vref = devm_regulator_get_optional(dev, "vref");
>  	if (IS_ERR(priv->reg_vref)) {
> @@ -904,6 +992,9 @@ static int ads1298_probe(struct spi_device *spi)
>  	indio_dev->channels = ads1298_channels;
>  	indio_dev->info = &ads1298_info;
>  
> +	/* Out of power-down, now that the supplies and the clock are up */
> +	gpiod_set_value_cansleep(powerdown_gpio, 0);
As above.   Seems to apply to all parts, so precursor patch.

This final patch should only be adding ads1299 specific stuff.

> +
>  	/* Power-on reset time, counted from when the clock is valid */
>  	msleep(DIV_ROUND_UP(ADS1298_TPOR_CLOCKS * MILLI, clk_rate));
>  
> @@ -957,12 +1048,14 @@ static int ads1298_probe(struct spi_device *spi)
>  
>  static const struct spi_device_id ads1298_id[] = {
>  	{ .name = "ads1298", .driver_data = (kernel_ulong_t)&ads1298_chip_info },
> +	{ .name = "ads1299", .driver_data = (kernel_ulong_t)&ads1299_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ads1298_id);
>  
>  static const struct of_device_id ads1298_of_table[] = {
>  	{ .compatible = "ti,ads1298", .data = &ads1298_chip_info },
> +	{ .compatible = "ti,ads1299", .data = &ads1299_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ads1298_of_table);
> @@ -978,5 +1071,6 @@ static struct spi_driver ads1298_driver = {
>  module_spi_driver(ads1298_driver);
>  
>  MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> -MODULE_DESCRIPTION("TI ADS1298 ADC");
> +MODULE_AUTHOR("Stephan Costa Barros <stephanbrrs8@gmail.com>");
> +MODULE_DESCRIPTION("TI ADS1298 and ADS1299 ADC");
>  MODULE_LICENSE("GPL");

