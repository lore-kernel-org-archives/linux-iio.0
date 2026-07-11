Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEA4499B4;
	Sat, 11 Jul 2026 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783813977; cv=none; b=srdnr6DTLdW4SAgGrTrvjZELblaA5TeuZYpXEDAwP7eIlzY8FVjVqQjC7/yAv84ISH6mjxV1JUrv8xVkKUd28wsAgl/Z9nStDOUJVCBoANOHDGjLuAqDpeE4Mpy36bPsR7kb0PujqzeOGMYDH1d8nHql2EA36bK8LlhrqRI6dtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783813977; c=relaxed/simple;
	bh=U0ForyYQyPhHRqgc28t/XM2L0AcxaURE16Kdf4LgLO8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9YF+XBVa4tQUcMdidQsgGvBoIvxPWWW+j/2mBlx7VAhfWBfarHj8vf8QzZwdc2MNT9SwY7zN2Kt1HVrthWf5KjkDiYQjvQWy6PI3HuQCNtkIn9JoIOPFYWM4yQ3GyEaT5c5jVk0I5D3shPLK02mwwAi1Bjcsdjy2VKIYT1HIbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrsuWnhQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrsuWnhQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AC91F000E9;
	Sat, 11 Jul 2026 23:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783813976;
	bh=RwsrjQAR6QVRY4x8dxMwuakDsVZvPQvm70GMZUsYXd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YrsuWnhQuxsDg/mgx1H09bni9YRUOqdK6mLNiZaRAnE+62M/KHa00jt2ASH8ikNKt
	 350zHKV7E6jhpFJigw9Of5f1KZ5yMd5Uv3BAiA/GUmJ7CxqaeOuRw30SxDFhw7Pfjg
	 /83LtiEhqjQi15S7VA9w6L3A/PqLXpYGEl1PhCJKIjqahcux7/bd8Fbi5PCcgCtQj1
	 /T8U2MMO6nLdQWrkc5m07jYVnjyVui4xiwfpNKXgFPmEZxb2PQ8XaoZyzUurpbaGp8
	 cDfSJ5RLjHt4d8PyU5L0Bc0AntRvBiHa8WVzb+sEXzzvnzfPCzZv8F4RZho5laA5jr
	 YPtVz6iFIdZ8g==
Date: Sun, 12 Jul 2026 00:52:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: ti-ads1298: add ADS1299 EEG ADC family
 support
Message-ID: <20260712005251.251b5c83@jic23-huawei>
In-Reply-To: <20260706112614.1262241-3-shofiqtest@gmail.com>
References: <20260706112614.1262241-1-shofiqtest@gmail.com>
	<20260706112614.1262241-3-shofiqtest@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  6 Jul 2026 14:26:14 +0300
Md Shofiqul Islam <shofiqtest@gmail.com> wrote:

> The ADS1299, ADS1299-4 and ADS1299-6 are 8/4/6-channel, 24-bit
> biopotential (EEG) ADCs from Texas Instruments.  They share the same
> SPI interface, command set and register map as the ADS1298 ECG family,
> making it straightforward to support them in this driver.
> 
> Key differences from the ADS1298:
> - PGA gain range is 1/2/4/6/8/12/24 (vs 6/1/2/3/4/8/12 for ADS1298)
> - Internal voltage reference is always 2.4V (no 4V option)
> - Channel count is encoded differently in the ID register: bits [4:3]
>   identify the ADS1299 family (both bits set), bits [1:0] encode the
>   channel count as (bits + 2) * 2
> 
> Detect the chip family in ads1298_init() by checking bits [4:3] of
> the ID register.  Store the result in the is_ads1299 flag and use it
> to select the correct PGA table in ads1298_get_scale() and to skip
> the 4V reference option in the CONFIG3 initialisation.
> 
> Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

These sort of special purpose ADC chips are normally non trivial to test.
I'm curious, what are you testing with?  Basic testing with a dev board
or actual capture of ECG signals?  Or is there a device out there that has
one of these integrated and runs Linux? 

> ---
>  drivers/iio/adc/ti-ads1298.c | 84 ++++++++++++++++++++++++++++--------
>  1 file changed, 65 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> index 579200e06cbd6..7cff51d23d12f 100644
> --- a/drivers/iio/adc/ti-ads1298.c
> +++ b/drivers/iio/adc/ti-ads1298.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/* TI ADS1298 chip family driver
> +/* TI ADS1298/ADS1299 biopotential ADC driver
>   * Copyright (C) 2023 - 2024 Topic Embedded Products
> + * Copyright (C) 2026 Md Shofiqul Islam <shofiqtest@gmail.com>
>   */
>  
>  #include <linux/bitfield.h>
> @@ -43,6 +44,20 @@
>  #define ADS1298_MASK_ID_CHANNELS		GENMASK(2, 0)
>  #define ADS1298_ID_FAMILY_ADS129X		0x90

