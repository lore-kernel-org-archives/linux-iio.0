Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34207 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753886AbbK3R0H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 Nov 2015 12:26:07 -0500
Date: Mon, 30 Nov 2015 18:26:02 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Nicola Corna <nicola@corna.info>
Cc: Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>,
	Eric Anholt <eric@anholt.net>,
	Jonathan Cameron <jic23@kernel.org>, linux-i2c@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-algo-bit.c
Message-ID: <20151130172602.GC9554@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-2-git-send-email-nicola@corna.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
In-Reply-To: <1446118467-26453-2-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 12:34:24PM +0100, Nicola Corna wrote:
> Add I2C_AQ_NO_CLK_STRETCH to drivers/i2c/algos/i2c-algo-bit.c when getscl
> is not available.
>=20
> Signed-off-by: Nicola Corna <nicola@corna.info>

Applied to for-next, thanks! Please check git-log next time to see how
the subsystem likes its prefixes, here "i2c: algo-bit: ...".


--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXIaqAAoJEBQN5MwUoCm2tuAP/0pzu5YvrhrRZQUlF7rFkb9p
4WpOZt/+FKQlQdNmIf7E+q2OabVCz7AgIZUOvJdPkf/CX1IRzTKIlW3uT8GKzbRG
AyCwCmORrTraAcGKswI7KIOT5j9z+uguCPz9mtsbOnIpAnMeQ32NME5VPZyMZO5M
hzx/HF5TYRo4yCbwQTTxwIHLA7kOH3qyb9RQZ/J2m1LHTfklKW9jGmWdjwVezKaH
tEMWnB29IZOv7RRAdb2eCZvoIunyj48CL5I105PpbZMcaWfp8RH5QEd3Ppq/RJTW
cDIYuH7LC2iEJn8CTecXCmTNu5ClrSHSuKiCjM/Gb04x6ZhJ3toxqbKF7RPQTWqr
beRXJDdh7RhooM7AoPnXOCFuHNuG7rR3RotQTJqM5wj9CEdqhdSv1aMa0zAzEvCn
Gf68ub+ErkHBI/RLCmPjitOhVi4izEG+6Ga1nYEsUpUivdzFy6BPkkPZpgizzrSi
ThAMp1VfMgFlKaeJtQB6bVn8+XcpgNkDbmJ3j0ZnENhwlTHDVUDYkQmnhFjo9gbq
hdLv7/mKpAmAci7s5O5JkfRlNXpNe7vUtX0UD6S10PwDzLtdFxfn9giNFLLVoGXw
IXLv4+nS8vrhy0mwOheNA/Q2OZjrlGhtlR0dHocfHi0xOICDjNjdHpWkfrB9zPLQ
Wqbl3VfbO5Zq9wY81SCD
=gbZS
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
