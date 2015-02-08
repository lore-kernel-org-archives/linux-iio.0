Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39118 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbbBHLwq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Feb 2015 06:52:46 -0500
Message-ID: <54D74E06.2030302@kernel.org>
Date: Sun, 08 Feb 2015 11:52:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tolga Ceylan <tolga.ceylan@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Josef Gajdusek <atx@atalax.net>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Staging: iio: Coding Style Correction
References: <1423382693-4189-1-git-send-email-tolga.ceylan@gmail.com>
In-Reply-To: <1423382693-4189-1-git-send-email-tolga.ceylan@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/02/15 08:04, Tolga Ceylan wrote:
> Indentation corrections in struct initializations and
> one line over 80 characters split into two lines
> 
> Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
Whilst I find it hard to be inspired by these sort of patches,
you have presented the patch well and it's entirely sensible.
Only slight niggle that I've fixed is your patch title doesn't mention
the driver in question (and hence is identical to the other patch you
submitted at a quick glance).

Anyhow, applied to the togreg branch of iio.git which will get
pushed out as testing sometime soonish - perhaps controlled by when
my plane actually shows up today....
> ---
>  drivers/staging/iio/magnetometer/hmc5843_i2c.c | 34 +++++++++++++-------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843_i2c.c b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> index 6acd614..e221a58 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843_i2c.c
> @@ -19,49 +19,49 @@
>  #include "hmc5843.h"
>  
>  static const struct regmap_range hmc5843_readable_ranges[] = {
> -		regmap_reg_range(0, HMC5843_ID_END),
> +	regmap_reg_range(0, HMC5843_ID_END),
>  };
>  
>  static struct regmap_access_table hmc5843_readable_table = {
> -		.yes_ranges = hmc5843_readable_ranges,
> -		.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
> +	.yes_ranges = hmc5843_readable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(hmc5843_readable_ranges),
>  };
>  
>  static const struct regmap_range hmc5843_writable_ranges[] = {
> -		regmap_reg_range(0, HMC5843_MODE_REG),
> +	regmap_reg_range(0, HMC5843_MODE_REG),
>  };
>  
>  static struct regmap_access_table hmc5843_writable_table = {
> -		.yes_ranges = hmc5843_writable_ranges,
> -		.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
> +	.yes_ranges = hmc5843_writable_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(hmc5843_writable_ranges),
>  };
>  
>  static const struct regmap_range hmc5843_volatile_ranges[] = {
> -		regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
> +	regmap_reg_range(HMC5843_DATA_OUT_MSB_REGS, HMC5843_STATUS_REG),
>  };
>  
>  static struct regmap_access_table hmc5843_volatile_table = {
> -		.yes_ranges = hmc5843_volatile_ranges,
> -		.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
> +	.yes_ranges = hmc5843_volatile_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(hmc5843_volatile_ranges),
>  };
>  
>  static struct regmap_config hmc5843_i2c_regmap_config = {
> -		.reg_bits = 8,
> -		.val_bits = 8,
> +	.reg_bits = 8,
> +	.val_bits = 8,
>  
> -		.rd_table = &hmc5843_readable_table,
> -		.wr_table = &hmc5843_writable_table,
> -		.volatile_table = &hmc5843_volatile_table,
> +	.rd_table = &hmc5843_readable_table,
> +	.wr_table = &hmc5843_writable_table,
> +	.volatile_table = &hmc5843_volatile_table,
>  
> -		.cache_type = REGCACHE_RBTREE,
> +	.cache_type = REGCACHE_RBTREE,
>  };
>  
>  static int hmc5843_i2c_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	return hmc5843_common_probe(&client->dev,
> -			devm_regmap_init_i2c(client, &hmc5843_i2c_regmap_config),
> -			id->driver_data);
> +		devm_regmap_init_i2c(client, &hmc5843_i2c_regmap_config),
> +		id->driver_data);
>  }
>  
>  static int hmc5843_i2c_remove(struct i2c_client *client)
> 

