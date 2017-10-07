Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750948AbdJGLZr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Oct 2017 07:25:47 -0400
Date: Sat, 7 Oct 2017 12:25:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH v2 3/4] iio: imu: st_lsm6dsx: move decimator info in
 st_lsm6dsx_sensor_settings
Message-ID: <20171007122543.7ac18a15@archlinux>
In-Reply-To: <20171002163740.13780-4-lorenzo.bianconi@st.com>
References: <20171002163740.13780-1-lorenzo.bianconi@st.com>
        <20171002163740.13780-4-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  2 Oct 2017 18:37:39 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Move FIFO decimator info in st_lsm6dsx_sensor_settings list since
> decimator registers are exported in register map just in
> lsm6ds3/lsm6ds3h/lsm6dsl/lsm6dsm sensors and not in other compliant
> devices
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>

Applied.
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        | 10 ++++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 17 +++++++------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 34 +++++++++++++++++++++++---
>  3 files changed, 47 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 46352c7bff43..052db1fbb46e 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -52,10 +52,18 @@ struct st_lsm6dsx_reg {
>  	u8 mask;
>  };
>  
> +/**
> + * struct st_lsm6dsx_settings - ST IMU sensor settings
> + * @wai: Sensor WhoAmI default value.
> + * @max_fifo_size: Sensor max fifo length in FIFO words.
> + * @id: List of hw id supported by the driver configuration.
> + * @decimator: List of decimator register info (addr + mask).
> + */
>  struct st_lsm6dsx_settings {
>  	u8 wai;
>  	u16 max_fifo_size;
>  	enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
> +	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
>  };
>  
>  enum st_lsm6dsx_sensor_id {
> @@ -79,7 +87,6 @@ enum st_lsm6dsx_fifo_mode {
>   * @watermark: Sensor watermark level.
>   * @sip: Number of samples in a given pattern.
>   * @decimator: FIFO decimation factor.
> - * @decimator_mask: Sensor mask for decimation register.
>   * @delta_ts: Delta time between two consecutive interrupts.
>   * @ts: Latest timestamp from the interrupt handler.
>   */
> @@ -94,7 +101,6 @@ struct st_lsm6dsx_sensor {
>  	u16 watermark;
>  	u8 sip;
>  	u8 decimator;
> -	u8 decimator_mask;
>  
>  	s64 delta_ts;
>  	s64 ts;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 26fb970aed15..cb4f8558a98f 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -38,7 +38,6 @@
>  #define ST_LSM6DSX_REG_FIFO_THL_ADDR		0x06
>  #define ST_LSM6DSX_REG_FIFO_THH_ADDR		0x07
>  #define ST_LSM6DSX_FIFO_TH_MASK			GENMASK(11, 0)
> -#define ST_LSM6DSX_REG_FIFO_DEC_GXL_ADDR	0x08
>  #define ST_LSM6DSX_REG_HLACTIVE_ADDR		0x12
>  #define ST_LSM6DSX_REG_HLACTIVE_MASK		BIT(5)
>  #define ST_LSM6DSX_REG_PP_OD_ADDR		0x12
> @@ -110,8 +109,9 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>  	st_lsm6dsx_get_max_min_odr(hw, &max_odr, &min_odr);
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> -		sensor = iio_priv(hw->iio_devs[i]);
> +		const struct st_lsm6dsx_reg *dec_reg;
>  
> +		sensor = iio_priv(hw->iio_devs[i]);
>  		/* update fifo decimators and sample in pattern */
>  		if (hw->enable_mask & BIT(sensor->id)) {
>  			sensor->sip = sensor->odr / min_odr;
> @@ -123,12 +123,13 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>  			data = 0;
>  		}
>  
> -		err = st_lsm6dsx_write_with_mask(hw,
> -					ST_LSM6DSX_REG_FIFO_DEC_GXL_ADDR,
> -					sensor->decimator_mask, data);
> -		if (err < 0)
> -			return err;
> -
> +		dec_reg = &hw->settings->decimator[sensor->id];
> +		if (dec_reg->addr) {
> +			err = st_lsm6dsx_write_with_mask(hw, dec_reg->addr,
> +							 dec_reg->mask, data);
> +			if (err < 0)
> +				return err;
> +		}
>  		sip += sensor->sip;
>  	}
>  	hw->sip = sip;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index e6e0363cd1c2..4532671df1be 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -42,8 +42,6 @@
>  
>  #include "st_lsm6dsx.h"
>  
> -#define ST_LSM6DSX_REG_ACC_DEC_MASK		GENMASK(2, 0)
> -#define ST_LSM6DSX_REG_GYRO_DEC_MASK		GENMASK(5, 3)
>  #define ST_LSM6DSX_REG_INT1_ADDR		0x0d
>  #define ST_LSM6DSX_REG_INT2_ADDR		0x0e
>  #define ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK	BIT(3)
> @@ -160,6 +158,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.id = {
>  			[0] = ST_LSM6DS3_ID,
>  		},
> +		.decimator = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.addr = 0x08,
> +				.mask = GENMASK(2, 0),
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.addr = 0x08,
> +				.mask = GENMASK(5, 3),
> +			},
> +		},
>  	},
>  	{
>  		.wai = 0x69,
> @@ -167,6 +175,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  		.id = {
>  			[0] = ST_LSM6DS3H_ID,
>  		},
> +		.decimator = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.addr = 0x08,
> +				.mask = GENMASK(2, 0),
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.addr = 0x08,
> +				.mask = GENMASK(5, 3),
> +			},
> +		},
>  	},
>  	{
>  		.wai = 0x6a,
> @@ -175,6 +193,16 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			[0] = ST_LSM6DSL_ID,
>  			[1] = ST_LSM6DSM_ID,
>  		},
> +		.decimator = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.addr = 0x08,
> +				.mask = GENMASK(2, 0),
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.addr = 0x08,
> +				.mask = GENMASK(5, 3),
> +			},
> +		},
>  	},
>  };
>  
> @@ -645,7 +673,6 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_acc_channels);
>  		iio_dev->info = &st_lsm6dsx_acc_info;
>  
> -		sensor->decimator_mask = ST_LSM6DSX_REG_ACC_DEC_MASK;
>  		scnprintf(sensor->name, sizeof(sensor->name), "%s_accel",
>  			  name);
>  		break;
> @@ -654,7 +681,6 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  		iio_dev->num_channels = ARRAY_SIZE(st_lsm6dsx_gyro_channels);
>  		iio_dev->info = &st_lsm6dsx_gyro_info;
>  
> -		sensor->decimator_mask = ST_LSM6DSX_REG_GYRO_DEC_MASK;
>  		scnprintf(sensor->name, sizeof(sensor->name), "%s_gyro",
>  			  name);
>  		break;

