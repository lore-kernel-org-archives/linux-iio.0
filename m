Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54046 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbbINO0P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Sep 2015 10:26:15 -0400
Date: Mon, 14 Sep 2015 16:26:05 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH v4 1/2] iio: bmg160: Separate i2c and core driver
Message-ID: <20150914142605.GJ18484@pengutronix.de>
References: <1439986366-25291-1-git-send-email-mpa@pengutronix.de>
 <1439986366-25291-2-git-send-email-mpa@pengutronix.de>
 <55E47B37.8010703@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jIYo0VRlfdMI9fLa"
In-Reply-To: <55E47B37.8010703@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--jIYo0VRlfdMI9fLa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jonathon,

Sorry for the late response I was on vacation.

On Mon, Aug 31, 2015 at 05:05:11PM +0100, Jonathan Cameron wrote:
> On 19/08/15 13:12, Markus Pargmann wrote:
> > This patch separates the core driver using regmap and the i2c driver
> > which creates the i2c regmap. Also in the Kconfig file BMG160 and
> > BMG160_I2C are separate now.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> Hi Markus,
>=20
> This didn't exactly go in cleanly.
> THe resulting core driver had no author or licence block
> so I put that back from the original.  Also as bmg160.h
> was not included in that driver, All sorts of fun warnings
> about non static, not exported symbols came up.  Added
> in the #include "bmg160.h"
>=20
> There was also some fuzz in the driver.  Could you check it
> went in correctly for me?

Thanks. I just looked at it and it seems to be correct.

Best Regards,

Markus

