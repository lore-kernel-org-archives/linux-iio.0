Return-Path: <broonie@sirena.org.uk>
Date: Wed, 12 Aug 2015 11:25:50 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Stephen Boyd <sboyd@codeaurora.org>
Message-ID: <20150812102550.GQ10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H2kTGx6mr3R59oXC"
In-Reply-To: <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
List-ID: <linux-iio@vger.kernel.org>


--H2kTGx6mr3R59oXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:27PM +0200, Markus Pargmann wrote:
> Regmap does not support 64bit. The ival that is used to write the 64bit
> data to, is unsigned int and can't hold 64bit. _regmap_write also just
> supports unsigend int.

What makes you say that unsigned int can't hold 64 bit?  An architecture
can have 64 bit ints if it likes.

--H2kTGx6mr3R59oXC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyx8tAAoJECTWi3JdVIfQPsIH/0DkJhKTB1YWk+cP+biLill5
UL3kxSk38lOrkCyCw+IDfRrBApWs1r5EaTM6X/OQs3/6HoXU55bX1V3S/yIZKD/y
0MHEifc0ibIcOEhisbviGdAIkKqtHPK1KOnZKbscTLtB0lTxmgOygH7BGMXDItuK
hFAdnL+iagN0v+fRSv4pwz5kTrZutpvTeaFGIMCCZgWTDgLqzx1IOR5M7d92MCYT
mxBvGLZ1U5AL3XonniwTef1W6zXdBfJ76nkBeabKQKR0mg00avcEjaJ/qpeCAnci
YfypY0oXcvWW9d5kAb4dJ4yGutodIUbw86V66/mCgP3X6TFCW3DEUmyiyqEL7Us=
=IeJG
-----END PGP SIGNATURE-----

--H2kTGx6mr3R59oXC--
