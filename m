Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683BE571;
	Sun, 14 Jun 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781450356; cv=none; b=PAw8liwAAhnSE8jcmMU02hRHB4vAQL2j2U0YG4DTyRgvP4D1jiI1Ux36Ha1TJaUizz1gOSv2dbEWkNuKIO6lO8WXQSXXUz40Ix6Aq13y3uO2uxhfv3RKuskAZcwkLxxZYW+fzR/tEhM8X4rnQGHtRzRCyWPD+ZuFiamBDaTZjRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781450356; c=relaxed/simple;
	bh=iytFsEXT0Oopasvbxcsp2kKYEGQQBdp/jkSNFz+J6ec=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjIqiLpP8LstTu4v/UPh7yl/DWad1adPAvg4MQQiAq84eCY+kyVQEFhgnrTx4nm2NLVsSGozYUZo9RSxyuGMxMr6RuLR5WdyaBMciBb4x40kBK03PTUIm+QGjDP7A47ACLDtZVZIu8zCYkZZjIsFO7hiL+mHPMAVlcbzdyuqRes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCf7lQBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCf7lQBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2C11F000E9;
	Sun, 14 Jun 2026 15:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781450355;
	bh=kZnIxw+CePR7ETE6li5GKd6uvpjg9eq3LoiBMDJYSNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TCf7lQBWvkI2kolTexjQ1dAoFYtjimSbc5P8Rlk+GVxlS1KlfAFw64Jyd8wkqYs4U
	 Oid6Vne9a4Zbid8saBfDvV0KItMRUVnJGtsTV09UQE7hOaiDqV95Dk6klVknNva1XW
	 /P/1Vu6nmaxTi6ImG03Ai839uqcfMreCaoxhb1HwlrSa4IBZVtdK8atzVusa3d6doR
	 xYdvFmvky2irFoogVvaBrvbIOtH0tvimsdVNwZcduuXO7S5LnefUHRcIMoOttx8OUn
	 pJs1iVM+utykZMW01mRN09BBt9GikwN3KGm2IGHt7lQmrgHWWwHB0lDzhMvEP3BvyP
	 fnkEtX04MKDDA==
Date: Sun, 14 Jun 2026 16:19:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Wadim Mueller <wafgo01@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Maxwell Doose <m32285159@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: Re: [PATCH v4 4/4] iio: flow: add Sensirion SLF3S liquid flow
 sensor driver
Message-ID: <20260614161906.5bb3251d@jic23-huawei>
In-Reply-To: <20260611132700.671322-5-wafgo01@gmail.com>
References: <20260611132700.671322-1-wafgo01@gmail.com>
	<20260611132700.671322-5-wafgo01@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 15:27:00 +0200
Wadim Mueller <wafgo01@gmail.com> wrote:

> Add a driver for the Sensirion SLF3S family of digital
> liquid-flow sensors on I2C.  Currently supported variants are
> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B; they share the same
> register map and differ only in flow-scale factor and calibrated
> measurement range.  The variant (and therefore the scale) is
> auto-detected from the product-information register at probe time;
> a sensor reporting an unknown sub-type falls back to the variant
> named in the device tree, as promised by the fallback compatible.
> 
> Each measurement frame returns a 16-bit signed flow value, a
> 16-bit signed temperature reading and a status word, each
> protected by a CRC-8 byte.  The driver exposes the flow rate as
> IIO_VOLUMEFLOW and the temperature as IIO_TEMP via the standard
> IIO read_raw / read_scale interface.
> 
> The volume-flow scale is reported in m^3/s.  As the per-LSB scale
> is on the order of 1e-12 m^3/s, it is emitted as a 64-bit
> fixed-point value with femto (1e-15) resolution
> (IIO_VAL_DECIMAL64_FEMTO) so the small SI value keeps full
> precision.  This relies on the IIO_VAL_DECIMAL64_FEMTO format type
> added earlier in this series, which extends the IIO_VAL_DECIMAL64
> core formatting introduced by Rodrigo Alencar's ADF41513 series.
> 
> The active calibration medium can be switched at runtime between
> the factory-calibrated water and isopropyl-alcohol modes via the
> in_volumeflow_medium sysfs attribute; the sensor starts in water
> mode after probe.
> 
> The sensor has no low-power state of its own, so system suspend
> stops the measurement and disables the vdd supply; resume powers
> the sensor back up, waits out the power-up time and restarts the
> measurement with the previously active medium, following the
> scd30/scd4x precedent.
> 
> This driver also creates the drivers/iio/flow/ subdirectory and
> the corresponding Kconfig/Makefile glue.
> 
> Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
A few minor things inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/flow/slf3s.c b/drivers/iio/flow/slf3s.c
> new file mode 100644
> index 000000000..ed7b89e8e
> --- /dev/null
> +++ b/drivers/iio/flow/slf3s.c
> @@ -0,0 +1,521 @@

