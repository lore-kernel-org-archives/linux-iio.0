Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726978AbeICArl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Sep 2018 20:47:41 -0400
Date: Sun, 2 Sep 2018 21:30:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: imu: st_lsm6dsx: add support to LSM6DSO
Message-ID: <20180902213038.5c7910b9@archlinux>
In-Reply-To: <20180830205259.7029-5-lorenzo.bianconi@redhat.com>
References: <20180830205259.7029-5-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 30 Aug 2018 22:52:58 +0200
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Add support to STM LSM6DSO 6-axis (acc + gyro) Mems sensor
> https://www.st.com/resource/en/datasheet/lsm6dso.pdf
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

A nice clean set of patches that add this somewhat different
device in a minimally invasive way.

Good stuff.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig            |   2 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  12 +-
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 144 +++++++++++++++++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  45 ++++++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c   |   5 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |   5 +
>  6 files changed, 205 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index ccc817e17eb8..094fd006b63d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -9,7 +9,7 @@ config IIO_ST_LSM6DSX
>  	help
>  	  Say yes here to build support for STMicroelectronics LSM6DSx imu
>  	  sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> -	  ism330dlc
> +	  ism330dlc, lsm6dso
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called st_lsm6dsx.
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 6cf806f10787..ef73519a0fb6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -19,6 +19,7 @@
>  #define ST_LSM6DSL_DEV_NAME	"lsm6dsl"
>  #define ST_LSM6DSM_DEV_NAME	"lsm6dsm"
>  #define ST_ISM330DLC_DEV_NAME	"ism330dlc"
> +#define ST_LSM6DSO_DEV_NAME	"lsm6dso"
>  
>  enum st_lsm6dsx_hw_id {
>  	ST_LSM6DS3_ID,
> @@ -26,14 +27,20 @@ enum st_lsm6dsx_hw_id {
>  	ST_LSM6DSL_ID,
>  	ST_LSM6DSM_ID,
>  	ST_ISM330DLC_ID,
> +	ST_LSM6DSO_ID,
>  	ST_LSM6DSX_MAX_ID,
>  };
>  
> -#define ST_LSM6DSX_BUFF_SIZE		400
> +#define ST_LSM6DSX_BUFF_SIZE		512
>  #define ST_LSM6DSX_CHAN_SIZE		2
>  #define ST_LSM6DSX_SAMPLE_SIZE		6
> +#define ST_LSM6DSX_TAG_SIZE		1
> +#define ST_LSM6DSX_TAGGED_SAMPLE_SIZE	(ST_LSM6DSX_SAMPLE_SIZE + \
> +					 ST_LSM6DSX_TAG_SIZE)
>  #define ST_LSM6DSX_MAX_WORD_LEN		((32 / ST_LSM6DSX_SAMPLE_SIZE) * \
>  					 ST_LSM6DSX_SAMPLE_SIZE)
> +#define ST_LSM6DSX_MAX_TAGGED_WORD_LEN	((32 / ST_LSM6DSX_TAGGED_SAMPLE_SIZE) \
> +					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
>  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
>  
>  struct st_lsm6dsx_reg {
> @@ -83,6 +90,7 @@ struct st_lsm6dsx_hw_ts_settings {
>   * @max_fifo_size: Sensor max fifo length in FIFO words.
>   * @id: List of hw id supported by the driver configuration.
>   * @decimator: List of decimator register info (addr + mask).
> + * @batch: List of FIFO batching register info (addr + mask).
>   * @fifo_ops: Sensor hw FIFO parameters.
>   * @ts_settings: Hw timer related settings.
>   */
> @@ -91,6 +99,7 @@ struct st_lsm6dsx_settings {
>  	u16 max_fifo_size;
>  	enum st_lsm6dsx_hw_id id[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_reg decimator[ST_LSM6DSX_MAX_ID];
> +	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
>  };
> @@ -180,6 +189,7 @@ int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  			     enum st_lsm6dsx_fifo_mode fifo_mode);
>  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
> +int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val);
>  
>  #endif /* ST_LSM6DSX_H */
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 2002ba4a1abd..340f2b16c457 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -12,6 +12,11 @@
>   * buffer contains the data of all the enabled FIFO data sets
>   * (e.g. Gx, Gy, Gz, Ax, Ay, Az), then data are repeated depending on the
>   * value of the decimation factor and ODR set for each FIFO data set.
> + *
> + * LSM6DSO: The FIFO buffer can be configured to store data from gyroscope and
> + * accelerometer. Each sample is queued with a tag (1B) indicating data source
> + * (gyroscope, accelerometer, hw timer).
> + *
>   * FIFO supported modes:
>   *  - BYPASS: FIFO disabled
>   *  - CONTINUOUS: FIFO enabled. When the buffer is full, the FIFO index
> @@ -46,6 +51,7 @@
>  #define ST_LSM6DSX_FIFO_ODR_MASK		GENMASK(6, 3)
>  #define ST_LSM6DSX_FIFO_EMPTY_MASK		BIT(12)
>  #define ST_LSM6DSX_REG_FIFO_OUTL_ADDR		0x3e
> +#define ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR	0x78
>  #define ST_LSM6DSX_REG_TS_RESET_ADDR		0x42
>  
>  #define ST_LSM6DSX_MAX_FIFO_ODR_VAL		0x08
> @@ -58,6 +64,12 @@ struct st_lsm6dsx_decimator_entry {
>  	u8 val;
>  };
>  
> +enum st_lsm6dsx_fifo_tag {
> +	ST_LSM6DSX_GYRO_TAG = 0x01,
> +	ST_LSM6DSX_ACC_TAG = 0x02,
> +	ST_LSM6DSX_TS_TAG = 0x04,
> +};
> +
>  static const
>  struct st_lsm6dsx_decimator_entry st_lsm6dsx_decimator_table[] = {
>  	{  0, 0x0 },
> @@ -177,12 +189,34 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
>  				   bool enable)
>  {
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_reg *batch_reg;
>  	u8 data;
>  
> -	data = hw->enable_mask ? ST_LSM6DSX_MAX_FIFO_ODR_VAL : 0;
> -	return regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> -				 ST_LSM6DSX_FIFO_ODR_MASK,
> -				 FIELD_PREP(ST_LSM6DSX_FIFO_ODR_MASK, data));
> +	batch_reg = &hw->settings->batch[sensor->id];
> +	if (batch_reg->addr) {
> +		int val;
> +
> +		if (enable) {
> +			int err;
> +
> +			err = st_lsm6dsx_check_odr(sensor, sensor->odr,
> +						   &data);
> +			if (err < 0)
> +				return err;
> +		} else {
> +			data = 0;
> +		}
> +		val = ST_LSM6DSX_SHIFT_VAL(data, batch_reg->mask);
> +		return regmap_update_bits(hw->regmap, batch_reg->addr,
> +					  batch_reg->mask, val);
> +	} else {
> +		data = hw->enable_mask ? ST_LSM6DSX_MAX_FIFO_ODR_VAL : 0;
> +		return regmap_update_bits(hw->regmap,
> +					  ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> +					  ST_LSM6DSX_FIFO_ODR_MASK,
> +					  FIELD_PREP(ST_LSM6DSX_FIFO_ODR_MASK,
> +						     data));
> +	}
>  }
>  
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
> @@ -252,8 +286,8 @@ static int st_lsm6dsx_reset_hw_ts(struct st_lsm6dsx_hw *hw)
>  }
>  
>  /*
> - * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN in order to avoid
> - * a kmalloc for each bus access
> + * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN/ST_LSM6DSX_MAX_TAGGED_WORD_LEN
> + * in order to avoid a kmalloc for each bus access
>   */
>  static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 addr,
>  					u8 *data, unsigned int data_len,
> @@ -404,6 +438,104 @@ int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	return read_len;
>  }
>  
> +/**
> + * st_lsm6dsx_read_tagged_fifo() - LSM6DSO read FIFO routine
> + * @hw: Pointer to instance of struct st_lsm6dsx_hw.
> + *
> + * Read samples from the hw FIFO and push them to IIO buffers.
> + *
> + * Return: Number of bytes read from the FIFO
> + */
> +int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
> +{
> +	u16 pattern_len = hw->sip * ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
> +	u16 fifo_len, fifo_diff_mask;
> +	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
> +	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE], tag;
> +	bool reset_ts = false;
> +	int i, err, read_len;
> +	__le16 fifo_status;
> +	s64 ts = 0;
> +
> +	err = regmap_bulk_read(hw->regmap,
> +			       hw->settings->fifo_ops.fifo_diff.addr,
> +			       &fifo_status, sizeof(fifo_status));
> +	if (err < 0) {
> +		dev_err(hw->dev, "failed to read fifo status (err=%d)\n",
> +			err);
> +		return err;
> +	}
> +
> +	fifo_diff_mask = hw->settings->fifo_ops.fifo_diff.mask;
> +	fifo_len = (le16_to_cpu(fifo_status) & fifo_diff_mask) *
> +		   ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
> +	if (!fifo_len)
> +		return 0;
> +
> +	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
> +
> +	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
> +		err = st_lsm6dsx_read_block(hw,
> +					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,
> +					    hw->buff, pattern_len,
> +					    ST_LSM6DSX_MAX_TAGGED_WORD_LEN);
> +		if (err < 0) {
> +			dev_err(hw->dev,
> +				"failed to read pattern from fifo (err=%d)\n",
> +				err);
> +			return err;
> +		}
> +
> +		for (i = 0; i < pattern_len;
> +		     i += ST_LSM6DSX_TAGGED_SAMPLE_SIZE) {
> +			memcpy(iio_buff, &hw->buff[i + ST_LSM6DSX_TAG_SIZE],
> +			       ST_LSM6DSX_SAMPLE_SIZE);
> +
> +			tag = hw->buff[i] >> 3;
> +			switch (tag) {
> +			case ST_LSM6DSX_TS_TAG:
> +				/*
> +				 * hw timestamp is 4B long and it is stored
> +				 * in FIFO according to this schema:
> +				 * B0 = ts[7:0], B1 = ts[15:8], B2 = ts[23:16],
> +				 * B3 = ts[31:24]
> +				 */
> +				ts = le32_to_cpu(*((__le32 *)iio_buff));
> +				/*
> +				 * check if hw timestamp engine is going to
> +				 * reset (the sensor generates an interrupt
> +				 * to signal the hw timestamp will reset in
> +				 * 1.638s)
> +				 */
> +				if (!reset_ts && ts >= 0xffff0000)
> +					reset_ts = true;
> +				ts *= ST_LSM6DSX_TS_SENSITIVITY;
> +				break;
> +			case ST_LSM6DSX_GYRO_TAG:
> +				iio_push_to_buffers_with_timestamp(
> +					hw->iio_devs[ST_LSM6DSX_ID_GYRO],
> +					iio_buff, gyro_sensor->ts_ref + ts);
> +				break;
> +			case ST_LSM6DSX_ACC_TAG:
> +				iio_push_to_buffers_with_timestamp(
> +					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> +					iio_buff, acc_sensor->ts_ref + ts);
> +				break;
> +			default:
> +				break;
> +			}
> +		}
> +	}
> +
> +	if (unlikely(reset_ts)) {
> +		err = st_lsm6dsx_reset_hw_ts(hw);
> +		if (err < 0)
> +			return err;
> +	}
> +	return read_len;
> +}
> +
>  int st_lsm6dsx_flush_fifo(struct st_lsm6dsx_hw *hw)
>  {
>  	int err;
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 5a43d8139950..2ad3c610e4b6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -23,6 +23,12 @@
>   *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
>   *   - FIFO size: 4KB
>   *
> + * - LSM6DSO
> + *   - Accelerometer/Gyroscope supported ODR [Hz]: 13, 26, 52, 104, 208, 416
> + *   - Accelerometer supported full-scale [g]: +-2/+-4/+-8/+-16
> + *   - Gyroscope supported full-scale [dps]: +-125/+-245/+-500/+-1000/+-2000
> + *   - FIFO size: 3KB
> + *
>   * Copyright 2016 STMicroelectronics Inc.
>   *
>   * Lorenzo Bianconi <lorenzo.bianconi@st.com>
> @@ -297,6 +303,45 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  		},
>  	},
> +	{
> +		.wai = 0x6c,
> +		.max_fifo_size = 512,
> +		.id = {
> +			[0] = ST_LSM6DSO_ID,
> +		},
> +		.batch = {
> +			[ST_LSM6DSX_ID_ACC] = {
> +				.addr = 0x09,
> +				.mask = GENMASK(3, 0),
> +			},
> +			[ST_LSM6DSX_ID_GYRO] = {
> +				.addr = 0x09,
> +				.mask = GENMASK(7, 4),
> +			},
> +		},
> +		.fifo_ops = {
> +			.read_fifo = st_lsm6dsx_read_tagged_fifo,
> +			.fifo_th = {
> +				.addr = 0x07,
> +				.mask = GENMASK(8, 0),
> +			},
> +			.fifo_diff = {
> +				.addr = 0x3a,
> +				.mask = GENMASK(8, 0),
> +			},
> +			.th_wl = 1,
> +		},
> +		.ts_settings = {
> +			.timer_en = {
> +				.addr = 0x19,
> +				.mask = BIT(5),
> +			},
> +			.decimator = {
> +				.addr = 0x0a,
> +				.mask = GENMASK(7, 6),
> +			},
> +		},
> +	},
>  };
>  
>  #define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 377c4e9997da..448b7bc1e578 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -61,6 +61,10 @@ static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
>  		.compatible = "st,ism330dlc",
>  		.data = (void *)ST_ISM330DLC_ID,
>  	},
> +	{
> +		.compatible = "st,lsm6dso",
> +		.data = (void *)ST_LSM6DSO_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_i2c_of_match);
> @@ -71,6 +75,7 @@ static const struct i2c_device_id st_lsm6dsx_i2c_id_table[] = {
>  	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
>  	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
>  	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
> +	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_lsm6dsx_i2c_id_table);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index fec5c6ce7eb7..b1df8a6973e6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -61,6 +61,10 @@ static const struct of_device_id st_lsm6dsx_spi_of_match[] = {
>  		.compatible = "st,ism330dlc",
>  		.data = (void *)ST_ISM330DLC_ID,
>  	},
> +	{
> +		.compatible = "st,lsm6dso",
> +		.data = (void *)ST_LSM6DSO_ID,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_lsm6dsx_spi_of_match);
> @@ -71,6 +75,7 @@ static const struct spi_device_id st_lsm6dsx_spi_id_table[] = {
>  	{ ST_LSM6DSL_DEV_NAME, ST_LSM6DSL_ID },
>  	{ ST_LSM6DSM_DEV_NAME, ST_LSM6DSM_ID },
>  	{ ST_ISM330DLC_DEV_NAME, ST_ISM330DLC_ID },
> +	{ ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_lsm6dsx_spi_id_table);