>  #define ADS1298_ID_FAMILY_ADS129XR		0xd0
> +/*
> + * ADS1299 family is identified by bits [4:3] = 0b11.  Bits [7:5] encode
> + * the silicon revision and vary between production lots, so only bits [4:3]
> + * are checked for family identification.
> + */
> +#define ADS1299_MASK_ID_FAMILY			GENMASK(4, 3)
So the above wild cards, ADS129X covers this which makes me wonder if we need
to rename that.  I think we should - despite that naming being on the
datasheet. If anyone wondered why we don't trust device manufacturers
to keep to their numbering / naming schemes and hence generally resist wild
cards in IIO, then this is a wonderful example.

Also, the datasheet google fed me has
REV_ID: 7:5
Reserved: 4 - always 1.
DEV_ID: 3:2
NU_CH: 1:0

So I have no idea what this is...

> +#define ADS1299_ID_FAMILY_EEG			GENMASK(4, 3)

Have the values of the ID field as the values that will come out of
FIELD_GET(ADS1299_MASK_ID_FAMILY, val)
so, here that would be 3.  I'm not sure representing it as a bit
mask makes sense. It is just a number.    However it's also called
DEV_ID on the datat sheet, so follow that
> +/*
> + * ADS1299 channel count is encoded in bits [1:0] of the ID register:
> + * 00 -> 4 channels (ADS1299-4)
> + * 01 -> 6 channels (ADS1299-6)
> + * 10 -> 8 channels (ADS1299)
> + */
> +#define ADS1299_MASK_ID_CHANNELS		GENMASK(1, 0)
>  
>  #define ADS1298_REG_CONFIG1	0x01
>  #define ADS1298_MASK_CONFIG1_HR			BIT(7)
> @@ -101,6 +116,7 @@
>  struct ads1298_private {
>  	const struct ads1298_chip_info *chip_info;
>  	struct spi_device *spi;
> +	bool is_ads1299;
>  	struct regulator *reg_avdd;
>  	struct regulator *reg_vref;
>  	struct clk *clk;
> @@ -276,7 +292,10 @@ static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
>  				  cfg);
>  }
>  
> +/* ADS1298 PGA: register bits [6:4] -> gain (000=6, 001=1, 010=2, ...) */
>  static const u8 ads1298_pga_settings[] = { 6, 1, 2, 3, 4, 8, 12 };
> +/* ADS1299 PGA: register bits [6:4] -> gain (000=1, 001=2, 010=4, ...) */
> +static const u8 ads1299_pga_settings[] = { 1, 2, 4, 6, 8, 12, 24 };
>  
>  static int ads1298_get_scale(struct ads1298_private *priv,
>  			     int channel, int *val, int *val2)
> @@ -291,12 +310,15 @@ static int ads1298_get_scale(struct ads1298_private *priv,
>  			return ret;
>  
>  		*val = ret / MILLI; /* Convert to millivolts */
> +	} else if (priv->is_ads1299) {
> +		/* ADS1299 internal reference is always 2.4V */

It is?  Give as specific reference to which table, section that is in on the datasheet.
(which is to say I checked and am seeing a different value - though the wiring
is non trivial so maybe this is the effective value in some sense?)


> +		*val = 2400;
>  	} else {
>  		ret = regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
>  		if (ret)
>  			return ret;
>  
> -		/* Reference in millivolts */
> +		/* ADS1298 reference in millivolts: 2.4V or 4V */

Number is right there in the code, so not sure the comment adds much. 

>  		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
>  	}
>  
> @@ -304,7 +326,8 @@ static int ads1298_get_scale(struct ads1298_private *priv,
>  	if (ret)
>  		return ret;
>  
> -	gain = ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
> +	gain = (priv->is_ads1299 ? ads1299_pga_settings : ads1298_pga_settings)
> +		[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];

Too nasty to read. Use a local variable for the ternary output then
index into that.

>  	*val /= gain; /* Full scale is VREF / gain */
>  
>  	*val2 = ADS1298_BITS_PER_SAMPLE - 1; /* Signed, hence the -1 */
> @@ -600,20 +623,39 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  	if (ret)
>  		return ret;
>  
> -	/* Fill in name and channel count based on what the chip told us */
> -	indio_dev->num_channels = 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS);
> -	switch (val & ADS1298_MASK_ID_FAMILY) {
> -	case ADS1298_ID_FAMILY_ADS129X:
> -		suffix = "";
> -		break;
> -	case ADS1298_ID_FAMILY_ADS129XR:
> -		suffix = "r";
> -		break;
> -	default:
> -		return dev_err_probe(dev, -ENODEV, "Unknown ID: 0x%x\n", val);
> +	/*
> +	 * Detect chip family from the ID register.  The ADS1299 EEG family
> +	 * is identified by bits [4:3] = 0b11;

This reflects the question above.  Is it? I'm seeing that in [3:2] from
Table 12: ID Control Register Field Descriptions

Now the guarantee that bit 3 for the ADS1298 etc is 0 and for the ADS1299 is 1.
(upper bit of actual Id location) + the bit 4 is reserved on the ADS1299 and 1
makes this work but not for any of the reasons stated.  To me detecting between
these two annoyingly inconsistent families is going to be fragile and rely
on those reserved bits. So either it needs to do as many sanity checks as possible
on each type, or (and I'd go this way) given up and use the firmware description
as a lead on where to look.  So add match data to the arrays and use a structure
in that with fields to identify which sub part each is.

> the ADS1298 ECG family uses
> +	 * bits [7:3] for family identification.
> +	 */
> +	if (FIELD_GET(ADS1299_MASK_ID_FAMILY, val) == ADS1299_ID_FAMILY_EEG) {
> +		/*
> +		 * ADS1299 family: channel count from bits [1:0].
> +		 * 00 -> 4ch, 01 -> 6ch, 10 -> 8ch.
> +		 */
> +		priv->is_ads1299 = true;
> +		indio_dev->num_channels =
> +			(FIELD_GET(ADS1299_MASK_ID_CHANNELS, val) + 2) * 2;
> +		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads1299%s",
> +			indio_dev->num_channels == 4 ? "-4" :
> +			indio_dev->num_channels == 6 ? "-6" : "");
> +	} else {
> +		/* ADS1298 family: channel count from bits [2:0], name from family */
> +		indio_dev->num_channels = 4 + 2 * (val & ADS1298_MASK_ID_CHANNELS);
> +		switch (val & ADS1298_MASK_ID_FAMILY) {
> +		case ADS1298_ID_FAMILY_ADS129X:
> +			suffix = "";
> +			break;
> +		case ADS1298_ID_FAMILY_ADS129XR:
> +			suffix = "r";
> +			break;
> +		default:
> +			return dev_err_probe(dev, -ENODEV,
> +					     "Unknown ID: 0x%x\n", val);

That's fine on one line.  We get a bit flexible on 90 chars for cases like this,
just don't go too long.

> +		}
> +		indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
> +						 indio_dev->num_channels, suffix);
>  	}
> -	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "ads129%u%s",
> -					 indio_dev->num_channels, suffix);
>  	if (!indio_dev->name)
>  		return -ENOMEM;
>  
> @@ -621,8 +663,9 @@ static int ads1298_init(struct iio_dev *indio_dev)
>  	if (!priv->reg_vref) {
>  		/* Enable internal reference */
>  		val |= ADS1298_MASK_CONFIG3_PWR_REFBUF;
> -		/* Use 4V VREF when power supply is at least 4.4V */
> -		if (regulator_get_voltage(priv->reg_avdd) >= 4400000)
> +		/* ADS1298 only: use 4V VREF when supply is at least 4.4V */
> +		if (!priv->is_ads1299 &&
> +		    regulator_get_voltage(priv->reg_avdd) >= 4400000)
>  			val |= ADS1298_MASK_CONFIG3_VREF_4V;
>  	}
>  	return regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
> @@ -739,12 +782,14 @@ static int ads1298_probe(struct spi_device *spi)
>  
>  static const struct spi_device_id ads1298_id[] = {
>  	{ "ads1298" },
> +	{ "ads1299" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ads1298_id);
>  
>  static const struct of_device_id ads1298_of_table[] = {
>  	{ .compatible = "ti,ads1298" },
> +	{ .compatible = "ti,ads1299" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ads1298_of_table);
> @@ -760,5 +805,6 @@ static struct spi_driver ads1298_driver = {
>  module_spi_driver(ads1298_driver);
>  
>  MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> -MODULE_DESCRIPTION("TI ADS1298 ADC");
> +MODULE_AUTHOR("Md Shofiqul Islam <shofiqtest@gmail.com>");

Hmm. Maybe Mike has a view on this, but I'd take that as a stretch
given the relatively small amount of code needed to add the new part.
The copyright is fine for reflecting that I think.

> +MODULE_DESCRIPTION("TI ADS1298/ADS1299 biopotential ADC");
>  MODULE_LICENSE("GPL");

