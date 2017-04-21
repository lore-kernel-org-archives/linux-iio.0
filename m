Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:43390 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1041935AbdDUSdY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2017 14:33:24 -0400
Subject: Re: [PATCH 2/2] iio: imu: st_lsm6dsx: add system sleep power
 management support
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, jic23@kernel.org
References: <20170421182213.21481-1-lorenzo.bianconi@st.com>
 <20170421182213.21481-3-lorenzo.bianconi@st.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e38bb844-f259-f91b-bc56-db2fee6e830d@metafoo.de>
Date: Fri, 21 Apr 2017 20:33:09 +0200
MIME-Version: 1.0
In-Reply-To: <20170421182213.21481-3-lorenzo.bianconi@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/21/2017 08:22 PM, Lorenzo Bianconi wrote:
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Hi,

Please consider writing a commit message
(https://chris.beams.io/posts/git-commit/).

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 54 ++++++++++++++++++++++++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c  |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c  |  1 +
>  4 files changed, 58 insertions(+)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 7778520..46352c7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -135,6 +135,8 @@ struct st_lsm6dsx_hw {
>  #endif /* CONFIG_SPI_MASTER */
>  };
>  
> +extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
> +
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  		     const struct st_lsm6dsx_transfer_function *tf_ops);
>  int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 462a27b..1b53848 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -36,6 +36,7 @@
>  #include <linux/delay.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/pm.h>
>  
>  #include <linux/platform_data/st_sensors_pdata.h>
>  
> @@ -731,6 +732,59 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  }
>  EXPORT_SYMBOL(st_lsm6dsx_probe);
>  
> +#ifdef CONFIG_PM
> +static int st_lsm6dsx_suspend(struct device *dev)
> +{
> +	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
> +	struct st_lsm6dsx_sensor *sensor;
> +	int i, err = 0;
> +
> +	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		sensor = iio_priv(hw->iio_devs[i]);
> +		if (!(hw->enable_mask & BIT(sensor->id)))
> +			continue;
> +
> +		err = st_lsm6dsx_write_with_mask(hw,
> +				st_lsm6dsx_odr_table[sensor->id].reg.addr,
> +				st_lsm6dsx_odr_table[sensor->id].reg.mask, 0);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS)
> +		err = st_lsm6dsx_flush_fifo(hw);
> +
> +	return err;
> +}
> +
> +static int st_lsm6dsx_resume(struct device *dev)
> +{
> +	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
> +	struct st_lsm6dsx_sensor *sensor;
> +	int i, err = 0;
> +
> +	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> +		sensor = iio_priv(hw->iio_devs[i]);
> +		if (!(hw->enable_mask & BIT(sensor->id)))
> +			continue;
> +
> +		err = st_lsm6dsx_set_odr(sensor, sensor->odr);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (hw->enable_mask)
> +		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
> +
> +	return err;
> +}
> +#endif /* CONFIG_PM */
> +
> +const struct dev_pm_ops st_lsm6dsx_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(st_lsm6dsx_suspend, st_lsm6dsx_resume)
> +};
> +EXPORT_SYMBOL(st_lsm6dsx_pm_ops);
> +
>  MODULE_AUTHOR("Lorenzo Bianconi <lorenzo.bianconi@st.com>");
>  MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
>  MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx driver");
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 09a51cf..305fec7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -98,6 +98,7 @@ MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
>  static struct i2c_driver st_lsm6dsx_driver = {
>  	.driver = {
>  		.name = "st_lsm6dsx_i2c",
> +		.pm = &st_lsm6dsx_pm_ops,
>  		.of_match_table = of_match_ptr(st_lsm6dsx_i2c_of_match),
>  	},
>  	.probe = st_lsm6dsx_i2c_probe,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index f765a50..95472f1 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -115,6 +115,7 @@ MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
>  static struct spi_driver st_lsm6dsx_driver = {
>  	.driver = {
>  		.name = "st_lsm6dsx_spi",
> +		.pm = &st_lsm6dsx_pm_ops,
>  		.of_match_table = of_match_ptr(st_lsm6dsx_spi_of_match),
>  	},
>  	.probe = st_lsm6dsx_spi_probe,
> 

