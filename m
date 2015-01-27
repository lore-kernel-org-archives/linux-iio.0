Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Dogaru,
 Vlad" <vlad.dogaru@intel.com>, "Baluta, Daniel" <daniel.baluta@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald <pmeerw@pmeerw.net>
Subject: RE: [PATCH v2 08/10] iio: accel: mma9551: Add runtime pm support
Date: Tue, 27 Jan 2015 17:18:21 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A0F777@irsmsx105.ger.corp.intel.com>
References: <1421003416-27557-1-git-send-email-irina.tirdea@intel.com>
 <1421003416-27557-9-git-send-email-irina.tirdea@intel.com>
 <54C6909B.1060703@kernel.org>
In-Reply-To: <54C6909B.1060703@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 26 January, 2015 21:08
> To: Tirdea, Irina; linux-iio@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org; Dogaru, Vlad; Baluta, Daniel; Hartmut K=
naack; Lars-Peter Clausen; Peter Meerwald
> Subject: Re: [PATCH v2 08/10] iio: accel: mma9551: Add runtime pm support
>=20
> On 11/01/15 19:10, Irina Tirdea wrote:
> > Add support for runtime pm to reduce the power consumed by the device
> > when not used.
> >
> > If CONFIG_PM is not enabled, the device will be powered on at
> > init and only powered off on system suspend.
> >
> > If CONFIG_PM is enabled, runtime pm autosuspend is used:
> > - for raw reads will keep the device on for a specified time
> > - for events it will keep the device on as long as we have at least
> > one event active
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Reviewed-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Looks good.
>=20
> Applied to the togreg branch of iio.git
> (at least we are driving down the size of the patch set for the next
> revision!)
Yes, that helps. Thanks Jonathan!

