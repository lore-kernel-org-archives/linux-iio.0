Return-Path: <pmeerw@pmeerw.net>
Date: Thu, 19 Feb 2015 08:15:27 +0100 (CET)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Kevin Tsai <ktsai@capellamicro.com>
cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 1/1] iio: light: Added PM support for Capella CM3232
 ambient light sensor driver.
In-Reply-To: <1424304808-14666-1-git-send-email-ktsai@capellamicro.com>
Message-ID: <alpine.DEB.2.02.1502190813420.16447@pmeerw.net>
References: <1424304808-14666-1-git-send-email-ktsai@capellamicro.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Added Power Management Support.

comments below
 
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
> ---
> v1:
> Added Power Management support.
> 
>  drivers/iio/light/cm3232.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 90e3519..9e54ea7 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -378,6 +378,34 @@ static const struct i2c_device_id cm3232_id[] = {
>  	{}
>  };
>  
> +static int cm3232_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct cm3232_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	chip->regs_cmd |= CM3232_CMD_ALS_DISABLE;
> +	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> +					chip->regs_cmd);
> +
> +	return ret;
> +}
> +

these functions are not used when CONFIG_PM_SLEEP is not #defined, leading 
to warning

> +static int cm3232_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct cm3232_chip *chip = iio_priv(indio_dev);
> +	struct i2c_client *client = chip->client;
> +	int ret;
> +
> +	chip->regs_cmd &= ~CM3232_CMD_ALS_DISABLE;
> +	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> +					chip->regs_cmd | CM3232_CMD_ALS_RESET);
> +
> +	return ret;
> +}
> +
>  MODULE_DEVICE_TABLE(i2c, cm3232_id);
>  
>  static const struct of_device_id cm3232_of_match[] = {
> @@ -385,11 +413,15 @@ static const struct of_device_id cm3232_of_match[] = {
>  	{}
>  };
>  
> +static const struct dev_pm_ops cm3232_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};

probably put the closing brace in the next line

> +
>  static struct i2c_driver cm3232_driver = {
>  	.driver = {
>  		.name	= "cm3232",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = of_match_ptr(cm3232_of_match),
> +		.pm	= &cm3232_pm_ops,
>  	},
>  	.id_table	= cm3232_id,
>  	.probe		= cm3232_probe,
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