>=20
> Applied to the togreg branch of iio.git - initially pushed out
> as testing for the autobuilders to play with it.
>=20
> I also took the view that the changes in how it was built
> were not an issue for taking Srinivas' previous reviewed-by
> and so applied that as well.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > ---
> >  drivers/iio/gyro/Kconfig                     | 15 ++++--
> >  drivers/iio/gyro/Makefile                    |  3 +-
> >  drivers/iio/gyro/bmg160.h                    | 10 ++++
> >  drivers/iio/gyro/{bmg160.c =3D> bmg160_core.c} | 79 +++++-------------=
----------
> >  drivers/iio/gyro/bmg160_i2c.c                | 71 ++++++++++++++++++++=
+++++
> >  5 files changed, 107 insertions(+), 71 deletions(-)
> >  create mode 100644 drivers/iio/gyro/bmg160.h
> >  rename drivers/iio/gyro/{bmg160.c =3D> bmg160_core.c} (94%)
> >  create mode 100644 drivers/iio/gyro/bmg160_i2c.c
> >=20
> > diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> > index cf82d74139a2..94526b13d49f 100644
> > --- a/drivers/iio/gyro/Kconfig
> > +++ b/drivers/iio/gyro/Kconfig
> > @@ -52,16 +52,21 @@ config ADXRS450
> > =20
> >  config BMG160
> >  	tristate "BOSCH BMG160 Gyro Sensor"
> > -	depends on I2C
> > +	depends on (I2C || SPI_MASTER)
> >  	select IIO_BUFFER
> >  	select IIO_TRIGGERED_BUFFER
> > -	select REGMAP_I2C
> > +	select BMG160_I2C if (I2C)
> >  	help
> > -	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
> > -	  driver. This driver also supports BMI055 gyroscope.
> > +	  Say yes here to build support for BOSCH BMG160 Tri-axis Gyro Sensor
> > +	  driver connected via I2C or SPI. This driver also supports BMI055
> > +	  gyroscope.
> > =20
> >  	  This driver can also be built as a module.  If so, the module
> > -	  will be called bmg160.
> > +	  will be called bmg160_i2c.
> > +
> > +config BMG160_I2C
> > +	tristate
> > +	select REGMAP_I2C
> > =20
> >  config HID_SENSOR_GYRO_3D
> >  	depends on HID_SENSOR_HUB
> > diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> > index f46341b39139..608401041550 100644
> > --- a/drivers/iio/gyro/Makefile
> > +++ b/drivers/iio/gyro/Makefile
> > @@ -8,7 +8,8 @@ obj-$(CONFIG_ADIS16130) +=3D adis16130.o
> >  obj-$(CONFIG_ADIS16136) +=3D adis16136.o
> >  obj-$(CONFIG_ADIS16260) +=3D adis16260.o
> >  obj-$(CONFIG_ADXRS450) +=3D adxrs450.o
> > -obj-$(CONFIG_BMG160) +=3D bmg160.o
> > +obj-$(CONFIG_BMG160) +=3D bmg160_core.o
> > +obj-$(CONFIG_BMG160_I2C) +=3D bmg160_i2c.o
> > =20
> >  obj-$(CONFIG_HID_SENSOR_GYRO_3D) +=3D hid-sensor-gyro-3d.o
> > =20
> > diff --git a/drivers/iio/gyro/bmg160.h b/drivers/iio/gyro/bmg160.h
> > new file mode 100644
> > index 000000000000..72db723c8fb6
> > --- /dev/null
> > +++ b/drivers/iio/gyro/bmg160.h
> > @@ -0,0 +1,10 @@
> > +#ifndef BMG160_H_
> > +#define BMG160_H_
> > +
> > +extern const struct dev_pm_ops bmg160_pm_ops;
> > +
> > +int bmg160_core_probe(struct device *dev, struct regmap *regmap, int i=
rq,
> > +		      const char *name);
> > +void bmg160_core_remove(struct device *dev);
> > +
> > +#endif  /* BMG160_H_ */
> > diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160_core.c
> > similarity index 94%
> > rename from drivers/iio/gyro/bmg160.c
> > rename to drivers/iio/gyro/bmg160_core.c
> > index 39df64fb4262..7366cb9f613d 100644
> > --- a/drivers/iio/gyro/bmg160.c
> > +++ b/drivers/iio/gyro/bmg160_core.c
> > @@ -13,7 +13,6 @@
> >   */
> > =20
> >  #include <linux/module.h>
> > -#include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/delay.h>
> >  #include <linux/slab.h>
> > @@ -30,7 +29,6 @@
> >  #include <linux/iio/triggered_buffer.h>
> >  #include <linux/regmap.h>
> > =20
> > -#define BMG160_DRV_NAME		"bmg160"
> >  #define BMG160_IRQ_NAME		"bmg160_event"
> >  #define BMG160_GPIO_NAME		"gpio_int"
> > =20
> > @@ -137,12 +135,6 @@ static const struct {
> >  			   { 133, BMG160_RANGE_250DPS},
> >  			   { 66, BMG160_RANGE_125DPS} };
> > =20
> > -struct regmap_config bmg160_regmap_i2c_conf =3D {
> > -	.reg_bits =3D 8,
> > -	.val_bits =3D 8,
> > -	.max_register =3D 0x3f
> > -};
> > -
> >  static int bmg160_set_mode(struct bmg160_data *data, u8 mode)
> >  {
> >  	int ret;
> > @@ -996,31 +988,22 @@ static const char *bmg160_match_acpi_device(struc=
t device *dev)
> >  	return dev_name(dev);
> >  }
> > =20
> > -static int bmg160_probe(struct i2c_client *client,
> > -			const struct i2c_device_id *id)
> > +int bmg160_core_probe(struct device *dev, struct regmap *regmap, int i=
rq,
> > +		      const char *name)
> >  {
> >  	struct bmg160_data *data;
> >  	struct iio_dev *indio_dev;
> >  	int ret;
> > -	const char *name =3D NULL;
> > -	struct regmap *regmap;
> > -	struct device *dev =3D &client->dev;
> > -
> > -	regmap =3D devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
> > -	if (IS_ERR(regmap)) {
> > -		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> > -			(int)PTR_ERR(regmap));
> > -		return PTR_ERR(regmap);
> > -	}
> > =20
> > -	indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data));
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> >  	if (!indio_dev)
> >  		return -ENOMEM;
> > =20
> >  	data =3D iio_priv(indio_dev);
> >  	dev_set_drvdata(dev, indio_dev);
> >  	data->dev =3D dev;
> > -	data->irq =3D client->irq;
> > +	data->irq =3D irq;
> > +	data->regmap =3D regmap;
> > =20
> >  	ret =3D bmg160_chip_init(data);
> >  	if (ret < 0)
> > @@ -1028,9 +1011,6 @@ static int bmg160_probe(struct i2c_client *client,
> > =20
> >  	mutex_init(&data->mutex);
> > =20
> > -	if (id)
> > -		name =3D id->name;
> > -
> >  	if (ACPI_HANDLE(dev))
> >  		name =3D bmg160_match_acpi_device(dev);
> > =20
> > @@ -1125,15 +1105,16 @@ err_trigger_unregister:
> > =20
> >  	return ret;
> >  }
> > +EXPORT_SYMBOL_GPL(bmg160_core_probe);
> > =20
> > -static int bmg160_remove(struct i2c_client *client)
> > +void bmg160_core_remove(struct device *dev)
> >  {
> > -	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> > +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct bmg160_data *data =3D iio_priv(indio_dev);
> > =20
> > -	pm_runtime_disable(&client->dev);
> > -	pm_runtime_set_suspended(&client->dev);
> > -	pm_runtime_put_noidle(&client->dev);
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_set_suspended(dev);
> > +	pm_runtime_put_noidle(dev);
> > =20
> >  	iio_device_unregister(indio_dev);
> >  	iio_triggered_buffer_cleanup(indio_dev);
> > @@ -1146,9 +1127,8 @@ static int bmg160_remove(struct i2c_client *clien=
t)
> >  	mutex_lock(&data->mutex);
> >  	bmg160_set_mode(data, BMG160_MODE_DEEP_SUSPEND);
> >  	mutex_unlock(&data->mutex);
> > -
> > -	return 0;
> >  }
> > +EXPORT_SYMBOL_GPL(bmg160_core_remove);
> > =20
> >  #ifdef CONFIG_PM_SLEEP
> >  static int bmg160_suspend(struct device *dev)
> > @@ -1210,40 +1190,9 @@ static int bmg160_runtime_resume(struct device *=
dev)
> >  }
> >  #endif
> > =20
> > -static const struct dev_pm_ops bmg160_pm_ops =3D {
> > +const struct dev_pm_ops bmg160_pm_ops =3D {
> >  	SET_SYSTEM_SLEEP_PM_OPS(bmg160_suspend, bmg160_resume)
> >  	SET_RUNTIME_PM_OPS(bmg160_runtime_suspend,
> >  			   bmg160_runtime_resume, NULL)
> >  };
> > -
> > -static const struct acpi_device_id bmg160_acpi_match[] =3D {
> > -	{"BMG0160", 0},
> > -	{"BMI055B", 0},
> > -	{},
> > -};
> > -
> > -MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
> > -
> > -static const struct i2c_device_id bmg160_id[] =3D {
> > -	{"bmg160", 0},
> > -	{"bmi055_gyro", 0},
> > -	{}
> > -};
> > -
> > -MODULE_DEVICE_TABLE(i2c, bmg160_id);
> > -
> > -static struct i2c_driver bmg160_driver =3D {
> > -	.driver =3D {
> > -		.name	=3D BMG160_DRV_NAME,
> > -		.acpi_match_table =3D ACPI_PTR(bmg160_acpi_match),
> > -		.pm	=3D &bmg160_pm_ops,
> > -	},
> > -	.probe		=3D bmg160_probe,
> > -	.remove		=3D bmg160_remove,
> > -	.id_table	=3D bmg160_id,
> > -};
> > -module_i2c_driver(bmg160_driver);
> > -
> > -MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>");
> > -MODULE_LICENSE("GPL v2");
> > -MODULE_DESCRIPTION("BMG160 Gyro driver");
> > +EXPORT_SYMBOL_GPL(bmg160_pm_ops);
> > diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2=
c.c
> > new file mode 100644
> > index 000000000000..90126a5a7663
> > --- /dev/null
> > +++ b/drivers/iio/gyro/bmg160_i2c.c
> > @@ -0,0 +1,71 @@
> > +#include <linux/i2c.h>
> > +#include <linux/regmap.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/acpi.h>
> > +
> > +#include "bmg160.h"
> > +
> > +static const struct regmap_config bmg160_regmap_i2c_conf =3D {
> > +	.reg_bits =3D 8,
> > +	.val_bits =3D 8,
> > +	.max_register =3D 0x3f
> > +};
> > +
> > +static int bmg160_i2c_probe(struct i2c_client *client,
> > +			    const struct i2c_device_id *id)
> > +{
> > +	struct regmap *regmap;
> > +	const char *name =3D NULL;
> > +
> > +	regmap =3D devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
> > +	if (IS_ERR(regmap)) {
> > +		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> > +			(int)PTR_ERR(regmap));
> > +		return PTR_ERR(regmap);
> > +	}
> > +
> > +	if (id)
> > +		name =3D id->name;
> > +
> > +	return bmg160_core_probe(&client->dev, regmap, client->irq, name);
> > +}
> > +
> > +static int bmg160_i2c_remove(struct i2c_client *client)
> > +{
> > +	bmg160_core_remove(&client->dev);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct acpi_device_id bmg160_acpi_match[] =3D {
> > +	{"BMG0160", 0},
> > +	{"BMI055B", 0},
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(acpi, bmg160_acpi_match);
> > +
> > +static const struct i2c_device_id bmg160_i2c_id[] =3D {
> > +	{"bmg160", 0},
> > +	{"bmi055_gyro", 0},
> > +	{}
> > +};
> > +
> > +MODULE_DEVICE_TABLE(i2c, bmg160_i2c_id);
> > +
> > +static struct i2c_driver bmg160_i2c_driver =3D {
> > +	.driver =3D {
> > +		.name	=3D "bmg160_i2c",
> > +		.acpi_match_table =3D ACPI_PTR(bmg160_acpi_match),
> > +		.pm	=3D &bmg160_pm_ops,
> > +	},
> > +	.probe		=3D bmg160_i2c_probe,
> > +	.remove		=3D bmg160_i2c_remove,
> > +	.id_table	=3D bmg160_i2c_id,
> > +};
> > +module_i2c_driver(bmg160_i2c_driver);
> > +
> > +MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.co=
m>");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_DESCRIPTION("BMG160 I2C Gyro driver");
> >=20
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--jIYo0VRlfdMI9fLa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV9tj9AAoJEEpcgKtcEGQQXwsP/2tp3KL7D/XUoufr5Zww5yKH
0DOLw3/fS0Kbdfcrqu+VOPrCstCpGihUN3dEjzlOEAuuz+gJCw8uHM7/Bxy0dpnZ
3IhFxx9U/NQNwK1t4D5EFB5BPJitC9bf75b8BGlPcsn815Qa5cZdXP2TxIFYLfnQ
ZIOTk4CDWH9fcjxY3NdJpCvrkOhavcn5GCYC714tVGyeLgX4KtiMLtv5yGsWrAOA
MaGFd7dcT1IwS1pBc+JWTc7S33F06lMLLYH1aHEFydnaBxtYO9miQR9Bvw2qtRtm
Yg1nfVHLVMBiB+8Pqr/g/X877eJ2R1cRUTrY+l9Kd0pzPyENcKYM+CpduK6kCj3g
kwWIctw5HhzyIq8y6qJ0CXw/W3cJoMB99gCEtqO7Z0tKoeczQ41BozGu7uffuxzF
lkqtv+hW7mlXwUaCpB1fLdnB/TmWAIO+flgqXIfMm/chQJeFe5JD+9t7vlEM7Cbt
6MUf4N4dxyENF2zWdUXyZmXjXOULkIgnlvjdoLzkvXrgChnE32Vk0FO6Mgy5aJLr
62azqOLRPu8ztNNrCyxQeHlkmplhPg6o2KLqrGFoJd0CpvZziTBpO1EdHxqry6Ph
vIxX2mgNmL1DAtuH97jngMfDUjp/1Z/36zdqdw3DhphSZdSxmVCMk0X5CES5Y21u
VtthUffrqsunTaRRcqsz
=NDwv
-----END PGP SIGNATURE-----

--jIYo0VRlfdMI9fLa--
