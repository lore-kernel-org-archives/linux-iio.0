Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:51499 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751428AbeACLtA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Jan 2018 06:49:00 -0500
To: linux-leds@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
        Paul Fertser <fercerpav@gmail.com>
From: Oleksij Rempel <linux@rempel-privat.de>
Subject: proper framework for meter sink?
Message-ID: <649fa764-6598-8f05-90c0-e10a4d36b08f@rempel-privat.de>
Date: Wed, 3 Jan 2018 12:48:36 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2VSFfMUdyK0OJWUMrMhKuov9fsqKowNdS"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2VSFfMUdyK0OJWUMrMhKuov9fsqKowNdS
Content-Type: multipart/mixed; boundary="5JXIsWezL3qkDygrxiIJimxXE5eMClgGC";
 protected-headers="v1"
From: Oleksij Rempel <linux@rempel-privat.de>
To: linux-leds@vger.kernel.org, Sakari Ailus <sakari.ailus@iki.fi>,
 linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
 Paul Fertser <fercerpav@gmail.com>
Message-ID: <649fa764-6598-8f05-90c0-e10a4d36b08f@rempel-privat.de>
Subject: proper framework for meter sink?

--5JXIsWezL3qkDygrxiIJimxXE5eMClgGC
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hallo all,

I wont to use existing LED triggers by setting multiple LEDs on trigger.
The triggers should use brightness value by different trigger intensity
and the driver should set different amount of LEDs depending on
brightness value.
With other words LED meter controller by kernel LED framework. It should
be possible to configure LED arrays by Device Tree.
Initially i was thinking about some kind of extended leds-gpio.c driver
which will convert brightness value to LED position. But one my friend
pointed me that metes exist in different configurations and it make no
sense to bind it to LED framework.

Do you have any ideas, suggestions, tips? I know there are lot of user
space based variants. On other hand kernel already have almost every
thing what I need.

--=20
Regards,
Oleksij


--5JXIsWezL3qkDygrxiIJimxXE5eMClgGC--

--2VSFfMUdyK0OJWUMrMhKuov9fsqKowNdS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF4EAREIAAYFAlpMwxQACgkQHwImuRkmbWnQXAD/TY+IhQq9eFM9bkRSLWXb4/rA
tmeHUjVPtwJfH4H4PPoA/3kyNOJvzLo2u+fuUl2xa8bX6IR2n76FMe4DlAD2kzw0
=QsCB
-----END PGP SIGNATURE-----

--2VSFfMUdyK0OJWUMrMhKuov9fsqKowNdS--
