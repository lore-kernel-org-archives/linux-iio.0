Return-Path: <maxime.ripard@free-electrons.com>
Date: Wed, 28 Aug 2013 10:56:31 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Josh Wu <josh.wu@atmel.com>
Cc: jic23@cam.ac.uk, linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com, thomas.petazzoni@free-electrons.com,
	mark.rutland@arm.com, b.brezillon@overkiz.com
Subject: Re: [PATCH v3 3/6] iio: at91: Use different prescal, startup mask in
 MR for different IP
Message-ID: <20130828085631.GO2695@lukather>
References: <1377602932-1899-1-git-send-email-josh.wu@atmel.com>
 <1377602932-1899-4-git-send-email-josh.wu@atmel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NKtYx2Ppz7d1tORf"
In-Reply-To: <1377602932-1899-4-git-send-email-josh.wu@atmel.com>
List-ID: <linux-iio@vger.kernel.org>


--NKtYx2Ppz7d1tORf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Josh,


On Tue, Aug 27, 2013 at 07:28:49PM +0800, Josh Wu wrote:
> For at91 boards, there are different IPs for adc. Different IPs has diffe=
rent
> STARTUP & PRESCAL mask in ADC_MR.
>=20
> Signed-off-by: Josh Wu <josh.wu@atmel.com>

It looks fine.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--NKtYx2Ppz7d1tORf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJSHbs/AAoJEBx+YmzsjxAgsPoP/0PYpy9nwGVh2J7HXrpBaPWZ
oNpuYeN7PQyQA9Z4GJSTHwHCnKKnyDeNxtckgPtbSrjBP6aWNdPIUwt1IKNFfygs
wfJpcmYLBMK8MgMC3BMcipKnKVQuJHwoq9FMQoXFJimEmtv7EYU/enxBkJFIqlSI
bPr+zJFoM00jwNJKl1dDst4QWoOqKsn4sv2W+fEFXklM/J4Q//eLEy4b4Zn2ksFY
QznXhslU64mt1QmiEmQEQ5PiULDCXxe3t4ofiyO+ryAmRK9SeXMdPWW99+EE7Ke9
F496ZGrA+DBUk+kkuocoi4pdu6T5cd7/DzAR2u7zDzOaLSD9WJK+ADLyVnTmlslG
zaHHifCNh7hrdgeGU3GTo5G+snw57UUpEXItuVhuAJnO11FtcsbPvZQA4MfD+zY6
s3WuW0AaUzERPgygDQ0BHx/Vcz1dDzuumxFJyGParpEBJqwBX8s65/4HftFvk0Wb
rV6q4g7EikAxZxmvmL2I3gDtVNyoaPtc4m7+0Zh7TyNnl/8qkc2eMvIVXQtRyubJ
mnfbiheNzqOcq2q1SbWQO2iWQB8t4kn/VgRN4kI538R2l0CB5vJ1U1aNjIxaAzbp
4WLfumGueOvjsdroAzZ9IqHSdbXQ136pbkUmCss4QTe22Mk2/fktaSIkD4GCGmwu
CUDByA0A3Ch5AimmNbQf
=5h5z
-----END PGP SIGNATURE-----

--NKtYx2Ppz7d1tORf--
