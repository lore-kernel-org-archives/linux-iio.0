Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:58699 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754469AbcIEHHT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Sep 2016 03:07:19 -0400
Date: Mon, 5 Sep 2016 09:07:16 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        lee.jones@linaro.org, thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 3/3] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20160905070716.GA6322@lukather>
References: <1472738705-20145-1-git-send-email-quentin.schulz@free-electrons.com>
 <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="lrZ03NoBR/3+SXJZ"
In-Reply-To: <1472738705-20145-4-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Nitpicks ahead.

On Thu, Sep 01, 2016 at 04:05:05PM +0200, Quentin Schulz wrote:
> +	info->soc_specific =3D (struct soc_specific *)platform_get_device_id(pd=
ev)->driver_data;

This line is still rather long. How about calling the field "data" and
the structure gpadc_data?

> +
> +	tzd =3D devm_thermal_zone_of_sensor_register(pdev->dev.parent, 0, info,
> +						   &sun4i_ts_tz_ops);

A comment on why you put the parent device structure and not the
device itself like you're doing on all the other calls in that probe
would be nice.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--lrZ03NoBR/3+SXJZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXzRmkAAoJEBx+YmzsjxAgZZoQAJLcPr1UlajYkObtSAzJfUHJ
Zv7w95wB5uaKd0MZjWoBYM42g3TujgseKVdLBwUdJP2HprgHytR3Hr8GIC4TJKcK
r+rmdhpyhwQN8+ivYJTikehB/HXNxl9jR+o9isPCaWbtsiWDVC/mB6dYBo1Qarwc
7YYaYbVJP8X8G3sClQL4vEH3SYVBJAUNHZ5HvVRJmKTkOJrjjtoBS9a9iEpLymkN
mBZPYTKNuing60sLuyb1ywmi8EJvvy3JbiF+jbg2mU5MlUI8mC9tG4KsGsQWUqtT
gK+6VO+0+JasoyYVtiPZNVzR7N1PvzGil3m6QyKpF1DCsjpXCTB5VYNYsWovEy5q
suab4OnQgrSyqEsXX8N0i6gLU6nzWnjPcjmDwI2qUmu/2cIjK3RhzGKVJjgv4tHM
JbWP3IkdeIHQLhFxihrWyJGy1q/D0lH3FPQ+e6krqQFQ9eIu2Cebgn3SrvJBXbSY
jfQsba10cShGU/0vg6t1IfmkWz2k7u5cX7TT83p0f72PI6DhSDqXfHRL7Hx4NC+q
HAf+I+ZxK9G54ksG46Uq7vRJpgFpJKBudumqSrYirWHHnsRG1w5vnrEn6P5hn/qS
zu6dFpjpDWy9nDucjdzSKheNZ8K7E0zdABZJtBbFM3alJ5rO7UISeC8pd+OACjmQ
8fOtk0P7x/tUUe2Gw0aw
=93Jt
-----END PGP SIGNATURE-----

--lrZ03NoBR/3+SXJZ--
