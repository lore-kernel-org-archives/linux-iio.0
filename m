Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5498E23A984;
	Thu, 29 Jan 2026 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769710792; cv=none; b=DRSpGyAPmeGOvbkOKf5JK8LjxDVNTK/yh6P2B4oevSY560ReBYqEX4fvFMjX6UH/THS8+dVYq71BSacF+jKHoSZkL8+cEg2HkHWk7CSHNE4gil40d16KajLrEKHbBoFhqUiG+wJ4ltS+HSbxV0FuwVgfwhB3d5rw2i/yRaEIonk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769710792; c=relaxed/simple;
	bh=og90nOX/+6jWXCTeB4CAJLzIXd1dsAZvRA+nFx2XInc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKiLC0aMdSfvMyhYTxnCydxn1dVHNU/VVhmeQUwLm8MPMBakoh2rl9hGVw6gv1gTDGv4riLit9DIcuBtqgokMxUcog6RvS+bXMi1ezKy1IG7KKkWpKuWbHqbtpTANXrpg6czVYB/Po7IuJvLZWFdn/P6/TAT35FMQq3bBvPxguI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC89fFDm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC89fFDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECC2C4CEF7;
	Thu, 29 Jan 2026 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769710791;
	bh=og90nOX/+6jWXCTeB4CAJLzIXd1dsAZvRA+nFx2XInc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FC89fFDmUOLbxVrWJudzUoL6CGgbCKmvNg00z19QqRTJ6dG6N+BbbZsqlDC39FObm
	 O9h3580qG0pc87JrmkFA+dIDUDA0vCDi6nIe0i2UCGP12V2zwpr7GSZWJBguXePct/
	 Kee1DE5Gx61Qiyqn093X1OoW3cH+cQ1UViVtmG2+8Qs6AqPvrepcMjq6UFRUDf1miZ
	 idCO22w3iEAzmhnYW/rKiMxeZkOqx23v8aIwnyS7I0tHY8Sgdu/VKDjNQFQlA3eoGs
	 AXce/TLAp/uxzar7qxEnOg8IkdMdY9lXhCGq4pr+6JGiLAYBXZRuPiOYqtOLF1O6Jr
	 3W6RueUIVjFPg==
Date: Thu, 29 Jan 2026 18:19:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Jander <david@protonic.nl>
Subject: Re: [PATCH v3 8/8] iio: dac: ds4424: add Rfs-based scale and
 per-variant limits
Message-ID: <20260129181942.1bf0ae28@jic23-huawei>
In-Reply-To: <20260128153824.3679187-9-o.rempel@pengutronix.de>
References: <20260128153824.3679187-1-o.rempel@pengutronix.de>
	<20260128153824.3679187-9-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Jan 2026 16:38:24 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Parse optional maxim,rfs-ohms values to derive the per-channel output
> current scale (mA per step) for the IIO current ABI.
> 
> Select per-variant parameters to match the shared register map while
> handling different data widths and full-scale current calculations.
> 
> Behavior changes:
> - If maxim,rfs-ohms is present, IIO_CHAN_INFO_SCALE becomes available
>   and reports mA/step derived from Rfs.
> - If maxim,rfs-ohms is missing, SCALE is not exposed to keep older DTs
>   working without requiring updates.
> - RAW writes are now limited to the representable sign-magnitude range
>   of the detected variant to avoid silent truncation (e.g. +/-31 on
>   DS440x).

This seems to be doing several things.
Split it into a patch introducing the structure for per channel information
and then one adding the maxim,rfs-ohms support.

Various more specific suggestions inline.

Thanks,

Jonathan

> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v3:
> - Added explicit check for negative return from device_property_count_u32().
> - Rename vref_mv to vref_mV
> - Use devm_kmemdup_array() instead of devm_kmemdup()
> - Use %u for unsigned index in Rfs error logs.
> - Consolidated Rfs parse logs to a single line.
> changes v2:
> - Reorder struct ds4424_chip_info members to optimize padding.
> - Use GENMASK() for chip variant masks instead of hex constants.
> - Simplify ds4424_setup_channels: use direct devm_kmemdup to avoid stack
>   usage and memcpy.
> - Use local 'dev' pointer and dev_err_probe() in ds4424_parse_rfs for
>   cleaner error handling.
> - Rename the static iio_info struct to ds4424_iio_info to prevent name
>   collision with the new hardware chip_info structs.
> - Use unsigned int for loop counters.
> - Rebase on top of regmap and symmetrical raw_access refactoring.
> ---
>  drivers/iio/dac/ds4424.c | 121 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 116 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index 9bef1c60b2eb..2b01e20daee4 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -12,6 +12,7 @@
>  #include <linux/i2c.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> @@ -24,6 +25,7 @@
>  #define DS4424_MAX_DAC_CHANNELS		4
>  
>  #define DS4424_DAC_MASK			GENMASK(6, 0)
> +#define DS4404_DAC_MASK			GENMASK(4, 0)
>  #define DS4424_DAC_SOURCE		BIT(7)
>  
>  #define DS4424_DAC_ADDR(chan)   ((chan) + 0xf8)
> @@ -43,9 +45,38 @@ enum ds4424_device_ids {
>  	ID_DS4424,
>  };
>  
> +/*
> + * Two variant groups share the same register map but differ in:
> + * - resolution/data mask (DS4402/DS4404: 5-bit, DS4422/DS4424: 7-bit)
> + * - full-scale current calculation (different Vref and divider)
> + * Addressing also differs (DS440x tri-level, DS442x bi-level), but is
> + * handled via board configuration, not driver logic.
> + */
> +struct ds4424_chip_info {
As mentioned below. This being introduced should occur
without anything related to the rfs. I'd also like the enum to go away
in favour of using these structures directly as the per device type data
in the i2c_device_id tables and the dt ones.
Note there is a nice helper that tries to get that data first from DT
and then falls back to the i2c_device_id table if it fails
i2c_get_match_data().

> +	int vref_mV;
> +	int scale_denom;
> +	u8 result_mask;
> +};
> +
> +static const struct ds4424_chip_info ds4424_info = {
> +	.vref_mV = 976,
> +	.scale_denom = 16,
> +	.result_mask = DS4424_DAC_MASK,
> +};
> +
> +/* DS4402 is handled like DS4404 (same resolution and scale formula). */
> +static const struct ds4424_chip_info ds4404_info = {
> +	.vref_mV = 1230,
> +	.scale_denom = 4,
> +	.result_mask = DS4404_DAC_MASK,
> +};
> +
>  struct ds4424_data {
>  	struct regmap *regmap;
>  	struct regulator *vcc_reg;
> +	const struct ds4424_chip_info *chip_info;
> +	u32 rfs_ohms[DS4424_MAX_DAC_CHANNELS];
> +	bool has_rfs;
>  };
>  
>  static const struct iio_chan_spec ds4424_channels[] = {
> @@ -144,11 +175,20 @@ static int ds4424_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		}
>  
> -		*val = regval & DS4424_DAC_MASK;
> +		*val = regval & data->chip_info->result_mask;
>  		if (!(regval & DS4424_DAC_SOURCE))
>  			*val = -*val;
>  
>  		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (!data->has_rfs)
> +			return -EINVAL;
> +
> +		/* SCALE is mA/step: mV / Ohm = mA. */
> +		*val = data->chip_info->vref_mV;
> +		*val2 = data->rfs_ohms[chan->channel] *
> +			data->chip_info->scale_denom;
> +		return IIO_VAL_FRACTIONAL;
>  
>  	default:
>  		return -EINVAL;
> @@ -168,7 +208,7 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		abs_val = abs(val);
> -		if (abs_val > DS4424_DAC_MASK)
> +		if (abs_val > data->chip_info->result_mask)
This confused me as nothing to do with the rfs.
So this should be multiple patches.

