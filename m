Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752759AbeAFMTW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:19:22 -0500
Date: Sat, 6 Jan 2018 12:19:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: introduce conf_lock mutex
Message-ID: <20180106121918.035d7242@archlinux>
In-Reply-To: <20180101185444.22045-3-lorenzo.bianconi@redhat.com>
References: <20180101185444.22045-3-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  1 Jan 2018 19:54:43 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Add conf_lock mutex to prevent concurrent FIFO configuration update
> 
> Fixes: 290a6ce11d93 (iio: imu: add support to lsm6dsx driver)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Initially I thought with care you could share the existing lock
but given we scrap that in the following patch this makes more
sense.

Applied to the togreg branch of iio.git and pushed out as
testing.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  2 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 21 +++++++++++++--------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   |  6 ++++++
>  3 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 4fdb7fcc3ea8..cebc6bd31b79 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -130,6 +130,7 @@ struct st_lsm6dsx_sensor {
>   * @irq: Device interrupt line (I2C or SPI).
>   * @lock: Mutex to protect read and write operations.
>   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
> + * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
>   * @fifo_mode: FIFO operating mode supported by the device.
>   * @enable_mask: Enabled sensor bitmask.
>   * @sip: Total number of samples (acc/gyro) in a given pattern.
> @@ -144,6 +145,7 @@ struct st_lsm6dsx_hw {
>  
>  	struct mutex lock;
>  	struct mutex fifo_lock;
> +	struct mutex conf_lock;
>  
>  	enum st_lsm6dsx_fifo_mode fifo_mode;
>  	u8 enable_mask;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 755c472e8a05..c899d658f6be 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -325,38 +325,40 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int err;
>  
> +	mutex_lock(&hw->conf_lock);
> +
>  	if (hw->fifo_mode != ST_LSM6DSX_FIFO_BYPASS) {
>  		err = st_lsm6dsx_flush_fifo(hw);
>  		if (err < 0)
> -			return err;
> +			goto out;
>  	}
>  
>  	if (enable) {
>  		err = st_lsm6dsx_sensor_enable(sensor);
>  		if (err < 0)
> -			return err;
> +			goto out;
>  	} else {
>  		err = st_lsm6dsx_sensor_disable(sensor);
>  		if (err < 0)
> -			return err;
> +			goto out;
>  	}
>  
>  	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
>  	if (err < 0)
> -		return err;
> +		goto out;
>  
>  	err = st_lsm6dsx_update_decimators(hw);
>  	if (err < 0)
> -		return err;
> +		goto out;
>  
>  	err = st_lsm6dsx_update_watermark(sensor, sensor->watermark);
>  	if (err < 0)
> -		return err;
> +		goto out;
>  
>  	if (hw->enable_mask) {
>  		err = st_lsm6dsx_set_fifo_mode(hw, ST_LSM6DSX_FIFO_CONT);
>  		if (err < 0)
> -			return err;
> +			goto out;
>  
>  		/*
>  		 * store enable buffer timestamp as reference to compute
> @@ -365,7 +367,10 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>  		sensor->ts = iio_get_time_ns(iio_dev);
>  	}
>  
> -	return 0;
> +out:
> +	mutex_unlock(&hw->conf_lock);
> +
> +	return err;
>  }
>  
>  static irqreturn_t st_lsm6dsx_handler_irq(int irq, void *private)
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 812cd25f284e..4d43c956d676 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -528,7 +528,12 @@ static int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val)
>  	if (val < 1 || val > hw->settings->max_fifo_size)
>  		return -EINVAL;
>  
> +	mutex_lock(&hw->conf_lock);
> +
>  	err = st_lsm6dsx_update_watermark(sensor, val);
> +
> +	mutex_unlock(&hw->conf_lock);
> +
>  	if (err < 0)
>  		return err;
>  
> @@ -739,6 +744,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  
>  	mutex_init(&hw->lock);
>  	mutex_init(&hw->fifo_lock);
> +	mutex_init(&hw->conf_lock);
>  
>  	hw->dev = dev;
>  	hw->irq = irq;

