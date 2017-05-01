Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.zeus03.de ([194.117.254.33]:32856 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S3000658AbdEAKiT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 May 2017 06:38:19 -0400
Date: Mon, 1 May 2017 12:38:16 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] hwmon: twl4030-madc: drop driver
Message-ID: <20170501103816.GA4435@katana>
References: <20170427153012.32310-1-sebastian.reichel@collabora.co.uk>
 <20170427153012.32310-2-sebastian.reichel@collabora.co.uk>
 <20170427165159.GB30189@roeck-us.net>
 <567f0680-abe9-790e-aea7-65c98ae0698a@kernel.org>
 <20170501092754.wgwhbrjjigpc7xjf@earth>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
In-Reply-To: <20170501092754.wgwhbrjjigpc7xjf@earth>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I can then pick up the rest once I have acks from Wolfram
> > (who should have been cc'd as we are hoovering up things from the
> > i2c directories in this series)
>=20
> $ ./scripts/get_maintainer.pl -f include/linux/i2c/twl4030-madc.h
> linux-kernel@vger.kernel.org (open list)
>=20
> This directory contains headers for random i2c chips
> and Wolfram maintains the bus drivers (and is already
> overloaded with work afaik), so I did not Cc him.

You both have a point :) I should maintain include/linux/i2c but as it
is mainly cruft at the moment, I don't do it very actively.

That being said, I now noticed the patchset and am super happy for the
move of the include file to the proper place. So, for all patches
touching include/linux/i2c:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

Thanks!


--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlkHEBMACgkQFA3kzBSg
KbYoiA//c5FX8zb4cfMlukUKXTCsZJTzJKfjfQy+FakqnnBGUsf2rwOJRMLef2gx
juff9RxvE8YDSHeMdmc5N2ROop5c5X8vAfY3mIaR286nJ7gSWKSKwbyBUarA2NFP
rw3dlGjIQ2M7xaKi5ntLsAECIhduSrn73yqYG95oZapncLxXgu7pBEb3hnzF8tmK
JHisj7fEt1kC73/R2EUX8uPfq5giuwoterZe+H9VUy9bHtkqAXK06GoWeriLDnJL
/49SdZelKmwB3mT4p5b9W0F2JnitL7HQy+7BMKYaCw+1mS2S5d2zTiAxoezWSkRv
h2boxcfQANUuJ7MjR+/RB/3713fw5IGc0jyAf+LjxORQQDQaQ9QGilhPN3O6sCUL
9NjKqaLVYwEWM8oaik7aZoyo7DNeFHYelVk6NPvojHh+8VTttBF6R0uSRPnSQ7DB
tkSvnT/pAUFznDbd7J6N0Sz1O5PH58akcgFN5lvs5jj07L1kUqa9QxL0HCJkXnSj
RTXnmtf01XyCWVDzA680Xtzmj+iFaVK+AWzdhbYMkvSu8aoV14F1b5ad+cLhrvgn
tOncDMuDztSH4vuRQtR0qgmSZsQuhjefHElbNg7k76UPTV0/Kkr/vxHaq1hz1Ezw
ELzhiyHHTKqDqo84dHSCqtoLUwCIlWYu4l4lj4hIoSD/0Cpq9ZE=
=5x9x
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
