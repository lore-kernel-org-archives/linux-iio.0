Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "Dogaru, Vlad"
	<vlad.dogaru@intel.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH 1/2] iio: magn: bmc150: decouple buffer and trigger
Date: Tue, 23 Jun 2015 14:18:00 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F06170C@irsmsx105.ger.corp.intel.com>
References: <1434097899-13984-1-git-send-email-vlad.dogaru@intel.com>
 <1434097899-13984-2-git-send-email-vlad.dogaru@intel.com>
 <557C70C4.7090501@kernel.org>
In-Reply-To: <557C70C4.7090501@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 13 June, 2015 21:05
> To: Dogaru, Vlad; Tirdea, Irina; linux-iio@vger.kernel.org
> Subject: Re: [PATCH 1/2] iio: magn: bmc150: decouple buffer and trigger
>=20
> On 12/06/15 09:31, Vlad Dogaru wrote:
> > Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
> Looks good to me.  Will let it sit for a while to give Irina and others
> time to comment though.  We are looking at the next cycle now anyway so
> no rush!

This already got merged, but looks fine to me.

>=20
> Jonathan
> > ---
> >  drivers/iio/magnetometer/bmc150_magn.c | 69 +++++++++++++++++++-------=
--------
> >  1 file changed, 38 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magne=
tometer/bmc150_magn.c
> > index d4c1788..a0e64f1 100644
> > --- a/drivers/iio/magnetometer/bmc150_magn.c
> > +++ b/drivers/iio/magnetometer/bmc150_magn.c
> > @@ -588,17 +588,6 @@ static int bmc150_magn_write_raw(struct iio_dev *i=
ndio_dev,
> >  	}
> >  }
> >
> > -static int bmc150_magn_validate_trigger(struct iio_dev *indio_dev,
> > -					struct iio_trigger *trig)
> > -{
> > -	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > -
> > -	if (data->dready_trig !=3D trig)
> > -		return -EINVAL;
> > -
> > -	return 0;
> > -}
> > -
> >  static ssize_t bmc150_magn_show_samp_freq_avail(struct device *dev,
> >  						struct device_attribute *attr,
> >  						char *buf)
> > @@ -659,7 +648,6 @@ static const struct iio_info bmc150_magn_info =3D {
> >  	.attrs =3D &bmc150_magn_attrs_group,
> >  	.read_raw =3D bmc150_magn_read_raw,
> >  	.write_raw =3D bmc150_magn_write_raw,
> > -	.validate_trigger =3D bmc150_magn_validate_trigger,
> >  	.driver_module =3D THIS_MODULE,
> >  };
> >
> > @@ -682,7 +670,7 @@ static irqreturn_t bmc150_magn_trigger_handler(int =
irq, void *p)
> >  					   pf->timestamp);
> >
> >  err:
> > -	iio_trigger_notify_done(data->dready_trig);
> > +	iio_trigger_notify_done(indio_dev->trig);
> >
> >  	return IRQ_HANDLED;
> >  }
> > @@ -827,6 +815,27 @@ static const struct iio_trigger_ops bmc150_magn_tr=
igger_ops =3D {
> >  	.owner =3D THIS_MODULE,
> >  };
> >
> > +static int bmc150_magn_buffer_preenable(struct iio_dev *indio_dev)
> > +{
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +
> > +	return bmc150_magn_set_power_state(data, true);
> > +}
> > +
> > +static int bmc150_magn_buffer_postdisable(struct iio_dev *indio_dev)
> > +{
> > +	struct bmc150_magn_data *data =3D iio_priv(indio_dev);
> > +
> > +	return bmc150_magn_set_power_state(data, false);
> > +}
> > +
> > +static const struct iio_buffer_setup_ops bmc150_magn_buffer_setup_ops =
=3D {
> > +	.preenable =3D bmc150_magn_buffer_preenable,
> > +	.postenable =3D iio_triggered_buffer_postenable,
> > +	.predisable =3D iio_triggered_buffer_predisable,
> > +	.postdisable =3D bmc150_magn_buffer_postdisable,
> > +};
> > +
> >  static int bmc150_magn_gpio_probe(struct i2c_client *client)
> >  {
> >  	struct device *dev;
> > @@ -932,16 +941,6 @@ static int bmc150_magn_probe(struct i2c_client *cl=
ient,
> >  			goto err_poweroff;
> >  		}
> >
> > -		ret =3D iio_triggered_buffer_setup(indio_dev,
> > -						 &iio_pollfunc_store_time,
> > -						 bmc150_magn_trigger_handler,
> > -						 NULL);
> > -		if (ret < 0) {
> > -			dev_err(&client->dev,
> > -				"iio triggered buffer setup failed\n");
> > -			goto err_trigger_unregister;
> > -		}
> > -
> >  		ret =3D request_threaded_irq(client->irq,
> >  					   iio_trigger_generic_data_rdy_poll,
> >  					   NULL,
> > @@ -951,14 +950,24 @@ static int bmc150_magn_probe(struct i2c_client *c=
lient,
> >  		if (ret < 0) {
> >  			dev_err(&client->dev, "request irq %d failed\n",
> >  				client->irq);
> > -			goto err_buffer_cleanup;
> > +			goto err_trigger_unregister;
> >  		}
> >  	}
> >
> > +	ret =3D iio_triggered_buffer_setup(indio_dev,
> > +					 iio_pollfunc_store_time,
> > +					 bmc150_magn_trigger_handler,
> > +					 &bmc150_magn_buffer_setup_ops);
> > +	if (ret < 0) {
> > +		dev_err(&client->dev,
> > +			"iio triggered buffer setup failed\n");
> > +		goto err_free_irq;
> > +	}
> > +
> >  	ret =3D iio_device_register(indio_dev);
> >  	if (ret < 0) {
> >  		dev_err(&client->dev, "unable to register iio device\n");
> > -		goto err_free_irq;
> > +		goto err_buffer_cleanup;
> >  	}
> >
> >  	ret =3D pm_runtime_set_active(&client->dev);
> > @@ -976,12 +985,11 @@ static int bmc150_magn_probe(struct i2c_client *c=
lient,
> >
> >  err_iio_unregister:
> >  	iio_device_unregister(indio_dev);
> > +err_buffer_cleanup:
> > +	iio_triggered_buffer_cleanup(indio_dev);
> >  err_free_irq:
> >  	if (client->irq > 0)
> >  		free_irq(client->irq, data->dready_trig);
> > -err_buffer_cleanup:
> > -	if (data->dready_trig)
> > -		iio_triggered_buffer_cleanup(indio_dev);
> >  err_trigger_unregister:
> >  	if (data->dready_trig)
> >  		iio_trigger_unregister(data->dready_trig);
> > @@ -1000,14 +1008,13 @@ static int bmc150_magn_remove(struct i2c_client=
 *client)
> >  	pm_runtime_put_noidle(&client->dev);
> >
> >  	iio_device_unregister(indio_dev);
> > +	iio_triggered_buffer_cleanup(indio_dev);
> >
> >  	if (client->irq > 0)
> >  		free_irq(data->client->irq, data->dready_trig);
> >
> > -	if (data->dready_trig) {
> > -		iio_triggered_buffer_cleanup(indio_dev);
> > +	if (data->dready_trig)
> >  		iio_trigger_unregister(data->dready_trig);
> > -	}
> >
> >  	mutex_lock(&data->mutex);
> >  	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true=
);
> >
