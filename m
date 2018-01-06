Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeAFMUb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:20:31 -0500
Date: Sat, 6 Jan 2018 12:20:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: add regmap API support
Message-ID: <20180106122027.35e49ea1@archlinux>
In-Reply-To: <20180101185444.22045-4-lorenzo.bianconi@redhat.com>
References: <20180101185444.22045-4-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  1 Jan 2018 19:54:44 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Introduce regmap API support to access to i2c/spi bus instead of
> using a custom support. Set max bulk read to
> (32 / SAMPLE_SIZE) * SAMPLE_SIZE since spi_write_then_read() used in
> regmap_spi indicates that is the max buffer length to use in order to
> avoid a kmalloc for each bus access.
> Remove lock mutex since concurrency is already managed by regmap API
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

There are a couple of sparse warnings unconnected to this patch that I'd
love it if you would clean up:

  CHECK   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:250:17: warning: Variable length array is used.
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:283:55: error: cannot size expression

I would fix that one by just making the array the maximum size it ever needs to
be.

On the FIELD_PREP not working unless mask is available at compile time,
I wonder if a bit of macro magic would allow us to fall back transparently
to a version that works at runtime if the compiler can't figure out the
mask.

Would make it more generally useful but would need a lot of care.

Otherwise looks good to me.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig             |   2 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h        |  31 ++------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c |  81 ++++++++++++-------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c   | 103 ++++++++++---------------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c    |  55 ++++---------
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c    |  70 ++++-------------
>  6 files changed, 131 insertions(+), 211 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index e57337159b57..14f2eb6e9fb7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -16,7 +16,9 @@ config IIO_ST_LSM6DSX
>  config IIO_ST_LSM6DSX_I2C
>  	tristate
>  	depends on IIO_ST_LSM6DSX
> +	select REGMAP_I2C
>  
>  config IIO_ST_LSM6DSX_SPI
>  	tristate
>  	depends on IIO_ST_LSM6DSX
> +	select REGMAP_SPI
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index cebc6bd31b79..ccbe44cef41a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -29,21 +29,9 @@ enum st_lsm6dsx_hw_id {
>  
>  #define ST_LSM6DSX_CHAN_SIZE		2
>  #define ST_LSM6DSX_SAMPLE_SIZE		6
> -
> -#if defined(CONFIG_SPI_MASTER)
> -#define ST_LSM6DSX_RX_MAX_LENGTH	256
> -#define ST_LSM6DSX_TX_MAX_LENGTH	8
> -
> -struct st_lsm6dsx_transfer_buffer {
> -	u8 rx_buf[ST_LSM6DSX_RX_MAX_LENGTH];
> -	u8 tx_buf[ST_LSM6DSX_TX_MAX_LENGTH] ____cacheline_aligned;
> -};
> -#endif /* CONFIG_SPI_MASTER */
> -
> -struct st_lsm6dsx_transfer_function {
> -	int (*read)(struct device *dev, u8 addr, int len, u8 *data);
> -	int (*write)(struct device *dev, u8 addr, int len, u8 *data);
> -};
> +#define ST_LSM6DSX_MAX_WORD_LEN		((32 / ST_LSM6DSX_SAMPLE_SIZE) * \
> +					 ST_LSM6DSX_SAMPLE_SIZE)
> +#define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
>  
>  struct st_lsm6dsx_reg {
>  	u8 addr;
> @@ -127,8 +115,8 @@ struct st_lsm6dsx_sensor {
>  /**
>   * struct st_lsm6dsx_hw - ST IMU MEMS hw instance
>   * @dev: Pointer to instance of struct device (I2C or SPI).
> + * @regmap: Register map of the device.
>   * @irq: Device interrupt line (I2C or SPI).
> - * @lock: Mutex to protect read and write operations.
>   * @fifo_lock: Mutex to prevent concurrent access to the hw FIFO.
>   * @conf_lock: Mutex to prevent concurrent FIFO configuration update.
>   * @fifo_mode: FIFO operating mode supported by the device.
> @@ -136,14 +124,12 @@ struct st_lsm6dsx_sensor {
>   * @sip: Total number of samples (acc/gyro) in a given pattern.
>   * @iio_devs: Pointers to acc/gyro iio_dev instances.
>   * @settings: Pointer to the specific sensor settings in use.
> - * @tf: Transfer function structure used by I/O operations.
> - * @tb: Transfer buffers used by SPI I/O operations.
>   */
>  struct st_lsm6dsx_hw {
>  	struct device *dev;
> +	struct regmap *regmap;
>  	int irq;
>  
> -	struct mutex lock;
>  	struct mutex fifo_lock;
>  	struct mutex conf_lock;
>  
> @@ -154,17 +140,12 @@ struct st_lsm6dsx_hw {
>  	struct iio_dev *iio_devs[ST_LSM6DSX_ID_MAX];
>  
>  	const struct st_lsm6dsx_settings *settings;
> -
> -	const struct st_lsm6dsx_transfer_function *tf;
> -#if defined(CONFIG_SPI_MASTER)
> -	struct st_lsm6dsx_transfer_buffer tb;
> -#endif /* CONFIG_SPI_MASTER */
>  };
>  
>  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
>  
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
> -		     const struct st_lsm6dsx_transfer_function *tf_ops);
> +		     struct regmap *regmap);
>  int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor);
>  int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor);
>  int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw);
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index c899d658f6be..093f9750974a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -30,6 +30,8 @@
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/platform_data/st_sensors_pdata.h>
>  
> @@ -120,8 +122,10 @@ static int st_lsm6dsx_update_decimators(struct st_lsm6dsx_hw *hw)
>  
>  		dec_reg = &hw->settings->decimator[sensor->id];
>  		if (dec_reg->addr) {
> -			err = st_lsm6dsx_write_with_mask(hw, dec_reg->addr,
> -							 dec_reg->mask, data);
> +			int val = ST_LSM6DSX_SHIFT_VAL(data, dec_reg->mask);
> +
> +			err = regmap_update_bits(hw->regmap, dec_reg->addr,
> +						 dec_reg->mask, val);
>  			if (err < 0)
>  				return err;
>  		}
> @@ -137,8 +141,10 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  {
>  	int err;
>  
> -	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> -					 ST_LSM6DSX_FIFO_MODE_MASK, fifo_mode);
> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> +				 ST_LSM6DSX_FIFO_MODE_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_FIFO_MODE_MASK,
> +					    fifo_mode));
>  	if (err < 0)
>  		return err;
>  
> @@ -154,8 +160,9 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
>  	u8 data;
>  
>  	data = hw->enable_mask ? ST_LSM6DSX_MAX_FIFO_ODR_VAL : 0;
> -	return st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> -					  ST_LSM6DSX_FIFO_ODR_MASK, data);
> +	return regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_FIFO_MODE_ADDR,
> +				 ST_LSM6DSX_FIFO_ODR_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_FIFO_ODR_MASK, data));
>  }
>  
>  int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
> @@ -163,9 +170,8 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>  	u16 fifo_watermark = ~0, cur_watermark, sip = 0, fifo_th_mask;
>  	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	struct st_lsm6dsx_sensor *cur_sensor;
> +	int i, err, data;
>  	__le16 wdata;
> -	int i, err;
> -	u8 data;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
>  		cur_sensor = iio_priv(hw->iio_devs[i]);
> @@ -187,24 +193,42 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
>  	fifo_watermark = (fifo_watermark / sip) * sip;
>  	fifo_watermark = fifo_watermark * hw->settings->fifo_ops.th_wl;
>  
> -	mutex_lock(&hw->lock);
> -
> -	err = hw->tf->read(hw->dev, hw->settings->fifo_ops.fifo_th.addr + 1,
> -			   sizeof(data), &data);
> +	err = regmap_read(hw->regmap, hw->settings->fifo_ops.fifo_th.addr + 1,
> +			  &data);
>  	if (err < 0)
> -		goto out;
> +		return err;
>  
>  	fifo_th_mask = hw->settings->fifo_ops.fifo_th.mask;
>  	fifo_watermark = ((data << 8) & ~fifo_th_mask) |
>  			 (fifo_watermark & fifo_th_mask);
>  
>  	wdata = cpu_to_le16(fifo_watermark);
> -	err = hw->tf->write(hw->dev, hw->settings->fifo_ops.fifo_th.addr,
> -			    sizeof(wdata), (u8 *)&wdata);
> -out:
> -	mutex_unlock(&hw->lock);
> +	return regmap_bulk_write(hw->regmap,
> +				 hw->settings->fifo_ops.fifo_th.addr,
> +				 &wdata, sizeof(wdata));
> +}
>  
> -	return err < 0 ? err : 0;
> +/*
> + * Set max bulk read to ST_LSM6DSX_MAX_WORD_LEN in order to avoid
> + * a kmalloc for each bus access
> + */
> +static inline int st_lsm6dsx_read_block(struct st_lsm6dsx_hw *hw, u8 *data,
> +					unsigned int data_len)
> +{
> +	unsigned int word_len, read_len = 0;
> +	int err;
> +
> +	while (read_len < data_len) {
> +		word_len = min_t(unsigned int, data_len - read_len,
> +				 ST_LSM6DSX_MAX_WORD_LEN);
> +		err = regmap_bulk_read(hw->regmap,
> +				       ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
> +				       data + read_len, word_len);
> +		if (err < 0)
> +			return err;
> +		read_len += word_len;
> +	}
> +	return 0;
>  }
>  
>  /**
> @@ -226,8 +250,9 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  	u8 buff[pattern_len];
>  	__le16 fifo_status;
>  
> -	err = hw->tf->read(hw->dev, hw->settings->fifo_ops.fifo_diff.addr,
> -			   sizeof(fifo_status), (u8 *)&fifo_status);
> +	err = regmap_bulk_read(hw->regmap,
> +			       hw->settings->fifo_ops.fifo_diff.addr,
> +			       &fifo_status, sizeof(fifo_status));
>  	if (err < 0)
>  		return err;
>  
> @@ -255,8 +280,7 @@ static int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw)
>  				samples);
>  
>  	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
> -		err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_FIFO_OUTL_ADDR,
> -				   sizeof(buff), buff);
> +		err = st_lsm6dsx_read_block(hw, buff, sizeof(buff));
>  		if (err < 0)
>  			return err;
>  
> @@ -449,17 +473,20 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
>  		return -EINVAL;
>  	}
>  
> -	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_HLACTIVE_ADDR,
> -					 ST_LSM6DSX_REG_HLACTIVE_MASK,
> -					 irq_active_low);
> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_HLACTIVE_ADDR,
> +				 ST_LSM6DSX_REG_HLACTIVE_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_REG_HLACTIVE_MASK,
> +					    irq_active_low));
>  	if (err < 0)
>  		return err;
>  
>  	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
>  	if ((np && of_property_read_bool(np, "drive-open-drain")) ||
>  	    (pdata && pdata->open_drain)) {
> -		err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_PP_OD_ADDR,
> -						 ST_LSM6DSX_REG_PP_OD_MASK, 1);
> +		err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_PP_OD_ADDR,
> +					 ST_LSM6DSX_REG_PP_OD_MASK,
> +					 FIELD_PREP(ST_LSM6DSX_REG_PP_OD_MASK,
> +						    1));
>  		if (err < 0)
>  			return err;
>  
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 4d43c956d676..819a85bb86ec 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -37,6 +37,8 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/pm.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
>  
>  #include <linux/platform_data/st_sensors_pdata.h>
>  
> @@ -277,36 +279,9 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> -int st_lsm6dsx_write_with_mask(struct st_lsm6dsx_hw *hw, u8 addr, u8 mask,
> -			       u8 val)
> -{
> -	u8 data;
> -	int err;
> -
> -	mutex_lock(&hw->lock);
> -
> -	err = hw->tf->read(hw->dev, addr, sizeof(data), &data);
> -	if (err < 0) {
> -		dev_err(hw->dev, "failed to read %02x register\n", addr);
> -		goto out;
> -	}
> -
> -	data = (data & ~mask) | ((val << __ffs(mask)) & mask);
> -
> -	err = hw->tf->write(hw->dev, addr, sizeof(data), &data);
> -	if (err < 0)
> -		dev_err(hw->dev, "failed to write %02x register\n", addr);
> -
> -out:
> -	mutex_unlock(&hw->lock);
> -
> -	return err;
> -}
> -
>  static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
>  {
> -	int err, i, j;
> -	u8 data;
> +	int err, i, j, data;
>  
>  	for (i = 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>  		for (j = 0; j < ST_LSM6DSX_MAX_ID; j++) {
> @@ -322,8 +297,7 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
>  		return -ENODEV;
>  	}
>  
> -	err = hw->tf->read(hw->dev, ST_LSM6DSX_REG_WHOAMI_ADDR, sizeof(data),
> -			   &data);
> +	err = regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
>  	if (err < 0) {
>  		dev_err(hw->dev, "failed to read whoami register\n");
>  		return err;
> @@ -342,22 +316,22 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
>  static int st_lsm6dsx_set_full_scale(struct st_lsm6dsx_sensor *sensor,
>  				     u32 gain)
>  {
> -	enum st_lsm6dsx_sensor_id id = sensor->id;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_reg *reg;
>  	int i, err;
>  	u8 val;
>  
>  	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++)
> -		if (st_lsm6dsx_fs_table[id].fs_avl[i].gain == gain)
> +		if (st_lsm6dsx_fs_table[sensor->id].fs_avl[i].gain == gain)
>  			break;
>  
>  	if (i == ST_LSM6DSX_FS_LIST_SIZE)
>  		return -EINVAL;
>  
> -	val = st_lsm6dsx_fs_table[id].fs_avl[i].val;
> -	err = st_lsm6dsx_write_with_mask(sensor->hw,
> -					 st_lsm6dsx_fs_table[id].reg.addr,
> -					 st_lsm6dsx_fs_table[id].reg.mask,
> -					 val);
> +	val = st_lsm6dsx_fs_table[sensor->id].fs_avl[i].val;
> +	reg = &st_lsm6dsx_fs_table[sensor->id].reg;
> +	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +				 ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
>  	if (err < 0)
>  		return err;
>  
> @@ -385,7 +359,8 @@ static int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr,
>  
>  static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>  {
> -	enum st_lsm6dsx_sensor_id id = sensor->id;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_reg *reg;
>  	int err;
>  	u8 val;
>  
> @@ -393,10 +368,9 @@ static int st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>  	if (err < 0)
>  		return err;
>  
> -	return st_lsm6dsx_write_with_mask(sensor->hw,
> -					  st_lsm6dsx_odr_table[id].reg.addr,
> -					  st_lsm6dsx_odr_table[id].reg.mask,
> -					  val);
> +	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
> +	return regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +				  ST_LSM6DSX_SHIFT_VAL(val, reg->mask));
>  }
>  
>  int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
> @@ -414,16 +388,17 @@ int st_lsm6dsx_sensor_enable(struct st_lsm6dsx_sensor *sensor)
>  
>  int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor)
>  {
> -	enum st_lsm6dsx_sensor_id id = sensor->id;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	const struct st_lsm6dsx_reg *reg;
>  	int err;
>  
> -	err = st_lsm6dsx_write_with_mask(sensor->hw,
> -					 st_lsm6dsx_odr_table[id].reg.addr,
> -					 st_lsm6dsx_odr_table[id].reg.mask, 0);
> +	reg = &st_lsm6dsx_odr_table[sensor->id].reg;
> +	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +				 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
>  	if (err < 0)
>  		return err;
>  
> -	sensor->hw->enable_mask &= ~BIT(id);
> +	sensor->hw->enable_mask &= ~BIT(sensor->id);
>  
>  	return 0;
>  }
> @@ -431,6 +406,7 @@ int st_lsm6dsx_sensor_disable(struct st_lsm6dsx_sensor *sensor)
>  static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  				   u8 addr, int *val)
>  {
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
>  	int err, delay;
>  	__le16 data;
>  
> @@ -441,8 +417,7 @@ static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
>  	delay = 1000000 / sensor->odr;
>  	usleep_range(delay, 2 * delay);
>  
> -	err = sensor->hw->tf->read(sensor->hw->dev, addr, sizeof(data),
> -				   (u8 *)&data);
> +	err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
>  	if (err < 0)
>  		return err;
>  
> @@ -657,20 +632,20 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
>  
>  static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  {
> -	u8 data, drdy_int_reg;
> +	u8 drdy_int_reg;
>  	int err;
>  
> -	data = ST_LSM6DSX_REG_RESET_MASK;
> -	err = hw->tf->write(hw->dev, ST_LSM6DSX_REG_RESET_ADDR, sizeof(data),
> -			    &data);
> +	err = regmap_write(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> +			   ST_LSM6DSX_REG_RESET_MASK);
>  	if (err < 0)
>  		return err;
>  
>  	msleep(200);
>  
>  	/* enable Block Data Update */
> -	err = st_lsm6dsx_write_with_mask(hw, ST_LSM6DSX_REG_BDU_ADDR,
> -					 ST_LSM6DSX_REG_BDU_MASK, 1);
> +	err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_BDU_ADDR,
> +				 ST_LSM6DSX_REG_BDU_MASK,
> +				 FIELD_PREP(ST_LSM6DSX_REG_BDU_MASK, 1));
>  	if (err < 0)
>  		return err;
>  
> @@ -679,8 +654,10 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  	if (err < 0)
>  		return err;
>  
> -	return st_lsm6dsx_write_with_mask(hw, drdy_int_reg,
> -					  ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK, 1);
> +	return regmap_update_bits(hw->regmap, drdy_int_reg,
> +				  ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
> +				  FIELD_PREP(ST_LSM6DSX_REG_FIFO_FTH_IRQ_MASK,
> +					     1));
>  }
>  
>  static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
> @@ -731,7 +708,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  }
>  
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
> -		     const struct st_lsm6dsx_transfer_function *tf_ops)
> +		     struct regmap *regmap)
>  {
>  	struct st_lsm6dsx_hw *hw;
>  	int i, err;
> @@ -742,13 +719,12 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  
>  	dev_set_drvdata(dev, (void *)hw);
>  
> -	mutex_init(&hw->lock);
>  	mutex_init(&hw->fifo_lock);
>  	mutex_init(&hw->conf_lock);
>  
>  	hw->dev = dev;
>  	hw->irq = irq;
> -	hw->tf = tf_ops;
> +	hw->regmap = regmap;
>  
>  	err = st_lsm6dsx_check_whoami(hw, hw_id);
>  	if (err < 0)
> @@ -784,6 +760,7 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>  {
>  	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
>  	struct st_lsm6dsx_sensor *sensor;
> +	const struct st_lsm6dsx_reg *reg;
>  	int i, err = 0;
>  
>  	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
> @@ -791,9 +768,9 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
>  		if (!(hw->enable_mask & BIT(sensor->id)))
>  			continue;
>  
> -		err = st_lsm6dsx_write_with_mask(hw,
> -				st_lsm6dsx_odr_table[sensor->id].reg.addr,
> -				st_lsm6dsx_odr_table[sensor->id].reg.mask, 0);
> +		reg = &st_lsm6dsx_odr_table[sensor->id].reg;
> +		err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
> +					 ST_LSM6DSX_SHIFT_VAL(0, reg->mask));
>  		if (err < 0)
>  			return err;
>  	}
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> index 305fec712ab0..41525dd2aab7 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c
> @@ -14,55 +14,30 @@
>  #include <linux/i2c.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/regmap.h>
>  
>  #include "st_lsm6dsx.h"
>  
> -static int st_lsm6dsx_i2c_read(struct device *dev, u8 addr, int len, u8 *data)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct i2c_msg msg[2];
> -
> -	msg[0].addr = client->addr;
> -	msg[0].flags = client->flags;
> -	msg[0].len = 1;
> -	msg[0].buf = &addr;
> -
> -	msg[1].addr = client->addr;
> -	msg[1].flags = client->flags | I2C_M_RD;
> -	msg[1].len = len;
> -	msg[1].buf = data;
> -
> -	return i2c_transfer(client->adapter, msg, 2);
> -}
> -
> -static int st_lsm6dsx_i2c_write(struct device *dev, u8 addr, int len, u8 *data)
> -{
> -	struct i2c_client *client = to_i2c_client(dev);
> -	struct i2c_msg msg;
> -	u8 send[len + 1];
> -
> -	send[0] = addr;
> -	memcpy(&send[1], data, len * sizeof(u8));
> -
> -	msg.addr = client->addr;
> -	msg.flags = client->flags;
> -	msg.len = len + 1;
> -	msg.buf = send;
> -
> -	return i2c_transfer(client->adapter, &msg, 1);
> -}
> -
> -static const struct st_lsm6dsx_transfer_function st_lsm6dsx_transfer_fn = {
> -	.read = st_lsm6dsx_i2c_read,
> -	.write = st_lsm6dsx_i2c_write,
> +static const struct regmap_config st_lsm6dsx_i2c_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
>  };
>  
>  static int st_lsm6dsx_i2c_probe(struct i2c_client *client,
>  				const struct i2c_device_id *id)
>  {
> +	int hw_id = id->driver_data;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &st_lsm6dsx_i2c_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
>  	return st_lsm6dsx_probe(&client->dev, client->irq,
> -				(int)id->driver_data, id->name,
> -				&st_lsm6dsx_transfer_fn);
> +				hw_id, id->name, regmap);
>  }
>  
>  static const struct of_device_id st_lsm6dsx_i2c_of_match[] = {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> index 95472f153ad2..2c8135834479 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c
> @@ -14,72 +14,30 @@
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/of.h>
> +#include <linux/regmap.h>
>  
>  #include "st_lsm6dsx.h"
>  
> -#define SENSORS_SPI_READ	BIT(7)
> -
> -static int st_lsm6dsx_spi_read(struct device *dev, u8 addr, int len,
> -			       u8 *data)
> -{
> -	struct spi_device *spi = to_spi_device(dev);
> -	struct st_lsm6dsx_hw *hw = spi_get_drvdata(spi);
> -	int err;
> -
> -	struct spi_transfer xfers[] = {
> -		{
> -			.tx_buf = hw->tb.tx_buf,
> -			.bits_per_word = 8,
> -			.len = 1,
> -		},
> -		{
> -			.rx_buf = hw->tb.rx_buf,
> -			.bits_per_word = 8,
> -			.len = len,
> -		}
> -	};
> -
> -	hw->tb.tx_buf[0] = addr | SENSORS_SPI_READ;
> -
> -	err = spi_sync_transfer(spi, xfers,  ARRAY_SIZE(xfers));
> -	if (err < 0)
> -		return err;
> -
> -	memcpy(data, hw->tb.rx_buf, len * sizeof(u8));
> -
> -	return len;
> -}
> -
> -static int st_lsm6dsx_spi_write(struct device *dev, u8 addr, int len,
> -				u8 *data)
> -{
> -	struct st_lsm6dsx_hw *hw;
> -	struct spi_device *spi;
> -
> -	if (len >= ST_LSM6DSX_TX_MAX_LENGTH)
> -		return -ENOMEM;
> -
> -	spi = to_spi_device(dev);
> -	hw = spi_get_drvdata(spi);
> -
> -	hw->tb.tx_buf[0] = addr;
> -	memcpy(&hw->tb.tx_buf[1], data, len);
> -
> -	return spi_write(spi, hw->tb.tx_buf, len + 1);
> -}
> -
> -static const struct st_lsm6dsx_transfer_function st_lsm6dsx_transfer_fn = {
> -	.read = st_lsm6dsx_spi_read,
> -	.write = st_lsm6dsx_spi_write,
> +static const struct regmap_config st_lsm6dsx_spi_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
>  };
>  
>  static int st_lsm6dsx_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> +	int hw_id = id->driver_data;
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_spi(spi, &st_lsm6dsx_spi_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +			(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
>  
>  	return st_lsm6dsx_probe(&spi->dev, spi->irq,
> -				(int)id->driver_data, id->name,
> -				&st_lsm6dsx_transfer_fn);
> +				hw_id, id->name, regmap);
>  }
>  
>  static const struct of_device_id st_lsm6dsx_spi_of_match[] = {

