Return-Path: <broonie@opensource.wolfsonmicro.com>
Date: Thu, 9 Feb 2012 19:20:55 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	guenter.roeck@ericsson.com, khali@linux-fr.org,
	dmitry.torokhov@gmail.com, alan@lxorguk.ukuu.org.uk, arnd@arndb.de,
	linus.walleij@linaro.org, maxime.ripard@free-electrons.com,
	thomas.petazzoni@free-electrons.com, zdevai@gmail.com,
	w.sang@pengutronix.de, marek.vasut@gmail.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 1/5] staging:iio:core add in kernel interface mapping and
 getting IIO channels.
Message-ID: <20120209192054.GN3058@opensource.wolfsonmicro.com>
References: <1327837614-24176-1-git-send-email-jic23@kernel.org>
 <1327837614-24176-2-git-send-email-jic23@kernel.org>
 <20120209181056.GA957@kroah.com>
 <4F3411BA.5070401@kernel.org>
 <20120209185754.GA10284@kroah.com>
 <20120209191509.GM3058@opensource.wolfsonmicro.com>
 <20120209191718.GA10999@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z3ovhOgMYmj8MRdq"
In-Reply-To: <20120209191718.GA10999@kroah.com>
List-ID: <linux-iio@vger.kernel.org>


--z3ovhOgMYmj8MRdq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 09, 2012 at 11:17:18AM -0800, Greg KH wrote:
> On Thu, Feb 09, 2012 at 07:15:10PM +0000, Mark Brown wrote:

> > This is nothing to do with init ordering, it's all about the two devices
> > finding each other at all.

> Ok, if that's all this is for, they why name it "iio in-kernel logic"?
> That made me believe that this is something that is needed if anyone who
> happens to want to use the iio interface needs it.

> If it's just "iio discovery" then call it that :)

I think that's all due to the overall goal of the patch series - the
original use case for IIO was purely for userspace users and what the
patch series is doing is adding the ability to use IIO devices from
within the kernel.

--z3ovhOgMYmj8MRdq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPNBx9AAoJEBus8iNuMP3dr5AP/30WrYkUrr4+fTDznCI1tSLd
1j/AnpeZUf12T7UIJab3CEgMP3nY0/Wdi2Lc5E3sXRHkAPjbSl3jufC/1ssPDXly
szbdjpPnt2K3rmmXEeSc7uBISFfVZgJdoaSikobpkPgz6XGNXZ2Sc8U36CAhXaXN
zYI3h2qrSYR35weUPvxEsmXEwlhQJWpyz5rHAaLdaTofQ6iFyTq90ZASQ2vxKubE
TTg+Z8Psy3kR9Pc5F+c7QoEVui3PI/ofRy/t41SAyfKjHfrrIKVWtnWX3IoBVpQJ
Fv0fztI6inzLDviQ+EsYTPZwQDAvMaIJjTDVZg5u4OB/1mjud3ARa/sXCPu8rotx
jmTSxriQEHemhSBZFN82L+IM67jA8kpZY6JYEaQqRG518WHfY6IAzm3bX5SxVaED
vQVS5LjglrnmpAw3dmf/pHCAt/Q4mEPDhLvti4N58TkuzlNuWNJ8yHHPzx6u7OO6
QdUEPDiogAYK+iGRK0hBN24UDrz8QbX9QnwcQEowJaq0hha0CaOVadcRBbj+dBXe
nW2xzPjFfSmmIvxM+FQyK4UYXPV7HqnooOyPZrmhVPdEJtbKmaUMf79Xli+H0NVD
fF1al9mKyeyew1ePQ13+fkOlElmCvKmqrmgVYXfiuMk2BxGhiSiAEmeBJZORa+Bd
9IWg7g+o02Y6D6Ns+F4L
=BBff
-----END PGP SIGNATURE-----

--z3ovhOgMYmj8MRdq--
