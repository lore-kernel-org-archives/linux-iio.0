Return-Path: <Milo.Kim@ti.com>
From: "Kim, Milo" <Milo.Kim@ti.com>
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, Jonathan Cameron <jic23@cam.ac.uk>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] iio: adc: add new lp8788 adc driver
Date: Fri, 14 Sep 2012 00:33:27 +0000
Message-ID: <A874F61F95741C4A9BA573A70FE3998F41EF4BFC@DQHE02.ent.ti.com>
References: <A874F61F95741C4A9BA573A70FE3998F41EF45CC@DQHE02.ent.ti.com>
 <504DADE1.6010303@metafoo.de>
In-Reply-To: <504DADE1.6010303@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> Hi,
>=20
> One issue and a couple of nitpicks inline.

I really appreciate it.
Please see my questions below.

> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		ret =3D lp8788_get_adc_result(adc, id, val) ? -EIO :
> IIO_VAL_INT;
> > +		break;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		*val =3D (lp8788_scale[id] / 1000) * 1000;
> > +		*val2 =3D (lp8788_scale[id] % 1000) * 1000000;
>=20
> This looks suspicious. E.g. if the entry in your table has the value
> "1234"
> you'd end up with a scale factor of 1000.234000000. Which looks wrong
> for
> two reasons, given that you return INT_PLUS_MICRO val2 should never
> exceed 6
> decimal digits and secondly val is multiplied by a factor of thousand.
>=20
> Can you tell us in what unit the values in lp8788_scale are, that would
> make
> review easier.

The LP8788 has 13 ADC input selection.

ADC selection:
Battery voltage, general ADC1 and so on.

ADC result:
Result =3D MAX_VALUE * (raw + 0.5) / 4095  except ADC is the charger voltag=
e
If the ADC input is the charger voltage,
Result =3D MAX_VALUE * (raw + 0.5) / (4095 * 0.48)

The raw value is from the registers.
It has the range between 0 to 4095. (12bits)

MAX_VALUE is constant for each selection.
For the battery voltage, there are three ADC inputs. 5.0/5.5/6.0V
Battery voltage for Max 5.0V =3D 5.0
Battery voltage for Max 5.5V =3D 5.5
Battery voltage for Max 6.0V =3D 6.0
Charger =3D 6.0
ADC1 =3D 2.5=20

I'm afraid I still misunderstand how IIO ADC works.
Could you me some guide how to setup the scale in the driver?

Thank you.

Best Regards,
Milo
