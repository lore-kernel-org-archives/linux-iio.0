Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>, Lars-Peter Clausen <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] iio: adc: add new lp8788 adc driver
Date: Fri, 14 Sep 2012 00:33:36 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF4C03@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F41EF45CC@DQHE02.ent.ti.com>
 <5051D05C.4050802@kernel.org>
In-Reply-To: <5051D05C.4050802@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

>=20
> Couple of nitpicks in line to add to Lars-Peter's ones.

I really appreciate it.

> > +#define LP8788_CHAN(_id, _type) {				\
> > +		.type =3D _type,					\
> > +		.indexed =3D 1,					\
> > +		.channel =3D LPADC_##_id,				\
> > +		.info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
> > +			IIO_CHAN_INFO_SCALE_SEPARATE_BIT,	\
> > +		.address =3D LP8788_ADC_RAW,			\
> > +		.scan_type =3D IIO_ST('u', 12, 16, 0),		\
> > +		.scan_index =3D 1,				\
> scan_type and scan_index should only be relevant if you are doing
> buffered capture (unless I'm missing another use of them in here
> somewhere...)  Hence drop them for now...

Thanks for clarifying this.

> > +static void lp8788_iio_map_unregister(struct iio_dev *indio_dev,
> > +				struct lp8788_adc *adc)
> > +{
> Can't immediately see how this runs without adc->map set. If it
> doesn't drop the check.
> > +	if (adc->map)
> > +		iio_map_array_unregister(indio_dev, adc->map);
> > +}

You're right. No need to check whether iio_map is valid or not.
That is already implemented in the iio_map_array_unregister().
It will be removed in the next patch.

Thank you.

Best Regards,
Milo
