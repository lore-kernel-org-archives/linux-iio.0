Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49744 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751180AbbHBRda (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Aug 2015 13:33:30 -0400
Date: Sun, 2 Aug 2015 19:33:19 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/7] iio: bmg160: Use i2c regmap instead of direct i2c
 access
Message-ID: <20150802173319.GA19600@pengutronix.de>
References: <1438370998.10028.4.camel@spandruv-DESK3.jf.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
In-Reply-To: <1438370998.10028.4.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 31, 2015 at 12:29:58PM -0700, Srinivas Pandruvada wrote:
> On Wed, 2015-07-29 at 15:46 +0200, Markus Pargmann wrote:
> > This patch introduces regmap usage into the driver. This is done to
> > later easily support the SPI interface of this chip.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  drivers/iio/gyro/bmg160.c | 200 +++++++++++++++++++++-----------------=
--------
> >  1 file changed, 89 insertions(+), 111 deletions(-)
> >=20
> > diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> > index 460bf715d541..626f5c98dde8 100644
> > --- a/drivers/iio/gyro/bmg160.c
> > +++ b/drivers/iio/gyro/bmg160.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/trigger_consumer.h>
> >  #include <linux/iio/triggered_buffer.h>
> > +#include <linux/regmap.h>
> Don't we need "select REGMAP_I2C" in Kconfig?

Oh yes. This is wrongly introduced in Patch 6/7. But it should really be
in this one.

Thanks,

Markus

