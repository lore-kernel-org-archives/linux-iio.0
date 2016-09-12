Return-Path: <maxime.ripard@free-electrons.com>
Date: Mon, 12 Sep 2016 12:07:19 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>, jdelvare@suse.com,
	linux@roeck-us.net, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 2/3] mfd: add support for Allwinner SoCs ADC
Message-ID: <20160912100719.GJ9449@lukather>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-3-git-send-email-quentin.schulz@free-electrons.com>
 <20160912091829.GB1873@dell>
 <93bd339b-85ab-d0fc-5e80-e2aca290c0d7@free-electrons.com>
 <20160912095923.GD1873@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9pltayyoy9lWEMH"
In-Reply-To: <20160912095923.GD1873@dell>
List-ID: <linux-iio@vger.kernel.org>


--M9pltayyoy9lWEMH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 12, 2016 at 10:59:23AM +0100, Lee Jones wrote:
> > >> +static const struct of_device_id sun4i_gpadc_mfd_of_match[] =3D {
> > >> +	{
> > >> +		.compatible =3D "allwinner,sun4i-a10-ts",
> > >> +		.data =3D &sun4i_gpadc_mfd_cells,
> > >> +	}, {
> > >> +		.compatible =3D "allwinner,sun5i-a13-ts",
> > >> +		.data =3D &sun5i_gpadc_mfd_cells,
> > >> +	}, {
> > >> +		.compatible =3D "allwinner,sun6i-a31-ts",
> > >> +		.data =3D &sun6i_gpadc_mfd_cells,
> > >> +	}, { /* sentinel */ }
> > >> +};
> > >=20
> > > Don't mix OF and MFD functionality.
> > >=20
> > > Why don't you create a node for "iio_hwmon" and have
> > > platform_of_populate() do your bidding?
> > >=20
> >=20
> > We are using a stable binding which we cannot modify. This means, the DT
> > in its current state can only be modified to add features, which is not
> > the case of this driver (it is a rewriting of an existing driver which
> > uses the rtp node).
>=20
> Then use .data =3D <defined model ID> and set up a switch() in .probe().

Uh? Why? It just adds a non-standard indirection, while using
of_match_device is very standard, and used extensively in Linux.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--M9pltayyoy9lWEMH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX1n5XAAoJEBx+YmzsjxAgpNAP/jncdHrKYlSWR6YUCODSlLVJ
DeSkHIIsvg6PDgFX1jGFtdXDoVcN7uHvhAZsBeKsN03/VUFS+/NmJ1VWy5SFqU/n
PjxMzIYMe5etiiFeu6C9R7DjDoJnJsGwUVjNa/ZI4G1A+Wj6ZVxz1cu8WERe8JhZ
eDyaDENj7t88HqaunsDs/94tiGpqBv+FtdqjXlZSeG8htGjjflNos00rHDUv1jIn
QaEV6rMLkhT7XjHvzSCGU3zN03vzli66bmV82ztbodv1g/AOyWTvC2Q+nZKXRWWs
SUdiP/EzqnerEnRAeF0dD3AOHl8S9GAh6fFkCdn9bNYL5zmaFxCp/pW9aqlV6FjA
Hz+twnaXorxsN/S5AO+YK6R98wrtubqOfaCidmxoCvRq4ig+1PiEDiVztIzviseG
MUTsJTmA4GQA3YrsjeTGFFAnxymRZW/GjglnQ8960lGRs+MksxynvjEJ65El73wK
fihWoRFgFHTqPU9Qz3Kp/9yQLwvS/RocLktYAzpeAGw+D8iugmNSlufDa1KtYSoD
XhohWc3yQSpbAqg3QBEX3vd9biyG3rqXMlf+zWofRUOe1d8WvubF7l7pBA2tljCh
vqQGo17VmsAle+93B6GP8BKzxx9e+f2rOXvFJZpUkHREi3i9mvZpcOl803XDSUgo
AvL/Rbu7/5JZ7crqOqvC
=6/CP
-----END PGP SIGNATURE-----

--M9pltayyoy9lWEMH--
