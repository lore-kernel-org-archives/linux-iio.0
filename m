Return-Path: <lars@metafoo.de>
Message-ID: <50F6B410.6040207@metafoo.de>
Date: Wed, 16 Jan 2013 15:07:12 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/9] iio:common: Add STMicroelectronics common library
References: <1358238660-14929-1-git-send-email-denis.ciocca@st.com> <1358238660-14929-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1358238660-14929-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

looks pretty good overall, just a few nitpicks.

On 01/15/2013 09:30 AM, Denis CIOCCA wrote:
> This patch add generic library for STMicroelectronics 3-axis sensors.
adds a
> 
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> ---
[...]
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> new file mode 100644
> index 0000000..2170b1d
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -0,0 +1,115 @@
> +/*
> + * STMicroelectronics sensors buffer library driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.

2012-2013 ;)

> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
[...]
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> new file mode 100644
> index 0000000..af3eb1f
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -0,0 +1,329 @@
> +/*
> + * STMicroelectronics sensors core library driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/iio/iio.h>
> +
> +#include <linux/iio/common/st_sensors.h>
> +
> +
> +#define ST_SENSORS_WAI_ADDRESS		0x0f
> +#define ST_SENSORS_G_TO_MG(x)		(x*1000000ULL)

It looks as if this macro is not used

> +
> +int st_sensors_write_data_with_mask(struct iio_dev *indio_dev, u8 reg_addr,
> +						u8 mask, short num_bit, u8 data)
> +{

The num_bit parameter is not used in this function.

> +	int err;
> +	u8 new_data;
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	err = sdata->tf->read_byte(&sdata->tb, sdata->dev, reg_addr, &new_data);
> +	if (err < 0)
> +		goto st_sensors_write_data_with_mask_error;
> +
> +	new_data = ((new_data & (~mask)) | ((data << __ffs(mask)) & mask));
> +	err = sdata->tf->write_byte(&sdata->tb, sdata->dev, reg_addr, new_data);
> +
> +st_sensors_write_data_with_mask_error:
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_write_data_with_mask);
> +
> +int st_sensors_get_sampling_frequency_avl(struct iio_dev *indio_dev,
> +			const struct st_sensor_odr_avl *odr_avl, char *buf)
> +{
> +	int i, len = 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
> +		if (odr_avl[i].hz == 0)
> +			break;
> +
> +		len += sprintf(buf + len, "%d ", odr_avl[i].hz);

Although a buffer overflow is more of a theoretical concern here, using
scnprintf is still a good idea.

		len += scnprintf(buf + len, PAGE_SIZE - len, ...)

> +	}
> +	mutex_unlock(&indio_dev->mlock);
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(st_sensors_get_sampling_frequency_avl);
> +
> +int st_sensors_get_scale_avl(struct iio_dev *indio_dev,
> +		const struct st_sensor_fullscale_avl *fullscale_avl, char *buf)
> +{
> +	int i, len = 0;
> +
> +	mutex_lock(&indio_dev->mlock);
> +	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> +		if (fullscale_avl[i].num == 0)
> +			break;
> +
> +		len += sprintf(buf + len, "0.%06u ", fullscale_avl[i].gain);

Same here

> +	}
> +	mutex_unlock(&indio_dev->mlock);
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +EXPORT_SYMBOL(st_sensors_get_scale_avl);
> +
> +static int st_sensors_match_odr(const struct st_sensors *sensor,
> +			unsigned int odr, struct st_sensor_odr_avl *odr_out)
> +{
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i < ST_SENSORS_ODR_LIST_MAX; i++) {
> +		if ((sensor->odr.odr_avl[i].hz == odr) &&
> +					(sensor->odr.odr_avl[i].hz != 0)) {

I guess you could skip the second check here if you did a
 if (odr == 0)
	return -EINVAL;

earlier

> +			odr_out->hz = sensor->odr.odr_avl[i].hz;
> +			odr_out->value = sensor->odr.odr_avl[i].value;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
[...]
> +static int st_sensors_match_fs(const struct st_sensors *sensor,
> +					unsigned int fs, int *index_fs_avl)
> +{
> +	int i, ret = -EINVAL;
> +
> +	for (i = 0; i < ST_SENSORS_FULLSCALE_AVL_MAX; i++) {
> +		if ((sensor->fs.fs_avl[i].num == fs) &&
> +					(sensor->fs.fs_avl[i].num != 0)) {

Same here

> +			*index_fs_avl = i;
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +

[...]

> +
> +int st_sensors_read_axis_data(struct iio_dev *indio_dev, u8 ch_addr, int *data)
> +{
> +	int err;
> +	u8 outdata[ST_SENSORS_BYTE_FOR_CHANNEL];
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
> +			ch_addr, ST_SENSORS_BYTE_FOR_CHANNEL,
> +						outdata, sdata->multiread_bit);
> +	if (err < 0)
> +		goto read_error;
> +
> +	*data = ((s16)le16_to_cpup((__le16 *)outdata));

Either make outdata a __le16 or use get_unaligned_le16.

> +
> +read_error:
> +	return err;
> +}
> +EXPORT_SYMBOL(st_sensors_read_axis_data);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics ST-sensors core");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> new file mode 100644
> index 0000000..1498831
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
> @@ -0,0 +1,81 @@
> +/*
> + * STMicroelectronics sensors i2c library driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/iio/iio.h>
> +
> +#include <linux/iio/common/st_sensors.h>
> +
> +
> +#define ST_SENSORS_I2C_MULTIREAD	0x80
> +
> +unsigned int st_sensors_i2c_get_irq(struct iio_dev *indio_dev)

static

> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	return to_i2c_client(sdata->dev)->irq;
> +}
[...]
> +void st_sensors_i2c_configure(struct iio_dev *indio_dev,
> +		struct i2c_client *client, struct st_sensor_data *sdata)
> +{
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	indio_dev->dev.parent = &client->dev;
> +	indio_dev->name = client->name;
> +
> +	sdata->tf = (struct st_sensor_transfer_function *)&st_sensors_tf_i2c;

Don't cast the const away, just make tf const as well.

> +	sdata->get_irq_data_ready = st_sensors_i2c_get_irq;
> +}
> +EXPORT_SYMBOL(st_sensors_i2c_configure);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics ST-sensors i2c driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
> new file mode 100644
> index 0000000..2079f4b
> --- /dev/null
> +++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
> @@ -0,0 +1,128 @@
> +/*
> + * STMicroelectronics sensors spi library driver
> + *
> + * Copyright 2012 STMicroelectronics Inc.
> + *
> + * Denis Ciocca <denis.ciocca@st.com>
> + *
> + * Licensed under the GPL-2.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/iio/iio.h>
> +
> +#include <linux/iio/common/st_sensors.h>
> +
> +
> +#define ST_SENSORS_SPI_MULTIREAD	0xc0
> +#define ST_SENSORS_SPI_READ		0x80
> +
> +unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
static
> +{
> +	struct st_sensor_data *sdata = iio_priv(indio_dev);
> +
> +	return to_spi_device(sdata->dev)->irq;
> +}


> +
> +void st_sensors_spi_configure(struct iio_dev *indio_dev,
> +			struct spi_device *spi, struct st_sensor_data *sdata)
> +{
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi->modalias;
> +
> +	sdata->tf = (struct st_sensor_transfer_function *)&st_sensors_tf_spi;

Again, no cast.

> +	sdata->get_irq_data_ready = st_sensors_spi_get_irq;
> +}
> +EXPORT_SYMBOL(st_sensors_spi_configure);
> +
> +MODULE_AUTHOR("Denis Ciocca <denis.ciocca@st.com>");
> +MODULE_DESCRIPTION("STMicroelectronics ST-sensors spi driver");
> +MODULE_LICENSE("GPL v2");
[...]
> diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
> new file mode 100644
> index 0000000..f396bc5
> --- /dev/null
> +++ b/include/linux/iio/common/st_sensors.h
> @@ -0,0 +1,278 @@
[...]
> +
> +/**
> + * struct st_sensor_data - ST sensor device status
> + * @dev: Pointer to instance of struct device (I2C or SPI).
> + * @trig: The trigger in use by the core driver.
> + * @current_fullscale: Maximum range of measure by the sensor.
> + * @enabled: Status of the sensor (false->off, true->on).
> + * @multiread_bit: Use or not particular bit for [I2C/SPI] multiread.
> + * @index: Number used to point the sensor being used in the st_sensors struct.
> + * @buffer_data: Data used by buffer part.
> + * @odr: Output data rate of the sensor [Hz].
> + * @get_irq_data_ready: Function to get the IRQ used for data ready signal.
> + * @tf: Transfer function structure used by I/O operations.
> + * @tb: Transfer buffers and mutex used by I/O operations.
> + */
> +struct st_sensor_data {
> +	struct device *dev;
> +	struct iio_trigger *trig;
> +	struct st_sensor_fullscale_avl *current_fullscale;
> +
> +	bool enabled;
> +	bool multiread_bit;
> +
> +	short index;
> +
> +	char *buffer_data;
> +
> +	unsigned int odr;
> +
> +	unsigned int (*get_irq_data_ready) (struct iio_dev *indio_dev);
> +
> +	struct st_sensor_transfer_function *tf;

const struct st_sensor_transfer_function *tf

> +	struct st_sensor_transfer_buffer tb;
> +};
> +
> +/**
> + * struct st_sensors - ST sensors list
> + * @wai: Contents of WhoAmI register.
* @sensors_supported: ...
> + * @ch: IIO channels for the sensor.
> + * @odr: Output data rate register and ODR list available.
> + * @pw: Power register of the sensor.
> + * @enable_axis: Enable one or more axis of the sensor.
> + * @fs: Full scale register and full scale list available.
> + * @bdu: Block data update register.
> + * @drdy_irq: Data ready register of the sensor.
> + * @multi_read_bit: Use or not particular bit for [I2C/SPI] multi-read.
> + * @bootime: samples to discard when sensor passing from power-down to power-up.
> + */
> +struct st_sensors {
> +	u8 wai;
> +	char sensors_supported[ST_SENSORS_MAX_4WAI][ST_SENSORS_MAX_NAME];
> +	struct iio_chan_spec *ch;
> +	struct st_sensor_odr odr;
> +	struct st_sensor_power pw;
> +	struct st_sensor_axis enable_axis;
> +	struct st_sensor_fullscale fs;
> +	struct st_sensor_bdu bdu;
> +	struct st_sensor_data_ready_irq drdy_irq;
> +	bool multi_read_bit;
> +	unsigned int bootime;
> +};
> +
[...]
