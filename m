Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754862AbdETQyy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 20 May 2017 12:54:54 -0400
Date: Sat, 20 May 2017 18:54:51 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/7] twl4030-madc cleanup
Message-ID: <20170520165450.aet2oekjakzorcw3@earth>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fd4rk5hiupvihi5n"
In-Reply-To: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--fd4rk5hiupvihi5n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

> Here are a few cleanup patches for the twl4030-madc
> driver, that remove the last users of the driver's
> legacy API and then remove it.
>=20
> Sebastian Reichel (7):
>   hwmon: twl4030-madc: drop driver
>   power: supply: avoid unused twl4030-madc.h
>   iio: adc: twl4030: Drop twl4030_get_madc_conversion()
>   iio: adc: twl4030: Unexport twl4030_madc_conversion()
>   iio: adc: twl4030: Drop struct twl4030_madc_user_parms
>   iio: adc: twl4030: Remove twl4030_madc_request.func_cb
>   iio: adc: twl4030: Fold twl4030-madc.h into driver

Just a reminder, that patch 1 & 2 have been merged into 4.12-rc1
and Wolfram acked the changes to header in include/linux/i2c,
so patch 3-7 can be queued by iio for 4.13 :)

-- Sebastian

--fd4rk5hiupvihi5n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlkgdNgACgkQ2O7X88g7
+ppmMBAAi9z54t11LFBRc+Ng5v0hykVmt37E25CvsDGJu/b2c+bIW942j21JorRU
qpomBqU9yX//rjKAKZMnOarynMao9p/j1ZqrfFsH8IxhlIZlGzldzSnDBXZ3ZbOa
SWCmfyDLFoKJh9VdB/4jocy2jGNkxwo+FAIep/ugX5Zwf0z1wEFoormDWMD9UxjF
k8M93NsEvmthmWcCiDdDg8vn90FEVNQ/0A5QjSIhLH9whK8hTVkeFGJfua7vnQ+S
XQA5wNMhMdi7NSwNqPyNUbpRx+mCl8YDXL2z7LUeGton/bbX1xQUtO1id3vfwKLw
xMN7x1b5e+Lh27NKFoa28kOZmXIYY7v4yLgxW5wMVKC47ZMwb3bQBnU49QWE1mko
e4yND3XYtdzwiiisc9UYQI3EwrnJAYso/6lXynqJre+5JOjMOmWUgP79M5N8rKds
HIKIUsTmBEiTydHeBUqHg3tr5jh271sgxU55YPZ2HzbBT0eEVt09oLQg3uYACRDm
dQH+GaTEGriuMyQGcBEliP2NRksytIgRBRmegfK16VJk3TMRmRI5rqiXQqOyWYek
xrrfrZHyIc7vK/zOqH+sfnPgXCo975dPZfzxG3KnSzxPPCZtpwHVD4grlNnRgpCW
dz/fqEJXIJg44enO/gz4HZdt5CuHFXVdiZz+q1wG2vGp4HiKQ7E=
=oIdJ
-----END PGP SIGNATURE-----

--fd4rk5hiupvihi5n--
