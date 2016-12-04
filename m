Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42812 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938198AbdAHJne (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:43:34 -0500
Subject: Re: [PATCH 03/19] staging: iio: isl29028: remove chip test and
 defaults from isl29028_chip_init()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-4-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <93242211-c8cd-4369-c262-03ef0ca85d3e@kernel.org>
Date: Sun, 4 Dec 2016 11:23:44 +0000
MIME-Version: 1.0
In-Reply-To: <1480817983-32359-4-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/16 02:19, Brian Masney wrote:
> isl29028_chip_init() contains the device driver defaults and
> two I2C calls that detect the presence of the chip. This patch
> moves these into isl29028_probe() so that this function can
> be used by the power management runtinme in a followup patch. This
> patch also renames isl29028_chip_init() to
> isl29028_chip_init_and_power_on().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
I've skipped patch 2 for now but will carry on applying until they stop going in
cleanly.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29028.c | 42 +++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index c8e234d..4f819a8 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -416,29 +416,11 @@ static const struct iio_info isl29028_info = {
>  	.write_raw = isl29028_write_raw,
>  };
>  
> -static int isl29028_chip_init(struct isl29028_chip *chip)
> +static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
>  {
>  	struct device *dev = regmap_get_device(chip->regmap);
>  	int ret;
>  
> -	chip->enable_prox  = false;
> -	chip->prox_sampling = 20;
> -	chip->lux_scale = 2000;
> -	chip->als_ir_mode = ISL29028_MODE_NONE;
> -
> -	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
> -	if (ret < 0) {
> -		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
> -			__func__, ISL29028_REG_TEST1_MODE, ret);
> -		return ret;
> -	}
> -	ret = regmap_write(chip->regmap, ISL29028_REG_TEST2_MODE, 0x0);
> -	if (ret < 0) {
> -		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
> -			__func__, ISL29028_REG_TEST2_MODE, ret);
> -		return ret;
> -	}
> -
>  	ret = regmap_write(chip->regmap, ISL29028_REG_CONFIGURE, 0x0);
>  	if (ret < 0) {
>  		dev_err(dev, "%s(): write to reg %d failed, err = %d\n",
> @@ -506,7 +488,27 @@ static int isl29028_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ret = isl29028_chip_init(chip);
> +	chip->enable_prox  = false;
> +	chip->prox_sampling = 20;
> +	chip->lux_scale = 2000;
> +	chip->als_ir_mode = ISL29028_MODE_NONE;
> +
> +	ret = regmap_write(chip->regmap, ISL29028_REG_TEST1_MODE, 0x0);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"%s(): write to reg %d failed, err = %d\n", __func__,
> +			ISL29028_REG_TEST1_MODE, ret);
> +		return ret;
> +	}
> +	ret = regmap_write(chip->regmap, ISL29028_REG_TEST2_MODE, 0x0);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"%s(): write to reg %d failed, err = %d\n", __func__,
> +			ISL29028_REG_TEST2_MODE, ret);
> +		return ret;
> +	}
> +
> +	ret = isl29028_chip_init_and_power_on(chip);
>  	if (ret < 0) {
>  		dev_err(&client->dev, "chip initialization failed: %d\n", ret);
>  		return ret;
> 

