Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4374CF471;
	Fri, 16 Oct 2026 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195036; cv=none; b=APXZIlnrgCqGmp0xNWM4TqR1EBbJBbFDi6mzVTe/L8794m9gag8XHWRrMhjt63R+72qkEFHnFQfBOF9IZW7NIKtbbDXuRMIbStqPsTZ8In+zwP4xRnJhAnzPTD1zOL28A9Bj02diG+80B3o6m/bM1LUfAetWg3Ehg40rZoIoRs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195036; c=relaxed/simple;
	bh=1ieCLC7URCvyBrd1DA3JhtgOvvTZghMqmYS1oJzq29s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ElR9hpYYc0ziOwF6ciFvG8uWm5EYGGSV6OCUpun9vTdP5R9i4ieCt+KWYX1NUX0b/74O8WKQG+qasJQk10JfkCgmLnBZFD9JlEZnAhrRXpRDE7zcZ0nnXDjsGtc1R8E0jMfPKtPrcx9untk72+Rbu+PxXMjPSOoYDuSiZ90SSV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZncxkHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZncxkHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8653A1F000C4;
	Fri, 16 Oct 2026 23:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195035;
	bh=RyTiiSxvmDfn/osn8G/jibbVhsbBSmPAubOj1FNHER8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nZncxkHfoy/0ABpXAn27iZ60hfDRl0NESPicG1YiTdpksP7rqLBBWdwmfWVQc0suE
	 y332SqKSiNQ+0PnRCMuAICJgh2My2iQ1GmYZguFrqIgAYrYsNtZmBbtBlxbbbsDDKJ
	 tmXxQv3DVZx9xmGuQgha7aOZX3c3a7rG4af6xZAhY/+yAQQH+NOtjdo3eGRHcLBd2t
	 ujIZ2f/kHN1+Vwc2c0RbJ++VAzrh8Hr8Dv7zHwB2IcDcI6X18HxXW8SlpbL035q0UH
	 HiPeZJ2CjGiryx7cIgzA1D0rmJX+jkOz/r3kzW4T2yHz8LnBfjIqc4gZynoYUxRk65
	 rUFJsB+iTe9ZA==
Date: Sat, 17 Oct 2026 00:57:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: linux-iio@vger.kernel.org, Eddie James <eajames@linux.ibm.com>, Joel
 Stanley <joel@jms.id.au>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUs=?=
 =?UTF-8?B?w7ZuaWc=?= <u.kleine-koenig@baylibre.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rupesh
 Majhi <zoone.rupert@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: pressure: dps310: add per-chip data
Message-ID: <20261017005709.1bf16c34@jic23-hlaptop>
In-Reply-To: <20261016153533.3701000-4-paulius.zaleckas@gmail.com>
References: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
	<20261016153533.3701000-4-paulius.zaleckas@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 18:35:31 +0300
Paulius Zaleckas <paulius.zaleckas@gmail.com> wrote:

> Move the coefficient count, the TMP_CFG startup value and the IIO device
> name into a per-chip structure, passed through the I2C and ACPI match
> data. This prepares for the Zilltek ZTS8032, which has two more
> coefficients and a different TMP_CFG layout.
> 
> No functional change.
> 
> Assisted-by: LLM
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
A few little things in line.

Sorry I'm late to the game - too much travel and catch up recently!

Jonathan