Irina
>=20
> Jonathan
> > ---
> >  drivers/iio/accel/mma9551.c | 162 ++++++++++++++++++++++++++++++++++++=
+-------
> >  1 file changed, 139 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma9551.c b/drivers/iio/accel/mma9551.c
> > index 6563e26..f1a5a06 100644
> > --- a/drivers/iio/accel/mma9551.c
> > +++ b/drivers/iio/accel/mma9551.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> >  #include <linux/iio/events.h>
> > +#include <linux/pm_runtime.h>
> >
> >  #define MMA9551_DRV_NAME		"mma9551"
> >  #define MMA9551_IRQ_NAME		"mma9551_event"
> > @@ -71,6 +72,7 @@ enum mma9551_gpio_pin {
> >  /* Sleep/Wake application */
> >  #define MMA9551_SLEEP_CFG		0x06
> >  #define MMA9551_SLEEP_CFG_SNCEN		BIT(0)
> > +#define MMA9551_SLEEP_CFG_FLEEN		BIT(1)
> >  #define MMA9551_SLEEP_CFG_SCHEN		BIT(2)
> >
> >  /* AFE application */
> > @@ -114,6 +116,9 @@ enum mma9551_tilt_axis {
> >  #define MMA9551_I2C_READ_RETRIES	5
> >  #define MMA9551_I2C_READ_DELAY	50	/* us */
> >
> > +#define MMA9551_DEFAULT_SAMPLE_RATE	122	/* Hz */
> > +#define MMA9551_AUTO_SUSPEND_DELAY_MS	2000
> > +
> >  struct mma9551_mbox_request {
> >  	u8 start_mbox;		/* Always 0. */
> >  	u8 app_id;
> > @@ -387,16 +392,55 @@ static int mma9551_read_version(struct i2c_client=
 *client)
> >  }
> >
> >  /*
> > + * Power on chip and enable doze mode.
> >   * Use 'false' as the second parameter to cause the device to enter
> >   * sleep.
> >   */
> > -static int mma9551_set_device_state(struct i2c_client *client,
> > -				    bool enable)
> > +static int mma9551_set_device_state(struct i2c_client *client, bool en=
able)
> >  {
> >  	return mma9551_update_config_bits(client, MMA9551_APPID_SLEEP_WAKE,
> >  					  MMA9551_SLEEP_CFG,
> > -					  MMA9551_SLEEP_CFG_SNCEN,
> > -					  enable ? 0 : MMA9551_SLEEP_CFG_SNCEN);
> > +					  MMA9551_SLEEP_CFG_SNCEN |
> > +					  MMA9551_SLEEP_CFG_FLEEN |
> > +					  MMA9551_SLEEP_CFG_SCHEN,
> > +					  enable ? MMA9551_SLEEP_CFG_SCHEN |
> > +					  MMA9551_SLEEP_CFG_FLEEN :
> > +					  MMA9551_SLEEP_CFG_SNCEN);
> > +}
> > +
> > +static int mma9551_set_power_state(struct i2c_client *client, bool on)
> > +{
> > +#ifdef CONFIG_PM
> > +	int ret;
> > +
> > +	if (on)
> > +		ret =3D pm_runtime_get_sync(&client->dev);
> > +	else {
> > +		pm_runtime_mark_last_busy(&client->dev);
> > +		ret =3D pm_runtime_put_autosuspend(&client->dev);
> > +	}
> > +
> > +	if (ret < 0) {
> > +		dev_err(&client->dev,
> > +			"failed to change power state to %d\n", on);
> > +		if (on)
> > +			pm_runtime_put_noidle(&client->dev);
> > +
> > +		return ret;
> > +	}
> > +#endif
> > +
> > +	return 0;
> > +}
> > +
> > +static void mma9551_sleep(int freq)
> > +{
> > +	int sleep_val =3D 1000 / freq;
> > +
> > +	if (sleep_val < 20)
> > +		usleep_range(sleep_val * 1000, 20000);
> > +	else
> > +		msleep_interruptible(sleep_val);
> >  }
> >
> >  static int mma9551_read_incli_chan(struct i2c_client *client,
> > @@ -424,15 +468,19 @@ static int mma9551_read_incli_chan(struct i2c_cli=
ent *client,
> >  		return -EINVAL;
> >  	}
> >
> > +	ret =3D mma9551_set_power_state(client, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	ret =3D mma9551_read_status_byte(client, MMA9551_APPID_TILT,
> >  				       reg_addr, &angle);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out_poweroff;
> >
> >  	ret =3D mma9551_read_status_byte(client, MMA9551_APPID_TILT,
> >  				       MMA9551_TILT_QUAD_REG, &quadrant);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out_poweroff;
> >
> >  	angle &=3D ~MMA9551_TILT_ANGFLG;
> >  	quadrant =3D (quadrant >> quad_shift) & 0x03;
> > @@ -442,7 +490,11 @@ static int mma9551_read_incli_chan(struct i2c_clie=
nt *client,
> >  	else
> >  		*val =3D angle + 90 * quadrant;
> >
> > -	return IIO_VAL_INT;
> > +	ret =3D IIO_VAL_INT;
> > +
> > +out_poweroff:
> > +	mma9551_set_power_state(client, false);
> > +	return ret;
> >  }
> >
> >  static int mma9551_read_accel_chan(struct i2c_client *client,
> > @@ -467,14 +519,22 @@ static int mma9551_read_accel_chan(struct i2c_cli=
ent *client,
> >  		return -EINVAL;
> >  	}
> >
> > +	ret =3D mma9551_set_power_state(client, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> >  	ret =3D mma9551_read_status_word(client, MMA9551_APPID_AFE,
> >  				       reg_addr, &raw_accel);
> >  	if (ret < 0)
> > -		return ret;
> > +		goto out_poweroff;
> >
> >  	*val =3D raw_accel;
> >
> > -	return IIO_VAL_INT;
> > +	ret =3D IIO_VAL_INT;
> > +
> > +out_poweroff:
> > +	mma9551_set_power_state(client, false);
> > +	return ret;
> >  }
> >
> >  static int mma9551_read_raw(struct iio_dev *indio_dev,
> > @@ -556,6 +616,10 @@ static int mma9551_config_incli_event(struct iio_d=
ev *indio_dev,
> >  					  MMA9551_APPID_NONE, 0, 0);
> >  		if (ret < 0)
> >  			return ret;
> > +
> > +		ret =3D mma9551_set_power_state(data->client, false);
> > +		if (ret < 0)
> > +			return ret;
> >  	} else {
> >  		int bitnum;
> >
> > @@ -574,11 +638,18 @@ static int mma9551_config_incli_event(struct iio_=
dev *indio_dev,
> >  			return -EINVAL;
> >  		}
> >
> > +
> Trivial but one blank line here is enough...
> > +		ret =3D mma9551_set_power_state(data->client, true);
> > +		if (ret < 0)
> > +			return ret;
> > +
> >  		ret =3D mma9551_gpio_config(data->client,
> >  					  (enum mma9551_gpio_pin)mma_axis,
> >  					  MMA9551_APPID_TILT, bitnum, 0);
> > -		if (ret < 0)
> > +		if (ret < 0) {
> > +			mma9551_set_power_state(data->client, false);
> >  			return ret;
> > +		}
> >  	}
> >
> >  	data->event_enabled[mma_axis] =3D state;
> > @@ -771,12 +842,7 @@ static int mma9551_init(struct mma9551_data *data)
> >  	if (ret)
> >  		return ret;
> >
> > -	/* Power on chip and enable doze mode. */
> > -	return mma9551_update_config_bits(data->client,
> > -			 MMA9551_APPID_SLEEP_WAKE,
> > -			 MMA9551_SLEEP_CFG,
> > -			 MMA9551_SLEEP_CFG_SCHEN | MMA9551_SLEEP_CFG_SNCEN,
> > -			 MMA9551_SLEEP_CFG_SCHEN);
> > +	return mma9551_set_device_state(data->client, true);
> >  }
> >
> >  static int mma9551_gpio_probe(struct iio_dev *indio_dev)
> > @@ -869,8 +935,19 @@ static int mma9551_probe(struct i2c_client *client=
,
> >  		goto out_poweroff;
> >  	}
> >
> > +	ret =3D pm_runtime_set_active(&client->dev);
> > +	if (ret < 0)
> > +		goto out_iio_unregister;
> > +
> > +	pm_runtime_enable(&client->dev);
> > +	pm_runtime_set_autosuspend_delay(&client->dev,
> > +					 MMA9551_AUTO_SUSPEND_DELAY_MS);
> > +	pm_runtime_use_autosuspend(&client->dev);
> > +
> >  	return 0;
> >
> > +out_iio_unregister:
> > +	iio_device_unregister(indio_dev);
> >  out_poweroff:
> >  	mma9551_set_device_state(client, false);
> >
> > @@ -882,6 +959,10 @@ static int mma9551_remove(struct i2c_client *clien=
t)
> >  	struct iio_dev *indio_dev =3D i2c_get_clientdata(client);
> >  	struct mma9551_data *data =3D iio_priv(indio_dev);
> >
> > +	pm_runtime_disable(&client->dev);
> > +	pm_runtime_set_suspended(&client->dev);
> > +	pm_runtime_put_noidle(&client->dev);
> > +
> >  	iio_device_unregister(indio_dev);
> >  	mutex_lock(&data->mutex);
> >  	mma9551_set_device_state(data->client, false);
> > @@ -890,37 +971,72 @@ static int mma9551_remove(struct i2c_client *clie=
nt)
> >  	return 0;
> >  }
> >
> > +#ifdef CONFIG_PM
> > +static int mma9551_runtime_suspend(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct mma9551_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	mutex_lock(&data->mutex);
> > +	ret =3D mma9551_set_device_state(data->client, false);
> > +	mutex_unlock(&data->mutex);
> > +	if (ret < 0) {
> > +		dev_err(&data->client->dev, "powering off device failed\n");
> > +		return -EAGAIN;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int mma9551_runtime_resume(struct device *dev)
> > +{
> > +	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> > +	struct mma9551_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret =3D mma9551_set_device_state(data->client, true);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	mma9551_sleep(MMA9551_DEFAULT_SAMPLE_RATE);
> > +
> > +	return 0;
> > +}
> > +#endif
> > +
> >  #ifdef CONFIG_PM_SLEEP
> >  static int mma9551_suspend(struct device *dev)
> >  {
> >  	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> >  	struct mma9551_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> >
> >  	mutex_lock(&data->mutex);
> > -	mma9551_set_device_state(data->client, false);
> > +	ret =3D mma9551_set_device_state(data->client, false);
> >  	mutex_unlock(&data->mutex);
> >
> > -	return 0;
> > +	return ret;
> >  }
> >
> >  static int mma9551_resume(struct device *dev)
> >  {
> >  	struct iio_dev *indio_dev =3D i2c_get_clientdata(to_i2c_client(dev));
> >  	struct mma9551_data *data =3D iio_priv(indio_dev);
> > +	int ret;
> >
> >  	mutex_lock(&data->mutex);
> > -	mma9551_set_device_state(data->client, true);
> > +	ret =3D mma9551_set_device_state(data->client, true);
> >  	mutex_unlock(&data->mutex);
> >
> > -	return 0;
> > +	return ret;
> >  }
> > -#else
> > -#define mma9551_suspend NULL
> > -#define mma9551_resume NULL
> >  #endif
> >
> >  static const struct dev_pm_ops mma9551_pm_ops =3D {
> >  	SET_SYSTEM_SLEEP_PM_OPS(mma9551_suspend, mma9551_resume)
> > +	SET_RUNTIME_PM_OPS(mma9551_runtime_suspend,
> > +			   mma9551_runtime_resume, NULL)
> >  };
> >
> >  static const struct acpi_device_id mma9551_acpi_match[] =3D {
> >
