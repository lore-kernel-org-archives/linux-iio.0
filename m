Return-Path: <SRS0=M1Cr=KV=sirena.org.uk=broonie@kernel.org>
Date: Mon, 6 Aug 2018 17:04:02 +0100
From: Mark Brown <broonie@kernel.org>
To: "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"leonard.crestez@intel.com" <leonard.crestez@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v4 3/6] regmap: Add regmap_noinc_read API
Message-ID: <20180806160402.GR2414@sirena.org.uk>
References: <1533557087-10401-1-git-send-email-stefan.popa@analog.com>
 <1533557087-10401-4-git-send-email-stefan.popa@analog.com>
 <20180806143901.GP2414@sirena.org.uk>
 <1533569985.11050.9.camel@analog.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CVXKxAdNG2kQIXaJ"
In-Reply-To: <1533569985.11050.9.camel@analog.com>
List-ID: <linux-iio@vger.kernel.org>


--CVXKxAdNG2kQIXaJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 06, 2018 at 03:39:53PM +0000, Popa, Stefan Serban wrote:
> On Lu, 2018-08-06 at 15:39 +0100, Mark Brown wrote:

> > I suggested having an explicit operation to check if a register supports
> > this mode of operation when I reviewed an earlier version, I didn't
> > notice a reply on that?

> Sorry, I got confused about what needs to be done. Should I add a new fie=
ld
> to the=A0regmap_config struct which will be checked during the function c=
all?
> Something like=A0can_multi_write? How do you suggest it should be called?=
 Is
> readable_noinc_reg ok?

Like I said last time I'd suggest making it more like the readable and
volatile checks - I'm fairly sure I've seen devices that don't
autoincrement only for some registers.

--CVXKxAdNG2kQIXaJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltocXEACgkQJNaLcl1U
h9CPEwgAgJgNRHOcXvq09ljPcT1HbHSUubDS7V9azrcS1ep0ybNo22MQvjqIZnbU
8GZasf4D4qUuVuswM7kMLuJsgiq6JyY8CNJYWluZWXAmqYo6jSrX5fVwjimkSdjT
DJj6MqjheDNKEmkToR2NNLbWsVC34Ky8Fy7qOg/xiOTl9A9ZTIq1PIeQoFeafK27
sg6+IRkm1Mad9Eenxu79DXxj7wZaJMCX/e6syQSuw3yMYMBPdymPXibIuyS6EsCX
91r/8xKnhERTBDV65dNfoo+XNCk3kHAIrUFw6lr75G9qz/Vk9uM6p8RiQDoQjlzF
UKNfObAIqgWfy+WcqJoGVjCVYQLjGA==
=08kk
-----END PGP SIGNATURE-----

--CVXKxAdNG2kQIXaJ--
