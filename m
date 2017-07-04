Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60280 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752031AbdGDT0r (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jul 2017 15:26:47 -0400
Date: Tue, 4 Jul 2017 20:26:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: Re: [PATCH] iio: accel: st_accel: add SPI-3wire support
Message-ID: <20170704202643.039f5354@kernel.org>
In-Reply-To: <20170703180711.8225-1-lorenzo.bianconi@st.com>
References: <20170703180711.8225-1-lorenzo.bianconi@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  3 Jul 2017 20:07:11 +0200
Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:

> Add sensor interface mode (SIM) lookup table to support devices
> (like LSM303AGR accel sensor) that support just SPI-3wire
> communication mode. SIM mode has to be configured before any
> other operation since it is not enabled by default and the driver
> is not able to read without that configuration
> 
> Fixes: ddc05fa28606 (iio: st-accel: add support for lsm303agr accel)
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Just checked and the 3-wire device tree property is documented in spi-bus.txt

So, that's all fine.  However, I'm not keen on introducing a special look up
table for this when we already have a convenient one covering all the other
per device registers etc.

Another approach suggested inline...
> ---
>  drivers/iio/accel/st_accel_core.c               | 37 +++++++++++++++++++++++++
>  drivers/iio/common/st_sensors/st_sensors_core.c | 36 ++++++++++++++++++++++++
>  include/linux/iio/common/st_sensors.h           | 11 ++++++++
>  include/linux/platform_data/st_sensors_pdata.h  |  2 ++
>  4 files changed, 86 insertions(+)
> 
> diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
> index 07d1489cd457..195966e82516 100644
> --- a/drivers/iio/accel/st_accel_core.c
> +++ b/drivers/iio/accel/st_accel_core.c
> @@ -619,6 +619,38 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
>  	},
>  };
>  
> +static const struct st_sensor_sim st_accel_sim_table[] = {
> +	{
> +		.sensors = {
> +			[0] = LSM303AGR_ACCEL_DEV_NAME,
> +			[1] = LIS3DH_ACCEL_DEV_NAME,
> +			[2] = LIS2DH12_ACCEL_DEV_NAME,
> +			[3] = LIS331DLH_ACCEL_DEV_NAME,
> +			[4] = LNG2DM_ACCEL_DEV_NAME,
> +			[5] = LSM330D_ACCEL_DEV_NAME,
> +			[6] = LSM330DL_ACCEL_DEV_NAME,
> +			[7] = LSM330DLC_ACCEL_DEV_NAME,
The index has no meaning as we really have an unordered
list so perhaps drop it and let it automatically place them.

Doing it by name is particularly ugly given we already
have a big look up table for device differences. 

One option would be to split the st_sensors_check_device_support
function into two parts - the first does the match by name
and the second does the wai check.   That way you could
then stick your configuration in between the two and
put this info in with all the other device specific
characteristics.

To make the transition easy you could add the two split
functions and call them from the original.  Then you can
introduce the split as needed into the various st sensor
drivers.
> +		},
> +		.addr = 0x23,
> +		.val = BIT(0),
> +	},
> +	{
> +		.sensors = {
> +			[0] = LSM330_ACCEL_DEV_NAME,
> +		},
> +		.addr = 0x24,
> +		.val = BIT(0),
> +	},
> +	{
> +		.sensors = {
> +			[0] = LIS3L02DQ_ACCEL_DEV_NAME,
> +			[1] = LIS3LV02DL_ACCEL_DEV_NAME,
> +		},
> +		.addr = 0x21,
> +		.val = BIT(1),
> +	},
> +};
> +
>  static int st_accel_read_raw(struct iio_dev *indio_dev,
>  			struct iio_chan_spec const *ch, int *val,
>  							int *val2, long mask)
> @@ -719,6 +751,11 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
>  	indio_dev->info = &accel_info;
>  	mutex_init(&adata->tb.buf_lock);
>  
> +	err = st_sensors_init_interface_mode(indio_dev, st_accel_sim_table,
> +					     ARRAY_SIZE(st_accel_sim_table));
> +	if (err < 0)
> +		return err;
> +
>  	err = st_sensors_power_enable(indio_dev);
>  	if (err)
>  		return err;
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index 274868100fd0..50c281b6286d 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -384,6 +384,42 @@ static struct st_sensors_platform_data *st_sensors_of_probe(struct device *dev,
>  }
>  #endif
>  
> +int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> +				   const struct st_sensor_sim *sim_table,
> +				   int sim_len)
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +	struct device_node *np = sdata->dev->of_node;
> +	struct st_sensors_platform_data *pdata;
> +	int err = 0;
> +
> +	pdata = (struct st_sensors_platform_data *)sdata->dev->platform_data;
> +	if ((np && of_property_read_bool(np, "spi-3wire")) ||
> +	    (pdata && pdata->spi_3wire)) {
> +		int i, j;
> +
> +		for (i = 0; i < sim_len; i++) {
> +			for (j = 0; j < ST_SENSORS_MAX_SIM; j++) {
> +				if (!strcmp(sim_table[i].sensors[j],
> +					    indio_dev->name))
> +					break;
> +			}
> +			if (j < ST_SENSORS_MAX_SIM)
> +				break;
> +		}
> +
> +		if (i == sim_len)
> +			return -EINVAL;
> +
> +		err = sdata->tf->write_byte(&sdata->tb, sdata->dev,
> +					    sim_table[i].addr,
> +					    sim_table[i].val);
> +	}
> +
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_init_interface_mode);
> +
>  int st_sensors_init_sensor(struct iio_dev *indio_dev,
>  					struct st_sensors_platform_data *pdata)
>  {
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> index 1f8211b6438b..15ce0cb360d7 100644
> --- a/include/linux/iio/common/st_sensors.h
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -41,6 +41,7 @@
>  
>  #define ST_SENSORS_MAX_NAME			17
>  #define ST_SENSORS_MAX_4WAI			7
> +#define ST_SENSORS_MAX_SIM			9
>  
>  #define ST_SENSORS_LSM_CHANNELS(device_type, mask, index, mod, \
>  					ch2, s, endian, rbits, sbits, addr) \
> @@ -105,6 +106,12 @@ struct st_sensor_fullscale {
>  	struct st_sensor_fullscale_avl fs_avl[ST_SENSORS_FULLSCALE_AVL_MAX];
>  };
>  
> +struct st_sensor_sim {
> +	char sensors[ST_SENSORS_MAX_SIM][ST_SENSORS_MAX_NAME];
> +	u8 addr;
> +	u8 val;
> +};
> +
>  /**
>   * struct st_sensor_bdu - ST sensor device block data update
>   * @addr: address of the register.
> @@ -325,6 +332,10 @@ ssize_t st_sensors_sysfs_sampling_frequency_avail(struct device *dev,
>  ssize_t st_sensors_sysfs_scale_avail(struct device *dev,
>  				struct device_attribute *attr, char *buf);
>  
> +int st_sensors_init_interface_mode(struct iio_dev *indio_dev,
> +				   const struct st_sensor_sim *sim_table,
> +				   int sim_len);
> +
>  #ifdef CONFIG_OF
>  void st_sensors_of_name_probe(struct device *dev,
>  			      const struct of_device_id *match,
> diff --git a/include/linux/platform_data/st_sensors_pdata.h b/include/linux/platform_data/st_sensors_pdata.h
> index 79b0e4cdb814..f8274b0c6888 100644
> --- a/include/linux/platform_data/st_sensors_pdata.h
> +++ b/include/linux/platform_data/st_sensors_pdata.h
> @@ -17,10 +17,12 @@
>   *	Available only for accelerometer and pressure sensors.
>   *	Accelerometer DRDY on LSM330 available only on pin 1 (see datasheet).
>   * @open_drain: set the interrupt line to be open drain if possible.
> + * @spi_3wire: enable spi-3wire mode.
>   */
>  struct st_sensors_platform_data {
>  	u8 drdy_int_pin;
>  	bool open_drain;
> +	bool spi_3wire;
>  };
>  
>  #endif /* ST_SENSORS_PDATA_H */

