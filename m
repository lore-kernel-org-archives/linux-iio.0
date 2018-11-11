Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729193AbeKLCdC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:33:02 -0500
Date: Sun, 11 Nov 2018 16:43:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 8/9] iio: imu: st_lsm6dsx: add hw FIFO support to i2c
 controller
Message-ID: <20181111164357.035c3d1b@archlinux>
In-Reply-To: <469ad1943950ca63adfa680fd5e7cb5a414ea15c.1541945612.git.lorenzo.bianconi@redhat.com>
References: <cover.1541945612.git.lorenzo.bianconi@redhat.com>
        <469ad1943950ca63adfa680fd5e7cb5a414ea15c.1541945612.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 11 Nov 2018 15:15:35 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Introduce hw FIFO support to lsm6dsx i2c controller.
> st_lsm6dsx sensor-hub relies on SLV0 for slave configuration since SLV0
> is the only channel that can be used to write into i2c slave devices.
> SLV{1,2,3} channels are used to read external data and push them into
> the hw FIFO
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  4 +
>  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 47 ++++++++++--
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  5 ++
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 75 +++++++++++++++++++
>  4 files changed, 125 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> index d20746eb3d2d..d1d8d07a0714 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> @@ -130,18 +130,22 @@ struct st_lsm6dsx_hw_ts_settings {
>   * @master_en: master config register info (addr + mask).
>   * @pullup_en: i2c controller pull-up register info (addr + mask).
>   * @aux_sens: aux sensor register info (addr + mask).
> + * @wr_once: write_once register info (addr + mask).
>   * @shub_out: sensor hub first output register info.
>   * @slv0_addr: slave0 address in secondary page.
>   * @dw_slv0_addr: slave0 write register address in secondary page.
> + * @batch_en: Enable/disable FIFO batching.
>   */
>  struct st_lsm6dsx_shub_settings {
>  	struct st_lsm6dsx_reg page_mux;
>  	struct st_lsm6dsx_reg master_en;
>  	struct st_lsm6dsx_reg pullup_en;
>  	struct st_lsm6dsx_reg aux_sens;
> +	struct st_lsm6dsx_reg wr_once;
>  	u8 shub_out;
>  	u8 slv0_addr;
>  	u8 dw_slv0_addr;
> +	u8 batch_en;
>  };
>  
>  enum st_lsm6dsx_ext_sensor_id {
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> index 4e7ff370cbe0..2c0d3763405a 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
> @@ -68,6 +68,9 @@ enum st_lsm6dsx_fifo_tag {
>  	ST_LSM6DSX_GYRO_TAG = 0x01,
>  	ST_LSM6DSX_ACC_TAG = 0x02,
>  	ST_LSM6DSX_TS_TAG = 0x04,
> +	ST_LSM6DSX_EXT0_TAG = 0x0f,
> +	ST_LSM6DSX_EXT1_TAG = 0x10,
> +	ST_LSM6DSX_EXT2_TAG = 0x11,
>  };
>  
>  static const
> @@ -460,6 +463,12 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
>  	struct st_lsm6dsx_sensor *sensor;
>  	struct iio_dev *iio_dev;
>  
> +	/*
> +	 * EXT_TAG are managed in FIFO fashion so ST_LSM6DSX_EXT0_TAG
> +	 * corresponds to the first enabled channel, ST_LSM6DSX_EXT1_TAG
> +	 * to the second one and ST_LSM6DSX_EXT2_TAG to the last enabled
> +	 * channel
> +	 */
>  	switch (tag) {
>  	case ST_LSM6DSX_GYRO_TAG:
>  		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_GYRO];
> @@ -467,6 +476,24 @@ st_lsm6dsx_push_tagged_data(struct st_lsm6dsx_hw *hw, u8 tag,
>  	case ST_LSM6DSX_ACC_TAG:
>  		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_ACC];
>  		break;
> +	case ST_LSM6DSX_EXT0_TAG:
> +		if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT0))
> +			iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT0];
> +		else if (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT1))
> +			iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT1];
> +		else
> +			iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> +		break;
> +	case ST_LSM6DSX_EXT1_TAG:
> +		if ((hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT0)) &&
> +		    (hw->enable_mask & BIT(ST_LSM6DSX_ID_EXT1)))
> +			iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT1];
> +		else
> +			iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> +		break;
> +	case ST_LSM6DSX_EXT2_TAG:
> +		iio_dev = hw->iio_devs[ST_LSM6DSX_ID_EXT2];
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -593,13 +620,21 @@ static int st_lsm6dsx_update_fifo(struct iio_dev *iio_dev, bool enable)
>  			goto out;
>  	}
>  
> -	err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> -	if (err < 0)
> -		goto out;
> +	if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
> +	    sensor->id == ST_LSM6DSX_ID_EXT1 ||
> +	    sensor->id == ST_LSM6DSX_ID_EXT2) {
> +		err = st_lsm6dsx_shub_set_enable(sensor, enable);
> +		if (err < 0)
> +			goto out;
> +	} else {
> +		err = st_lsm6dsx_sensor_set_enable(sensor, enable);
> +		if (err < 0)
> +			goto out;
>  
> -	err = st_lsm6dsx_set_fifo_odr(sensor, enable);
> -	if (err < 0)
> -		goto out;
> +		err = st_lsm6dsx_set_fifo_odr(sensor, enable);
> +		if (err < 0)
> +			goto out;
> +	}
>  
>  	err = st_lsm6dsx_update_decimators(hw);
>  	if (err < 0)
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 149080acd859..12e29dda9b98 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -337,9 +337,14 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  				.addr = 0x14,
>  				.mask = GENMASK(1, 0),
>  			},
> +			.wr_once = {
> +				.addr = 0x14,
> +				.mask = BIT(6),
> +			},
>  			.shub_out = 0x02,
>  			.slv0_addr = 0x15,
>  			.dw_slv0_addr = 0x21,
> +			.batch_en = BIT(3),
>  		}
>  	},
>  };
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> index d6c5ffe9b556..016ae9016c50 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> @@ -148,6 +148,26 @@ static int st_lsm6dsx_shub_write_reg(struct st_lsm6dsx_hw *hw, u8 addr,
>  	return err;
>  }
>  
> +static int
> +st_lsm6dsx_shub_write_reg_with_mask(struct st_lsm6dsx_hw *hw, u8 addr,
> +				    u8 mask, u8 val)
> +{
> +	int err;
> +
> +	mutex_lock(&hw->page_lock);
> +	err = st_lsm6dsx_set_page(hw, true);
> +	if (err < 0)
> +		goto out;
> +
> +	err = regmap_update_bits(hw->regmap, addr, mask, val);
> +
> +	st_lsm6dsx_set_page(hw, false);
> +out:
> +	mutex_unlock(&hw->page_lock);
> +
> +	return err;
> +}
> +
>  static int st_lsm6dsx_shub_master_enable(struct st_lsm6dsx_sensor *sensor,
>  					 bool enable)
>  {
> @@ -238,6 +258,18 @@ st_lsm6dsx_shub_write(struct st_lsm6dsx_sensor *sensor, u8 addr,
>  	int err, i;
>  
>  	hub_settings = &hw->settings->shub_settings;
> +	if (hub_settings->wr_once.addr) {
> +		unsigned int data;
> +
> +		data = ST_LSM6DSX_SHIFT_VAL(1, hub_settings->wr_once.mask);
> +		err = st_lsm6dsx_shub_write_reg_with_mask(hw,
> +			hub_settings->wr_once.addr,
> +			hub_settings->wr_once.mask,
> +			data);
> +		if (err < 0)
> +			return err;
> +	}
> +
>  	slv_addr = ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
>  	config[0] = sensor->ext_info.addr << 1;
>  	for (i = 0 ; i < len; i++) {
> @@ -319,11 +351,54 @@ st_lsm6dsx_shub_set_odr(struct st_lsm6dsx_sensor *sensor, u16 odr)
>  					       val);
>  }
>  
> +/* use SLV{1,2,3} for FIFO read operations */
> +static int
> +st_lsm6dsx_shub_config_channels(struct st_lsm6dsx_sensor *sensor,
> +				bool enable)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	const struct st_lsm6dsx_ext_dev_settings *settings;
> +	u8 config[9] = {}, enable_mask, slv_addr;
> +	struct st_lsm6dsx_hw *hw = sensor->hw;
> +	struct st_lsm6dsx_sensor *cur_sensor;
> +	int i, j = 0;
> +
> +	hub_settings = &hw->settings->shub_settings;
> +	if (enable)
> +		enable_mask = hw->enable_mask | BIT(sensor->id);
> +	else
> +		enable_mask = hw->enable_mask & ~BIT(sensor->id);
> +
> +	for (i = ST_LSM6DSX_ID_EXT0; i <= ST_LSM6DSX_ID_EXT2; i++) {
> +		if (!hw->iio_devs[i])
> +			continue;
> +
> +		cur_sensor = iio_priv(hw->iio_devs[i]);
> +		if (!(enable_mask & BIT(cur_sensor->id)))
> +			continue;
> +
> +		settings = cur_sensor->ext_info.settings;
> +		config[j] = (sensor->ext_info.addr << 1) | 1;
> +		config[j + 1] = settings->out.addr;
> +		config[j + 2] = (settings->out.len & ST_LS6DSX_READ_OP_MASK) |
> +				hub_settings->batch_en;
> +		j += 3;
> +	}
> +
> +	slv_addr = ST_LSM6DSX_SLV_ADDR(1, hub_settings->slv0_addr);
> +	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> +					 sizeof(config));
> +}
> +
>  int st_lsm6dsx_shub_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
>  {
>  	const struct st_lsm6dsx_ext_dev_settings *settings;
>  	int err;
>  
> +	err = st_lsm6dsx_shub_config_channels(sensor, enable);
> +	if (err < 0)
> +		return err;
> +
>  	settings = sensor->ext_info.settings;
>  	if (enable) {
>  		err = st_lsm6dsx_shub_set_odr(sensor, sensor->odr);
