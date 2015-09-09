Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Markus Pargmann <mpa@pengutronix.de>, Jonathan Cameron <jic23@kernel.org>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Lars-Peter
 Clausen" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v2 1/4] iio: bmc150: Use i2c regmap
Date: Wed, 9 Sep 2015 14:36:54 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F0C8371@irsmsx105.ger.corp.intel.com>
References: <1440074986-28716-1-git-send-email-mpa@pengutronix.de>
 <1440074986-28716-2-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1440074986-28716-2-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Markus Pargmann [mailto:mpa@pengutronix.de]
> Sent: 20 August, 2015 15:50
> To: Jonathan Cameron
> Cc: Srinivas Pandruvada; Tirdea, Irina; Lars-Peter Clausen; linux-iio@vge=
r.kernel.org; linux-kernel@vger.kernel.org;
> kernel@pengutronix.de; Markus Pargmann
> Subject: [PATCH v2 1/4] iio: bmc150: Use i2c regmap
>=20
> This replaces all usage of direct i2c accesses with regmap accesses.
>=20
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> ---

This patch works, but I would wait for the rebased version and check again.
One minor comment below.

>  drivers/iio/accel/Kconfig        |   2 +
>  drivers/iio/accel/bmc150-accel.c | 219 +++++++++++++++++----------------=
------
>  2 files changed, 95 insertions(+), 126 deletions(-)
>=20
> diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> index 00e7bcbdbe24..01dd03d194d1 100644
> --- a/drivers/iio/accel/Kconfig
> +++ b/drivers/iio/accel/Kconfig
> @@ -22,6 +22,8 @@ config BMC150_ACCEL
>  	depends on I2C
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select REGMAP
> +	select REGMAP_I2C
>  	help
>  	  Say yes here to build support for the following Bosch accelerometers:
>  	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-=
accel.c
> index 55751d9e1ade..c5c773e75173 100644
> --- a/drivers/iio/accel/bmc150-accel.c
> +++ b/drivers/iio/accel/bmc150-accel.c
> @@ -35,6 +35,7 @@
>  #include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
> +#include <linux/regmap.h>
>=20
>  #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
>  #define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
> @@ -185,6 +186,8 @@ enum bmc150_accel_trigger_id {
>=20
>  struct bmc150_accel_data {
>  	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct device *dev;
>  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
>  	atomic_t active_intr;
>  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> @@ -241,6 +244,11 @@ static const struct {
>  				       {500000, BMC150_ACCEL_SLEEP_500_MS},
>  				       {1000000, BMC150_ACCEL_SLEEP_1_SEC} };
>=20
> +static const struct regmap_config bmc150_i2c_regmap_conf =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.max_register =3D 0x3f,
> +};
>=20
>  static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
>  				 enum bmc150_power_modes mode,
> @@ -270,8 +278,7 @@ static int bmc150_accel_set_mode(struct bmc150_accel_=
data *data,
>=20
>  	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
>=20
> -	ret =3D i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
> +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
>  		return ret;
> @@ -289,8 +296,7 @@ static int bmc150_accel_set_bw(struct bmc150_accel_da=
ta *data, int val,
>  	for (i =3D 0; i < ARRAY_SIZE(bmc150_accel_samp_freq_table); ++i) {
>  		if (bmc150_accel_samp_freq_table[i].val =3D=3D val &&
>  				bmc150_accel_samp_freq_table[i].val2 =3D=3D val2) {
> -			ret =3D i2c_smbus_write_byte_data(
> -				data->client,
> +			ret =3D regmap_write(data->regmap,
>  				BMC150_ACCEL_REG_PMU_BW,
>  				bmc150_accel_samp_freq_table[i].bw_bits);
>  			if (ret < 0)
> @@ -307,26 +313,19 @@ static int bmc150_accel_set_bw(struct bmc150_accel_=
data *data, int val,
>=20
>  static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
>  {
> -	int ret, val;
> +	int ret;
>=20
> -	ret =3D i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_6,
> +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
>  					data->slope_thres);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_int_6\n");
>  		return ret;
>  	}
>=20
> -	ret =3D i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5);
> +	ret =3D regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
> +				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_int_5\n");
> -		return ret;
> -	}
> -
> -	val =3D (ret & ~BMC150_ACCEL_SLOPE_DUR_MASK) | data->slope_dur;
> -	ret =3D i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_5,
> -					val);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error write reg_int_5\n");
> +		dev_err(&data->client->dev, "Error updating reg_int_5\n");
>  		return ret;
>  	}
>=20
> @@ -348,17 +347,18 @@ static int bmc150_accel_any_motion_setup(struct bmc=
150_accel_trigger *t,
>  static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
>  {
>  	int ret;
> +	unsigned int val;
>=20
> -	ret =3D i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_ID=
);
> +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"Error: Reading chip id\n");
>  		return ret;
>  	}
>=20
> -	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
> -	if (ret !=3D data->chip_info->chip_id) {
> -		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
> +	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
> +	if (val !=3D data->chip_info->chip_id) {
> +		dev_err(&data->client->dev, "Invalid chip %x\n", val);
>  		return -ENODEV;
>  	}
>=20
> @@ -372,9 +372,8 @@ static int bmc150_accel_chip_init(struct bmc150_accel=
_data *data)
>  		return ret;
>=20
>  	/* Set Default Range */
> -	ret =3D i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_PMU_RANGE,
> -					BMC150_ACCEL_DEF_RANGE_4G);
> +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
> +			   BMC150_ACCEL_DEF_RANGE_4G);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  					"Error writing reg_pmu_range\n");
> @@ -391,10 +390,9 @@ static int bmc150_accel_chip_init(struct bmc150_acce=
l_data *data)
>  		return ret;
>=20
>  	/* Set default as latched interrupts */
> -	ret =3D i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_RST_LATCH,
> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> +			   BMC150_ACCEL_INT_MODE_LATCH_INT |
> +			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"Error writing reg_int_rst_latch\n");
> @@ -527,38 +525,18 @@ static int bmc150_accel_set_interrupt(struct bmc150=
_accel_data *data, int i,
>  		return ret;
>=20
>  	/* map the interrupt to the appropriate pins */
> -	ret =3D i2c_smbus_read_byte_data(data->client, info->map_reg);
> +	ret =3D regmap_update_bits(data->regmap, info->map_reg, info->map_bitma=
sk,
> +				 (state ? info->map_bitmask : 0));
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_int_map\n");
> -		goto out_fix_power_state;
> -	}
> -	if (state)
> -		ret |=3D info->map_bitmask;
> -	else
> -		ret &=3D ~info->map_bitmask;
> -
> -	ret =3D i2c_smbus_write_byte_data(data->client, info->map_reg,
> -					ret);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_map\n");
> +		dev_err(&data->client->dev, "Error updating reg_int_map\n");
>  		goto out_fix_power_state;
>  	}
>=20
>  	/* enable/disable the interrupt */
> -	ret =3D i2c_smbus_read_byte_data(data->client, info->en_reg);
> +	ret =3D regmap_update_bits(data->regmap, info->en_reg, info->en_bitmask=
,
> +				 (state ? info->en_bitmask : 0));
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_int_en\n");
> -		goto out_fix_power_state;
> -	}
> -
> -	if (state)
> -		ret |=3D info->en_bitmask;
> -	else
> -		ret &=3D ~info->en_bitmask;
> -
> -	ret =3D i2c_smbus_write_byte_data(data->client, info->en_reg, ret);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_en\n");
> +		dev_err(&data->client->dev, "Error updating reg_int_en\n");
>  		goto out_fix_power_state;
>  	}
>=20
> @@ -581,8 +559,7 @@ static int bmc150_accel_set_scale(struct bmc150_accel=
_data *data, int val)
>=20
>  	for (i =3D 0; i < ARRAY_SIZE(data->chip_info->scale_table); ++i) {
>  		if (data->chip_info->scale_table[i].scale =3D=3D val) {
> -			ret =3D i2c_smbus_write_byte_data(
> -				     data->client,
> +			ret =3D regmap_write(data->regmap,
>  				     BMC150_ACCEL_REG_PMU_RANGE,
>  				     data->chip_info->scale_table[i].reg_range);
>  			if (ret < 0) {
> @@ -602,16 +579,17 @@ static int bmc150_accel_set_scale(struct bmc150_acc=
el_data *data, int val)
>  static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *va=
l)
>  {
>  	int ret;
> +	unsigned int value;
>=20
>  	mutex_lock(&data->mutex);
>=20
> -	ret =3D i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_TEMP);
> +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_temp\n");
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> -	*val =3D sign_extend32(ret, 7);
> +	*val =3D sign_extend32(value, 7);
>=20
>  	mutex_unlock(&data->mutex);
>=20
> @@ -624,6 +602,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_=
data *data,
>  {
>  	int ret;
>  	int axis =3D chan->scan_index;
> +	unsigned int raw_val;
>=20
>  	mutex_lock(&data->mutex);
>  	ret =3D bmc150_accel_set_power_state(data, true);
> @@ -632,15 +611,15 @@ static int bmc150_accel_get_axis(struct bmc150_acce=
l_data *data,
>  		return ret;
>  	}
>=20
> -	ret =3D i2c_smbus_read_word_data(data->client,
> -				       BMC150_ACCEL_AXIS_TO_REG(axis));
> +	ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
> +			       &raw_val, 2);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
>  		bmc150_accel_set_power_state(data, false);
>  		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
> -	*val =3D sign_extend32(ret >> chan->scan_type.shift,
> +	*val =3D sign_extend32(raw_val >> chan->scan_type.shift,
>  			     chan->scan_type.realbits - 1);
>  	ret =3D bmc150_accel_set_power_state(data, false);
>  	mutex_unlock(&data->mutex);
> @@ -904,52 +883,34 @@ static int bmc150_accel_set_watermark(struct iio_de=
v *indio_dev, unsigned val)
>   * We must read at least one full frame in one burst, otherwise the rest=
 of the
>   * frame data is discarded.
>   */
> -static int bmc150_accel_fifo_transfer(const struct i2c_client *client,
> +static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
>  				      char *buffer, int samples)
>  {
>  	int sample_length =3D 3 * 2;
> -	u8 reg_fifo_data =3D BMC150_ACCEL_REG_FIFO_DATA;
> -	int ret =3D -EIO;
> -
> -	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> -		struct i2c_msg msg[2] =3D {
> -			{
> -				.addr =3D client->addr,
> -				.flags =3D 0,
> -				.buf =3D &reg_fifo_data,
> -				.len =3D sizeof(reg_fifo_data),
> -			},
> -			{
> -				.addr =3D client->addr,
> -				.flags =3D I2C_M_RD,
> -				.buf =3D (u8 *)buffer,
> -				.len =3D samples * sample_length,
> -			}
> -		};
> +	int ret;
> +	int total_length =3D samples * sample_length;
> +	int i;
> +	int step =3D regmap_get_raw_read_max(data->regmap);
>=20
> -		ret =3D i2c_transfer(client->adapter, msg, 2);
> -		if (ret !=3D 2)
> -			ret =3D -EIO;
> -		else
> -			ret =3D 0;
> -	} else {
> -		int i, step =3D I2C_SMBUS_BLOCK_MAX / sample_length;
> -
> -		for (i =3D 0; i < samples * sample_length; i +=3D step) {
> -			ret =3D i2c_smbus_read_i2c_block_data(client,
> -							    reg_fifo_data, step,
> -							    &buffer[i]);
> -			if (ret !=3D step) {
> -				ret =3D -EIO;
> -				break;
> -			}
> +	if (!step || step > total_length)
> +		step =3D total_length;
> +	else if (step < total_length)
> +		step =3D sample_length;
>=20
> -			ret =3D 0;
> -		}
> +	/*
> +	 * Seems we have a bus with size limitation so we have to execute
> +	 * multiple reads
> +	 */
> +	for (i =3D 0; i < total_length; i +=3D step) {
> +		ret =3D regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
> +				      &buffer[i], step);
> +		if (ret)
> +			break;
>  	}
>=20
>  	if (ret)
> -		dev_err(&client->dev, "Error transferring data from fifo\n");
> +		dev_err(data->dev, "Error transferring data from fifo in single steps =
of %zu\n",
> +			step);

step is declared as int, so using %zu will generate the following warning a=
t build:
drivers/iio/accel/bmc150-accel.c:859:4: warning: format '%zu' expects argum=
ent of type 'size_t', but argument 3 has type 'int' [-Wformat=3D]
    step);
    ^
>=20
>  	return ret;
>  }
> @@ -963,14 +924,15 @@ static int __bmc150_accel_fifo_flush(struct iio_dev=
 *indio_dev,
>  	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
>  	int64_t tstamp;
>  	uint64_t sample_period;
> -	ret =3D i2c_smbus_read_byte_data(data->client,
> -				       BMC150_ACCEL_REG_FIFO_STATUS);
> +	unsigned int val;
> +
> +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
>  		return ret;
>  	}
>=20
> -	count =3D ret & 0x7F;
> +	count =3D val & 0x7F;
>=20
>  	if (!count)
>  		return 0;
> @@ -1009,7 +971,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev =
*indio_dev,
>  	if (samples && count > samples)
>  		count =3D samples;
>=20
> -	ret =3D bmc150_accel_fifo_transfer(data->client, (u8 *)buffer, count);
> +	ret =3D bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
>  	if (ret)
>  		return ret;
>=20
> @@ -1206,17 +1168,19 @@ static irqreturn_t bmc150_accel_trigger_handler(i=
nt irq, void *p)
>  	struct iio_dev *indio_dev =3D pf->indio_dev;
>  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
>  	int bit, ret, i =3D 0;
> +	unsigned int raw_val;
>=20
>  	mutex_lock(&data->mutex);
>  	for_each_set_bit(bit, indio_dev->active_scan_mask,
>  			 indio_dev->masklength) {
> -		ret =3D i2c_smbus_read_word_data(data->client,
> -					       BMC150_ACCEL_AXIS_TO_REG(bit));
> +		ret =3D regmap_bulk_read(data->regmap,
> +				       BMC150_ACCEL_AXIS_TO_REG(bit), &raw_val,
> +				       2);
>  		if (ret < 0) {
>  			mutex_unlock(&data->mutex);
>  			goto err_read;
>  		}
> -		data->buffer[i++] =3D ret;
> +		data->buffer[i++] =3D raw_val;
>  	}
>  	mutex_unlock(&data->mutex);
>=20
> @@ -1240,10 +1204,9 @@ static int bmc150_accel_trig_try_reen(struct iio_t=
rigger *trig)
>=20
>  	mutex_lock(&data->mutex);
>  	/* clear any latched interrupt */
> -	ret =3D i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_RST_LATCH,
> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> +			   BMC150_ACCEL_INT_MODE_LATCH_INT |
> +			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  	mutex_unlock(&data->mutex);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
> @@ -1300,34 +1263,34 @@ static int bmc150_accel_handle_roc_event(struct i=
io_dev *indio_dev)
>  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
>  	int dir;
>  	int ret;
> +	unsigned int val;
>=20
> -	ret =3D i2c_smbus_read_byte_data(data->client,
> -				       BMC150_ACCEL_REG_INT_STATUS_2);
> +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
>  		return ret;
>  	}
>=20
> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
>  		dir =3D IIO_EV_DIR_FALLING;
>  	else
>  		dir =3D IIO_EV_DIR_RISING;
>=20
> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_X)
> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_X)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  							0,
>  							IIO_MOD_X,
>  							IIO_EV_TYPE_ROC,
>  							dir),
>  							data->timestamp);
> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Y)
> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Y)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  							0,
>  							IIO_MOD_Y,
>  							IIO_EV_TYPE_ROC,
>  							dir),
>  							data->timestamp);
> -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Z)
> +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Z)
>  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
>  							0,
>  							IIO_MOD_Z,
> @@ -1360,10 +1323,9 @@ static irqreturn_t bmc150_accel_irq_thread_handler=
(int irq, void *private)
>  	}
>=20
>  	if (ack) {
> -		ret =3D i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_INT_RST_LATCH,
> -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +		ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> +				   BMC150_ACCEL_INT_MODE_LATCH_INT |
> +				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  		if (ret)
>  			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
>  		ret =3D IRQ_HANDLED;
> @@ -1516,7 +1478,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc150=
_accel_data *data)
>  	u8 reg =3D BMC150_ACCEL_REG_FIFO_CONFIG1;
>  	int ret;
>=20
> -	ret =3D i2c_smbus_write_byte_data(data->client, reg, data->fifo_mode);
> +	ret =3D regmap_write(data->regmap, reg, data->fifo_mode);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
>  		return ret;
> @@ -1525,9 +1487,8 @@ static int bmc150_accel_fifo_set_mode(struct bmc150=
_accel_data *data)
>  	if (!data->fifo_mode)
>  		return 0;
>=20
> -	ret =3D i2c_smbus_write_byte_data(data->client,
> -					BMC150_ACCEL_REG_FIFO_CONFIG0,
> -					data->watermark);
> +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
> +			   data->watermark);
>  	if (ret < 0)
>  		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
>=20
> @@ -1627,6 +1588,13 @@ static int bmc150_accel_probe(struct i2c_client *c=
lient,
>  	data =3D iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	data->client =3D client;
> +	data->dev =3D &client->dev;
> +
> +	data->regmap =3D devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf);
> +	if (IS_ERR(data->regmap)) {
> +		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> +		return PTR_ERR(data->regmap);
> +	}
>=20
>  	if (id) {
>  		name =3D id->name;
> @@ -1680,9 +1648,8 @@ static int bmc150_accel_probe(struct i2c_client *cl=
ient,
>  		 * want to use latch mode when we can to prevent interrupt
>  		 * flooding.
>  		 */
> -		ret =3D i2c_smbus_write_byte_data(data->client,
> -						BMC150_ACCEL_REG_INT_RST_LATCH,
> -					     BMC150_ACCEL_INT_MODE_LATCH_RESET);
> +		ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> +				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
>  		if (ret < 0) {
>  			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
>  			goto err_buffer_cleanup;
> --
> 2.4.6
