Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33398 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751404AbcCFM7R (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 6 Mar 2016 07:59:17 -0500
Subject: Re: [PATCH 3/4] iio: mma8452: add support for runtime power
 management
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com, mfuzzey@parkeon.com
References: <1456993444-21320-1-git-send-email-martink@posteo.de>
 <1456993444-21320-4-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DC29A0.8030603@kernel.org>
Date: Sun, 6 Mar 2016 12:59:12 +0000
MIME-Version: 1.0
In-Reply-To: <1456993444-21320-4-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 08:24, Martin Kepplinger wrote:
> This adds support for runtime power management and, if configured, activates
> automatic standby after 2 seconds of inactivity.
> 
> Inactivity means no read of acceleration values and no events triggered or
> activated.
> 
> If CONFIG_PM is not set, this doesn't change anything for existing users.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
> Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Looks good.   Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 118 ++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 108 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 9c4a84a..5ca0d16 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -31,6 +31,7 @@
>  #include <linux/delay.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> +#include <linux/pm_runtime.h>
>  
>  #define MMA8452_STATUS				0x00
>  #define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> @@ -92,6 +93,8 @@
>  #define MMA8652_DEVICE_ID			0x4a
>  #define MMA8653_DEVICE_ID			0x5a
>  
> +#define MMA8452_AUTO_SUSPEND_DELAY_MS		2000
> +
>  struct mma8452_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> @@ -172,6 +175,31 @@ static int mma8452_drdy(struct mma8452_data *data)
>  	return -EIO;
>  }
>  
> +static int mma8452_set_runtime_pm_state(struct i2c_client *client, bool on)
> +{
> +#ifdef CONFIG_PM
> +	int ret;
> +
> +	if (on) {
> +		ret = pm_runtime_get_sync(&client->dev);
> +	} else {
> +		pm_runtime_mark_last_busy(&client->dev);
> +		ret = pm_runtime_put_autosuspend(&client->dev);
> +	}
> +
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"failed to change power state to %d\n", on);
> +		if (on)
> +			pm_runtime_put_noidle(&client->dev);
> +
> +		return ret;
> +	}
> +#endif
> +
> +	return 0;
> +}
> +
>  static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
>  {
>  	int ret = mma8452_drdy(data);
> @@ -179,8 +207,16 @@ static int mma8452_read(struct mma8452_data *data, __be16 buf[3])
>  	if (ret < 0)
>  		return ret;
>  
> -	return i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
> -					     3 * sizeof(__be16), (u8 *)buf);
> +	ret = mma8452_set_runtime_pm_state(data->client, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_smbus_read_i2c_block_data(data->client, MMA8452_OUT_X,
> +					    3 * sizeof(__be16), (u8 *)buf);
> +
> +	ret = mma8452_set_runtime_pm_state(data->client, false);
> +
> +	return ret;
>  }
>  
>  static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*vals)[2],
> @@ -707,7 +743,11 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	const struct mma_chip_info *chip = data->chip_info;
> -	int val;
> +	int val, ret;
> +
> +	ret = mma8452_set_runtime_pm_state(data->client, state);
> +	if (ret)
> +		return ret;
>  
>  	switch (dir) {
>  	case IIO_EV_DIR_FALLING:
> @@ -1139,7 +1179,11 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mma8452_data *data = iio_priv(indio_dev);
> -	int reg;
> +	int reg, ret;
> +
> +	ret = mma8452_set_runtime_pm_state(data->client, state);
> +	if (ret)
> +		return ret;
>  
>  	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
>  	if (reg < 0)
> @@ -1365,6 +1409,15 @@ static int mma8452_probe(struct i2c_client *client,
>  			goto buffer_cleanup;
>  	}
>  
> +	ret = pm_runtime_set_active(&client->dev);
> +	if (ret < 0)
> +		goto buffer_cleanup;
> +
> +	pm_runtime_enable(&client->dev);
> +	pm_runtime_set_autosuspend_delay(&client->dev,
> +					 MMA8452_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&client->dev);
> +
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto buffer_cleanup;
> @@ -1389,6 +1442,11 @@ static int mma8452_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
>  	iio_device_unregister(indio_dev);
> +
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	pm_runtime_put_noidle(&client->dev);
> +
>  	iio_triggered_buffer_cleanup(indio_dev);
>  	mma8452_trigger_cleanup(indio_dev);
>  	mma8452_standby(iio_priv(indio_dev));
> @@ -1396,6 +1454,45 @@ static int mma8452_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PM
> +static int mma8452_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&data->lock);
> +	ret = mma8452_standby(data);
> +	mutex_unlock(&data->lock);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "powering off device failed\n");
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mma8452_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int ret, sleep_val;
> +
> +	ret = mma8452_active(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = mma8452_get_odr_index(data);
> +	sleep_val = 1000 / mma8452_samp_freq[ret][0];
> +	if (sleep_val < 20)
> +		usleep_range(sleep_val * 1000, 20000);
> +	else
> +		msleep_interruptible(sleep_val);
> +
> +	return 0;
> +}
> +#endif
> +
>  #ifdef CONFIG_PM_SLEEP
>  static int mma8452_suspend(struct device *dev)
>  {
> @@ -1408,13 +1505,14 @@ static int mma8452_resume(struct device *dev)
>  	return mma8452_active(iio_priv(i2c_get_clientdata(
>  		to_i2c_client(dev))));
>  }
> -
> -static SIMPLE_DEV_PM_OPS(mma8452_pm_ops, mma8452_suspend, mma8452_resume);
> -#define MMA8452_PM_OPS (&mma8452_pm_ops)
> -#else
> -#define MMA8452_PM_OPS NULL
>  #endif
>  
> +static const struct dev_pm_ops mma8452_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(mma8452_suspend, mma8452_resume)
> +	SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
> +			   mma8452_runtime_resume, NULL)
> +};
> +
>  static const struct i2c_device_id mma8452_id[] = {
>  	{ "mma8452", mma8452 },
>  	{ "mma8453", mma8453 },
> @@ -1428,7 +1526,7 @@ static struct i2c_driver mma8452_driver = {
>  	.driver = {
>  		.name	= "mma8452",
>  		.of_match_table = of_match_ptr(mma8452_dt_ids),
> -		.pm	= MMA8452_PM_OPS,
> +		.pm	= &mma8452_pm_ops,
>  	},
>  	.probe = mma8452_probe,
>  	.remove = mma8452_remove,
> 

