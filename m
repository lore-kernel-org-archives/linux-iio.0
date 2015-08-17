Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53575 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752385AbbHQHtm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 03:49:42 -0400
Date: Mon, 17 Aug 2015 09:49:35 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 17/20] iio: bmc150: Use i2c regmap
Message-ID: <20150817074935.GJ19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-18-git-send-email-mpa@pengutronix.de>
 <55CF3E53.2080005@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0Fhs++QIS2o6H55x"
In-Reply-To: <55CF3E53.2080005@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--0Fhs++QIS2o6H55x
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 02:27:47PM +0100, Jonathan Cameron wrote:
> On 12/08/15 11:12, Markus Pargmann wrote:
> > This replaces all usage of direct i2c accesses with regmap accesses.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Clearly there is some work needed on the earlier patches and this
> might change as a result (particularly the fifo read).  I'll review
> as is however..
>=20
> Few bits on top of what other reviews have highlighted...
>=20
> Jonathan
> > ---
> >  drivers/iio/accel/Kconfig        |   2 +
> >  drivers/iio/accel/bmc150-accel.c | 225 +++++++++++++++++--------------=
--------
> >  2 files changed, 101 insertions(+), 126 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
> > index 00e7bcbdbe24..01dd03d194d1 100644
> > --- a/drivers/iio/accel/Kconfig
> > +++ b/drivers/iio/accel/Kconfig
> > @@ -22,6 +22,8 @@ config BMC150_ACCEL
> >  	depends on I2C
> >  	select IIO_BUFFER
> >  	select IIO_TRIGGERED_BUFFER
> > +	select REGMAP
> > +	select REGMAP_I2C
> >  	help
> >  	  Say yes here to build support for the following Bosch accelerometer=
s:
> >  	  BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> > diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc15=
0-accel.c
> > index fe2d2316158f..1484e956482e 100644
> > --- a/drivers/iio/accel/bmc150-accel.c
> > +++ b/drivers/iio/accel/bmc150-accel.c
> > @@ -35,6 +35,7 @@
> >  #include <linux/iio/trigger.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > +#include <linux/regmap.h>
> > =20
> >  #define BMC150_ACCEL_DRV_NAME			"bmc150_accel"
> >  #define BMC150_ACCEL_IRQ_NAME			"bmc150_accel_event"
> > @@ -185,6 +186,8 @@ enum bmc150_accel_trigger_id {
> > =20
> >  struct bmc150_accel_data {
> >  	struct i2c_client *client;
> > +	struct regmap *regmap;
> > +	struct device *dev;
> >  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
> >  	atomic_t active_intr;
> >  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> > @@ -241,6 +244,14 @@ static const struct {
> >  				       {500000, BMC150_ACCEL_SLEEP_500_MS},
> >  				       {1000000, BMC150_ACCEL_SLEEP_1_SEC} };
> > =20
> > +static const struct regmap_config bmc150_i2c_regmap_conf =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D 0x3f,
> > +
> > +	.use_single_rw =3D false,
> > +	.cache_type =3D REGCACHE_NONE,
> > +};
> > =20
> >  static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
> >  				 enum bmc150_power_modes mode,
> > @@ -270,8 +281,7 @@ static int bmc150_accel_set_mode(struct bmc150_acce=
l_data *data,
> > =20
> >  	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
> > =20
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_PMU_LPW, lpw_bits);
> > +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits=
);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
> >  		return ret;
> > @@ -289,8 +299,7 @@ static int bmc150_accel_set_bw(struct bmc150_accel_=
data *data, int val,
> >  	for (i =3D 0; i < ARRAY_SIZE(bmc150_accel_samp_freq_table); ++i) {
> >  		if (bmc150_accel_samp_freq_table[i].val =3D=3D val &&
> >  				bmc150_accel_samp_freq_table[i].val2 =3D=3D val2) {
> > -			ret =3D i2c_smbus_write_byte_data(
> > -				data->client,
> > +			ret =3D regmap_write(data->regmap,
> >  				BMC150_ACCEL_REG_PMU_BW,
> >  				bmc150_accel_samp_freq_table[i].bw_bits);
> >  			if (ret < 0)
> > @@ -307,26 +316,19 @@ static int bmc150_accel_set_bw(struct bmc150_acce=
l_data *data, int val,
> > =20
> >  static int bmc150_accel_update_slope(struct bmc150_accel_data *data)
> >  {
> > -	int ret, val;
> > +	int ret;
> > =20
> > -	ret =3D i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_=
6,
> > +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
> >  					data->slope_thres);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> >  		return ret;
> >  	}
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_INT_5=
);
> > +	ret =3D regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
> > +				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_5\n");
> > -		return ret;
> > -	}
> > -
> > -	val =3D (ret & ~BMC150_ACCEL_SLOPE_DUR_MASK) | data->slope_dur;
> > -	ret =3D i2c_smbus_write_byte_data(data->client, BMC150_ACCEL_REG_INT_=
5,
> > -					val);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error write reg_int_5\n");
> > +		dev_err(&data->client->dev, "Error updating reg_int_5\n");
> >  		return ret;
> >  	}
> > =20
> > @@ -348,17 +350,18 @@ static int bmc150_accel_any_motion_setup(struct b=
mc150_accel_trigger *t,
> >  static int bmc150_accel_chip_init(struct bmc150_accel_data *data)
> >  {
> >  	int ret;
> > +	unsigned int val;
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_CHIP_=
ID);
> > +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  			"Error: Reading chip id\n");
> >  		return ret;
> >  	}
> > =20
> > -	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
> > -	if (ret !=3D data->chip_info->chip_id) {
> > -		dev_err(&data->client->dev, "Invalid chip %x\n", ret);
> > +	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
> > +	if (val !=3D data->chip_info->chip_id) {
> > +		dev_err(&data->client->dev, "Invalid chip %x\n", val);
> >  		return -ENODEV;
> >  	}
> > =20
> > @@ -372,9 +375,8 @@ static int bmc150_accel_chip_init(struct bmc150_acc=
el_data *data)
> >  		return ret;
> > =20
> >  	/* Set Default Range */
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_PMU_RANGE,
> > -					BMC150_ACCEL_DEF_RANGE_4G);
> > +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
> > +			   BMC150_ACCEL_DEF_RANGE_4G);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  					"Error writing reg_pmu_range\n");
> > @@ -391,10 +393,9 @@ static int bmc150_accel_chip_init(struct bmc150_ac=
cel_data *data)
> >  		return ret;
> > =20
> >  	/* Set default as latched interrupts */
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_INT_RST_LATCH,
> > -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> > -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> > +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> > +			   BMC150_ACCEL_INT_MODE_LATCH_INT |
> > +			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  			"Error writing reg_int_rst_latch\n");
> > @@ -527,38 +528,18 @@ static int bmc150_accel_set_interrupt(struct bmc1=
50_accel_data *data, int i,
> >  		return ret;
> > =20
> >  	/* map the interrupt to the appropriate pins */
> > -	ret =3D i2c_smbus_read_byte_data(data->client, info->map_reg);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_map\n");
> > -		goto out_fix_power_state;
> > -	}
> > -	if (state)
> > -		ret |=3D info->map_bitmask;
> > -	else
> > -		ret &=3D ~info->map_bitmask;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(data->client, info->map_reg,
> > -					ret);
> > +	ret =3D regmap_update_bits(data->regmap, info->map_reg, info->map_bit=
mask,
> > +				 (state ? info->map_bitmask : 0));
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_map\n");
> > +		dev_err(&data->client->dev, "Error updating reg_int_map\n");
> >  		goto out_fix_power_state;
> >  	}
> > =20
> >  	/* enable/disable the interrupt */
> > -	ret =3D i2c_smbus_read_byte_data(data->client, info->en_reg);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_en\n");
> > -		goto out_fix_power_state;
> > -	}
> > -
> > -	if (state)
> > -		ret |=3D info->en_bitmask;
> > -	else
> > -		ret &=3D ~info->en_bitmask;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(data->client, info->en_reg, ret);
> > +	ret =3D regmap_update_bits(data->regmap, info->en_reg, info->en_bitma=
sk,
> > +				 (state ? info->en_bitmask : 0));
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_en\n");
> > +		dev_err(&data->client->dev, "Error updating reg_int_en\n");
> >  		goto out_fix_power_state;
> >  	}
> > =20
> > @@ -581,8 +562,7 @@ static int bmc150_accel_set_scale(struct bmc150_acc=
el_data *data, int val)
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(data->chip_info->scale_table); ++i) {
> >  		if (data->chip_info->scale_table[i].scale =3D=3D val) {
> > -			ret =3D i2c_smbus_write_byte_data(
> > -				     data->client,
> > +			ret =3D regmap_write(data->regmap,
> >  				     BMC150_ACCEL_REG_PMU_RANGE,
> >  				     data->chip_info->scale_table[i].reg_range);
> >  			if (ret < 0) {
> > @@ -602,16 +582,17 @@ static int bmc150_accel_set_scale(struct bmc150_a=
ccel_data *data, int val)
> >  static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *=
val)
> >  {
> >  	int ret;
> > +	unsigned int value;
> > =20
> >  	mutex_lock(&data->mutex);
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMC150_ACCEL_REG_TEMP);
> > +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading reg_temp\n");
> >  		mutex_unlock(&data->mutex);
> >  		return ret;
> >  	}
> > -	*val =3D sign_extend32(ret, 7);
> > +	*val =3D sign_extend32(value, 7);
> > =20
> >  	mutex_unlock(&data->mutex);
> > =20
> > @@ -624,6 +605,7 @@ static int bmc150_accel_get_axis(struct bmc150_acce=
l_data *data,
> >  {
> >  	int ret;
> >  	int axis =3D chan->scan_index;
> > +	unsigned int raw_val;
> > =20
> >  	mutex_lock(&data->mutex);
> >  	ret =3D bmc150_accel_set_power_state(data, true);
> > @@ -632,15 +614,15 @@ static int bmc150_accel_get_axis(struct bmc150_ac=
cel_data *data,
> >  		return ret;
> >  	}
> > =20
> > -	ret =3D i2c_smbus_read_word_data(data->client,
> > -				       BMC150_ACCEL_AXIS_TO_REG(axis));
> > +	ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
> > +			       &raw_val, 2);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
> >  		bmc150_accel_set_power_state(data, false);
> >  		mutex_unlock(&data->mutex);
> >  		return ret;
> >  	}
> > -	*val =3D sign_extend32(ret >> chan->scan_type.shift,
> > +	*val =3D sign_extend32(raw_val >> chan->scan_type.shift,
> >  			     chan->scan_type.realbits - 1);
> >  	ret =3D bmc150_accel_set_power_state(data, false);
> >  	mutex_unlock(&data->mutex);
> > @@ -904,52 +886,37 @@ static int bmc150_accel_set_watermark(struct iio_=
dev *indio_dev, unsigned val)
> >   * We must read at least one full frame in one burst, otherwise the re=
st of the
> >   * frame data is discarded.
> >   */
> > -static int bmc150_accel_fifo_transfer(const struct i2c_client *client,
> > +static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
> >  				      char *buffer, int samples)
> >  {
> >  	int sample_length =3D 3 * 2;
> > -	u8 reg_fifo_data =3D BMC150_ACCEL_REG_FIFO_DATA;
> > -	int ret =3D -EIO;
> > -
> > -	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > -		struct i2c_msg msg[2] =3D {
> > -			{
> > -				.addr =3D client->addr,
> > -				.flags =3D 0,
> > -				.buf =3D &reg_fifo_data,
> > -				.len =3D sizeof(reg_fifo_data),
> > -			},
> > -			{
> > -				.addr =3D client->addr,
> > -				.flags =3D I2C_M_RD,
> > -				.buf =3D (u8 *)buffer,
> > -				.len =3D samples * sample_length,
> > -			}
> > -		};
> > +	int ret;
> > +	int total_length =3D samples * sample_length;
> > +	int i, step;
> > =20
> > -		ret =3D i2c_transfer(client->adapter, msg, 2);
> > -		if (ret !=3D 2)
> > -			ret =3D -EIO;
> > -		else
> > -			ret =3D 0;
> > -	} else {
> > -		int i, step =3D I2C_SMBUS_BLOCK_MAX / sample_length;
> > -
> > -		for (i =3D 0; i < samples * sample_length; i +=3D step) {
> > -			ret =3D i2c_smbus_read_i2c_block_data(client,
> > -							    reg_fifo_data, step,
> > -							    &buffer[i]);
> > -			if (ret !=3D step) {
> > -				ret =3D -EIO;
> > -				break;
> > -			}
> > +	ret =3D regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA, buf=
fer,
> > +			      total_length);
> > +	if (ret !=3D -E2BIG) {
> > +		if (ret)
> I'd invert the logic for more readability.
>=20
> if (ret =3D=3D -E2BIT) {
> ...
> } else if (ret) {
> ...
> } else {
>    return ret;
> }

Okay.

> > +			dev_err(data->dev, "Error transferring data from fifo\n");
> > +		return ret;
> > +	}
> > =20
> > -			ret =3D 0;
> > -		}
> > +	/*
> > +	 * Seems we have a bus with size limitation so we have to execute
> > +	 * multiple reads
> > +	 */
> Can we not just query this in advance before going through the previous
> failed call?  THat would be cleaner to my mind.

Yes we can check that in advance and make the reads accordingly.
>=20
> > +	step =3D regmap_get_raw_io_max(data->regmap) / sample_length;
> > +	for (i =3D -1; i < samples * sample_length; i +=3D step) {
> > +		ret =3D regmap_raw_read(data->regmap, BMC150_ACCEL_REG_FIFO_DATA,
> > +				      &buffer[i], step);
> umm. Can't say I like the negative index into buffer.  Why is it
> necessary?

No this is an error, thanks.

> > +		if (ret)
> > +			break;
> >  	}
> > =20
> >  	if (ret)
> > -		dev_err(&client->dev, "Error transferring data from fifo\n");
> > +		dev_err(data->dev, "Error transferring data from fifo in single step=
s of %zu\n",
>=20
> multiple steps of %zu perhaps?

Yes.

> > +			step);
> > =20
> >  	return ret;
> >  }
> > @@ -963,14 +930,15 @@ static int __bmc150_accel_fifo_flush(struct iio_d=
ev *indio_dev,
> >  	u16 buffer[BMC150_ACCEL_FIFO_LENGTH * 3];
> >  	int64_t tstamp;
> >  	uint64_t sample_period;
> > -	ret =3D i2c_smbus_read_byte_data(data->client,
> > -				       BMC150_ACCEL_REG_FIFO_STATUS);
> > +	unsigned int val;
> > +
> > +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
> >  		return ret;
> >  	}
> > =20
> > -	count =3D ret & 0x7F;
> > +	count =3D val & 0x7F;
> > =20
> >  	if (!count)
> >  		return 0;
> > @@ -1009,7 +977,7 @@ static int __bmc150_accel_fifo_flush(struct iio_de=
v *indio_dev,
> >  	if (samples && count > samples)
> >  		count =3D samples;
> > =20
> > -	ret =3D bmc150_accel_fifo_transfer(data->client, (u8 *)buffer, count);
> > +	ret =3D bmc150_accel_fifo_transfer(data, (u8 *)buffer, count);
> >  	if (ret)
> >  		return ret;
> > =20
> > @@ -1206,17 +1174,19 @@ static irqreturn_t bmc150_accel_trigger_handler=
(int irq, void *p)
> >  	struct iio_dev *indio_dev =3D pf->indio_dev;
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> >  	int bit, ret, i =3D 0;
> > +	unsigned int raw_val;
> > =20
> >  	mutex_lock(&data->mutex);
> >  	for_each_set_bit(bit, indio_dev->active_scan_mask,
> >  			 indio_dev->masklength) {
> > -		ret =3D i2c_smbus_read_word_data(data->client,
> > -					       BMC150_ACCEL_AXIS_TO_REG(bit));
> > +		ret =3D regmap_bulk_read(data->regmap,
> > +				       BMC150_ACCEL_AXIS_TO_REG(bit), &raw_val,
> > +				       2);
> Is using a variable on the stack not going to cause issues when we add
> SPI?  (cacheline dma requirements).

Good question. Just looked it up. regmap uses spi_write_then_read which
uses its own buffer and copies the result back to the receive buffer at
the end. So this shouldn't be a problem.

Thanks,

Markus

> >  		if (ret < 0) {
> >  			mutex_unlock(&data->mutex);
> >  			goto err_read;
> >  		}
> > -		data->buffer[i++] =3D ret;
> > +		data->buffer[i++] =3D raw_val;
> >  	}
> >  	mutex_unlock(&data->mutex);
> > =20
> > @@ -1240,10 +1210,9 @@ static int bmc150_accel_trig_try_reen(struct iio=
_trigger *trig)
> > =20
> >  	mutex_lock(&data->mutex);
> >  	/* clear any latched interrupt */
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_INT_RST_LATCH,
> > -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> > -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> > +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> > +			   BMC150_ACCEL_INT_MODE_LATCH_INT |
> > +			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  	mutex_unlock(&data->mutex);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> > @@ -1300,34 +1269,34 @@ static int bmc150_accel_handle_roc_event(struct=
 iio_dev *indio_dev)
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> >  	int dir;
> >  	int ret;
> > +	unsigned int val;
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client,
> > -				       BMC150_ACCEL_REG_INT_STATUS_2);
> > +	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val=
);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
> >  		return ret;
> >  	}
> > =20
> > -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
> > +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_SIGN)
> >  		dir =3D IIO_EV_DIR_FALLING;
> >  	else
> >  		dir =3D IIO_EV_DIR_RISING;
> > =20
> > -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_X)
> > +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_X)
> >  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> >  							0,
> >  							IIO_MOD_X,
> >  							IIO_EV_TYPE_ROC,
> >  							dir),
> >  							data->timestamp);
> > -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Y)
> > +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Y)
> >  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> >  							0,
> >  							IIO_MOD_Y,
> >  							IIO_EV_TYPE_ROC,
> >  							dir),
> >  							data->timestamp);
> > -	if (ret & BMC150_ACCEL_ANY_MOTION_BIT_Z)
> > +	if (val & BMC150_ACCEL_ANY_MOTION_BIT_Z)
> >  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ACCEL,
> >  							0,
> >  							IIO_MOD_Z,
> > @@ -1360,10 +1329,9 @@ static irqreturn_t bmc150_accel_irq_thread_handl=
er(int irq, void *private)
> >  	}
> > =20
> >  	if (ack) {
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_INT_RST_LATCH,
> > -					BMC150_ACCEL_INT_MODE_LATCH_INT |
> > -					BMC150_ACCEL_INT_MODE_LATCH_RESET);
> > +		ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> > +				   BMC150_ACCEL_INT_MODE_LATCH_INT |
> > +				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  		if (ret)
> >  			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
> >  		ret =3D IRQ_HANDLED;
> > @@ -1516,7 +1484,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc1=
50_accel_data *data)
> >  	u8 reg =3D BMC150_ACCEL_REG_FIFO_CONFIG1;
> >  	int ret;
> > =20
> > -	ret =3D i2c_smbus_write_byte_data(data->client, reg, data->fifo_mode);
> > +	ret =3D regmap_write(data->regmap, reg, data->fifo_mode);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
> >  		return ret;
> > @@ -1525,9 +1493,8 @@ static int bmc150_accel_fifo_set_mode(struct bmc1=
50_accel_data *data)
> >  	if (!data->fifo_mode)
> >  		return 0;
> > =20
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMC150_ACCEL_REG_FIFO_CONFIG0,
> > -					data->watermark);
> > +	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
> > +			   data->watermark);
> >  	if (ret < 0)
> >  		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
> > =20
> > @@ -1627,6 +1594,13 @@ static int bmc150_accel_probe(struct i2c_client =
*client,
> >  	data =3D iio_priv(indio_dev);
> >  	i2c_set_clientdata(client, indio_dev);
> >  	data->client =3D client;
> > +	data->dev =3D &client->dev;
> > +
> > +	data->regmap =3D devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf=
);
> > +	if (IS_ERR(data->regmap)) {
> > +		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> > +		return PTR_ERR(data->regmap);
> > +	}
> > =20
> >  	if (id) {
> >  		name =3D id->name;
> > @@ -1680,9 +1654,8 @@ static int bmc150_accel_probe(struct i2c_client *=
client,
> >  		 * want to use latch mode when we can to prevent interrupt
> >  		 * flooding.
> >  		 */
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMC150_ACCEL_REG_INT_RST_LATCH,
> > -					     BMC150_ACCEL_INT_MODE_LATCH_RESET);
> > +		ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> > +				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  		if (ret < 0) {
> >  			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
> >  			goto err_buffer_cleanup;
> >=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--0Fhs++QIS2o6H55x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0ZIPAAoJEEpcgKtcEGQQ3UQP/Rf92hD7ED5EZ+nE7wgvN1Wj
GmTK9yb+v1nZ9Vow7Dj/yVP44YJIHCEnSwbd9zyVjyJpSvU4RzwPd6RMMjjw3u3M
Zx8BUwtmsNRf+5BCKHMJuCMekR6SC62KeAQax7qC+OAnYVMkw139ANiS9V9yFGpX
ypvhta/ZVhQvhQiL+FYYX7980rpKHcsnsWUoVnF0i205NfURZQZj9tHQVh3/YC7p
nWk1FLMYqjkEz/7tZioZ7u78H3KHu8SdVynoRA6+ssvQY+ZQYIN7I8PWqX8r9qf5
04M/Lt6k2aM6YE3D64MWAouurImy3HuccUDjsAK/nAsLmQEbHU9GLRQ2SWczAQnJ
AdnJ75KLwVfil3tPZlJQcRvz5mB0yKelc9nJzneGnGV1/xgH1Wop5jvJBmqCoyNJ
KCKVBMUf+ZLehO+SP/ZFGw93i3jXT8HhEc257+BILoMhBNmP6HnWX9e2uJkdeRFq
+8QaWjoROQQRn8/tRzIb5w/jUssLutAT4IwxrednL6aKurcMbcbg9GpLtlwQYSVF
BBkaLkI5VTC4b5dQfIdQR3QsSD7faF6LuKtngvVaC1DSMlDhqMi62e/NvL5tdE3T
yNLcpKV4KGPG4K8c1xZ6pSAKBxE8lHXnZ9KBKbni+wgdk4K/WCt327K95Z7jicLq
n+WuibkUq2GlKR8yELWx
=Ciik
-----END PGP SIGNATURE-----

--0Fhs++QIS2o6H55x--
