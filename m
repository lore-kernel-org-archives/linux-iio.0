Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:46483 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753847AbdERGvC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 May 2017 02:51:02 -0400
Date: Thu, 18 May 2017 08:51:00 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, wens@csie.org, clabbe.montjoie@gmail.com,
        linux-iio@vger.kernel.org, thomas.petazzoni@free-electrons.com,
        linux-sunxi@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: sun4i-gpadc-iio: fix parent device being
 used in devm function
Message-ID: <20170518065100.bn2t7ef2pw4wfaia@flea.home>
References: <20170518063607.11069-1-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2j4uhec5sdtecg6p"
In-Reply-To: <20170518063607.11069-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--2j4uhec5sdtecg6p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 18, 2017 at 08:36:07AM +0200, Quentin Schulz wrote:
> For the sake of DT binding stability, this IIO driver is a child of an
> MFD driver for Allwinner A10, A13 and A31 because there already exists a
> DT binding for this IP. The MFD driver has a DT node but the IIO driver
> does not.
>=20
> The IIO device registers the temperature sensor in the thermal framework
> using the DT node of the parent, the MFD device, so the thermal
> framework could match the phandle to the MFD device in the DT and the
> struct device used to register in the thermal framework.
>=20
> devm_thermal_zone_of_sensor_register was previously used to register the
> thermal sensor with the parent struct device of the IIO device,
> representing the MFD device. By doing so, we registered actually the
> parent in the devm routine and not the actual IIO device.
>=20
> This lead to the devm unregister function not being called when the IIO
> module driver is removed. It resulted in the thermal framework still
> polling the get_temp function of the IIO module while the device doesn't
> exist anymore, thus generated a kernel panic.
>=20
> Use the non-devm function instead and do the unregister manually in the
> remove function.
>=20
> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Reported-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Reviewed-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2j4uhec5sdtecg6p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZHURUAAoJEBx+YmzsjxAgm1IP/1Om18Sxz5ruUpVdKw/jY1fn
uS55sHzY4sLU9zYDXGsuzEm2Iz7sYrz+H4VmrAvMkvrbt6nVVox6+RnLpC6v+JSq
q3Pibiwi6OtBtvkZvDPv+w24JEmKLAzUIU44Bx9fHX2FejTYe4rgKOS5o2gGaSIK
bC3LOlvOHTocQqj37uAXBVz7IMJMBFWE1qcn13GzlyH64ZkctIgjldhXafj9RrUN
VKgxENKXpcZJhFKQ4RsriLhTG3EakDOr2ZBXG5RPlBwhVex9CVHOxMEraxeEBNx6
F3FG8zeUccbjtp4WpbonECLxAa0c3AVvgSTPNlv62tIN0TvmYWOwx3PzubM566cM
FmQjNdnnBfEk+PIyg6Pg3zA4DY9BgIw7ZxG3YXKoUQxThikdUu42JKzlZZVnUC3b
0ph8RsBshWxc5OQ/4EzlI5SazfX1YHTzl6UvNj1Nzw9nA05Y5XyPj7aYrrA4VPW0
TWlurcBDnCx1oEj2Q8080VssnFnOdCURG6yCmauVM5bMsUUPr4uHd6ksm8mDz1Nm
z+yqjLIElx85xebu1ZBIm/sM/uk4xyFmH6ZUDFF71BvYvBW6+YRKD0eopLHty1Va
rWWS4dx37RwilNaOSznN8jQO5sX2KTTw0mPoLkvanGkgOvCgfdiUmk7TQSJjSMs3
kMk1FDHPnaptJu7TtADk
=C6f+
-----END PGP SIGNATURE-----

--2j4uhec5sdtecg6p--
