Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53590 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbbDIQN0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 12:13:26 -0400
Message-ID: <5526A524.9080908@kernel.org>
Date: Thu, 09 Apr 2015 17:13:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: sx9500: add power management
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com> <1428065254-6444-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428065254-6444-2-git-send-email-vlad.dogaru@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/15 13:47, Vlad Dogaru wrote:
> Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
Applied to the togreg branch of iio.git - initially pushed out as testing for the autobuilders to play.

J
> ---
>  drivers/iio/proximity/sx9500.c | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 
> diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
> index 74dff4e..f62d0b6 100644
> --- a/drivers/iio/proximity/sx9500.c
> +++ b/drivers/iio/proximity/sx9500.c
> @@ -18,6 +18,7 @@
>  #include <linux/acpi.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/regmap.h>
> +#include <linux/pm.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -89,6 +90,8 @@ struct sx9500_data {
>  	bool event_enabled[SX9500_NUM_CHANNELS];
>  	bool trigger_enabled;
>  	u16 *buffer;
> +	/* Remember enabled channels and sample rate during suspend. */
> +	unsigned int suspend_ctrl0;
>  };
>  
>  static const struct iio_event_spec sx9500_events[] = {
> @@ -724,6 +727,49 @@ static int sx9500_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM_SLEEP
> +static int sx9500_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct sx9500_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_read(data->regmap, SX9500_REG_PROX_CTRL0,
> +			  &data->suspend_ctrl0);
> +	if (ret < 0)
> +		goto out;
> +
> +	/*
> +	 * Scan period doesn't matter because when all the sensors are
> +	 * deactivated the device is in sleep mode.
> +	 */
> +	ret = regmap_write(data->regmap, SX9500_REG_PROX_CTRL0, 0);
> +
> +out:
> +	mutex_unlock(&data->mutex);
> +	return ret;
> +}
> +
> +static int sx9500_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct sx9500_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->mutex);
> +	ret = regmap_write(data->regmap, SX9500_REG_PROX_CTRL0,
> +			   data->suspend_ctrl0);
> +	mutex_unlock(&data->mutex);
> +
> +	return ret;
> +}
> +#endif /* CONFIG_PM_SLEEP */
> +
> +static const struct dev_pm_ops sx9500_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(sx9500_suspend, sx9500_resume)
> +};
> +
>  static const struct acpi_device_id sx9500_acpi_match[] = {
>  	{"SSX9500", 0},
>  	{ },
> @@ -740,6 +786,7 @@ static struct i2c_driver sx9500_driver = {
>  	.driver = {
>  		.name	= SX9500_DRIVER_NAME,
>  		.acpi_match_table = ACPI_PTR(sx9500_acpi_match),
> +		.pm = &sx9500_pm_ops,
>  	},
>  	.probe		= sx9500_probe,
>  	.remove		= sx9500_remove,
> 

