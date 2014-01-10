Return-Path: <vivien.didelot@savoirfairelinux.com>
Date: Fri, 10 Jan 2014 15:00:04 -0500 (EST)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	kernel@savoirfairelinux.com
Message-ID: <141310648.567420.1389384004339.JavaMail.root@mail>
In-Reply-To: <52CFBD0F.1080603@metafoo.de>
Subject: Re: max1363: internal reference
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

My bad, since a405b00 external reference is supported if the device has
a regulator, and fallback to internal if it doesn't.

Best,
Vivien

----- Mail original -----
> De: "Lars-Peter Clausen" <lars@metafoo.de>
> =C3=80: "Vivien Didelot" <vivien.didelot@savoirfairelinux.com>
> Cc: "Jonathan Cameron" <jic23@kernel.org>, linux-iio@vger.kernel.org, ker=
nel@savoirfairelinux.com
> Envoy=C3=A9: Vendredi 10 Janvier 2014 04:27:43
> Objet: Re: max1363: internal reference
>=20
> On 01/09/2014 06:39 PM, Vivien Didelot wrote:
> > Hi Jonathan,
> >=20
> > As described in the max1363.c header, the control of the internal
> > reference is not currently supported by the driver.
> >=20
> > We have two max11603 and max11605 which need this option. We
> > currently
> > use a monkey patch like this in max1363.c:
> >=20
> >     @@ -1414,7 +1414,12 @@ static const struct max1363_chip_info ma
> >      static int max1363_initial_setup(struct max1363_state *st)
> >      {
> >     +#ifdef OUR_BOARD
> >     +      st->setupbyte =3D MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_INT
> >     +#else
> >            st->setupbyte =3D MAX1363_SETUP_AIN3_IS_AIN3_REF_IS_VDD
> >     +#endif
> >                    | MAX1363_SETUP_POWER_UP_INT_REF
> >                    | MAX1363_SETUP_INT_CLOCK
> >                    | MAX1363_SETUP_UNIPOLAR
> >=20
> > In order to add the support for this, I would suggest adding a
> > platform_data for this driver such as:
> >=20
> >     struct max1363_platform_data {
> >         bool internal_reference;
> >     };
> >=20
> > What do you think?
>=20
> Yes. But make sure to properly document the platform data struct with
> kernel
> doc.
>=20
> - Lars
>=20
