Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C33BED26;
	Wed, 20 May 2026 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296293; cv=none; b=NIPDbpThFT5FMJbMuwL+kkAVMhPgWVSZCp9pr5rTdl/MS+zBK4HWkIykfd2zwH9InLzE47d7fdhlTzsPXs67HWvWFEwBI1+L7PN5B8kA8iGbHWOW2d1Axu4wxEDl1ee6ptzBY3YJU9Bm4dm2ax6RLbshjzKKk57JGVpTJ+ZYlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296293; c=relaxed/simple;
	bh=g9oOxa3KAzDSgGlMuFDShyU6Cu07r5dNrVVqFXDHQm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dBcB7nnPnbzLXU4G1y0V1XnPWXcrt+EXIp41nNGFpXX2K4FM4GpRZlVi+UwMYY5TkTgBh8H8JvudTszg8hT8Ez7BBWqOezO/ArJy4Pjdc9iMFEUHeq4h43S1KmaJLdbxLlzO96HZ0pWvg0zbXGtCw+RoR7njgQGIpVyaje3bNU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2LljfgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2LljfgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97911F00893;
	Wed, 20 May 2026 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779296292;
	bh=Q+RGdBV1fAOjSGTl0MP2/NwsWkgq8a03gaD/eAA0qA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Q2LljfgR9q6D6w2BBozfsmTSjs40lP/A9aBt7eRofslSeK8zDJexEq2DM6d3ZmZG+
	 BipsDXqAfw/rgJaaodgLmV1kMbMAnnIf0yDqqSun2tQhlzjlFYMP+l8fM5IcnI4daT
	 XnZrXD56lT/9WCXkf1x+AsHVig/YwzKViUuPmrqjjYjTz6CrFTMoXSR/FdUnDzvyoE
	 ftR3fJTbIkvP4t3rsyBOD/W9MK5aazyGhHKAgA+UxzTTpQt9KnibapSQRSWYTrmLpJ
	 sE8BS0CFH1cM8ukvwUUmqhiR4BDAnAYEo/CbLhv2DPCLq/EVVq75ilokaDTql08fwm
	 CR9xlBtgUdFRw==
Date: Wed, 20 May 2026 17:58:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V8 04/10] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <20260520175801.12f74521@jic23-huawei>
In-Reply-To: <20260518200526.458421-5-macroalpha82@gmail.com>
References: <20260518200526.458421-1-macroalpha82@gmail.com>
	<20260518200526.458421-5-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 15:05:19 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add I2C and SPI driver support for InvenSense ICM-42607 devices.
> Add necessary Kconfig and Makefile to allow building of (incomplete)
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Hi Chris.

More trivial stuff. Some of which is just to save
having to do a follow up patch to move to named initializers
for the id tables.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 6c5e7d9b08b7..74d8d3d7c890 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -13,6 +13,16 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  
> +/* serial bus slew rates */
> +enum inv_icm42607_slew_rate {
> +	INV_ICM42607_SLEW_RATE_20_60NS,
> +	INV_ICM42607_SLEW_RATE_12_36NS,
> +	INV_ICM42607_SLEW_RATE_6_18NS,
> +	INV_ICM42607_SLEW_RATE_4_12NS,
> +	INV_ICM42607_SLEW_RATE_2_6NS,
> +	INV_ICM42607_SLEW_RATE_INF_2NS
Probably missing trailing comma. Mind you I'm confused
on what the meaning is of INF_2NS - so maybe a comment?

> +};
> +
>  enum inv_icm42607_sensor_mode {
>  	INV_ICM42607_SENSOR_MODE_OFF,
>  	INV_ICM42607_SENSOR_MODE_STANDBY,
> @@ -325,6 +335,8 @@ struct inv_icm42607_state {
>  typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
>  
>  extern const struct regmap_config inv_icm42607_regmap_config;
This is only introduced in this patch.  I'd argue maybe that
should have been in the earlier one?

> +extern const struct inv_icm42607_hw inv_icm42607_hw_data;
> +extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
I'd also have been tempted to push these into the previous patch
even though like the regmap they would have had no users briefly.

>  
>  int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
>  			    inv_icm42607_bus_setup bus_setup);
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index b270d48335ba..e9c81b52f9ef 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

>  static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
>  				 const struct inv_icm42607_conf *conf)
>  {
> @@ -95,6 +152,11 @@ static int inv_icm42607_setup(struct inv_icm42607_state *st,
>  		return dev_err_probe(dev, ret,
>  				     "reset error, reset done bit not set\n");
>  
> +	/* Sync the regcache again after a reset. */
> +	ret = regcache_sync(st->map);

Silly question but what has this to do with the bus support?  Should
it be in the previous patch.  I suppose you could argue this is where the
cache got introduced.  

> +	if (ret)
> +		return ret;
> +
>  	ret = bus_setup(st);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> new file mode 100644
> index 000000000000..8631579a609a
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> @@ -0,0 +1,89 @@

> +
> +static const struct i2c_device_id inv_icm42607_id[] = {
> +	{ "icm42607", (kernel_ulong_t)&inv_icm42607_hw_data },
> +	{ "icm42607p", (kernel_ulong_t)&inv_icm42607p_hw_data },
Named initializers please. (see below)
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
> +
> +static const struct of_device_id inv_icm42607_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42607",
> +		.data = &inv_icm42607_hw_data,
> +	}, {
> +		.compatible = "invensense,icm42607p",
> +		.data = &inv_icm42607p_hw_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
> +
> +static struct i2c_driver inv_icm42607_driver = {
> +	.driver = {
> +		.name = "inv-icm42607-i2c",
> +		.of_match_table = inv_icm42607_of_matches,
> +	},
> +	.id_table = inv_icm42607_id,
> +	.probe = inv_icm42607_probe,
> +};
> +module_i2c_driver(inv_icm42607_driver);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-42607x I2C driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_ICM42607");
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> new file mode 100644
> index 000000000000..960b5d3e9abc
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> @@ -0,0 +1,101 @@

> +static const struct of_device_id inv_icm42607_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42607",
> +		.data = &inv_icm42607_hw_data,
> +	},
> +	{
> +		.compatible = "invensense,icm42607p",
> +		.data = &inv_icm42607p_hw_data,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
> +
> +static const struct spi_device_id inv_icm42607_spi_id_table[] = {
> +	{ "icm42607", (kernel_ulong_t)&inv_icm42607_hw_data },
> +	{ "icm42607p", (kernel_ulong_t)&inv_icm42607p_hw_data },
Please use named initializers (see the work Uwe is doing currently to 
clean this up). It has always been odd that we do it for of_ but
not spi_device_id / i2c_device_id.

That work from Uwe crossed with the development of this series
but I'd rather avoid an immediate follow up patch if we can just
tidy it up from the start.  I'd definitely have fixed this whilst
applying if there was no other reason for a v9.


Jonathan


> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);
> +
> +static struct spi_driver inv_icm42607_driver = {
> +	.driver = {
> +		.name = "inv-icm42607-spi",
> +		.of_match_table = inv_icm42607_of_matches,
> +	},
> +	.id_table = inv_icm42607_spi_id_table,
> +	.probe = inv_icm42607_probe,
> +};
> +module_spi_driver(inv_icm42607_driver);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-42607x SPI driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_ICM42607");

