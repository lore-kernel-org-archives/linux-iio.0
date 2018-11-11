Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728761AbeKLCUG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:20:06 -0500
Date: Sun, 11 Nov 2018 16:31:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/9] iio: imu: st_lsm6dsx: introduce
 st_lsm6dsx_sensor_set_enable routine
Message-ID: <20181111163103.4f2f6376@archlinux>
In-Reply-To: <faa1857c37967fe11502bde788b4d81d4c0b3ace.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
        <faa1857c37967fe11502bde788b4d81d4c0b3ace.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 15:15:32 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Add st_lsm6dsx_sensor_set_enable routine and remove
> st_lsm6dsx_sensor_{enable/disable} ones in order to make the code more
> readable and remove unnecessary functions
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +--
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 12 ++-----
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 32 ++++++-------------
>  3 files changed, 15 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 4c8385d19c78..2beb4f563892 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -185,8 +185,8 @@ extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
>  
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  		     struct regmap *regmap);
> -int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
> -int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
> +int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> +				 bool enable);
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_set_watermark(struct iio_dev *iio_dev, unsigned int val);
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index f4804008b585..6a379767b919 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -579,15 +579,9 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>  			goto out;
>  	}
>  
> -	if (enable) {
> -		err = st_lsm6dsx_sensor_enable(sensor);
> -		if (err < 0)
> -			goto out;
> -	} else {
> -		err = st_lsm6dsx_sensor_disable(sensor);
> -		if (err < 0)
> -			goto out;
> -	}
> +	err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> +	if (err < 0)
> +		goto out;
>  
>  	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
>  	if (err < 0)
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 8885c9755456..28ddedbd1304 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -530,33 +530,21 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 req_odr)
>  	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
>  }
>  
> -int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
> -{
> -	int err;
> -
> -	err = st_lsm6dsx_set_odr(sensor, sensor->odr);
> -	if (err < 0)
> -		return err;
> -
> -	sensor->hw->enable_mask |= BIT(sensor->id);
> -
> -	return 0;
> -}
> -
> -int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor)
> +int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
> +				 bool enable)
>  {
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> -	const struct st_lsm6dsx_reg *reg;
> -	unsigned int data;
> +	u16 odr = enable ? sensor->odr : 0;
>  	int err;
>  
> -	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
> -	data = ST_LSM6DSX_SHIFT_VAL(0, reg->mask);
> -	err = st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
> +	err = st_lsm6dsx_set_odr(sensor, odr);
>  	if (err < 0)
>  		return err;
>  
> -	sensor->hw->enable_mask &= ~BIT(sensor->id);
> +	if (enable)
> +		hw->enable_mask |= BIT(sensor->id);
> +	else
> +		hw->enable_mask &= ~BIT(sensor->id);
>  
>  	return 0;
>  }
> @@ -568,7 +556,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  	int err, delay;
>  	__le16 data;
>  
> -	err = st_lsm6dsx_sensor_enable(sensor);
> +	err = st_lsm6dsx_sensor_set_enable(sensor, true);
>  	if (err < 0)
>  		return err;
>  
> @@ -579,7 +567,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  	if (err < 0)
>  		return err;
>  
> -	st_lsm6dsx_sensor_disable(sensor);
> +	st_lsm6dsx_sensor_set_enable(sensor, false);
>  
>  	*val = (s16)le16_to_cpu(data);
>  
