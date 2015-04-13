Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] iio: accel: mma9553: coding style fixes
Date: Mon, 13 Apr 2015 13:43:35 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F19A4F5B7@irsmsx105.ger.corp.intel.com>
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com>
 <1428503857-9081-2-git-send-email-irina.tirdea@intel.com>
 <552662FF.6030006@kernel.org>
In-Reply-To: <552662FF.6030006@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 09 April, 2015 14:31
> To: Tirdea, Irina; linux-iio@vger.kernel.org; Hartmut Knaack
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/8] iio: accel: mma9553: coding style fixes
>=20
> On 08/04/15 15:37, Irina Tirdea wrote:
> > Fix a couple of coding style issues including:
> >   * issues reported by checkpatch.pl --strict
> >   * add mma9553_ prefix to all local functions/declarations
> >   * fix documentation
> >   * use GENMASK instead of direct masks
> >   * fix code alignment
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> > Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
> Please break this up into smaller focused patches as it's a mixture of
> various different things.
>=20
> First high urgency patches:
>=20
> Typo fixes
> Wrong docs fixes
>=20
> Then lower urgency (nice to have ones)
>=20
> Prefixing naming
> GENMASK
> Aligment
>=20
> So I'd say at least 5 short patches.

Sure, I'll break them into smaller patches.
Thanks for pointing out which are high urgency patches and which nice to ha=
ve - I wasn't sure which is which in this case.

