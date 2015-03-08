Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35281 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271AbbCHMF6 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 08:05:58 -0400
Message-ID: <54FC3B24.5080601@kernel.org>
Date: Sun, 08 Mar 2015 12:05:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/1] iio: light: Added PM support for Capella CM3232
 ambient light sensor driver.
References: <1424386971-811-1-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1424386971-811-1-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/02/15 23:02, Kevin Tsai wrote:
> Added Power Management Support.
> 
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play.

Thanks,

Jonathan
> ---
> v2:
> Added CONFIG_PM_SLEEP to suspend/resume functions to fix the build warning
> when CONFIG_PM_SLEEP is not selected.
> 
> v1:
> Added Power Management support.
> 
>  drivers/iio/light/cm3232.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 90e3519..39c8d99 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -378,6 +378,39 @@ static const struct i2c_device_id cm3232_id[] = {
>  	{}
>  };
>  
> +#ifdef CONFIG_PM_SLEEP
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
> +static const struct dev_pm_ops cm3232_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(cm3232_suspend, cm3232_resume)};
> +#endif
> +
>  MODULE_DEVICE_TABLE(i2c, cm3232_id);
>  
>  static const struct of_device_id cm3232_of_match[] = {
> @@ -390,6 +423,9 @@ static struct i2c_driver cm3232_driver = {
>  		.name	= "cm3232",
>  		.owner	= THIS_MODULE,
>  		.of_match_table = of_match_ptr(cm3232_of_match),
> +#ifdef CONFIG_PM_SLEEP
> +		.pm	= &cm3232_pm_ops,
> +#endif
>  	},
>  	.id_table	= cm3232_id,
>  	.probe		= cm3232_probe,
> 

