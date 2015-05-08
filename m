Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52530 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbbEHSaU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:30:20 -0400
Message-ID: <554CC35B.2050609@kernel.org>
Date: Fri, 08 May 2015 10:08:27 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, pmeerw@pmeerw.net
CC: knaack.h@gmx.de, lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: magnetometer: mmc35240: Add PM sleep support
References: <1429891112-11888-1-git-send-email-daniel.baluta@intel.com> <1429891112-11888-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1429891112-11888-3-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/04/15 11:58, Daniel Baluta wrote:
> We rely on regmap to save the state of the registers at suspend,
> and then we do an explicit sync at resume.
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied
> ---
>  drivers/iio/magnetometer/mmc35240.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index beefebc..7a52c3e 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -17,6 +17,7 @@
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/regmap.h>
> +#include <linux/pm.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -447,6 +448,39 @@ static int mmc35240_probe(struct i2c_client *client,
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int mmc35240_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mmc35240_data *data = iio_priv(indio_dev);
> +
> +	regcache_cache_only(data->regmap, true);
> +
> +	return 0;
> +}
> +
> +static int mmc35240_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mmc35240_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	regcache_mark_dirty(data->regmap);
> +	ret = regcache_sync_region(data->regmap, MMC35240_REG_CTRL0,
> +				   MMC35240_REG_CTRL1);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to restore control registers\n");
> +
> +	regcache_cache_only(data->regmap, false);
> +
> +	return 0;
> +}
> +#endif
> +
> +static const struct dev_pm_ops mmc35240_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mmc35240_suspend, mmc35240_resume)
> +};
> +
>  static const struct i2c_device_id mmc35240_id[] = {
>  	{"MMC35240", 0},
>  	{}
> @@ -456,6 +490,7 @@ MODULE_DEVICE_TABLE(i2c, mmc35240_id);
>  static struct i2c_driver mmc35240_driver = {
>  	.driver = {
>  		.name = MMC35240_DRV_NAME,
> +		.pm = &mmc35240_pm_ops,
>  	},
>  	.probe		= mmc35240_probe,
>  	.id_table	= mmc35240_id,
> 