> > ---
> >  drivers/iio/accel/mma9551_core.c |  8 ++--
> >  drivers/iio/accel/mma9551_core.h |  2 +-
> >  drivers/iio/accel/mma9553.c      | 98 ++++++++++++++++++++------------=
--------
> >  3 files changed, 55 insertions(+), 53 deletions(-)
> >
> > diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma95=
51_core.c
> > index 7f55a6d..54b3ae6 100644
> > --- a/drivers/iio/accel/mma9551_core.c
> > +++ b/drivers/iio/accel/mma9551_core.c
> > @@ -374,7 +374,7 @@ EXPORT_SYMBOL(mma9551_read_status_word);
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> >   * @len:	Length of array to read in bytes
> > - * @val:	Array of words to read
> > + * @buf:	Array of words to read
> wrong docs aren't a style fix and probably want to go in faster so
> please break these out into a separate patch.
> >   *
> >   * Read multiple configuration registers (word-sized registers).
> >   *
> > @@ -409,7 +409,7 @@ EXPORT_SYMBOL(mma9551_read_config_words);
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> >   * @len:	Length of array to read in bytes
> > - * @val:	Array of words to read
> > + * @buf:	Array of words to read
> >   *
> >   * Read multiple status registers (word-sized registers).
> >   *
> > @@ -444,7 +444,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
> >   * @app_id:	Application ID
> >   * @reg:	Application register
> >   * @len:	Length of array to write in bytes
> > - * @val:	Array of words to write
> > + * @buf:	Array of words to write
> >   *
> >   * Write multiple configuration registers (word-sized registers).
> >   *
> > @@ -785,7 +785,7 @@ EXPORT_SYMBOL(mma9551_read_accel_scale);
> >   */
> >  int mma9551_app_reset(struct i2c_client *client, u32 app_mask)
> >  {
> > -	return mma9551_write_config_byte(client, MMA9551_APPID_RCS,
> This isn't a style fix.  I'm guessing it is a straight fix for a typo?
> Please break this out to it's own patch. More important than style fixes.
>=20
> > +	return mma9551_write_config_byte(client, MMA9551_APPID_RSC,
> >  					 MMA9551_RSC_RESET +
> >  					 MMA9551_RSC_OFFSET(app_mask),
> >  					 MMA9551_RSC_VAL(app_mask));
> > diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma95=
51_core.h
> > index edaa56b..79939e4 100644
> > --- a/drivers/iio/accel/mma9551_core.h
> > +++ b/drivers/iio/accel/mma9551_core.h
> > @@ -22,7 +22,7 @@
> >  #define MMA9551_APPID_TILT		0x0B
> >  #define MMA9551_APPID_SLEEP_WAKE	0x12
> >  #define MMA9551_APPID_PEDOMETER	        0x15
> > -#define MMA9551_APPID_RCS		0x17
> > +#define MMA9551_APPID_RSC		0x17
> >  #define MMA9551_APPID_NONE		0xff
> >
> >  /* Reset/Suspend/Clear application app masks */
> > diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> > index 2df1af7..d095f81 100644
> > --- a/drivers/iio/accel/mma9553.c
> > +++ b/drivers/iio/accel/mma9553.c
> > @@ -54,6 +54,7 @@
> >  #define MMA9553_MASK_CONF_STEPCOALESCE		GENMASK(7, 0)
> >
> >  #define MMA9553_REG_CONF_ACTTHD			0x0E
> > +#define MMA9553_MAX_ACTTHD			GENMASK(15, 0)
> >
> >  /* Pedometer status registers (R-only) */
> >  #define MMA9553_REG_STATUS			0x00
> > @@ -62,8 +63,8 @@
> >  #define MMA9553_MASK_STATUS_STEPCHG		BIT(13)
> >  #define MMA9553_MASK_STATUS_ACTCHG		BIT(12)
> >  #define MMA9553_MASK_STATUS_SUSP		BIT(11)
> > -#define MMA9553_MASK_STATUS_ACTIVITY		(BIT(10) | BIT(9) | BIT(8))
> > -#define MMA9553_MASK_STATUS_VERSION		0x00FF
> > +#define MMA9553_MASK_STATUS_ACTIVITY		GENMASK(10, 8)
> > +#define MMA9553_MASK_STATUS_VERSION		GENMASK(7, 0)
> >
> >  #define MMA9553_REG_STEPCNT			0x02
> >  #define MMA9553_REG_DISTANCE			0x04
> > @@ -75,14 +76,14 @@
> >  #define MMA9553_DEFAULT_GPIO_PIN	mma9551_gpio6
> >  #define MMA9553_DEFAULT_GPIO_POLARITY	0
> >
> > -/* Bitnum used for gpio configuration =3D bit number in high status by=
te */
> > -#define STATUS_TO_BITNUM(bit)		(ffs(bit) - 9)
> > +/* Bitnum used for GPIO configuration =3D bit number in high status by=
te */
> > +#define MMA9553_STATUS_TO_BITNUM(bit)	(ffs(bit) - 9)
> >
> >  #define MMA9553_DEFAULT_SAMPLE_RATE	30	/* Hz */
> >
> >  /*
> >   * The internal activity level must be stable for ACTTHD samples befor=
e
> > - * ACTIVITY is updated.The ACTIVITY variable contains the current acti=
vity
> > + * ACTIVITY is updated. The ACTIVITY variable contains the current act=
ivity
> >   * level and is updated every time a step is detected or once a second
> >   * if there are no steps.
> >   */
> > @@ -343,21 +344,21 @@ static int mma9553_conf_gpio(struct mma9553_data =
*data)
> >  	struct mma9553_event *ev_step_detect;
> >  	bool activity_enabled;
> >
> > -	activity_enabled =3D
> > -	    mma9553_is_any_event_enabled(data, true, IIO_ACTIVITY);
> > -	ev_step_detect =3D
> > -	    mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD, IIO_EV_DIR_NONE);
> > +	activity_enabled =3D mma9553_is_any_event_enabled(data, true,
> > +							IIO_ACTIVITY);
> > +	ev_step_detect =3D mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD,
> > +					   IIO_EV_DIR_NONE);
> This is defintlely a matter of taste rather than required, but fair enoug=
h
> in a style cleanup patch.
> >
> >  	/*
> >  	 * If both step detector and activity are enabled, use the MRGFL bit.
> >  	 * This bit is the logical OR of the SUSPCHG, STEPCHG, and ACTCHG fla=
gs.
> >  	 */
> >  	if (activity_enabled && ev_step_detect->enabled)
> > -		bitnum =3D STATUS_TO_BITNUM(MMA9553_MASK_STATUS_MRGFL);
> > +		bitnum =3D MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_MRGFL);
> >  	else if (ev_step_detect->enabled)
> > -		bitnum =3D STATUS_TO_BITNUM(MMA9553_MASK_STATUS_STEPCHG);
> > +		bitnum =3D MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_STEPCHG);
> >  	else if (activity_enabled)
> > -		bitnum =3D STATUS_TO_BITNUM(MMA9553_MASK_STATUS_ACTCHG);
> > +		bitnum =3D MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_ACTCHG);
> >  	else			/* Reset */
> >  		appid =3D MMA9551_APPID_NONE;
> >
> > @@ -365,13 +366,15 @@ static int mma9553_conf_gpio(struct mma9553_data =
*data)
> >  		return 0;
> >
> >  	/* Save initial values for activity and stepcnt */
> > -	if (activity_enabled || ev_step_detect->enabled)
> > -		mma9553_read_activity_stepcnt(data, &data->activity,
> > -					      &data->stepcnt);
> > +	if (activity_enabled || ev_step_detect->enabled) {
> > +		ret =3D mma9553_read_activity_stepcnt(data, &data->activity,
> > +						    &data->stepcnt);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> >
> > -	ret =3D mma9551_gpio_config(data->client,
> > -				  MMA9553_DEFAULT_GPIO_PIN,
> > -				  appid, bitnum, MMA9553_DEFAULT_GPIO_POLARITY);
> > +	ret =3D mma9551_gpio_config(data->client, MMA9553_DEFAULT_GPIO_PIN, a=
ppid,
> > +				  bitnum, MMA9553_DEFAULT_GPIO_POLARITY);
> >  	if (ret < 0)
> >  		return ret;
> >  	data->gpio_bitnum =3D bitnum;
> > @@ -392,19 +395,19 @@ static int mma9553_init(struct mma9553_data *data=
)
> >  	 * a device identification command to differentiate the MMA9553L
> >  	 * from the MMA9550L.
> >  	 */
> > -	ret =3D
> > -	    mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMETER,
> > -				      MMA9553_REG_CONF_SLEEPMIN,
> > -				      sizeof(data->conf), (u16 *) &data->conf);
> > +	ret =3D mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMET=
ER,
> > +					MMA9553_REG_CONF_SLEEPMIN,
> > +					sizeof(data->conf),
> > +					(u16 *)&data->conf);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> > -			"device is not MMA9553L: failed to read cfg regs\n");
> > +			"failed to read configuration registers\n");
> >  		return ret;
> >  	}
> >
> >
> > -	/* Reset gpio */
> >  	data->gpio_bitnum =3D -1;
> > +	/* Reset GPIO */
> >  	ret =3D mma9553_conf_gpio(data);
> >  	if (ret < 0)
> >  		return ret;
> > @@ -417,18 +420,18 @@ static int mma9553_init(struct mma9553_data *data=
)
> >  	data->conf.sleepmin =3D MMA9553_DEFAULT_SLEEPMIN;
> >  	data->conf.sleepmax =3D MMA9553_DEFAULT_SLEEPMAX;
> >  	data->conf.sleepthd =3D MMA9553_DEFAULT_SLEEPTHD;
> > -	data->conf.config =3D
> > -	    mma9553_set_bits(data->conf.config, 1, MMA9553_MASK_CONF_CONFIG);
> > +	data->conf.config =3D mma9553_set_bits(data->conf.config, 1,
> > +					     MMA9553_MASK_CONF_CONFIG);
> >  	/*
> >  	 * Clear the activity debounce counter when the activity level change=
s,
> >  	 * so that the confidence level applies for any activity level.
> >  	 */
> >  	data->conf.config =3D mma9553_set_bits(data->conf.config, 1,
> >  					     MMA9553_MASK_CONF_ACT_DBCNTM);
> > -	ret =3D
> > -	    mma9551_write_config_words(data->client, MMA9551_APPID_PEDOMETER,
> > -				       MMA9553_REG_CONF_SLEEPMIN,
> > -				       sizeof(data->conf), (u16 *) &data->conf);
> > +	ret =3D mma9551_write_config_words(data->client, MMA9551_APPID_PEDOME=
TER,
> > +					 MMA9553_REG_CONF_SLEEPMIN,
> > +					 sizeof(data->conf),
> > +					 (u16 *)&data->conf);
> >  	if (ret < 0) {
> >  		dev_err(&data->client->dev,
> >  			"failed to write configuration registers\n");
> > @@ -791,7 +794,7 @@ static int mma9553_write_event_config(struct iio_de=
v *indio_dev,
> >
> >  	mutex_unlock(&data->mutex);
> >
> > -	return ret;
> > +	return 0;
> >
> >  err_conf_gpio:
> >  	if (state) {
> > @@ -896,7 +899,7 @@ static int mma9553_get_calibgender_mode(struct iio_=
dev *indio_dev,
> >  	gender =3D mma9553_get_bits(data->conf.filter, MMA9553_MASK_CONF_MALE=
);
> >  	/*
> >  	 * HW expects 0 for female and 1 for male,
> > -	 * while iio index is 0 for male and 1 for female
> > +	 * while iio index is 0 for male and 1 for female.
> >  	 */
> >  	return !gender;
> >  }
> > @@ -943,11 +946,11 @@ static const struct iio_event_spec mma9553_activi=
ty_events[] =3D {
> >  	},
> >  };
> >
> > -static const char * const calibgender_modes[] =3D { "male", "female" }=
;
> > +static const char * const mma9553_calibgender_modes[] =3D { "male", "f=
emale" };
> >
> >  static const struct iio_enum mma9553_calibgender_enum =3D {
> > -	.items =3D calibgender_modes,
> > -	.num_items =3D ARRAY_SIZE(calibgender_modes),
> > +	.items =3D mma9553_calibgender_modes,
> > +	.num_items =3D ARRAY_SIZE(mma9553_calibgender_modes),
> >  	.get =3D mma9553_get_calibgender_mode,
> >  	.set =3D mma9553_set_calibgender_mode,
> >  };
> > @@ -1054,16 +1057,15 @@ static irqreturn_t mma9553_event_handler(int ir=
q, void *private)
> >  		return IRQ_HANDLED;
> >  	}
> >
> > -	ev_prev_activity =3D
> > -	    mma9553_get_event(data, IIO_ACTIVITY,
> > -			      mma9553_activity_to_mod(data->activity),
> > -			      IIO_EV_DIR_FALLING);
> > -	ev_activity =3D
> > -	    mma9553_get_event(data, IIO_ACTIVITY,
> > -			      mma9553_activity_to_mod(activity),
> > -			      IIO_EV_DIR_RISING);
> > -	ev_step_detect =3D
> > -	    mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD, IIO_EV_DIR_NONE);
> > +	ev_prev_activity =3D mma9553_get_event(data, IIO_ACTIVITY,
> > +					     mma9553_activity_to_mod(
> > +					     data->activity),
> > +					     IIO_EV_DIR_FALLING);
> > +	ev_activity =3D mma9553_get_event(data, IIO_ACTIVITY,
> > +					mma9553_activity_to_mod(activity),
> > +					IIO_EV_DIR_RISING);
> > +	ev_step_detect =3D mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD,
> > +					   IIO_EV_DIR_NONE);
> >
> >  	if (ev_step_detect->enabled && (stepcnt !=3D data->stepcnt)) {
> >  		data->stepcnt =3D stepcnt;
> > @@ -1108,16 +1110,16 @@ static int mma9553_gpio_probe(struct i2c_client=
 *client)
> >
> >  	dev =3D &client->dev;
> >
> > -	/* data ready gpio interrupt pin */
> > +	/* data ready GPIO interrupt pin */
> >  	gpio =3D devm_gpiod_get_index(dev, MMA9553_GPIO_NAME, 0, GPIOD_IN);
> >  	if (IS_ERR(gpio)) {
> > -		dev_err(dev, "acpi gpio get index failed\n");
> > +		dev_err(dev, "ACPI GPIO get index failed\n");
> >  		return PTR_ERR(gpio);
> >  	}
> >
> >  	ret =3D gpiod_to_irq(gpio);
> >
> > -	dev_dbg(dev, "gpio resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret=
);
> > +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret=
);
> >
> >  	return ret;
> >  }
> >
