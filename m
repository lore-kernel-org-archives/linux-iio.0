Return-Path: <wsa@the-dreams.de>
Date: Mon, 9 Mar 2015 17:43:08 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vianney le =?utf-8?Q?Cl=C3=A9ment?= de Saint-Marcq <vianney.leclement@essensium.com>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	devicetree@vger.kernel.org,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>,
	Linux I2C <linux-i2c@vger.kernel.org>,
	Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 6/7] iio: mlx90614: Add power management
Message-ID: <20150309164308.GA2320@katana>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
 <1424879712-28304-7-git-send-email-vianney.leclement@essensium.com>
 <54FDBEB7.8030403@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
In-Reply-To: <54FDBEB7.8030403@kernel.org>
List-ID: <linux-iio@vger.kernel.org>


--huq684BweRXVnRxX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 09, 2015 at 03:39:35PM +0000, Jonathan Cameron wrote:
> On 25/02/15 15:55, Vianney le Cl=C3=A9ment de Saint-Marcq wrote:
> > Add support for system sleep and runtime power management.
> >=20
> > To wake up the device, the SDA line should be held low for at least 33ms
> > while SCL is high.  As this is not possible using the i2c API (and not
> > supported by all i2c adapters), a GPIO connected to the SDA line is
> > needed.  The GPIO is named "wakeup" and can be specified in a device
> > tree with the "wakeup-gpios" binding.
> Needs some i2c specialist input on this!  As you mentioned it is liable
> to be controversial.  Wolfram, is this a one off special or do
> any other devices do this sort of magic?

s/magic/insanity/ :)

I have never heard of something like this. Unsuprisingly, I can
not recommend doing it this way. But we all know hardware...

And while we could think about reusing the bus_recovery_infrastructure,
I don't think it is worth the hazzle. So, doing this GPIO fallback may
well be the best we can do now.


--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/c2cAAoJEBQN5MwUoCm2FkIP/3FI5LL0CgAzQFo6q2fy08yr
Ee1m2xBWD5rlT8oDtYRrAPq+cz5NU8tvwpxjUiIGwb2D/Gn7F+nCWu4GKFUJ7f48
041ifDquYqpkfsT5sIILWn2mDJJX7w0KEIF7h/VGoaVSmWTE7UZnrkvk2DKp7lbO
ZStvhynJ2QNhzETcBcADstwCw/6yq3iEYGAJrqapclUrNkIkicQL27Em6nVdGavY
9WaGbew2MwJSMKoyAtzrX5jE/LJKfxbtYncLCR0YucPvmQzrB2PyZzZh42HbftqH
NmNrAQJnFyGOKRCHISyoscM0WnNcbjPhUWlPRWVaQrgUbRQd67jhDUfj5IYxQpnY
oKKca60h2GagHPGpGo6Lpu0l5yJk8bVDpl281M12S5IWhd/XtH3qEMfcVndcejTl
90Z8EwBMwFozg9KFFxtMbXa3CHpGeIEKoKuzhYbNsl3fj4gKwjsfgTphlWUzB2DE
tBdB6DFdEy3BrJBNBpyAgQXFxGa76zPR25rlhA5k3G62mHMbtKhzpGiYw4D9mlxP
dmVN3aJWT6aMNQtcla2OPfaiI1sX8OXee+HX20b5G0GglStc429iBg4oVfyIukV6
xYJBo8AIATNIe0TMvhnykGTtN7QAvmlxRWSIXxG1nRWa7aPppYL0KfHs3SgUZmi9
e21m/ivCI/w3JvEpGQe/
=GMGj
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
