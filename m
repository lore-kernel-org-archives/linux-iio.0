Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53957 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754374AbbHQH5T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 17 Aug 2015 03:57:19 -0400
Date: Mon, 17 Aug 2015 09:57:13 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: Re: [PATCH 18/20] iio: bcm150: Remove i2c_client from private data
Message-ID: <20150817075713.GK19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-19-git-send-email-mpa@pengutronix.de>
 <55CF3FBF.1030707@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6tk3Tc7DvQ0rvXK2"
In-Reply-To: <55CF3FBF.1030707@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--6tk3Tc7DvQ0rvXK2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 15, 2015 at 02:33:51PM +0100, Jonathan Cameron wrote:
> On 12/08/15 11:12, Markus Pargmann wrote:
> > i2c_client struct is now only used for debugging output. We can use the
> > device struct as well so we can remove all struct i2c_client usage.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> This one looks fine to me.
>=20
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>=20
> Ideally these bmc150 patches should also get a look from Srinivas
> before merging however (and testing given I'm guessing you don't have
> all the parts!)

Thanks. Yes indeed, I only have the SPI parts. Also to keep the fifo
read support of the bmc150 as it is in the driver currently the regmap
series has to be fixed.

Best Regards,

Markus

>=20
> Jonathan
> > ---
> >  drivers/iio/accel/bmc150-accel.c | 120 +++++++++++++++++++------------=
--------
> >  1 file changed, 58 insertions(+), 62 deletions(-)
> >=20
> > diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc15=
0-accel.c
> > index 1484e956482e..d75e1b0aa7e9 100644
> > --- a/drivers/iio/accel/bmc150-accel.c
> > +++ b/drivers/iio/accel/bmc150-accel.c
> > @@ -185,9 +185,9 @@ enum bmc150_accel_trigger_id {
> >  };
> > =20
> >  struct bmc150_accel_data {
> > -	struct i2c_client *client;
> >  	struct regmap *regmap;
> >  	struct device *dev;
> > +	int irq;
> >  	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
> >  	atomic_t active_intr;
> >  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> > @@ -279,11 +279,11 @@ static int bmc150_accel_set_mode(struct bmc150_ac=
cel_data *data,
> >  	lpw_bits =3D mode << BMC150_ACCEL_PMU_MODE_SHIFT;
> >  	lpw_bits |=3D (dur_val << BMC150_ACCEL_PMU_BIT_SLEEP_DUR_SHIFT);
> > =20
> > -	dev_dbg(&data->client->dev, "Set Mode bits %x\n", lpw_bits);
> > +	dev_dbg(data->dev, "Set Mode bits %x\n", lpw_bits);
> > =20
> >  	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_LPW, lpw_bits=
);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_pmu_lpw\n");
> > +		dev_err(data->dev, "Error writing reg_pmu_lpw\n");
> >  		return ret;
> >  	}
> > =20
> > @@ -321,18 +321,18 @@ static int bmc150_accel_update_slope(struct bmc15=
0_accel_data *data)
> >  	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_6,
> >  					data->slope_thres);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_int_6\n");
> > +		dev_err(data->dev, "Error writing reg_int_6\n");
> >  		return ret;
> >  	}
> > =20
> >  	ret =3D regmap_update_bits(data->regmap, BMC150_ACCEL_REG_INT_5,
> >  				 BMC150_ACCEL_SLOPE_DUR_MASK, data->slope_dur);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error updating reg_int_5\n");
> > +		dev_err(data->dev, "Error updating reg_int_5\n");
> >  		return ret;
> >  	}
> > =20
> > -	dev_dbg(&data->client->dev, "%s: %x %x\n", __func__, data->slope_thre=
s,
> > +	dev_dbg(data->dev, "%s: %x %x\n", __func__, data->slope_thres,
> >  		data->slope_dur);
> > =20
> >  	return ret;
> > @@ -354,14 +354,14 @@ static int bmc150_accel_chip_init(struct bmc150_a=
ccel_data *data)
> > =20
> >  	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_CHIP_ID, &val);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev,
> > +		dev_err(data->dev,
> >  			"Error: Reading chip id\n");
> >  		return ret;
> >  	}
> > =20
> > -	dev_dbg(&data->client->dev, "Chip Id %x\n", val);
> > +	dev_dbg(data->dev, "Chip Id %x\n", val);
> >  	if (val !=3D data->chip_info->chip_id) {
> > -		dev_err(&data->client->dev, "Invalid chip %x\n", val);
> > +		dev_err(data->dev, "Invalid chip %x\n", val);
> >  		return -ENODEV;
> >  	}
> > =20
> > @@ -378,8 +378,7 @@ static int bmc150_accel_chip_init(struct bmc150_acc=
el_data *data)
> >  	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_PMU_RANGE,
> >  			   BMC150_ACCEL_DEF_RANGE_4G);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev,
> > -					"Error writing reg_pmu_range\n");
> > +		dev_err(data->dev, "Error writing reg_pmu_range\n");
> >  		return ret;
> >  	}
> > =20
> > @@ -397,7 +396,7 @@ static int bmc150_accel_chip_init(struct bmc150_acc=
el_data *data)
> >  			   BMC150_ACCEL_INT_MODE_LATCH_INT |
> >  			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev,
> > +		dev_err(data->dev,
> >  			"Error writing reg_int_rst_latch\n");
> >  		return ret;
> >  	}
> > @@ -439,16 +438,16 @@ static int bmc150_accel_set_power_state(struct bm=
c150_accel_data *data, bool on)
> >  	int ret;
> > =20
> >  	if (on)
> > -		ret =3D pm_runtime_get_sync(&data->client->dev);
> > +		ret =3D pm_runtime_get_sync(data->dev);
> >  	else {
> > -		pm_runtime_mark_last_busy(&data->client->dev);
> > -		ret =3D pm_runtime_put_autosuspend(&data->client->dev);
> > +		pm_runtime_mark_last_busy(data->dev);
> > +		ret =3D pm_runtime_put_autosuspend(data->dev);
> >  	}
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev,
> > +		dev_err(data->dev,
> >  			"Failed: bmc150_accel_set_power_state for %d\n", on);
> >  		if (on)
> > -			pm_runtime_put_noidle(&data->client->dev);
> > +			pm_runtime_put_noidle(data->dev);
> > =20
> >  		return ret;
> >  	}
> > @@ -531,7 +530,7 @@ static int bmc150_accel_set_interrupt(struct bmc150=
_accel_data *data, int i,
> >  	ret =3D regmap_update_bits(data->regmap, info->map_reg, info->map_bit=
mask,
> >  				 (state ? info->map_bitmask : 0));
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error updating reg_int_map\n");
> > +		dev_err(data->dev, "Error updating reg_int_map\n");
> >  		goto out_fix_power_state;
> >  	}
> > =20
> > @@ -539,7 +538,7 @@ static int bmc150_accel_set_interrupt(struct bmc150=
_accel_data *data, int i,
> >  	ret =3D regmap_update_bits(data->regmap, info->en_reg, info->en_bitma=
sk,
> >  				 (state ? info->en_bitmask : 0));
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error updating reg_int_en\n");
> > +		dev_err(data->dev, "Error updating reg_int_en\n");
> >  		goto out_fix_power_state;
> >  	}
> > =20
> > @@ -566,7 +565,7 @@ static int bmc150_accel_set_scale(struct bmc150_acc=
el_data *data, int val)
> >  				     BMC150_ACCEL_REG_PMU_RANGE,
> >  				     data->chip_info->scale_table[i].reg_range);
> >  			if (ret < 0) {
> > -				dev_err(&data->client->dev,
> > +				dev_err(data->dev,
> >  					"Error writing pmu_range\n");
> >  				return ret;
> >  			}
> > @@ -588,7 +587,7 @@ static int bmc150_accel_get_temp(struct bmc150_acce=
l_data *data, int *val)
> > =20
> >  	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_temp\n");
> > +		dev_err(data->dev, "Error reading reg_temp\n");
> >  		mutex_unlock(&data->mutex);
> >  		return ret;
> >  	}
> > @@ -617,7 +616,7 @@ static int bmc150_accel_get_axis(struct bmc150_acce=
l_data *data,
> >  	ret =3D regmap_bulk_read(data->regmap, BMC150_ACCEL_AXIS_TO_REG(axis),
> >  			       &raw_val, 2);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading axis %d\n", axis);
> > +		dev_err(data->dev, "Error reading axis %d\n", axis);
> >  		bmc150_accel_set_power_state(data, false);
> >  		mutex_unlock(&data->mutex);
> >  		return ret;
> > @@ -934,7 +933,7 @@ static int __bmc150_accel_fifo_flush(struct iio_dev=
 *indio_dev,
> > =20
> >  	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_FIFO_STATUS, &val);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_fifo_status\n");
> > +		dev_err(data->dev, "Error reading reg_fifo_status\n");
> >  		return ret;
> >  	}
> > =20
> > @@ -1215,7 +1214,7 @@ static int bmc150_accel_trig_try_reen(struct iio_=
trigger *trig)
> >  			   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  	mutex_unlock(&data->mutex);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev,
> > +		dev_err(data->dev,
> >  			"Error writing reg_int_rst_latch\n");
> >  		return ret;
> >  	}
> > @@ -1273,7 +1272,7 @@ static int bmc150_accel_handle_roc_event(struct i=
io_dev *indio_dev)
> > =20
> >  	ret =3D regmap_read(data->regmap, BMC150_ACCEL_REG_INT_STATUS_2, &val=
);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error reading reg_int_status_2\n");
> > +		dev_err(data->dev, "Error reading reg_int_status_2\n");
> >  		return ret;
> >  	}
> > =20
> > @@ -1333,7 +1332,7 @@ static irqreturn_t bmc150_accel_irq_thread_handle=
r(int irq, void *private)
> >  				   BMC150_ACCEL_INT_MODE_LATCH_INT |
> >  				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  		if (ret)
> > -			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
> > +			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
> >  		ret =3D IRQ_HANDLED;
> >  	} else {
> >  		ret =3D IRQ_NONE;
> > @@ -1385,17 +1384,13 @@ static const char *bmc150_accel_match_acpi_devi=
ce(struct device *dev, int *data)
> >  	return dev_name(dev);
> >  }
> > =20
> > -static int bmc150_accel_gpio_probe(struct i2c_client *client,
> > -					struct bmc150_accel_data *data)
> > +static int bmc150_accel_gpio_probe(struct bmc150_accel_data *data)
> >  {
> >  	struct device *dev;
> >  	struct gpio_desc *gpio;
> >  	int ret;
> > =20
> > -	if (!client)
> > -		return -EINVAL;
> > -
> > -	dev =3D &client->dev;
> > +	dev =3D data->dev;
> > =20
> >  	/* data ready gpio interrupt pin */
> >  	gpio =3D devm_gpiod_get_index(dev, BMC150_ACCEL_GPIO_NAME, 0, GPIOD_I=
N);
> > @@ -1448,7 +1443,7 @@ static int bmc150_accel_triggers_setup(struct iio=
_dev *indio_dev,
> >  	for (i =3D 0; i < BMC150_ACCEL_TRIGGERS; i++) {
> >  		struct bmc150_accel_trigger *t =3D &data->triggers[i];
> > =20
> > -		t->indio_trig =3D devm_iio_trigger_alloc(&data->client->dev,
> > +		t->indio_trig =3D devm_iio_trigger_alloc(data->dev,
> >  					       bmc150_accel_triggers[i].name,
> >  						       indio_dev->name,
> >  						       indio_dev->id);
> > @@ -1457,7 +1452,7 @@ static int bmc150_accel_triggers_setup(struct iio=
_dev *indio_dev,
> >  			break;
> >  		}
> > =20
> > -		t->indio_trig->dev.parent =3D &data->client->dev;
> > +		t->indio_trig->dev.parent =3D data->dev;
> >  		t->indio_trig->ops =3D &bmc150_accel_trigger_ops;
> >  		t->intr =3D bmc150_accel_triggers[i].intr;
> >  		t->data =3D data;
> > @@ -1486,7 +1481,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc1=
50_accel_data *data)
> > =20
> >  	ret =3D regmap_write(data->regmap, reg, data->fifo_mode);
> >  	if (ret < 0) {
> > -		dev_err(&data->client->dev, "Error writing reg_fifo_config1\n");
> > +		dev_err(data->dev, "Error writing reg_fifo_config1\n");
> >  		return ret;
> >  	}
> > =20
> > @@ -1496,7 +1491,7 @@ static int bmc150_accel_fifo_set_mode(struct bmc1=
50_accel_data *data)
> >  	ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_FIFO_CONFIG0,
> >  			   data->watermark);
> >  	if (ret < 0)
> > -		dev_err(&data->client->dev, "Error writing reg_fifo_config0\n");
> > +		dev_err(data->dev, "Error writing reg_fifo_config0\n");
> > =20
> >  	return ret;
> >  }
> > @@ -1586,6 +1581,7 @@ static int bmc150_accel_probe(struct i2c_client *=
client,
> >  	int ret;
> >  	const char *name =3D NULL;
> >  	int chip_id =3D 0;
> > +	struct device *dev;
> > =20
> >  	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> >  	if (!indio_dev)
> > @@ -1593,12 +1589,13 @@ static int bmc150_accel_probe(struct i2c_client=
 *client,
> > =20
> >  	data =3D iio_priv(indio_dev);
> >  	i2c_set_clientdata(client, indio_dev);
> > -	data->client =3D client;
> >  	data->dev =3D &client->dev;
> > +	dev =3D &client->dev;
> > +	data->irq =3D client->irq;
> > =20
> >  	data->regmap =3D devm_regmap_init_i2c(client, &bmc150_i2c_regmap_conf=
);
> >  	if (IS_ERR(data->regmap)) {
> > -		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
> > +		dev_err(dev, "Failed to initialize i2c regmap\n");
> >  		return PTR_ERR(data->regmap);
> >  	}
> > =20
> > @@ -1607,8 +1604,8 @@ static int bmc150_accel_probe(struct i2c_client *=
client,
> >  		chip_id =3D id->driver_data;
> >  	}
> > =20
> > -	if (ACPI_HANDLE(&client->dev))
> > -		name =3D bmc150_accel_match_acpi_device(&client->dev, &chip_id);
> > +	if (ACPI_HANDLE(dev))
> > +		name =3D bmc150_accel_match_acpi_device(dev, &chip_id);
> > =20
> >  	data->chip_info =3D &bmc150_accel_chip_info_tbl[chip_id];
> > =20
> > @@ -1618,7 +1615,7 @@ static int bmc150_accel_probe(struct i2c_client *=
client,
> > =20
> >  	mutex_init(&data->mutex);
> > =20
> > -	indio_dev->dev.parent =3D &client->dev;
> > +	indio_dev->dev.parent =3D dev;
> >  	indio_dev->channels =3D data->chip_info->channels;
> >  	indio_dev->num_channels =3D data->chip_info->num_channels;
> >  	indio_dev->name =3D name;
> > @@ -1630,16 +1627,16 @@ static int bmc150_accel_probe(struct i2c_client=
 *client,
> >  					 bmc150_accel_trigger_handler,
> >  					 &bmc150_accel_buffer_ops);
> >  	if (ret < 0) {
> > -		dev_err(&client->dev, "Failed: iio triggered buffer setup\n");
> > +		dev_err(data->dev, "Failed: iio triggered buffer setup\n");
> >  		return ret;
> >  	}
> > =20
> > -	if (client->irq <=3D 0)
> > -		client->irq =3D bmc150_accel_gpio_probe(client, data);
> > +	if (data->irq <=3D 0)
> > +		data->irq =3D bmc150_accel_gpio_probe(data);
> > =20
> > -	if (client->irq > 0) {
> > +	if (data->irq > 0) {
> >  		ret =3D devm_request_threaded_irq(
> > -						&client->dev, client->irq,
> > +						data->dev, data->irq,
> >  						bmc150_accel_irq_handler,
> >  						bmc150_accel_irq_thread_handler,
> >  						IRQF_TRIGGER_RISING,
> > @@ -1657,7 +1654,7 @@ static int bmc150_accel_probe(struct i2c_client *=
client,
> >  		ret =3D regmap_write(data->regmap, BMC150_ACCEL_REG_INT_RST_LATCH,
> >  				   BMC150_ACCEL_INT_MODE_LATCH_RESET);
> >  		if (ret < 0) {
> > -			dev_err(&data->client->dev, "Error writing reg_int_rst_latch\n");
> > +			dev_err(data->dev, "Error writing reg_int_rst_latch\n");
> >  			goto err_buffer_cleanup;
> >  		}
> > =20
> > @@ -1678,18 +1675,17 @@ static int bmc150_accel_probe(struct i2c_client=
 *client,
> > =20
> >  	ret =3D iio_device_register(indio_dev);
> >  	if (ret < 0) {
> > -		dev_err(&client->dev, "Unable to register iio device\n");
> > +		dev_err(data->dev, "Unable to register iio device\n");
> >  		goto err_trigger_unregister;
> >  	}
> > =20
> > -	ret =3D pm_runtime_set_active(&client->dev);
> > +	ret =3D pm_runtime_set_active(dev);
> >  	if (ret)
> >  		goto err_iio_unregister;
> > =20
> > -	pm_runtime_enable(&client->dev);
> > -	pm_runtime_set_autosuspend_delay(&client->dev,
> > -					 BMC150_AUTO_SUSPEND_DELAY_MS);
> > -	pm_runtime_use_autosuspend(&client->dev);
> > +	pm_runtime_enable(dev);
> > +	pm_runtime_set_autosuspend_delay(dev, BMC150_AUTO_SUSPEND_DELAY_MS);
> > +	pm_runtime_use_autosuspend(dev);
> > =20
> >  	return 0;
> > =20
> > @@ -1708,9 +1704,9 @@ static int bmc150_accel_remove(struct i2c_client =
*client)
> >  	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> > =20
> > -	pm_runtime_disable(&client->dev);
> > -	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> > +	pm_runtime_disable(data->dev);
> > +	pm_runtime_set_suspended(data->dev);
> > +	pm_runtime_put_noidle(data->dev);
> > =20
> >  	iio_device_unregister(indio_dev);
> > =20
> > @@ -1728,7 +1724,7 @@ static int bmc150_accel_remove(struct i2c_client =
*client)
> >  #ifdef CONFIG_PM_SLEEP
> >  static int bmc150_accel_suspend(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> > =20
> >  	mutex_lock(&data->mutex);
> > @@ -1740,7 +1736,7 @@ static int bmc150_accel_suspend(struct device *de=
v)
> > =20
> >  static int bmc150_accel_resume(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> > =20
> >  	mutex_lock(&data->mutex);
> > @@ -1756,11 +1752,11 @@ static int bmc150_accel_resume(struct device *d=
ev)
> >  #ifdef CONFIG_PM
> >  static int bmc150_accel_runtime_suspend(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> >  	int ret;
> > =20
> > -	dev_dbg(&data->client->dev,  __func__);
> > +	dev_dbg(data->dev,  __func__);
> >  	ret =3D bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_SUSPEND, =
0);
> >  	if (ret < 0)
> >  		return -EAGAIN;
> > @@ -1770,12 +1766,12 @@ static int bmc150_accel_runtime_suspend(struct =
device *dev)
> > =20
> >  static int bmc150_accel_runtime_resume(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct bmc150_accel_data *data =3D iio_priv(indio_dev);
> >  	int ret;
> >  	int sleep_val;
> > =20
> > -	dev_dbg(&data->client->dev,  __func__);
> > +	dev_dbg(data->dev,  __func__);
> > =20
> >  	ret =3D bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0=
);
> >  	if (ret < 0)
> >=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--6tk3Tc7DvQ0rvXK2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV0ZPZAAoJEEpcgKtcEGQQlEIP/0AD/SEvuxtlO1R0ujKQajwZ
IgKvBojo+awnDk7wmpGvjshxWsbPkJgLwEufyYSHSggC2yPzdnjdqctz+2u5mmWC
f2EebALC51c23/SLrB8HuyArjwquIrvyV+w0NPQnirsNELcEB41TNex6MvQm8a7P
4ESjX8s7GdzeE2NSqbjRvXwkdStehhcZB/BO/ojrlnxdJG95TzaspoAbG5ill4iD
OSfakA+kaf75XQ7+ETJc9Ka3weYkdtGuGd0V5CYbTjyNGtoDVSVAmBftajOwUNaf
1yqbsDUiZhnXi9JN78/+NnZbwphEhrd34J4TGRuLjFBt4YmqxrXKk3+94YSXAzkG
Hp/8Ss4OUJKgf4c2JeXLTuh1EjXXNoX3ietqRpwpSM7HA222e5Kk6RcCU/oLyYDl
V4yvAitOkPqZI1N2a0r7+EhGzrJbR/vnXwlVfLv1s4jEtRmAayG/EuGTq+ucPC8I
tWgihG9yboi085qimXNOCtJjY2naxhqb3w66lo0GElDkzZyPks3Wf46RDNbHPjXF
8DLp13nTVFdLQQom1vcc3EuijJ0Ip3nN+fKsM2/TWI1mZ3ppBNll1FN2nvK2bW71
ZXnC+xnqGevqjX50Q9XIngUTfvrDN1LV0UZeO2vCtMjikJzAjyYCIsWaJSWBsFVN
wAs00/9bbDzZRv5urnFx
=9bnk
-----END PGP SIGNATURE-----

--6tk3Tc7DvQ0rvXK2--
