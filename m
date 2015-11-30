Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:34224 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753832AbbK3R1K (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 30 Nov 2015 12:27:10 -0500
Date: Mon, 30 Nov 2015 18:27:04 +0100
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
Subject: Re: [PATCH v2 3/5] i2c: add I2C_AQ_NO_CLK_STRETCH to i2c-bcm2835.c
Message-ID: <20151130172704.GD9554@katana>
References: <1445976718-7449-1-git-send-email-nicola@corna.info>
 <1446118467-26453-1-git-send-email-nicola@corna.info>
 <1446118467-26453-3-git-send-email-nicola@corna.info>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
In-Reply-To: <1446118467-26453-3-git-send-email-nicola@corna.info>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--tNQTSEo8WG/FKZ8E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2015 at 12:34:25PM +0100, Nicola Corna wrote:
> As reported here
> http://www.advamation.com/knowhow/raspberrypi/rpi-i2c-bug.html
> and confirmed here
> https://www.raspberrypi.org/forums/viewtopic.php?p=3D146272
> the BCM2835 has a hardware bug in its i2c module which prevents a correct
> clock stretching. This patch adds the I2C_AQ_NO_CLK_STRETCH quirk flag
> to i2c-bcm2835.
>=20
> Signed-off-by: Nicola Corna <nicola@corna.info>

I put the above links into the code as comments, reworded the commit
message a little and applied it to for-next, thanks!


--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWXIboAAoJEBQN5MwUoCm2pR8QAKAiOtb9vlMBVSGb5WcH9691
+1flu0xpdUB7pq7+UxpEYFtVuGmA2mK4Nf5OlXvkP09q7UhORyOOk06ehN22cxkF
mE/oLxI9kbycz8ky3XVedXvp59n0pJ7ZSG3O+lEayUzr25Mxbvf2WnBS1CZa7k4L
gBK8aEn6/9M4d1vX5TI+DY2OKckpZhrRggNxLIwnC8ZENyTd1jvo5wGWm6Dn8jrq
C6wTXZ9hdCqtCamdPN7+caOOu1folTnv+Qf3q87w1IG/bKGsu4Y3cBidYJAb/R3c
/qhVkZcuFzQadqBoprtmec17DV6+8fxeMgF8qKectjFjcEeVrB5erFSRTK7SytVM
/Zda3OjN61+4FmaE/eCWet1OU07yHsxpXlxxadMCvkiBiqcmmiDH0JyaMOCRiVpL
q5/o4FDzZQ6eJ2wxP5aNJWoDUHNrYq4p9tPbMEgi8CVVpU8QspvNhdBOayKjlaAR
+YBU78T3xEjXdGneSxtgLWNYfQZtcbzmB1IIjl8UFpw/Yp6ivjYPdou3U4FaQemu
boEcQ2CmzN9T6+8Rjaq3yfrNvVr8ZV2iz/vQ97z6Bl/DL4bU4k7IcidmmQw75CVN
OW4bzNRARLy+/9Q08RHpM9Qa8S7wJ8a4wBdeJPiUkT8MPAalLridmA8zhBNhKerw
hx9ud6bNf8Ej6xB/PL4i
=tAlU
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