> Changes looks fine. But there are many changes, so we need to test this
> on i2c before taking this patch.
>=20
> Thanks,
> Srinivas
>=20
> > =20
> >  #define BMG160_DRV_NAME		"bmg160"
> >  #define BMG160_IRQ_NAME		"bmg160_event"
> > @@ -98,6 +99,7 @@
> > =20
> >  struct bmg160_data {
> >  	struct i2c_client *client;
> > +	struct regmap *regmap;
> >  	struct iio_trigger *dready_trig;
> >  	struct iio_trigger *motion_trig;
> >  	struct mutex mutex;
> > @@ -134,12 +136,19 @@ static const struct {
> >  			   { 133, BMG160_RANGE_250DPS},
> >  			   { 66, BMG160_RANGE_125DPS} };
> > =20
> > +struct regmap_config bmg160_regmap_i2c_conf =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +
> > +	.use_single_rw =3D true,
> > +	.cache_type =3D REGCACHE_NONE,
> > +};
> > +
> >  static int bmg160_set_mode(struct bmg160_data *data, u8 mode)
> >  {
> >  	int ret;
> > =20
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_PMU_LPW, mode);
> > +	ret =3D regmap_write(data->regmap, BMG160_REG_PMU_LPW, mode);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
> >  		return ret;
> > @@ -169,8 +178,7 @@ static int bmg160_set_bw(struct bmg160_data *data, =
int val)
> >  	if (bw_bits < 0)
> >  		return bw_bits;
> > =20
> > -	ret =3D i2c_smbus_write_byte_data(data->client, BMG160_REG_PMU_BW,
> > -					bw_bits);
> > +	ret =3D regmap_write(data->regmap, BMG160_REG_PMU_BW, bw_bits);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_pmu_bw\n");
> >  		return ret;
> > @@ -184,16 +192,17 @@ static int bmg160_set_bw(struct bmg160_data *data=
, int val)
> >  static int bmg160_chip_init(struct bmg160_data *data)
> >  {
> >  	int ret;
> > +	unsigned int val;
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMG160_REG_CHIP_ID);
> > +	ret =3D regmap_read(data->regmap, BMG160_REG_CHIP_ID, &val);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading reg_chip_id\n");
> >  		return ret;
> >  	}
> > =20
> > -	dev_dbg(&data->client->dev, "Chip Id %x\n", ret);
> > -	if (ret !=3D BMG160_CHIP_ID_VAL) {
> > -		dev_err(&data->client->dev, "invalid chip %x\n", ret);
> > +	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
> > +	if (val !=3D BMG160_CHIP_ID_VAL) {
> > +		dev_err(&data->client->dev, "invalid chip %x\n", val);
> >  		return -ENODEV;
> >  	}
> > =20
> > @@ -210,40 +219,31 @@ static int bmg160_chip_init(struct bmg160_data *d=
ata)
> >  		return ret;
> > =20
> >  	/* Set Default Range */
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_RANGE,
> > -					BMG160_RANGE_500DPS);
> > +	ret =3D regmap_write(data->regmap, BMG160_REG_RANGE, BMG160_RANGE_500=
DPS);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_range\n");
> >  		return ret;
> >  	}
> >  	data->dps_range =3D BMG160_RANGE_500DPS;
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMG160_REG_SLOPE_THRES=
);
> > +	ret =3D regmap_read(data->regmap, BMG160_REG_SLOPE_THRES, &val);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading reg_slope_thres\n");
> >  		return ret;
> >  	}
> > -	data->slope_thres =3D ret;
> > +	data->slope_thres =3D val;
> > =20
> >  	/* Set default interrupt mode */
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_EN_1);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_en_1\n");
> > -		return ret;
> > -	}
> > -	ret &=3D ~BMG160_INT1_BIT_OD;
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_INT_EN_1, ret);
> > +	ret =3D regmap_update_bits(data->regmap, BMG160_REG_INT_EN_1,
> > +				 BMG160_INT1_BIT_OD, 0);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_en_1\n");
> > +		dev_err(&data->client->dev, "Error updating bits in reg_int_en_1\n");
> >  		return ret;
> >  	}
> > =20
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_INT_RST_LATCH,
> > -					BMG160_INT_MODE_LATCH_INT |
> > -					BMG160_INT_MODE_LATCH_RESET);
> > +	ret =3D regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
> > +			   BMG160_INT_MODE_LATCH_INT |
> > +			   BMG160_INT_MODE_LATCH_RESET);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  			"Error writing reg_motion_intr\n");
> > @@ -284,41 +284,28 @@ static int bmg160_setup_any_motion_interrupt(stru=
ct bmg160_data *data,
> >  	int ret;
> > =20
> >  	/* Enable/Disable INT_MAP0 mapping */
> > -	ret =3D i2c_smbus_read_byte_data(data->client,  BMG160_REG_INT_MAP_0);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_map0\n");
> > -		return ret;
> > -	}
> > -	if (status)
> > -		ret |=3D BMG160_INT_MAP_0_BIT_ANY;
> > -	else
> > -		ret &=3D ~BMG160_INT_MAP_0_BIT_ANY;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_INT_MAP_0,
> > -					ret);
> > +	ret =3D regmap_update_bits(data->regmap, BMG160_REG_INT_MAP_0,
> > +				 BMG160_INT_MAP_0_BIT_ANY,
> > +				 (status ? BMG160_INT_MAP_0_BIT_ANY : 0));
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_map0\n");
> > +		dev_err(&data->client->dev, "Error updating bits reg_int_map0\n");
> >  		return ret;
> >  	}
> > =20
> >  	/* Enable/Disable slope interrupts */
> >  	if (status) {
> >  		/* Update slope thres */
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_SLOPE_THRES,
> > -						data->slope_thres);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_SLOPE_THRES,
> > +				   data->slope_thres);
> >  		if (ret < 0) {
> >  			dev_err(&data->client->dev,
> >  				"Error writing reg_slope_thres\n");
> >  			return ret;
> >  		}
> > =20
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_MOTION_INTR,
> > -						BMG160_INT_MOTION_X |
> > -						BMG160_INT_MOTION_Y |
> > -						BMG160_INT_MOTION_Z);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_MOTION_INTR,
> > +				   BMG160_INT_MOTION_X | BMG160_INT_MOTION_Y |
> > +				   BMG160_INT_MOTION_Z);
> >  		if (ret < 0) {
> >  			dev_err(&data->client->dev,
> >  				"Error writing reg_motion_intr\n");
> > @@ -331,10 +318,10 @@ static int bmg160_setup_any_motion_interrupt(stru=
ct bmg160_data *data,
> >  		 * to set latched mode, we will be flooded anyway with INTR
> >  		 */
> >  		if (!data->dready_trigger_on) {
> > -			ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_INT_RST_LATCH,
> > -						BMG160_INT_MODE_LATCH_INT |
> > -						BMG160_INT_MODE_LATCH_RESET);
> > +			ret =3D regmap_write(data->regmap,
> > +					   BMG160_REG_INT_RST_LATCH,
> > +					   BMG160_INT_MODE_LATCH_INT |
> > +					   BMG160_INT_MODE_LATCH_RESET);
> >  			if (ret < 0) {
> >  				dev_err(&data->client->dev,
> >  					"Error writing reg_rst_latch\n");
> > @@ -342,14 +329,12 @@ static int bmg160_setup_any_motion_interrupt(stru=
ct bmg160_data *data,
> >  			}
> >  		}
> > =20
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_INT_EN_0,
> > -						BMG160_DATA_ENABLE_INT);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_INT_EN_0,
> > +				   BMG160_DATA_ENABLE_INT);
> > =20
> > -	} else
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_INT_EN_0,
> > -						0);
> > +	} else {
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_INT_EN_0, 0);
> > +	}
> > =20
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_int_en0\n");
> > @@ -365,55 +350,39 @@ static int bmg160_setup_new_data_interrupt(struct=
 bmg160_data *data,
> >  	int ret;
> > =20
> >  	/* Enable/Disable INT_MAP1 mapping */
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_MAP_1);
> > -	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_map1\n");
> > -		return ret;
> > -	}
> > -
> > -	if (status)
> > -		ret |=3D BMG160_INT_MAP_1_BIT_NEW_DATA;
> > -	else
> > -		ret &=3D ~BMG160_INT_MAP_1_BIT_NEW_DATA;
> > -
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_INT_MAP_1,
> > -					ret);
> > +	ret =3D regmap_update_bits(data->regmap, BMG160_REG_INT_MAP_1,
> > +				 BMG160_INT_MAP_1_BIT_NEW_DATA,
> > +				 (status ? BMG160_INT_MAP_1_BIT_NEW_DATA : 0));
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_map1\n");
> > +		dev_err(&data->client->dev, "Error updating bits in reg_int_map1\n");
> >  		return ret;
> >  	}
> > =20
> >  	if (status) {
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_INT_RST_LATCH,
> > -						BMG160_INT_MODE_NON_LATCH_INT |
> > -						BMG160_INT_MODE_LATCH_RESET);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
> > +				   BMG160_INT_MODE_NON_LATCH_INT |
> > +				   BMG160_INT_MODE_LATCH_RESET);
> >  		if (ret < 0) {
> >  			dev_err(&data->client->dev,
> >  				"Error writing reg_rst_latch\n");
> >  				return ret;
> >  		}
> > =20
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_INT_EN_0,
> > -						BMG160_DATA_ENABLE_INT);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_INT_EN_0,
> > +				   BMG160_DATA_ENABLE_INT);
> > =20
> >  	} else {
> >  		/* Restore interrupt mode */
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_INT_RST_LATCH,
> > -						BMG160_INT_MODE_LATCH_INT |
> > -						BMG160_INT_MODE_LATCH_RESET);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
> > +				   BMG160_INT_MODE_LATCH_INT |
> > +				   BMG160_INT_MODE_LATCH_RESET);
> >  		if (ret < 0) {
> >  			dev_err(&data->client->dev,
> >  				"Error writing reg_rst_latch\n");
> >  				return ret;
> >  		}
> > =20
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -						BMG160_REG_INT_EN_0,
> > -						0);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_INT_EN_0, 0);
> >  	}
> > =20
> >  	if (ret < 0) {
> > @@ -444,10 +413,8 @@ static int bmg160_set_scale(struct bmg160_data *da=
ta, int val)
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(bmg160_scale_table); ++i) {
> >  		if (bmg160_scale_table[i].scale =3D=3D val) {
> > -			ret =3D i2c_smbus_write_byte_data(
> > -					data->client,
> > -					BMG160_REG_RANGE,
> > -					bmg160_scale_table[i].dps_range);
> > +			ret =3D regmap_write(data->regmap, BMG160_REG_RANGE,
> > +					   bmg160_scale_table[i].dps_range);
> >  			if (ret < 0) {
> >  				dev_err(&data->client->dev,
> >  					"Error writing reg_range\n");
> > @@ -464,6 +431,7 @@ static int bmg160_set_scale(struct bmg160_data *dat=
a, int val)
> >  static int bmg160_get_temp(struct bmg160_data *data, int *val)
> >  {
> >  	int ret;
> > +	unsigned int raw_val;
> > =20
> >  	mutex_lock(&data->mutex);
> >  	ret =3D bmg160_set_power_state(data, true);
> > @@ -472,7 +440,7 @@ static int bmg160_get_temp(struct bmg160_data *data=
, int *val)
> >  		return ret;
> >  	}
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMG160_REG_TEMP);
> > +	ret =3D regmap_read(data->regmap, BMG160_REG_TEMP, &raw_val);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading reg_temp\n");
> >  		bmg160_set_power_state(data, false);
> > @@ -480,7 +448,7 @@ static int bmg160_get_temp(struct bmg160_data *data=
, int *val)
> >  		return ret;
> >  	}
> > =20
> > -	*val =3D sign_extend32(ret, 7);
> > +	*val =3D sign_extend32(raw_val, 7);
> >  	ret =3D bmg160_set_power_state(data, false);
> >  	mutex_unlock(&data->mutex);
> >  	if (ret < 0)
> > @@ -492,6 +460,7 @@ static int bmg160_get_temp(struct bmg160_data *data=
, int *val)
> >  static int bmg160_get_axis(struct bmg160_data *data, int axis, int *va=
l)
> >  {
> >  	int ret;
> > +	unsigned int raw_val;
> > =20
> >  	mutex_lock(&data->mutex);
> >  	ret =3D bmg160_set_power_state(data, true);
> > @@ -500,7 +469,8 @@ static int bmg160_get_axis(struct bmg160_data *data=
, int axis, int *val)
> >  		return ret;
> >  	}
> > =20
> > -	ret =3D i2c_smbus_read_word_data(data->client, BMG160_AXIS_TO_REG(axi=
s));
> > +	ret =3D regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw=
_val,
> > +			       2);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
> >  		bmg160_set_power_state(data, false);
> > @@ -508,7 +478,7 @@ static int bmg160_get_axis(struct bmg160_data *data=
, int axis, int *val)
> >  		return ret;
> >  	}
> > =20
> > -	*val =3D sign_extend32(ret, 15);
> > +	*val =3D sign_extend32(raw_val, 15);
> >  	ret =3D bmg160_set_power_state(data, false);
> >  	mutex_unlock(&data->mutex);
> >  	if (ret < 0)
> > @@ -807,12 +777,13 @@ static irqreturn_t bmg160_trigger_handler(int irq=
, void *p)
> >  	struct iio_dev *indio_dev =3D pf->indio_dev;
> >  	struct bmg160_data *data =3D iio_priv(indio_dev);
> >  	int bit, ret, i =3D 0;
> > +	unsigned int val;
> > =20
> >  	mutex_lock(&data->mutex);
> >  	for_each_set_bit(bit, indio_dev->active_scan_mask,
> >  			 indio_dev->masklength) {
> > -		ret =3D i2c_smbus_read_word_data(data->client,
> > -					       BMG160_AXIS_TO_REG(bit));
> > +		ret =3D regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(bit),
> > +				       &val, 2);
> >  		if (ret < 0) {
> >  			mutex_unlock(&data->mutex);
> >  			goto err;
> > @@ -840,10 +811,9 @@ static int bmg160_trig_try_reen(struct iio_trigger=
 *trig)
> >  		return 0;
> > =20
> >  	/* Set latched mode interrupt and clear any latched interrupt */
> > -	ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_INT_RST_LATCH,
> > -					BMG160_INT_MODE_LATCH_INT |
> > -					BMG160_INT_MODE_LATCH_RESET);
> > +	ret =3D regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
> > +			   BMG160_INT_MODE_LATCH_INT |
> > +			   BMG160_INT_MODE_LATCH_RESET);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error writing reg_rst_latch\n");
> >  		return ret;
> > @@ -907,33 +877,34 @@ static irqreturn_t bmg160_event_handler(int irq, =
void *private)
> >  	struct bmg160_data *data =3D iio_priv(indio_dev);
> >  	int ret;
> >  	int dir;
> > +	unsigned int val;
> > =20
> > -	ret =3D i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_STATUS_=
2);
> > +	ret =3D regmap_read(data->regmap, BMG160_REG_INT_STATUS_2, &val);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev, "Error reading reg_int_status2\n");
> >  		gCONFIG_oto ack_intr_status;
> >  	}
> > =20
> > -	if (ret & 0x08)
> > +	if (val & 0x08)
> >  		dir =3D IIO_EV_DIR_RISING;
> >  	else
> >  		dir =3D IIO_EV_DIR_FALLING;
> > =20
> > -	if (ret & BMG160_ANY_MOTION_BIT_X)
> > +	if (val & BMG160_ANY_MOTION_BIT_X)
> >  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> >  							0,
> >  							IIO_MOD_X,
> >  							IIO_EV_TYPE_ROC,
> >  							dir),
> >  							iio_get_time_ns());
> > -	if (ret & BMG160_ANY_MOTION_BIT_Y)
> > +	if (val & BMG160_ANY_MOTION_BIT_Y)
> >  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> >  							0,
> >  							IIO_MOD_Y,
> >  							IIO_EV_TYPE_ROC,
> >  		CONFIG_					dir),
> >  							iio_get_time_ns());
> > -	if (ret & BMG160_ANY_MOTION_BIT_Z)
> > +	if (val & BMG160_ANY_MOTION_BIT_Z)
> >  		iio_push_event(indio_dev, IIO_MOD_EVENT_CODE(IIO_ANGL_VEL,
> >  							0,
> >  							IIO_MOD_Z,
> > @@ -943,10 +914,9 @@ static irqreturn_t bmg160_event_handler(int irq, v=
oid *private)
> > =20
> >  ack_intr_status:
> >  	if (!data->dready_trigger_on) {
> > -		ret =3D i2c_smbus_write_byte_data(data->client,
> > -					BMG160_REG_INT_RST_LATCH,
> > -					BMG160_INT_MODE_LATCH_INT |
> > -					BMG160_INT_MODE_LATCH_RESET);
> > +		ret =3D regmap_write(data->regmap, BMG160_REG_INT_RST_LATCH,
> > +				   BMG160_INT_MODE_LATCH_INT |
> > +				   BMG160_INT_MODE_LATCH_RESET);
> >  		if (ret < 0)
> >  			dev_err(&data->client->dev,
> >  				"Error writing reg_rst_latch\n");
> > @@ -1038,6 +1008,14 @@ static int bmg160_probe(struct i2c_client *clien=
t,
> >  	struct iio_dev *indio_dev;
> >  	int ret;
> >  	const char *name =3D NULL;
> > +	struct regmap *regmap;
> > +
> > +	regmap =3D devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> > +			(int)PTR_ERR(regmap));
> > +		return PTR_ERR(regmap);
> > +	}
> > =20
> >  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> >  	if (!indio_dev)
>=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVvlRfAAoJEEpcgKtcEGQQzJMP/jhGBnS1WYeIwrdMGxYsgTDW
Uu+B1lIWqp+l/a0o0kaFY3g/VifFp2YJHIzvNle5WFW9ibZrYu137mOo7fkBJaIb
/6ms747J1ls0sXPB+p5aF8Q19D+0C35TcmL8JLkq+27Dr8QTz0RETzNHWGRMrA+C
98rsfryQGDFg/E1jvatsCVOL0CHosl9DMDyqSalxrSpzuRNhf0EboRSOP06FJCzG
kC66adujJg8POcB3ri7xbED1wh5z+gJnHyx7Kkyqv/X034B0j2JuDjmD0waXl/lS
ixb2C8H7uebwh7XGhS7MOu3kUjvP56gL8Rbac3cpQuVfAxqp2E3rctsNys5HJY9W
eyZqkF/BwaQAeJOdZGRLFqtSvWtEJSVe62wLDtX33bkpgw1TkJYVuHTdf8ybFe4y
UW4cMy2+n94haUldclE6frAgZ3tewUOwCxmuzQls+R8DcwEYS2yXgoiZr4MaTV/Q
848l4dQ1WZumDqsABEMfUr+/yfyD18vUd8b3oysW/HjJ4K3YLAVhtzXyTLHTMQNk
RbIskaW88glXlLV1N3t02Z29e91rBdOp48tEh4JGVyLmsFXWIsQvMXUzINhnXIvL
msG3RwLALx4eG/TfC76bCvUMvLuEOBpqflAQ+XKzRueetMj8eDVuiC7jqMoZJ37o
0R7nhTjro/lZJVBA7niV
=875h
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
