Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:43074 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbeHSOXR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Aug 2018 10:23:17 -0400
Date: Sun, 19 Aug 2018 12:12:08 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Jiecheng Wu <jasonwood2031@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] hmc5843_i2c.c: fix missing return value check of
 devm_regmap_init_i2c()
Message-ID: <20180819121208.19951cde@archlinux>
In-Reply-To: <20180819021641.3068-1-jasonwood2031@gmail.com>
References: <20180819021641.3068-1-jasonwood2031@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 19 Aug 2018 10:16:41 +0800
Jiecheng Wu <jasonwood2031@gmail.com> wrote:

> Function hmc5843_i2c_probe() defined in
>  drivers/iio/magnetometer/hmc5843_i2c.c calls devm_regmap_init_i2c()
>  to initialise managed register map. As the return value of
>  devm_regmap_init_i2c() will be an ERR_PTR() on error, the return
>  value must be checked against NULL.

This text isn't accurate.  Checking IS_ERR is definitely not checking
against NULL.

+ the issue with missing signoff etc that has already been raised.

Jonathan

> ---
>  drivers/iio/magnetometer/hmc5843_i2c.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_i2c.c b/drivers/iio/magnetometer/hmc5843_i2c.c
> index 3de7f44..4911cf8 100644
> --- a/drivers/iio/magnetometer/hmc5843_i2c.c
> +++ b/drivers/iio/magnetometer/hmc5843_i2c.c
> @@ -14,6 +14,7 @@
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/device.h>
>  
>  #include "hmc5843.h"
>  
> @@ -58,8 +59,13 @@ static const struct regmap_config hmc5843_i2c_regmap_config = {
>  static int hmc5843_i2c_probe(struct i2c_client *cli,
>  			     const struct i2c_device_id *id)
>  {
> -	return hmc5843_common_probe(&cli->dev,
> -			devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config),
> +	struct regmap *regmap;
> +	regmap = devm_regmap_init_i2c(cli, &hmc5843_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&cli->dev, "Failed to initialize i2c regmap\n");
> +		return PTR_ERR(regmap);
> +	}
> +	return hmc5843_common_probe(&cli->dev, regmap,
>  			id->driver_data, id->name);
>  }
>  
