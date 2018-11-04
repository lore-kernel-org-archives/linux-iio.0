Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731320AbeKEC6S (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 4 Nov 2018 21:58:18 -0500
Date: Sun, 4 Nov 2018 17:42:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 5/7] iio: imu: st_lsm6dsx: add i2c embedded controller
 support
Message-ID: <20181104174228.7d0f6ad8@archlinux>
In-Reply-To: <2fa8688ae1ebc85f29b65c2439d9b7e298f305ae.1541341926.git.lorenzo.bianconi@redhat.com>
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
        <2fa8688ae1ebc85f29b65c2439d9b7e298f305ae.1541341926.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  4 Nov 2018 15:39:04 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> i2c controller embedded in lsm6dx series can connect up to four
> slave devices using accelerometer sensor as trigger for i2c
> read/write operations.
> Introduce sensor hub support for lsm6dso sensor. Add register map
> for lis2mdl magnetometer sensor
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

I'd completely forgotten how this driver did the multiple device registration
so this had me completely confused initially ;)

Perhaps just state here that the result is an entirely separate apparent device
and what it's functionality is at this point in the patch set?

A few minor comments inline.  This looks like it is coming together quite
nicely to me.

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/Makefile           |   3 +-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 112 +++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 135 ++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 677 ++++++++++++++++++
>  .../linux/platform_data/st_sensors_pdata.h    |   2 +
>  5 files changed, 886 insertions(+), 43 deletions(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
> index 35919febea2a..e5f733ce6e11 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> @@ -1,4 +1,5 @@
> -st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o
> +st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
> +		st_lsm6dsx_shub.o
>  
>  obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
>  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index 2beb4f563892..d20746eb3d2d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -43,6 +43,24 @@ enum st_lsm6dsx_hw_id {
>  					 * ST_LSM6DSX_TAGGED_SAMPLE_SIZE)
>  #define ST_LSM6DSX_SHIFT_VAL(val, mask)	(((val) << __ffs(mask)) & (mask))
>  
> +#define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
> +{									\
> +	.type = chan_type,						\
> +	.address = addr,						\
> +	.modified = 1,							\
> +	.channel2 = mod,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			      BIT(IIO_CHAN_INFO_SCALE),			\
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> +	.scan_index = scan_idx,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 16,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_LE,					\
> +	},								\
> +}
> +
>  struct st_lsm6dsx_reg {
>  	u8 addr;
>  	u8 mask;
> @@ -50,6 +68,28 @@ struct st_lsm6dsx_reg {
>  
>  struct st_lsm6dsx_hw;
>  
> +struct st_lsm6dsx_odr {
> +	u16 hz;
> +	u8 val;
> +};
> +
> +#define ST_LSM6DSX_ODR_LIST_SIZE	6
> +struct st_lsm6dsx_odr_table_entry {
> +	struct st_lsm6dsx_reg reg;
> +	struct st_lsm6dsx_odr odr_avl[ST_LSM6DSX_ODR_LIST_SIZE];
> +};
> +
> +struct st_lsm6dsx_fs {
> +	u32 gain;
> +	u8 val;
> +};
> +
> +#define ST_LSM6DSX_FS_LIST_SIZE		4
> +struct st_lsm6dsx_fs_table_entry {
> +	struct st_lsm6dsx_reg reg;
> +	struct st_lsm6dsx_fs fs_avl[ST_LSM6DSX_FS_LIST_SIZE];
> +};
> +
>  /**
>   * struct st_lsm6dsx_fifo_ops - ST IMU FIFO settings
>   * @read_fifo: Read FIFO callback.
> @@ -84,6 +124,66 @@ struct st_lsm6dsx_hw_ts_settings {
>  	struct st_lsm6dsx_reg decimator;
>  };
>  
> +/**
> + * struct st_lsm6dsx_shub_settings - ST IMU hw i2c controller settings
> + * @page_mux: register page mux info (addr + mask).
> + * @master_en: master config register info (addr + mask).
> + * @pullup_en: i2c controller pull-up register info (addr + mask).
> + * @aux_sens: aux sensor register info (addr + mask).
> + * @shub_out: sensor hub first output register info.
> + * @slv0_addr: slave0 address in secondary page.
> + * @dw_slv0_addr: slave0 write register address in secondary page.
> + */
> +struct st_lsm6dsx_shub_settings {
> +	struct st_lsm6dsx_reg page_mux;
> +	struct st_lsm6dsx_reg master_en;
> +	struct st_lsm6dsx_reg pullup_en;
> +	struct st_lsm6dsx_reg aux_sens;
> +	u8 shub_out;
> +	u8 slv0_addr;
> +	u8 dw_slv0_addr;
> +};
> +
> +enum st_lsm6dsx_ext_sensor_id {
> +	ST_LSM6DSX_ID_MAGN,
> +};
> +
> +/**
> + * struct st_lsm6dsx_ext_dev_settings - i2c controller slave settings
> + * @i2c_addr: I2c slave address list.
> + * @wai: Wai address info.
> + * @id: external sensor id.
> + * @odr: Output data rate of the sensor [Hz].
> + * @gain: Configured sensor sensitivity.
> + * @temp_comp: Temperature compensation register info (addr + mask).
> + * @pwr_table: Power on register info (addr + mask).
> + * @off_canc: Offset cancellation register info (addr + mask).
> + * @bdu: Block data update register info (addr + mask).
> + * @out: Output register info.
> + */
> +struct st_lsm6dsx_ext_dev_settings {
> +	u8 i2c_addr[2];
> +	struct {
> +		u8 addr;
> +		u8 val;
> +	} wai;
> +	enum st_lsm6dsx_ext_sensor_id id;
> +	struct st_lsm6dsx_odr_table_entry odr_table;
> +	struct st_lsm6dsx_fs_table_entry fs_table;
> +	struct st_lsm6dsx_reg temp_comp;
> +	struct {
> +		struct st_lsm6dsx_reg reg;
> +		u8 off_val;
> +		u8 on_val;
> +	} pwr_table;
> +	struct st_lsm6dsx_reg off_canc;
> +	struct st_lsm6dsx_reg bdu;
> +	struct {
> +		u8 addr;
> +		u8 len;
> +	} out;
> +};
> +
>  /**
>   * struct st_lsm6dsx_settings - ST IMU sensor settings
>   * @wai: Sensor WhoAmI default value.
> @@ -93,6 +193,7 @@ struct st_lsm6dsx_hw_ts_settings {
>   * @batch: List of FIFO batching register info (addr + mask).
>   * @fifo_ops: Sensor hw FIFO parameters.
>   * @ts_settings: Hw timer related settings.
> + * @shub_settings: i2c controller related settings.
>   */
>  struct st_lsm6dsx_settings {
>  	u8 wai;
> @@ -102,6 +203,7 @@ struct st_lsm6dsx_settings {
>  	struct st_lsm6dsx_reg batch[ST_LSM6DSX_MAX_ID];
>  	struct st_lsm6dsx_fifo_ops fifo_ops;
>  	struct st_lsm6dsx_hw_ts_settings ts_settings;
> +	struct st_lsm6dsx_shub_settings shub_settings;
>  };
>  
>  enum st_lsm6dsx_sensor_id {
> @@ -129,6 +231,7 @@ enum st_lsm6dsx_fifo_mode {
>   * @sip: Number of samples in a given pattern.
>   * @decimator: FIFO decimation factor.
>   * @ts_ref: Sensor timestamp reference for hw one.
> + * @ext_info: Sensor settings if it is connected to i2c controller
>   */
>  struct st_lsm6dsx_sensor {
>  	char name[32];
> @@ -142,6 +245,11 @@ struct st_lsm6dsx_sensor {
>  	u8 sip;
>  	u8 decimator;
>  	s64 ts_ref;
> +
> +	struct {
> +		const struct st_lsm6dsx_ext_dev_settings *settings;
> +		u8 addr;
> +	} ext_info;
>  };
>  
>  /**
> @@ -181,6 +289,7 @@ struct st_lsm6dsx_hw {
>  	const struct st_lsm6dsx_settings *settings;
>  };
>  
> +static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
>  extern const struct dev_pm_ops st_lsm6dsx_pm_ops;
>  
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
> @@ -197,6 +306,9 @@ int st_lsm6dsx_set_fifo_mode(struct st_lsm6dsx_hw *hw,
>  int st_lsm6dsx_read_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw);
>  int st_lsm6dsx_check_odr(struct st_lsm6dsx_sensor *sensor, u16 odr, u8 *val);
> +int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name);
> +int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable);
> +int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable);
>  
>  static inline int
>  st_lsm6dsx_update_bits_locked(struct st_lsm6dsx_hw *hw, unsigned int addr,
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index f2549ddfee20..463859f287da 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -88,17 +88,6 @@
>  #define ST_LSM6DSX_GYRO_FS_1000_GAIN		IIO_DEGREE_TO_RAD(35000)
>  #define ST_LSM6DSX_GYRO_FS_2000_GAIN		IIO_DEGREE_TO_RAD(70000)
>  
> -struct st_lsm6dsx_odr {
> -	u16 hz;
> -	u8 val;
> -};
> -
> -#define ST_LSM6DSX_ODR_LIST_SIZE	6
> -struct st_lsm6dsx_odr_table_entry {
> -	struct st_lsm6dsx_reg reg;
> -	struct st_lsm6dsx_odr odr_avl[ST_LSM6DSX_ODR_LIST_SIZE];
> -};
> -
>  static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>  	[ST_LSM6DSX_ID_ACC] = {
>  		.reg = {
> @@ -126,17 +115,6 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
>  	}
>  };
>  
> -struct st_lsm6dsx_fs {
> -	u32 gain;
> -	u8 val;
> -};
> -
> -#define ST_LSM6DSX_FS_LIST_SIZE		4
> -struct st_lsm6dsx_fs_table_entry {
> -	struct st_lsm6dsx_reg reg;
> -	struct st_lsm6dsx_fs fs_avl[ST_LSM6DSX_FS_LIST_SIZE];
> -};
> -
>  static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
>  	[ST_LSM6DSX_ID_ACC] = {
>  		.reg = {
> @@ -342,27 +320,30 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.mask = GENMASK(7, 6),
>  			},
>  		},
> +		.shub_settings = {
> +			.page_mux = {
> +				.addr = 0x01,
> +				.mask = BIT(6),
> +			},
> +			.master_en = {
> +				.addr = 0x14,
> +				.mask = BIT(2),
> +			},
> +			.pullup_en = {
> +				.addr = 0x14,
> +				.mask = BIT(3),
> +			},
> +			.aux_sens = {
> +				.addr = 0x14,
> +				.mask = GENMASK(1, 0),
> +			},
> +			.shub_out = 0x02,
> +			.slv0_addr = 0x15,
> +			.dw_slv0_addr = 0x21,
> +		}
>  	},
>  };
>  
> -#define ST_LSM6DSX_CHANNEL(chan_type, addr, mod, scan_idx)		\
> -{									\
> -	.type = chan_type,						\
> -	.address = addr,						\
> -	.modified = 1,							\
> -	.channel2 = mod,						\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> -			      BIT(IIO_CHAN_INFO_SCALE),			\
> -	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
> -	.scan_index = scan_idx,						\
> -	.scan_type = {							\
> -		.sign = 's',						\
> -		.realbits = 16,						\
> -		.storagebits = 16,					\
> -		.endianness = IIO_LE,					\
> -	},								\
> -}
> -
>  static const struct iio_chan_spec st_lsm6dsx_acc_channels[] = {
>  	ST_LSM6DSX_CHANNEL(IIO_ACCEL, ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR,
>  			   IIO_MOD_X, 0),
> @@ -383,6 +364,21 @@ static const struct iio_chan_spec st_lsm6dsx_gyro_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
>  };
>  
> +int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw, bool enable)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	unsigned int data;
> +	int err;
> +
> +	hub_settings = &hw->settings->shub_settings;
> +	data = ST_LSM6DSX_SHIFT_VAL(enable, hub_settings->page_mux.mask);
> +	err = regmap_update_bits(hw->regmap, hub_settings->page_mux.addr,
> +				 hub_settings->page_mux.mask, data);
> +	usleep_range(100, 150);
> +
> +	return err;
> +}
> +
>  static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id)
>  {
>  	int err, i, j, data;
> @@ -728,8 +724,6 @@ static const struct iio_info st_lsm6dsx_gyro_info = {
>  	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
>  };
>  
> -static const unsigned long st_lsm6dsx_available_scan_masks[] = {0x7, 0x0};
> -
>  static int st_lsm6dsx_of_get_drdy_pin(struct st_lsm6dsx_hw *hw, int *drdy_pin)
>  {
>  	struct device_node *np = hw->dev->of_node;
> @@ -768,6 +762,51 @@ static int st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw, u8 *drdy_reg)
>  	return err;
>  }
>  
> +static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	struct device_node *np = hw->dev->of_node;
> +	struct st_sensors_platform_data *pdata;
> +	unsigned int data;
> +	int err = 0;
> +
> +	hub_settings = &hw->settings->shub_settings;
> +
> +	pdata = (struct st_sensors_platform_data *)hw->dev->platform_data;
> +	if ((np && of_property_read_bool(np, "st,pullups")) ||
> +	    (pdata && pdata->pullups)) {
> +		err = st_lsm6dsx_set_page(hw, true);
> +		if (err < 0)
> +			return err;
> +
> +		data = ST_LSM6DSX_SHIFT_VAL(1, hub_settings->pullup_en.mask);
> +		err = regmap_update_bits(hw->regmap,
> +					 hub_settings->pullup_en.addr,
> +					 hub_settings->pullup_en.mask, data);
> +
> +		st_lsm6dsx_set_page(hw, false);
> +
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (hub_settings->aux_sens.addr) {
> +		/* configure aux sensors */
> +		err = st_lsm6dsx_set_page(hw, true);
> +		if (err < 0)
> +			return err;
> +
> +		data = ST_LSM6DSX_SHIFT_VAL(3, hub_settings->aux_sens.mask);
> +		err = regmap_update_bits(hw->regmap,
> +					 hub_settings->aux_sens.addr,
> +					 hub_settings->aux_sens.mask, data);
> +
> +		st_lsm6dsx_set_page(hw, false);
> +	}
> +
> +	return err;
> +}
> +
>  static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
>  {
>  	const struct st_lsm6dsx_hw_ts_settings *ts_settings;
> @@ -846,6 +885,10 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
>  	if (err < 0)
>  		return err;
>  
> +	err = st_lsm6dsx_init_shub(hw);
> +	if (err < 0)
> +		return err;
> +
>  	return st_lsm6dsx_init_hw_timer(hw);
>  }
>  
> @@ -899,6 +942,7 @@ static struct iio_dev *st_lsm6dsx_alloc_iiodev(struct st_lsm6dsx_hw *hw,
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  		     struct regmap *regmap)
>  {
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
>  	struct st_lsm6dsx_hw *hw;
>  	int i, err;
>  
> @@ -934,6 +978,13 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
>  	if (err < 0)
>  		return err;
>  
> +	hub_settings = &hw->settings->shub_settings;
> +	if (hub_settings->master_en.addr) {
> +		err = st_lsm6dsx_shub_probe(hw, name);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	if (hw->irq > 0) {
>  		err = st_lsm6dsx_fifo_setup(hw);
>  		if (err < 0)
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> new file mode 100644
> index 000000000000..b37f9dbdad17
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -0,0 +1,677 @@
> +/*
> + * STMicroelectronics st_lsm6dsx i2c controller driver
> + *
> + * i2c controller embedded in lsm6dx series can connect up to four
> + * slave devices using accelerometer sensor as trigger for i2c
> + * read/write operations. Current implementation use SLV0 for slave
> + * configuration and SLV{1,2,3} to read data and push them into the
> + * hw FIFO
> + *
> + * Copyright (C) 2018 Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> + *
> + * Permission to use, copy, modify, and/or distribute this software for any
> + * purpose with or without fee is hereby granted, provided that the above
> + * copyright notice and this permission notice appear in all copies.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
> + * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
> + * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
> + * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
> + * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
> + * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
> + * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
> + *
> + */
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/bitfield.h>
> +
> +#include "st_lsm6dsx.h"
> +
> +#define ST_LSM6DSX_MAX_SLV_NUM			3
> +#define ST_LSM6DSX_SLV_ADDR(n, base)		((base) + (n) * 3)
> +#define ST_LSM6DSX_SLV_SUB_ADDR(n, base)	((base) + 1 + (n) * 3)
> +#define ST_LSM6DSX_SLV_CONFIG(n, base)		((base) + 2 + (n) * 3)
> +
> +#define ST_LS6DSX_READ_OP_MASK			GENMASK(2, 0)
> +
> +static const struct st_lsm6dsx_ext_dev_settings st_lsm6dsx_ext_dev_table[] = {
> +	/* LIS2MDL */
> +	{
> +		.i2c_addr = { 0x1e },
> +		.wai = {
> +			.addr = 0x4f,
> +			.val = 0x40,
> +		},
> +		.id = ST_LSM6DSX_ID_MAGN,
> +		.odr_table = {
> +			.reg = {
> +				.addr = 0x60,
> +				.mask = GENMASK(3, 2),
> +			},
> +			.odr_avl[0] = {  10, 0x0 },
> +			.odr_avl[1] = {  20, 0x1 },
> +			.odr_avl[2] = {  50, 0x2 },
> +			.odr_avl[3] = { 100, 0x3 },
> +		},
> +		.fs_table = {
> +			.fs_avl[0] = {
> +				.gain = 1500,
> +				.val = 0x0,
> +			}, /* 1500 uG/LSB */
> +		},
> +		.temp_comp = {
> +			.addr = 0x60,
> +			.mask = BIT(7),
> +		},
> +		.pwr_table = {
> +			.reg = {
> +				.addr = 0x60,
> +				.mask = GENMASK(1, 0),
> +			},
> +			.off_val = 0x2,
> +			.on_val = 0x0,
> +		},
> +		.off_canc = {
> +			.addr = 0x61,
> +			.mask = BIT(1),
> +		},
> +		.bdu = {
> +			.addr = 0x62,
> +			.mask = BIT(4),
> +		},
> +		.out = {
> +			.addr = 0x68,
> +			.len = 6,
> +		},
> +	},
> +};
> +
> +static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
> +{
> +	struct st_lsm6dsx_sensor *sensor;
> +
> +	sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +	msleep((2000U / sensor->odr) + 1);
> +}
> +
> +/**
> + * st_lsm6dsx_shub_read_reg - read i2c controller register
> + *
> + * Read st_lsm6dsx i2c controller register
> + */
> +static int st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 addr,
> +				    u8 *data, int len)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	int err;
> +
> +	mutex_lock(&hw->page_lock);
> +
> +	hub_settings = &hw->settings->shub_settings;
> +	err = st_lsm6dsx_set_page(hw, true);
> +	if (err < 0)
> +		goto out;
> +
> +	err = regmap_bulk_read(hw->regmap, addr, data, len);
> +
> +	st_lsm6dsx_set_page(hw, false);
> +out:
> +	mutex_unlock(&hw->page_lock);
> +
> +	return err;
> +}
> +
> +/**
> + * st_lsm6dsx_shub_write_reg - write i2c controller register
> + *
> + * Write st_lsm6dsx i2c controller register
> + */
> +static int st_lsm6dsx_shub_write_reg(struct st_lsm6dsx_hw *hw, u8 addr,
> +				     u8 *data, int len)
> +{
> +	int err;
> +
> +	mutex_lock(&hw->page_lock);
> +	err = st_lsm6dsx_set_page(hw, true);
> +	if (err < 0)
> +		goto out;
> +
> +	err = regmap_bulk_write(hw->regmap, addr, data, len);
> +
> +	st_lsm6dsx_set_page(hw, false);
> +out:
> +	mutex_unlock(&hw->page_lock);
> +
> +	return err;
> +}
> +
> +static int st_lsm6dsx_shub_master_enable(struct st_lsm6dsx_sensor *sensor,
> +					 bool enable)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	unsigned int data;
> +	int err;
> +
> +	/* enable acc sensor as trigger */
> +	err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> +	if (err < 0)
> +		return err;
> +
> +	mutex_lock(&hw->page_lock);
> +
> +	hub_settings = &hw->settings->shub_settings;
> +	err = st_lsm6dsx_set_page(hw, true);
> +	if (err < 0)
> +		goto out;
> +
> +	data = ST_LSM6DSX_SHIFT_VAL(enable, hub_settings->master_en.mask);
> +	err = regmap_update_bits(hw->regmap, hub_settings->master_en.addr,
> +				 hub_settings->master_en.mask, data);
> +
> +	st_lsm6dsx_set_page(hw, false);
> +out:
> +	mutex_unlock(&hw->page_lock);
> +
> +	return err;
> +}
> +
> +/**
> + * st_lsm6dsx_shub_read - read data from slave device register
> + *
> + * Read data from slave device register. SLV0 is used for
> + * one-shot read operation
> + */
> +static int
> +st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sensor, u8 addr,
> +		     u8 *data, int len)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	u8 config[3], slv_addr;
> +	int err;
> +
> +	hub_settings = &hw->settings->shub_settings;
> +	slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
> +
> +	config[0] = (sensor->ext_info.addr << 1) | 1;
> +	config[1] = addr;
> +	config[2] = len & ST_LS6DSX_READ_OP_MASK;
> +
> +	err = st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> +					sizeof(config));
> +	if (err < 0)
> +		return err;
> +
> +	err = st_lsm6dsx_shub_master_enable(sensor, true);
> +	if (err < 0)
> +		return err;
> +
> +	st_lsm6dsx_shub_wait_complete(hw);
> +
> +	err = st_lsm6dsx_shub_read_reg(hw, hub_settings->shub_out, data,
> +				       len & ST_LS6DSX_READ_OP_MASK);
> +
> +	st_lsm6dsx_shub_master_enable(sensor, false);
> +
> +	memset(config, 0, sizeof(config));
> +	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> +					 sizeof(config));
> +}
> +
> +/**
> + * st_lsm6dsx_shub_write - write data to slave device register
> + *
> + * Write data from slave device register. SLV0 is used for
> + * one-shot write operation
> + */
> +static int
> +st_lsm6dsx_shub_write(struct st_lsm6dsx_sensor *sensor, u8 addr,
> +		      u8 *data, int len)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	u8 config[2], slv_addr;
> +	int err, i;
> +
> +	hub_settings = &hw->settings->shub_settings;
> +	slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
> +	config[0] = sensor->ext_info.addr << 1;
> +	for (i = 0 ; i < len; i++) {
> +		config[1] = addr + i;
> +
> +		err = st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> +						sizeof(config));
> +		if (err < 0)
> +			return err;
> +
> +		err = st_lsm6dsx_shub_write_reg(hw, hub_settings->dw_slv0_addr,
> +						&data[i], 1);
> +		if (err < 0)
> +			return err;
> +
> +		err = st_lsm6dsx_shub_master_enable(sensor, true);
> +		if (err < 0)
> +			return err;
> +
> +		st_lsm6dsx_shub_wait_complete(hw);
> +
> +		st_lsm6dsx_shub_master_enable(sensor, false);
> +	}
> +
> +	memset(config, 0, sizeof(config));
> +	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config, sizeof(config));
> +}
> +
> +static int
> +st_lsm6dsx_shub_write_with_mask(struct st_lsm6dsx_sensor *sensor,
> +				u8 addr, u8 mask, u8 val)
> +{
> +	int err;
> +	u8 data;
> +
> +	err = st_lsm6dsx_shub_read(sensor, addr, &data, sizeof(data));
> +	if (err < 0)
> +		return err;
> +
> +	data = ((data & ~mask) | (val << __ffs(mask) & mask));
> +
> +	return st_lsm6dsx_shub_write(sensor, addr, &data, sizeof(data));
> +}
> +
> +static int
> +st_lsm6dsx_shub_get_odr_val(struct st_lsm6dsx_sensor *sensor,
> +			    u16 odr, u16 *val)
> +{
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	int i;
> +
> +	settings = sensor->ext_info.settings;
> +	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++)
> +		if (settings->odr_table.odr_avl[i].hz == odr)
> +			break;
> +
> +	if (i == ST_LSM6DSX_ODR_LIST_SIZE)
> +		return -EINVAL;
> +
> +	*val = settings->odr_table.odr_avl[i].val;
> +	return 0;
> +}
> +
> +static int
> +st_lsm6dsx_shub_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
> +{
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	u16 val;
> +	int err;
> +
> +	err = st_lsm6dsx_shub_get_odr_val(sensor, odr, &val);
> +	if (err < 0)
> +		return err;
> +
> +	settings = sensor->ext_info.settings;
> +	return st_lsm6dsx_shub_write_with_mask(sensor,
> +					       settings->odr_table.reg.addr,
> +					       settings->odr_table.reg.mask,
> +					       val);
> +}
> +
> +int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
> +{
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	int err;
> +
> +	settings = sensor->ext_info.settings;
> +	if (enable) {
> +		err = st_lsm6dsx_shub_set_odr(sensor, sensor->odr);
> +		if (err < 0)
> +			return err;
> +	} else {
> +		err = st_lsm6dsx_shub_write_with_mask(sensor,
> +					settings->odr_table.reg.addr,
> +					settings->odr_table.reg.mask, 0);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (settings->pwr_table.reg.addr) {
> +		u8 val;
> +
> +		val = enable ? settings->pwr_table.on_val
> +			     : settings->pwr_table.off_val;
> +		err = st_lsm6dsx_shub_write_with_mask(sensor,
> +					settings->pwr_table.reg.addr,
> +					settings->pwr_table.reg.mask, val);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	return st_lsm6dsx_shub_master_enable(sensor, enable);
> +}
> +
> +static int
> +st_lsm6dsx_shub_read_oneshot(struct st_lsm6dsx_sensor *sensor,
> +			     struct iio_chan_spec const *ch,
> +			     int *val)
> +{
> +	int err, delay, len = ch->scan_type.realbits >> 3;
> +	__le32 data;
> +
> +	err = st_lsm6dsx_shub_set_enable(sensor, true);
> +	if (err < 0)
> +		return err;
> +
> +	delay = 1000000 / sensor->odr;
> +	usleep_range(delay, 2 * delay);
> +
> +	err = st_lsm6dsx_shub_read(sensor, ch->address, (u8 *)&data, len);
> +	if (err < 0)
> +		return err;
> +
> +	st_lsm6dsx_shub_set_enable(sensor, false);
> +
> +	switch (len) {
> +	case 2:
> +		*val = (s16)le16_to_cpu(data);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int
> +st_lsm6dsx_shub_read_raw(struct iio_dev *iio_dev,
> +			 struct iio_chan_spec const *ch,
> +			 int *val, int *val2, long mask)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = iio_device_claim_direct_mode(iio_dev);
> +		if (ret)
> +			break;
> +
> +		ret = st_lsm6dsx_shub_read_oneshot(sensor, ch, val);
> +		iio_device_release_direct_mode(iio_dev);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = sensor->odr;
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 0;
> +		*val2 = sensor->gain;
> +		ret = IIO_VAL_INT_PLUS_MICRO;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int
> +st_lsm6dsx_shub_write_raw(struct iio_dev *iio_dev,
> +			  struct iio_chan_spec const *chan,
> +			  int val, int val2, long mask)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
> +	int err;
> +
> +	err = iio_device_claim_direct_mode(iio_dev);
> +	if (err)
> +		return err;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		u16 data;
> +
> +		err = st_lsm6dsx_shub_get_odr_val(sensor, val, &data);
> +		if (!err)
> +			sensor->odr = val;
> +		break;
> +	}
> +	default:
> +		err = -EINVAL;
> +		break;
> +	}
> +
> +	iio_device_release_direct_mode(iio_dev);
> +
> +	return err;
> +}
> +
> +static ssize_t
> +st_lsm6dsx_shub_sampling_freq_avail(struct device *dev,
> +				    struct device_attribute *attr,
> +				    char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	int i, len = 0;
> +
> +	settings = sensor->ext_info.settings;
> +	for (i = 0; i < ST_LSM6DSX_ODR_LIST_SIZE; i++) {
> +		u16 val = settings->odr_table.odr_avl[i].hz;
> +
> +		if (val > 0)
> +			len += scnprintf(buf + len, PAGE_SIZE - len, "%d ",
> +					 val);
> +	}
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static ssize_t st_lsm6dsx_shub_scale_avail(struct device *dev,
> +					   struct device_attribute *attr,
> +					   char *buf)
> +{
> +	struct st_lsm6dsx_sensor *sensor = iio_priv(dev_get_drvdata(dev));
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	int i, len = 0;
> +
> +	settings = sensor->ext_info.settings;
> +	for (i = 0; i < ST_LSM6DSX_FS_LIST_SIZE; i++) {
> +		u16 val = settings->fs_table.fs_avl[i].gain;
> +
> +		if (val > 0)
> +			len += scnprintf(buf + len, PAGE_SIZE - len, "0.%06u ",
> +					 val);
> +	}
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(st_lsm6dsx_shub_sampling_freq_avail);
> +static IIO_DEVICE_ATTR(in_ext_scale_available, 0444,
> +		       st_lsm6dsx_shub_scale_avail, NULL, 0);
> +static struct attribute *st_lsm6dsx_ext_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	&iio_dev_attr_in_ext_scale_available.dev_attr.attr,

What's this abi element?

> +	NULL,
> +};
> +
> +static const struct attribute_group st_lsm6dsx_ext_attribute_group = {
> +	.attrs = st_lsm6dsx_ext_attributes,
> +};
> +
> +static const struct iio_info st_lsm6dsx_ext_info = {
> +	.attrs = &st_lsm6dsx_ext_attribute_group,
> +	.read_raw = st_lsm6dsx_shub_read_raw,
> +	.write_raw = st_lsm6dsx_shub_write_raw,
> +	.hwfifo_set_watermark = st_lsm6dsx_set_watermark,
> +};
> +
> +static struct iio_dev *
> +st_lsm6dsx_shub_alloc_iiodev(struct st_lsm6dsx_hw *hw,
> +			     enum st_lsm6dsx_sensor_id id,
> +			     const struct st_lsm6dsx_ext_dev_settings *info,
> +			     u8 i2c_addr, const char *name)
> +{
> +	struct iio_chan_spec *ext_channels;
> +	struct st_lsm6dsx_sensor *sensor;
> +	struct iio_dev *iio_dev;
> +
> +	iio_dev = devm_iio_device_alloc(hw->dev, sizeof(*sensor));
> +	if (!iio_dev)
> +		return NULL;
> +
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->dev.parent = hw->dev;
> +	iio_dev->info = &st_lsm6dsx_ext_info;
> +
> +	sensor = iio_priv(iio_dev);
> +	sensor->id = id;
> +	sensor->hw = hw;
> +	sensor->odr = info->odr_table.odr_avl[0].hz;
> +	sensor->gain = info->fs_table.fs_avl[0].gain;
> +	sensor->ext_info.settings = info;
> +	sensor->ext_info.addr = i2c_addr;
> +	sensor->watermark = 1;
> +
> +	switch (info->id) {
> +	case ST_LSM6DSX_ID_MAGN: {
> +		const struct iio_chan_spec magn_channels[] = {
> +			ST_LSM6DSX_CHANNEL(IIO_MAGN, info->out.addr,
> +					   IIO_MOD_X, 0),
> +			ST_LSM6DSX_CHANNEL(IIO_MAGN, info->out.addr + 2,
> +					   IIO_MOD_Y, 1),
> +			ST_LSM6DSX_CHANNEL(IIO_MAGN, info->out.addr + 4,
> +					   IIO_MOD_Z, 2),
> +			IIO_CHAN_SOFT_TIMESTAMP(3),
> +		};
> +
> +		ext_channels = devm_kzalloc(hw->dev, sizeof(magn_channels),
> +					    GFP_KERNEL);
> +		if (!ext_channels)
> +			return NULL;
> +
> +		memcpy(ext_channels, magn_channels, sizeof(magn_channels));
> +		iio_dev->available_scan_masks = st_lsm6dsx_available_scan_masks;
> +		iio_dev->channels = ext_channels;
> +		iio_dev->num_channels = ARRAY_SIZE(magn_channels);
> +
> +		scnprintf(sensor->name, sizeof(sensor->name), "%s_magn",
> +			  name);
> +		break;
> +	}
> +	default:
> +		return NULL;
> +	}
> +	iio_dev->name = sensor->name;
> +
> +	return iio_dev;
> +}
> +
> +static int st_lsm6dsx_shub_init_device(struct st_lsm6dsx_sensor *sensor)
> +{
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	int err = 0;
> +
> +	settings = sensor->ext_info.settings;
> +	if (settings->bdu.addr) {
> +		err = st_lsm6dsx_shub_write_with_mask(sensor,
> +						      settings->bdu.addr,
> +						      settings->bdu.mask, 1);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (settings->temp_comp.addr) {
> +		err = st_lsm6dsx_shub_write_with_mask(sensor,
> +					settings->temp_comp.addr,
> +					settings->temp_comp.mask, 1);
> +		if (err < 0)
> +			return err;
> +	}
> +
> +	if (settings->off_canc.addr)
> +		err = st_lsm6dsx_shub_write_with_mask(sensor,
> +					settings->off_canc.addr,
> +					settings->off_canc.mask, 1);
Return directly from this last command and return 0 perhaps below?

That drops the need to initialize err as well.

Doesn't matter though if you prefer it this way!
> +
> +	return err;
> +}
> +
> +int st_lsm6dsx_shub_probe(struct st_lsm6dsx_hw *hw, const char *name)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	enum st_lsm6dsx_sensor_id id = ST_LSM6DSX_ID_EXT0;
> +	struct st_lsm6dsx_sensor *acc_sensor, *sensor;
> +	int err, i, j, num_ext_dev = 0;
> +	u8 config[3], data, slv_addr;
> +
> +	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> +	hub_settings = &hw->settings->shub_settings;
> +	slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
> +
> +	while (i < ARRAY_SIZE(st_lsm6dsx_ext_dev_table) &&
> +	       num_ext_dev < ST_LSM6DSX_MAX_SLV_NUM) {
> +		settings = &st_lsm6dsx_ext_dev_table[i];
Might be better as a for loop as then you'll have the loop
increment nice and obvious up here. Perhaps just break separately
for the num_ext_dev rather than having it as the loop condition?


> +
> +		for (j = 0; j < ARRAY_SIZE(settings->i2c_addr); j++) {
This is getting very deeply nested and perhaps worth pulling out to a utility
function?  I haven't checked just how many parameters that would have
though so perhaps not...

Could also reduce the scope of a few variables such as config by
pulling it in the for loop I think.

> +			if (!settings->i2c_addr[j])
> +				continue;
> +
> +			/* read wai slave register */
> +			config[0] = (settings->i2c_addr[j] << 1) | 0x1;
> +			config[1] = settings->wai.addr;
> +			config[2] = 0x1;
> +
> +			err = st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> +							sizeof(config));
> +			if (err < 0)
> +				return err;
> +
> +			err = st_lsm6dsx_shub_master_enable(acc_sensor, true);
> +			if (err < 0)
> +				return err;
> +
> +			st_lsm6dsx_shub_wait_complete(hw);
> +
> +			err = st_lsm6dsx_shub_read_reg(hw,
> +						       hub_settings->shub_out,
> +						       &data, sizeof(data));
> +
> +			st_lsm6dsx_shub_master_enable(acc_sensor, false);
> +
> +			if (err < 0)
> +				return err;
> +
> +			if (data != settings->wai.val)
> +				continue;
> +
> +			hw->iio_devs[id] = st_lsm6dsx_shub_alloc_iiodev(hw,
> +							id, settings,
> +							settings->i2c_addr[j],
> +							name);
> +			if (!hw->iio_devs[id])
> +				return -ENOMEM;
> +
> +			sensor = iio_priv(hw->iio_devs[id]);
> +			err = st_lsm6dsx_shub_init_device(sensor);
> +			if (err < 0)
> +				return err;
> +
> +			num_ext_dev++;
> +			id++;
> +			break;
> +		}
> +		i++;
> +	}
> +
> +	memset(config, 0, sizeof(config));
> +	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> +					 sizeof(config));
> +}
> diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
> index f8274b0c6888..728193111c2f 100644
> --- a/include/linux/platform_data/st_sensors_pdata.h
> +++ b/include/linux/platform_data/st_sensors_pdata.h
> @@ -18,11 +18,13 @@
>   *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
>   * @open_drain: set the interrupt line to be open drain if possible.
>   * @spi_3wire: enable spi-3wire mode.
> + * @pullups: enable/disable i2c controller pullup resistors.
>   */
>  struct st_sensors_platform_data {
>  	u8 drdy_int_pin;
>  	bool open_drain;
>  	bool spi_3wire;
> +	bool pullups;
>  };
>  
>  #endif /* ST_SENSORS_PDATA_H */
