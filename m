Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:40955 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750992AbcIIOur (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 9 Sep 2016 10:50:47 -0400
Date: Fri, 9 Sep 2016 16:50:34 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        lee.jones@linaro.org, thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 3/3] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20160909145034.GE8881@lukather>
References: <1473344917-1524-1-git-send-email-quentin.schulz@free-electrons.com>
 <1473344917-1524-4-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
In-Reply-To: <1473344917-1524-4-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 08, 2016 at 04:28:37PM +0200, Quentin Schulz wrote:
> The Allwinner SoCs all have an ADC that can also act as a touchscreen
> controller and a thermal sensor. This patch adds the ADC driver which is
> based on the MFD for the same SoCs ADC.
>=20
> This also registers the thermal adc channel in the iio map array so
> iio_hwmon could use it without modifying the Device Tree. This registers
> the driver in the thermal framework.
>=20
> This driver probes on three different platform_device_id to take into
> account slight differences (registers bit and temperature computation)
> between Allwinner SoCs ADCs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJX0sw6AAoJEBx+YmzsjxAgoVMQAL6y2vn206zMDi51MhQUflZh
3qpRwF54aluV3U+aJXdGfU8ObX1mxEMOPLhv+HC4WUfxpXyAZLTEeg8rRPIH5hnB
50wRJ9eqzFa3be5kYKpzZeTWg+aewBxI26BMHC6mI7ZVFFPp/X8ZveFLMn9rHHeC
U+chSNS6gRVL4XWLGuFgVeZl/xC/v1Pz2OXy6wUFiQJW59V/8pKSSVrujQ9Cfo8e
GP9LhSiqEycyZcBbN369A0Q2qPrEyiT2FBtoRUQSNY+wkLJ8N8ebFaEJksxkdoYJ
YZwbP8VSoJW6jM4kiBvtV+MMsxbmHleKFR7d1Jjop234PIXaSdsee7pEk+/7pVpk
MeYXk+lCGaTYVQk6A2au7gw7vrlp9ReIJJQTMjEJ2B25NfOGWqWgSHVVrYJXi/Ab
XPEJHB/2db5L/lKPwH+/zPJR58hhr/+N6Pt26QC4Os0sNvrOt9QlElPB1nBoR4Vk
OwwkA8dO4ez8TadqVoIg3tzmDev99cN/ijat/HJ1l0Dj3GNDgz9m2tDdkvyNaDDq
jPvKRBW5k0V123Oe5bQ3hTtcCqWYaklkNvXzK9kg8iCmHe0iZJmXIKgttqfag2Aj
6TgjjmkEtYmZQAObxBl3cELAbvtHTUfu+674eljO00efTKvkO1YJCDRpbtB97HgV
ZUXO67Afkj/rxAz4X7RL
=X2cn
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
