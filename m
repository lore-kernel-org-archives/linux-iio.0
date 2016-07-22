Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39526 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753749AbcGVSUd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 22 Jul 2016 14:20:33 -0400
Date: Fri, 22 Jul 2016 20:20:29 +0200
From: Sebastian Reichel <sre@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Samu Onkalo <samu.onkalo@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2 v3] iio: magn: add a driver for AK8974
Message-ID: <20160722182028.GB22991@earth>
References: <20160720235620.GA2561@earth>
 <CACRpkdZbYqKO88tDjKemZfyK5tT9rvhsHhBFQcMYoK1gq01K9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
In-Reply-To: <CACRpkdZbYqKO88tDjKemZfyK5tT9rvhsHhBFQcMYoK1gq01K9Q@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 22, 2016 at 05:50:25PM +0200, Linus Walleij wrote:
> On Thu, Jul 21, 2016 at 1:56 AM, Sebastian Reichel <sre@kernel.org> wrote:
> > [On N950]
> > Tested-By: Sebastian Reichel <sre@kernel.org>
>=20
> Thanks! If you have hints on how to scale the raw values to
> Gauss, please help. (Been looking at the Mer sensorfw repo to
> no avail...)

Sorry, I don't have any hints.

> What userspace do you use on this device?

I have Debian on the emmc (it's not yet ready for daily use).
Mainline status of N950 is documented here:
http://elinux.org/N950

> > Do you have plans to take over the axis rotation support
> > from Samu Onkalo's driver? The Nokia vendor kernel had Y
> > and Z axis inverted.
>=20
> Oh I didn't think of adding that. IIO has a standard rotation
> matrix lib and binding, used in e.g. AK8975. I'll add it and
> resend.

Thanks.

-- Sebastian

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJXkmPsAAoJENju1/PIO/qavbQP/3k+4L4T3vMzJwgpkeB/UutB
1iY7XqTke2yKKIjuUdx+zcUd4tsR6cUSUNAZ2hK0mPSDmQzNnoFdBo3z10WjLiNK
H2FNWdyLLlNnnmnKQ9Svm+YdnGc0Zt9bJmLdIijrBkNhXOGolEsiteVC2a1fsc9i
KSDkj2c7kxx91oHHLzDbtI+7AOOMGgWk0wod3+jxljvisvIU/rgnxTBAmuYhRQrE
l3rsqMZmS7ebLWwdDIlMXRQzjrb5saglsXPGOIGljWUp0UkJn1TJAElN03g2eGrh
Xd1R5iaS5jRsLh4VJ+bOLb+N7qe2hhUzg3qyayMS4BZbTe+DTIBwM+lA95J01f5w
iflvruSpfcMwKL18XReT9HMes9g5P84j/cwm1nvt8mb82TDq4NAXrDzHexiE5E7D
O7psvAdzJUlwVd1b50Bqgz+e+0kFDJ8R9YUJMlWnN5r1LBVB/ga/zYo5ID0iXBs5
X5BoI9Lvn7sYhqH7Z90t+BJPye4I/F+2TZu6cClrvOEO0EICJUbBsVYBD3lXyYS5
KkOdIVMbu+Qdbog9CRTl/u/s3BIruv0uuGvkikunGaJsfZ0L0gUse3rHW8lktJUc
ROpH4BNJ/K+Pg0Kwo/88fziOW3T/qZCXRBNbiOFOl+/FswhYx+CNzawPaUa70Aqx
zXISZMQf9yfGhcPIdTSy
=ZCWl
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--
