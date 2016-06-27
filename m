Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:46826 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638AbcF0RJg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jun 2016 13:09:36 -0400
Date: Mon, 27 Jun 2016 19:09:34 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/10 v3] iio: pressure: bmp280: add power management
In-Reply-To: <1467045020-2665-11-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.02.1606271908010.5271@pmeerw.net>
References: <1467045020-2665-1-git-send-email-linus.walleij@linaro.org> <1467045020-2665-11-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Jun 2016, Linus Walleij wrote:

> The PM280 has an internal standby-mode, but to really save power
> we should shut the sensor down and disconnect the power. With
> the proper .pm hooks we can enable both runtime and system power
> management of the sensor. We use the *force callbacks from the
> system PM hooks. When the sensor comes back we always reconfigure
> it to make sure it is ready to roll as expected.

comments below
 
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v0->v3:
> - New patch on top of the reworked patches: we can add runtime PM,
>   so we should.
> ---
>  drivers/iio/pressure/bmp280-core.c | 65 ++++++++++++++++++++++++++++++++++++++
>  drivers/iio/pressure/bmp280-i2c.c  |  1 +
>  drivers/iio/pressure/bmp280-spi.c  |  3 +-
>  drivers/iio/pressure/bmp280.h      |  3 ++
>  4 files changed, 71 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index f7233641c643..52ea8e465d7d 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -31,6 +31,7 @@
>  #include <linux/irq.h> /* For irq_get_irq_data() */
>  #include <linux/completion.h>
>  #include <linux/random.h>
> +#include <linux/pm_runtime.h>
>  
>  #include "bmp280.h"
>  
> @@ -358,6 +359,7 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	int ret;
>  	struct bmp280_data *data = iio_priv(indio_dev);
>  
> +	pm_runtime_get_sync(data->dev);
>  	mutex_lock(&data->lock);
>  
>  	switch (mask) {
> @@ -402,6 +404,8 @@ static int bmp280_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  	mutex_unlock(&data->lock);
> +	pm_runtime_mark_last_busy(data->dev);
> +	pm_runtime_put_autosuspend(data->dev);
>  
>  	return ret;
>  }
> @@ -466,6 +470,7 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		pm_runtime_get_sync(data->dev);
>  		mutex_lock(&data->lock);
>  		switch (chan->type) {
>  		case IIO_HUMIDITYRELATIVE:
> @@ -482,6 +487,8 @@ static int bmp280_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  		mutex_unlock(&data->lock);
> +		pm_runtime_mark_last_busy(data->dev);
> +		pm_runtime_put_autosuspend(data->dev);
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -1028,6 +1035,18 @@ int bmp280_common_probe(struct device *dev,
>  		dev_err(dev, "unable to register IIO device\n");
>  		goto out_disable_vdda;
>  	}
> +
> +	/* Enable runtime PM */
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	/*
> +	 * Set autosuspend to two orders of magnitude larger than the
> +	 * start-up time.
> +	 */
> +	pm_runtime_set_autosuspend_delay(dev, data->start_up_time *100);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_put(dev);
>  	return 0;
>  
>  out_disable_vdda:
> @@ -1042,8 +1061,54 @@ int bmp280_common_remove(struct device *dev)
>  {
>  	struct bmp280_data *data = dev_get_drvdata(dev);
>  
> +	pm_runtime_get_sync(data->dev);
> +	pm_runtime_put_noidle(data->dev);
> +	pm_runtime_disable(data->dev);
>  	regulator_disable(data->vdda);
>  	regulator_disable(data->vddd);
>  	return 0;
>  }
>  EXPORT_SYMBOL(bmp280_common_remove);
> +
> +#ifdef CONFIG_PM
> +static int bmp280_runtime_suspend(struct device *dev)
> +{
> +	struct bmp280_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_disable(data->vdda);
> +	if (ret)
> +		return ret;
> +	ret = regulator_disable(data->vddd);

can just 
return regulator_disable(data->vddd);
here to safe 3 lines as is customary within IIO

> +	if (ret)
> +		return ret;
> +	return 0;
> +}
> +
> +static int bmp280_runtime_resume(struct device *dev)
> +{
> +	struct bmp280_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = regulator_enable(data->vddd);
> +	if (ret)
> +		return ret;
> +	ret = regulator_enable(data->vdda);
> +	if (ret)
> +		return ret;
> +	msleep(data->start_up_time);
> +	ret = data->chip_info->chip_config(data);

just return

> +	if (ret)
> +		return ret;
> +	return 0;
> +
> +}
> +#endif /* CONFIG_PM */
> +
> +const struct dev_pm_ops bmp280_dev_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(bmp280_runtime_suspend,
> +			   bmp280_runtime_resume, NULL)
> +};
> +EXPORT_SYMBOL(bmp280_dev_pm_ops);
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 8cf8a900bdaa..03742b15b72a 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -78,6 +78,7 @@ static struct i2c_driver bmp280_i2c_driver = {
>  		.name	= "bmp280",
>  		.acpi_match_table = ACPI_PTR(bmp280_acpi_i2c_match),
>  		.of_match_table = of_match_ptr(bmp280_of_i2c_match),
> +		.pm = &bmp280_dev_pm_ops,
>  	},
>  	.probe		= bmp280_i2c_probe,
>  	.remove		= bmp280_i2c_remove,
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 2468224edb79..99b7386dffb3 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -112,7 +112,8 @@ MODULE_DEVICE_TABLE(spi, bmp280_spi_id);
>  static struct spi_driver bmp280_spi_driver = {
>  	.driver = {
>  		.name = "bmp280",
> -		.of_match_table = bmp280_of_spi_match
> +		.of_match_table = bmp280_of_spi_match,
> +		.pm = &bmp280_dev_pm_ops,
>  	},
>  	.id_table = bmp280_spi_id,
>  	.probe = bmp280_spi_probe,
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 573334b8e93b..3ba79d18639c 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -107,3 +107,6 @@ int bmp280_common_probe(struct device *dev,
>  			const char *name,
>  			int irq);
>  int bmp280_common_remove(struct device *dev);
> +
> +/* Runtime PM ops */
> +extern const struct dev_pm_ops bmp280_dev_pm_ops;
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