>  			return -EINVAL;
>  
>  		/*
> @@ -187,6 +227,65 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static int ds4424_setup_channels(struct i2c_client *client,
> +				 struct ds4424_data *data,
> +				 struct iio_dev *indio_dev)
> +{
> +	struct iio_chan_spec *channels;
> +
> +	/* Use a local non-const pointer for modification */
> +	channels = devm_kmemdup_array(&client->dev, ds4424_channels,
> +				      indio_dev->num_channels,
> +				      sizeof(ds4424_channels[0]), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	if (data->has_rfs) {
> +		for (unsigned int i = 0; i < indio_dev->num_channels; i++)
> +			channels[i].info_mask_separate |=
> +				BIT(IIO_CHAN_INFO_SCALE);

There are only two options.  Just have 2 static const iio_chan_spec []
and pick between them.  One has the scale and the other doesn't.

Dynamic channel specification creation is fine if there are lots
of variants, but not worth the effort for 2.

> +	}
> +
> +	indio_dev->channels = channels;
> +
> +	return 0;
> +}
> +
> +static int ds4424_parse_rfs(struct i2c_client *client,
> +			    struct ds4424_data *data,
> +			    struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &client->dev;
> +	int count, ret;
> +
> +	if (!device_property_present(dev, "maxim,rfs-ohms")) {
> +		dev_info_once(dev, "maxim,rfs-ohms missing, scale not supported\n");

Absences of the _scale sysfs file should be enough for that rather than filling up
the kernel log. dev_dbg() only.

> +		return 0;
> +	}
> +
> +	count = device_property_count_u32(dev, "maxim,rfs-ohms");
> +	if (count < 0)
> +		return dev_err_probe(dev, count, "Failed to count maxim,rfs-ohms entries\n");
> +	if (count != indio_dev->num_channels)
> +		return dev_err_probe(dev, -EINVAL, "maxim,rfs-ohms must have %u entries\n",
> +				     indio_dev->num_channels);
> +
> +	ret = device_property_read_u32_array(dev, "maxim,rfs-ohms",
> +					     data->rfs_ohms,
> +					     indio_dev->num_channels);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read maxim,rfs-ohms property\n");
> +
> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> +		if (!data->rfs_ohms[i])
> +			return dev_err_probe(dev, -EINVAL, "maxim,rfs-ohms entry %u is zero\n", i);
> +	}
> +
> +	data->has_rfs = true;
> +
> +	return 0;
> +}

> @@ -258,15 +357,20 @@ static int ds4424_probe(struct i2c_client *client)
>  	switch (id->driver_data) {
>  	case ID_DS4402:
>  		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
> +		/* See ds4404_info comment above. */
> +		data->chip_info = &ds4404_info;

I'd strongly prefer to see the driver_data become a pointer to this structure
(and have it it for all firmware types rather than relying on matching
 across them which sometimes goes wrong).

That would need to be a precursor patch but would end up simplifying
things because you'd just put num_channels in there as well and no
switch statement would be on these enum values (get rid of that enum)

>  		break;
>  	case ID_DS4404:
>  		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
> +		data->chip_info = &ds4404_info;
>  		break;
>  	case ID_DS4422:
>  		indio_dev->num_channels = DS4422_MAX_DAC_CHANNELS;
> +		data->chip_info = &ds4424_info;
>  		break;
>  	case ID_DS4424:
>  		indio_dev->num_channels = DS4424_MAX_DAC_CHANNELS;
> +		data->chip_info = &ds4424_info;
>  		break;
>  	default:
>  		dev_err(&client->dev,
> @@ -279,9 +383,16 @@ static int ds4424_probe(struct i2c_client *client)
>  	if (ret)
>  		goto fail;
>  
> -	indio_dev->channels = ds4424_channels;
> +	ret = ds4424_parse_rfs(client, data, indio_dev);
> +	if (ret)
> +		goto fail;
> +
> +	ret = ds4424_setup_channels(client, data, indio_dev);
> +	if (ret)
> +		goto fail;
> +
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->info = &ds4424_info;
> +	indio_dev->info = &ds4424_iio_info;
I'd be tempted to do the rename as at trivial precursor patch
that just says you need the namespace for the use made in this patch.

Otherwise the code becomes a bit fiddly to read in here as meaning
changes between removed and added code.

Jonathan
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0) {

