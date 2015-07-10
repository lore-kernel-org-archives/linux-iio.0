Return-Path: <irina.tirdea@intel.com>
From: "Tirdea, Irina" <irina.tirdea@intel.com>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, Jonathan Cameron
	<jic23@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Peter
 Meerwald" <pmeerw@pmeerw.net>, Wolfram Sang <wsa@the-dreams.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: RE: [PATCH v3 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
Date: Fri, 10 Jul 2015 17:31:58 +0000
Message-ID: <1F3AC3675D538145B1661F571FE1805F2F068001@irsmsx105.ger.corp.intel.com>
References: <1435916017-12859-1-git-send-email-irina.tirdea@intel.com>
 <1435916017-12859-7-git-send-email-irina.tirdea@intel.com>
 <55991E2F.5020901@kernel.org>
In-Reply-To: <55991E2F.5020901@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>



> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: 05 July, 2015 15:08
> To: Tirdea, Irina; Wolfram Sang; linux-iio@vger.kernel.org; linux-i2c@vge=
r.kernel.org
> Cc: linux-kernel@vger.kernel.org; Pandruvada, Srinivas; Peter Meerwald
> Subject: Re: [PATCH v3 6/8] iio: gyro: bmg160: optimize i2c transfers in =
trigger handler
>=20
> On 03/07/15 10:33, Irina Tirdea wrote:
> > Some i2c busses (e.g.: Synopsys DesignWare I2C adapter) need to
> > enable/disable the bus at each i2c transfer and must wait for
> > the enable/disable to happen before sending the data.
> >
> > When reading data in the trigger handler, the bmg160 driver does
> > one i2c transfer for each axis. This has an impact on the frequency
> > of the gyroscope at high sample rates due to additional delays
> > introduced by the i2c bus at each transfer.
> >
> > Reading all axis values in one i2c transfer reduces the delays
> > introduced by the i2c bus. Uses i2c_smbus_read_i2c_block_data_or_emulat=
ed
> > that will fallback to reading each axis as a separate word in case i2c
> > block read is not supported.
> >
> > Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Acked-by: Jonathan Cameron <jic23@kernel.org>
>=20

Thanks Jonathan!

> Obviously you'll ideally pick up Ack's from the driver authors /maintaine=
rs
> as well.
>=20

Srinivas, are you OK with these changes for bmc150, bmg160 and kxcjk-1013?

Thanks,
Irina

> Jonathan
> > ---
> >  drivers/iio/gyro/bmg160.c | 18 ++++++++----------
> >  1 file changed, 8 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> > index 4b423f2..04e15e9 100644
> > --- a/drivers/iio/gyro/bmg160.c
> > +++ b/drivers/iio/gyro/bmg160.c
> > @@ -784,6 +784,7 @@ static const struct iio_event_spec bmg160_event =3D=
 {
> >  		.sign =3D 's',						\
> >  		.realbits =3D 16,					\
> >  		.storagebits =3D 16,					\
> > +		.endianness =3D IIO_LE,					\
> >  	},								\
> >  	.event_spec =3D &bmg160_event,					\
> >  	.num_event_specs =3D 1						\
> > @@ -822,19 +823,16 @@ static irqreturn_t bmg160_trigger_handler(int irq=
, void *p)
> >  	struct iio_poll_func *pf =3D p;
> >  	struct iio_dev *indio_dev =3D pf->indio_dev;
> >  	struct bmg160_data *data =3D iio_priv(indio_dev);
> > -	int bit, ret, i =3D 0;
> > +	int ret =3D 0;
> >
> >  	mutex_lock(&data->mutex);
> > -	for (bit =3D 0; bit < AXIS_MAX; bit++) {
> > -		ret =3D i2c_smbus_read_word_data(data->client,
> > -					       BMG160_AXIS_TO_REG(bit));
> > -		if (ret < 0) {
> > -			mutex_unlock(&data->mutex);
> > -			goto err;
> > -		}
> > -		data->buffer[i++] =3D ret;
> > -	}
> > +	ret =3D i2c_smbus_read_i2c_block_data_or_emulated(data->client,
> > +							BMG160_REG_XOUT_L,
> > +							AXIS_MAX * 2,
> > +							(u8 *)data->buffer);
> >  	mutex_unlock(&data->mutex);
> > +	if (ret < 0)
> > +		goto err;
> >
> >  	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> >  					   data->timestamp);
> >
