Return-Path: <SRS0=dNHO=DG=rwth-aachen.de=Stefan.Bruens@kernel.org>
From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
To: Jonathan Cameron <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Maciej Purski <m.purski@samsung.com>, <linux-kernel@vger.kernel.org>, "Andrew
 F . Davis" <afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack
	<knaack.h@gmx.de>, Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v1 5/7] iio: adc: ina2xx: Use a monotonic clock for delay calculation
Date: Sun, 10 Dec 2017 21:47:37 +0100
Message-ID: <2674819.FhFV8Gkxuq@pebbles>
In-Reply-To: <20171210173157.6cc78b4b@archlinux>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de> <7330c7df-330f-449f-8706-a2407e92ebcf@rwthex-w2-a.rwth-ad.de> <20171210173157.6cc78b4b@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12846704.5jW2WQ1msK";
	micalg=pgp-sha1; protocol="application/pgp-signature"
List-ID: <linux-iio@vger.kernel.org>

--nextPart12846704.5jW2WQ1msK
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Sunday, December 10, 2017 6:31:57 PM CET Jonathan Cameron wrote:
> On Fri, 8 Dec 2017 18:41:50 +0100
>=20
> Stefan Br=FCns <stefan.bruens@rwth-aachen.de> wrote:
> > The iio timestamp clock is user selectable and may be non-monotonic. Al=
so,
> > only part of the acquisition time is measured, thus the delay was longer
> > than intended.
> >=20
> > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> > ---
> >=20
> >  drivers/iio/adc/ina2xx-adc.c | 35 +++++++++++++++++++++--------------
> >  1 file changed, 21 insertions(+), 14 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> > index 2621a34ee5c6..65bd9e69faf2 100644
> > --- a/drivers/iio/adc/ina2xx-adc.c
> > +++ b/drivers/iio/adc/ina2xx-adc.c
> > @@ -703,10 +703,10 @@ static int ina2xx_work_buffer(struct iio_dev
> > *indio_dev)>=20
> >  	/* data buffer needs space for channel data and timestap */
> >  	unsigned short data[4 + sizeof(s64)/sizeof(short)];
> >  	int bit, ret, i =3D 0;
> >=20
> > -	s64 time_a, time_b;
> > +	s64 time;
> >=20
> >  	unsigned int alert;
> >=20
> > -	time_a =3D iio_get_time_ns(indio_dev);
> > +	time =3D iio_get_time_ns(indio_dev);
> >=20
> >  	/*
> >  =09
> >  	 * Because the timer thread and the chip conversion clock
> >=20
> > @@ -752,11 +752,9 @@ static int ina2xx_work_buffer(struct iio_dev
> > *indio_dev)>=20
> >  		data[i++] =3D val;
> >  =09
> >  	}
> >=20
> > -	time_b =3D iio_get_time_ns(indio_dev);
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data, time);
> >=20
> > -	iio_push_to_buffers_with_timestamp(indio_dev, data, time_a);
> > -
> > -	return (unsigned long)(time_b - time_a) / 1000;
> > +	return 0;
> >=20
> >  };
> > =20
> >  static int ina2xx_capture_thread(void *data)
> >=20
> > @@ -764,7 +762,9 @@ static int ina2xx_capture_thread(void *data)
> >=20
> >  	struct iio_dev *indio_dev =3D data;
> >  	struct ina2xx_chip_info *chip =3D iio_priv(indio_dev);
> >  	int sampling_us =3D SAMPLING_PERIOD(chip);
> >=20
> > -	int buffer_us, delay_us;
> > +	int ret;
> > +	struct timespec64 next, now, delta;
> > +	s64 delay_us;
> >=20
> >  	/*
> >  =09
> >  	 * Poll a bit faster than the chip internal Fs, in case
> >=20
> > @@ -773,15 +773,22 @@ static int ina2xx_capture_thread(void *data)
> >=20
> >  	if (!chip->allow_async_readout)
> >  =09
> >  		sampling_us -=3D 200;
> >=20
> > +	ktime_get_ts64(&next);
> > +
> >=20
> >  	do {
> >=20
> > -		buffer_us =3D ina2xx_work_buffer(indio_dev);
> > -		if (buffer_us < 0)
> > -			return buffer_us;
> > +		ret =3D ina2xx_work_buffer(indio_dev);
> > +		if (ret < 0)
> > +			return ret;
> >=20
> > -		if (sampling_us > buffer_us) {
> > -			delay_us =3D sampling_us - buffer_us;
> > -			usleep_range(delay_us, (delay_us * 3) >> 1);
> > -		}
> > +		ktime_get_ts64(&now);
> > +
> > +		do {
> > +			timespec64_add_ns(&next, 1000 * sampling_us);
> > +			delta =3D timespec64_sub(next, now);
> > +			delay_us =3D timespec64_to_ns(&delta) / 1000;
> > +		} while (delay_us <=3D 0);
>=20
> Umm. I'm lost, what is the purpose of the above dance?
> A comment perhaps.

next is the timestamp for the next read to happen, now is the current time.=
=20
Obviously we have to sleep for the remainder.

Each sampling interval the "next" timestamp is pushed back by sampling_us.=
=20
Normally this happens exactly once per read, i.e. we schedule the reads to=
=20
happen exactly each sampling interval.

The sampling inteval is *only* added multiple times if it is faster than th=
e=20
bus can deliver the data (at 100 kBits/s, each register read takes about 40=
0=20
us, so sampling faster than every ~1 ms is not possible.

The old code measured the time spent for reading the registers and slept fo=
r=20
the remainder of the interval. This way the sampling drifts, as there is so=
me=20
time not accounted for - usleep_range, function call overhead, kthread=20
interrupted.

Using a timestamp avoids the drift. It also allows simple readjustment of t=
he=20
"next" sampling time when polling the status register.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart12846704.5jW2WQ1msK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWi2daQAKCRBvf0o9jP6q
UzvjAJ4818Bd7ni9KHOeYtIDPo+TNZLvggCgtd/ftvl5ine7B+fMuHTIAhe8BUY=
=R2tr
-----END PGP SIGNATURE-----

--nextPart12846704.5jW2WQ1msK--
