Return-Path: <balbi@ti.com>
Date: Tue, 26 May 2015 13:37:13 -0500
From: Felipe Balbi <balbi@ti.com>
To: Michael Welling <mwelling@ieee.org>,
        "Franklin Cooper Jr." <fcooper@ti.com>
CC: <dmitry.torokhov@gmail.com>, <vigneshr@ti.com>, <bgriffis@ti.com>,
        <jic23@kernel.org>, <wsa@the-dreams.de>, <balbi@ti.com>,
        <linux-input@vger.kernel.org>, <GWilson@sakuraus.com>,
        <linux-iio@vger.kernel.org>
Subject: Re: AM335x touchscreen issues
Message-ID: <20150526183713.GU26599@saruman.tx.rr.com>
Reply-To: <balbi@ti.com>
References: <20150526181157.GA8009@deathray>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HzaOE8X7KzPzAQEl"
In-Reply-To: <20150526181157.GA8009@deathray>
List-ID: <linux-iio@vger.kernel.org>

--HzaOE8X7KzPzAQEl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 26, 2015 at 01:11:57PM -0500, Michael Welling wrote:
> Greetings,
>=20
> I have been porting Linux to a new AM3554 based SoM and have found issues
> with the touchscreen reporting touch releases repeatedly to userspace
> without actually touching the screen when running ts_calibrate, ts_test
> or other graphical touchscreen applications.
>=20
> This started happening after updating pulling recent changes.

Can you bisect and find the offending commit ? Which recent changes are
you talking about ?

> It has also been confirmed to be happening on the beagle bone black:
> http://www.spinics.net/lists/linux-iio/msg18580.html
>=20
> If you look further into this thread you will see a workaround patch that
> I came up with:
> http://www.spinics.net/lists/linux-iio/msg18583.html
>=20
> Though this fix stops the reported events in userspace, interrupts are
> still occuring repeatedly.
>=20
> Does anyone have any suggestions beyond what I have done to remedy this
> issue?

yeah, it sounds similar to what Franklin has been working on.

Franklin, any comments ?

--=20
balbi

--HzaOE8X7KzPzAQEl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVZL1ZAAoJEIaOsuA1yqREpzMP/jf4N28wlJZZnumBt1h24BSr
aXluQr8polMMXV15xi1oyNvPi8ZyCC2CLaIw2N2EsHqCWVkGq9e3qTwxkKZKFnqi
JC355NoddOCz/Mggif02zIOCfG+7eMzor+A1Tw1PP4RO0nydLmjZqzxAtdeQuauT
woO2PHjZZbjEzMoPHKadzG0Yu/2kiMt56Owq7venmFvl30zv89S7PjAnmeVaITak
Ga/o3dEECiOpkHM6Y//R0qG0V+sIPRpitvJSPN7XKjQkQ6gPFcqHzW9nvkk6H8aV
Z1HYHBPAI4FJSVk8WoSNO2sPn+DRK1VgqfMNx/dQ1NnBFV08FSkX9xmx8K93ojle
Te/LqigCFdMFB2UvLqOKqTUZdRka2BDiOqAfK+T7/ULJ60zHNOKuoz19uCp6OzUg
aVB6YvG41Dcm9pbQQKtUnNFnLS3Qz3aG1Ottl8RwKVmmuZJI6Evdo7LjMUVCMdoB
uBFqhyNxshrUbR5hM2W3vzU6buFO+xoh/DWGY0Ljk+XRY9zBHa41btgy2G3s3psh
P11IHmnJizxw6D8oLV1rfh9+VlTI2m6KUGRQw05PZKsV3AGqpjH72GzA2Wqu7gKy
NR/1XEL6zXWH/lJftQ9QC0mwH09K+5nAEudZBVnvtkSNqZGWN5nj7nQ6Zqp2723g
Lpg/4q8yWAdOnYh8E643
=/YPt
-----END PGP SIGNATURE-----

--HzaOE8X7KzPzAQEl--
