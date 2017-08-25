Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:56046 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751453AbdHYFwY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2017 01:52:24 -0400
Date: Fri, 25 Aug 2017 07:52:56 +0200
From: Andreas Klinger <ak@it-klinger.de>
To: Colin Parker <colin.foeparker@aclima.io>
Cc: linux-iio@vger.kernel.org, foeparker.colin@gmail.com,
        Colin Parker <colin.parker@aclima.io>
Subject: Re: [PATCH] IIO: BME280: Humidity: Changes to the humidity ctrl_hum
 require a write to ctrl_meas.
Message-ID: <20170825055256.GA2172@arbeit>
References: <1503618871-22446-1-git-send-email-colin.parker@aclimalabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503618871-22446-1-git-send-email-colin.parker@aclimalabs.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Colin,

Colin Parker <colin.foeparker@aclima.io> schrieb am Thu, 24. Aug 16:54:
> From: Colin Parker <colin.parker@aclima.io>
> 
> This results in inaccurate Humidity readings that tend to not fluxuate.
> 
> Update the ordering of the register writes so that ctrl_meas is written
> after ctrl_hum. This is taken from section 5.4.3 of the datasheet.
> 
> "https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME280_DS001-11.pdf"

this part of the patch is already covered by commit afb2c3851b: "iio: bmp280:
properly initialize device for humidity reading"

Andreas

> 
> Also writes to the config register can be ignored if the device is in Normal Mode.
> Change the device to sleep mode before updating the config register.
> This has the nice side effect of guaranteeing that the regmap_update_bits
> function actually updates the driver and not just verifies the setting in its cache.
> 
> Signed-off-by: Colin Parker <colin.parker@aclima.io>
> ---
>  drivers/iio/pressure/bmp280-core.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index d82b788..85aa24c 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -559,10 +559,7 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  		  BMP280_OSRS_PRESS_X(data->oversampling_press + 1);
>  
>  	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> -				 BMP280_OSRS_TEMP_MASK |
> -				 BMP280_OSRS_PRESS_MASK |
> -				 BMP280_MODE_MASK,
> -				 osrs | BMP280_MODE_NORMAL);
> +				 BMP280_MODE_MASK, BMP280_MODE_SLEEP);
>  	if (ret < 0) {
>  		dev_err(data->dev,
>  			"failed to write ctrl_meas register\n");
> @@ -578,6 +575,17 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  		return ret;
>  	}
>  
> +	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
> +				 BMP280_OSRS_TEMP_MASK |
> +				 BMP280_OSRS_PRESS_MASK |
> +				 BMP280_MODE_MASK,
> +				 osrs | BMP280_MODE_NORMAL);
> +	if (ret < 0) {
> +		dev_err(data->dev,
> +			"failed to write ctrl_meas register\n");
> +		return ret;
> +	}
> +
>  	return ret;
>  }
>  
> @@ -597,14 +605,14 @@ static const struct bmp280_chip_info bmp280_chip_info = {
>  
>  static int bme280_chip_config(struct bmp280_data *data)
>  {
> -	int ret = bmp280_chip_config(data);
>  	u8 osrs = BMP280_OSRS_HUMIDITIY_X(data->oversampling_humid + 1);
> +	int ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
> +				  BMP280_OSRS_HUMIDITY_MASK, osrs);
>  
>  	if (ret < 0)
>  		return ret;
>  
> -	return regmap_update_bits(data->regmap, BMP280_REG_CTRL_HUMIDITY,
> -				  BMP280_OSRS_HUMIDITY_MASK, osrs);
> +	return bmp280_chip_config(data);
>  }
>  
>  static const struct bmp280_chip_info bme280_chip_info = {
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
