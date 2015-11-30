Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34189 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753877AbbK3RYz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 Nov 2015 12:24:55 -0500
Date: Mon, 30 Nov 2015 18:24:44 +0100
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
Subject: Re: [PATCH v2 1/5] i2c: add i2c quirk flag for unsupported clock
 stretching
Message-ID: <20151130172444.GB9554@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
In-Reply-To: <1446118467-26453-1-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 12:34:23PM +0100, Nicola Corna wrote:
> Add I2C_AQ_NO_CLK_STRETCH quirk flag, to be used when clock stretching is
> not supported.
>=20
> Signed-off-by: Nicola Corna <nicola@corna.info>

Applied to for-next, thanks!


--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXIZcAAoJEBQN5MwUoCm2NxsP/jgtu4WoXF4M607QBQTVnN2y
HZ/zuWYN7jbqOAIOP9uvaurj/IcMHtJnOio/FHJ4eFykSLGpAMHc3qs29+eCO7Or
4TYvArLnkTlMiV93Ov8LmOh/iukpQ3HkQ4e67jdh/LAj47zgF0cjRJ5xKWr9EolN
BP1gpz0sCl8bGq3OtyTMShiFVJ7UOFauX6PTkKAh2xRCm1hti+wEuI67TfdvwUjm
bnv7omKdhlifeZ1JmkAH1maa/7keTVpjKBH4YTYn3T9PVFGhDmR+odi8Sd6scUNM
8Sg8EKTAHeI/wZbI+GoKx9v8bdiKd/lQ3TxX/+6XkQdx+i1SzlWT5gb9f2CVngSe
nNfp3xJHy0WuJDaONUJ8UI3ZbUbGBRsFPsk6GfwHgwTkm3fXf/8wZpdyo1hrVG5F
Zo0d7An9hvhKToaMLKiHvVkQUoLvVZhj80M8xjjmi0TzBDQb95iDQDK5xP0bDiC+
6fgEPSIf2+QPFFqWRWuyeId9r8xgJPfT2YgDxuDx9mV1spr68Btc9mclGQfP15Bo
JGdsrArQe1nFe0ZDG33/3LFb2cUasA1C/Wnd5sMOZCw6a2aQOySvZhxfuKlmudBl
JxeSUIypFPGSmG6m2EMJ/wArofkj/L9hBUxKn8YZcRIZaEOAoJctUkASihNj4rY/
bULwnZQAg7K1KSzngqi9
=vxHD
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