> ---
>  drivers/iio/pressure/dps310.c | 36 +++++++++++++++++++++++++++--------
>  1 file changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 1d0b3232db9e..f2a8698e1e30 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -62,6 +62,9 @@
>  #define DPS310_RESET		0x0c
>  #define  DPS310_RESET_MAGIC	0x09
>  #define DPS310_COEF_BASE	0x10
> +#define DPS310_COEF_LEN		18
> +
> +#define MAX_COEF_LEN		18
>  
>  /* Make sure sleep time is <= 30ms for usleep_range */
>  #define DPS310_POLL_SLEEP_US(t)		min(30000, (t) / 8)
> @@ -86,10 +89,23 @@ static const int scale_factors[] = {
>  	2088960,
>  };
>  
> +struct dps310_chip_info {
> +	const char *name;
> +	u8 tmp_cfg;	/* TMP_CFG at startup: sensor the coefficients are for */

I had to look at the datasheet for the dps310 to figure out what this
meant.  Can we instead use a field for exactly what it is within TMP_CFG?

	bool coef_for_ext_sensor;


> +	u8 coef_len;
> +};
> +
> +static const struct dps310_chip_info dps310_chip_info = {
> +	.name = "dps310",
> +	.tmp_cfg = DPS310_TMP_EXT,
> +	.coef_len = DPS310_COEF_LEN,
> +};
> +
>  struct dps310_data {
>  	struct i2c_client *client;
>  	struct regmap *regmap;
>  	struct mutex lock;	/* Lock for sequential HW access functions */
> +	const struct dps310_chip_info *info;
>  
>  	s32 c0, c1;
>  	s32 c00, c10, c20, c30, c01, c11, c21;
> @@ -149,13 +165,13 @@ static const struct iio_chan_spec dps310_channels[] = {
>  static int dps310_get_coefs(struct dps310_data *data)
>  {
>  	int rc;
> -	u8 coef[18];
> +	u8 coef[MAX_COEF_LEN];
>  	u32 c0, c1;
>  	u32 c00, c10, c20, c30, c01, c11, c21;
>  
>  	/* Read all sensor calibration coefficients from the COEF registers. */
>  	rc = regmap_bulk_read(data->regmap, DPS310_COEF_BASE, coef,
> -			      sizeof(coef));
> +			      data->info->coef_len);
>  	if (rc < 0)
>  		return rc;
>  
> @@ -252,10 +268,10 @@ static int dps310_startup(struct dps310_data *data)
>  		return rc;
>  
>  	/*
> -	 * Set up external (MEMS) temperature sensor in single sample, one
> -	 * measurement per second mode
> +	 * Set up the temperature sensor the coefficients are for in single
> +	 * sample, one measurement per second mode
>  	 */
> -	rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
> +	rc = regmap_write(data->regmap, DPS310_TMP_CFG, data->info->tmp_cfg);
With change above this would then ideally use appropriate FIELD_PREP()
calls to write 3 fields such that we don't need the comment at all. Something
like
	rc = regmap_write(data->regmap, DPS310_TMP_CFG,
			  FIELD_PREP(DPS310_TMP_PRC_BITS, DPS310_TMP_PRC_1) |
			  FIELD_PREP(DPS310_TMP_RATE_BITS, DPS310_TMP_RATE_1SPS) |
 			  FIELD_PREP(DPS310_TMP_EXT,
				     data->info->coef_for_ext_sensor ? 1 : 0));
(with a few defines to make that work).
BTW I love that the PRC values are defined as 'optional, and may not be relevant'.
Huh? What does that mean. I guess - don't use them!

>  	if (rc)
>  		return rc;
>  
> @@ -979,7 +995,11 @@ static int dps310_probe(struct i2c_client *client)
>  	data->client = client;
>  	mutex_init(&data->lock);
>  
> -	iio->name = DPS310_DEV_NAME;
> +	data->info = i2c_get_match_data(client);
> +	if (!data->info)
> +		return -ENODATA;
> +
> +	iio->name = data->info->name;
>  	iio->channels = dps310_channels;
>  	iio->num_channels = ARRAY_SIZE(dps310_channels);
>  	iio->info = &dps310_info;
> @@ -1018,13 +1038,13 @@ static int dps310_probe(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id dps310_id[] = {
> -	{ .name = DPS310_DEV_NAME },
> +	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(i2c, dps310_id);
>  
>  static const struct acpi_device_id dps310_acpi_match[] = {
> -	{ "IFX3100" },
> +	{ .id = "IFX3100", .driver_data = (kernel_ulong_t)&dps310_chip_info },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, dps310_acpi_match);

