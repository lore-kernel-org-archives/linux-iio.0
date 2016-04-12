Return-Path: <pmeerw@pmeerw.net>
Date: Tue, 12 Apr 2016 07:17:57 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Matt Ranostay <matt.ranostay@intel.com>
cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: bmp280: add per chip initialize
 function pointer
In-Reply-To: <1460438494-16135-3-git-send-email-matt.ranostay@intel.com>
Message-ID: <alpine.DEB.2.20.12.1604120717320.31934@pmeerw.net>
References: <1460438494-16135-1-git-send-email-matt.ranostay@intel.com> <1460438494-16135-3-git-send-email-matt.ranostay@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Some variants have functions that need to be enabled outside of an core
> chip initialization.

comment below
 
> Signed-off-by: Matt Ranostay <matt.ranostay@intel.com>
> ---
>  drivers/iio/pressure/bmp280.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
> index 2e7cff38f5ff..e80cbf3b21fc 100644
> --- a/drivers/iio/pressure/bmp280.c
> +++ b/drivers/iio/pressure/bmp280.c
> @@ -88,6 +88,9 @@ enum { bmp280, bme280 };
>  struct bmp280_chip_info {
>  	int id;
>  	int num_channels;
> +
> +	/* per chip initialization function */
> +	int (*init)(struct bmp280_data *);
>  };
>  
>  static struct bmp280_chip_info bmp280_chip_info_table[] = {
> @@ -336,10 +339,18 @@ static const struct iio_info bmp280_info = {
>  	.read_raw = &bmp280_read_raw,
>  };
>  
> -static int bmp280_chip_init(struct bmp280_data *data)
> +static int bmp280_common_init(struct bmp280_data *data)
>  {
>  	int ret;
>  
> +	if (data->chip->init) {
> +		ret = data->chip->init(data);
> +		if (ret < 0) {
> +			dev_err(&data->client->dev, "failed to run chip init");

should have \n I think

> +			return ret;
> +		}
> +	}
> +
>  	ret = regmap_update_bits(data->regmap, BMP280_REG_CTRL_MEAS,
>  				 BMP280_OSRS_TEMP_MASK |
>  				 BMP280_OSRS_PRESS_MASK |
> @@ -429,7 +440,7 @@ static int bmp280_probe(struct i2c_client *client,
>  		return -EINVAL;
>  	}
>  
> -	ret = bmp280_chip_init(data);
> +	ret = bmp280_common_init(data);
>  	if (ret < 0)
>  		return ret;
>  
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