> +/**
> + * struct slf3s_data - per-device state
> + * @client:	I2C client this instance is bound to
> + * @vdd:	supply regulator, disabled while suspended
> + * @variant:	pointer into @slf3s_variants for the detected device
> + * @medium:	currently active calibration medium
> + * @lock:	serialises the multi-step command/response exchanges
> + * @crc_table:	pre-computed CRC-8 lookup table for SLF3S_CRC8_POLY
> + */
> +struct slf3s_data {
> +	struct i2c_client *client;
> +	struct regulator *vdd;
> +	const struct slf3s_variant *variant;
> +	enum slf3s_medium medium;
> +	struct mutex lock; /* serialises command/response exchanges */

Feel free to ignore checkpatch moaning about lack of comment.
There is a perfectly good one above, duplicating that info here is
pointless!

> +	u8 crc_table[CRC8_TABLE_SIZE];
> +};

> +
> +/*
> + * Read the product-info block and pick the matching variant.  The
> + * sub-type byte returned by the sensor is the source of truth; a
> + * DT-supplied compatible only seeds an initial guess and is overridden
> + * on mismatch (with an informational message so misconfigured device
> + * trees are easy to spot).
> + *
> + * Bus / CRC failures are real errors and fail probe.  An unknown
> + * sub-type byte falls back to the variant named in the device tree /
> + * I2C table: the fallback compatible promises that future family
> + * members work as an SLF3S-1300F, so do not reject them.  Without any
> + * match data probe fails since no meaningful scale can be published.
> + */
> +static int slf3s_detect_variant(struct slf3s_data *sf)
> +{
> +	struct i2c_client *client = sf->client;
> +	u8 buf[SLF3S_PRODUCT_ID_LEN];
> +	int ret;
> +
> +	ret = slf3s_send_cmd(client, slf3s_cmd_prep_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = slf3s_send_cmd(client, slf3s_cmd_read_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_master_recv(client, buf, sizeof(buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(buf))
> +		return -EIO;
> +
> +	for (unsigned int i = 0; i < SLF3S_PRODUCT_ID_LEN; i += 3) {
> +		if (!slf3s_crc_valid(sf, &buf[i]))
> +			return -EIO;
> +	}
> +
> +	if (buf[SLF3S_PRODUCT_FAMILY_BYTE] != SLF3S_PRODUCT_FAMILY_ID)
> +		dev_info(&client->dev,
> +			 "unexpected family byte 0x%02x (expected 0x%02x)\n",
> +			 buf[SLF3S_PRODUCT_FAMILY_BYTE],
> +			 SLF3S_PRODUCT_FAMILY_ID);
> +
> +	for (unsigned int i = 0; i < ARRAY_SIZE(slf3s_variants); i++) {
> +		if (buf[SLF3S_PRODUCT_SUBTYPE_BYTE] !=
> +		    slf3s_variants[i].sub_type)
> +			continue;
> +
> +		if (sf->variant && sf->variant != &slf3s_variants[i])
> +			dev_info(&client->dev,
> +				 "DT compatible says %s but sensor reports %s; using %s\n",
> +				 sf->variant->name,
> +				 slf3s_variants[i].name,
> +				 slf3s_variants[i].name);

Two params are the same which seems unlikely to be the intent. 

> +
> +		sf->variant = &slf3s_variants[i];
> +
> +		return 0;
> +	}
> +
> +	if (sf->variant) {
> +		dev_warn(&client->dev,
> +			 "unknown SLF3S sub-type 0x%02x, assuming %s\n",
> +			 buf[SLF3S_PRODUCT_SUBTYPE_BYTE], sf->variant->name);
> +		return 0;
> +	}
> +
> +	dev_err(&client->dev, "unknown SLF3S sub-type 0x%02x\n",
> +		buf[SLF3S_PRODUCT_SUBTYPE_BYTE]);
> +
> +	return -ENODEV;
> +}



> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(slf3s_pm_ops, slf3s_suspend, slf3s_resume);
> +
> +static const struct i2c_device_id slf3s_id[] = {
> +	{ .name = "slf3s-0600f",
> +	  .driver_data = (kernel_ulong_t)&slf3s_variants[0] },
> +	{ .name = "slf3s-1300f",
> +	  .driver_data = (kernel_ulong_t)&slf3s_variants[1] },
> +	{ .name = "slf3s-4000b",
> +	  .driver_data = (kernel_ulong_t)&slf3s_variants[2] },
Format as:
	{
		.name = "slf3s-4000b",
		.driver_data = (kernel_ulong_t)&slf3s_variants[ENUM_VAL],
	}, 
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, slf3s_id);
