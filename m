Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:54270 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbdIRHex (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Sep 2017 03:34:53 -0400
Date: Mon, 18 Sep 2017 09:34:52 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4 2/6] iio: adc: sun4i-gpadc-iio: rename A33-specified
 registers to contain A33
Message-ID: <20170918073452.2jizidgu4rvqesiq@flea.lan>
References: <20170914145251.21784-1-icenowy@aosc.io>
 <20170914145251.21784-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="uoz2scjs6reg45vo"
In-Reply-To: <20170914145251.21784-3-icenowy@aosc.io>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--uoz2scjs6reg45vo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2017 at 10:52:47PM +0800, Icenowy Zheng wrote:
> As the H3 SoC, which is also in sun8i line, has totally different
> register map for the thermal sensor (a cut down version of GPADC), we
> should rename A23/A33-specified registers to contain A33, in order to
> prevent obfuscation with H3 registers. Currently these registers are
> only prefixed "SUN8I", not "SUN8I_A33".
>=20
> Add "_A33" after "SUN8I" on the register names.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--uoz2scjs6reg45vo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZv3ccAAoJEBx+YmzsjxAg1QMP/1/WRcy2TsGFLxXWL1xuRa99
89hsgtjLYV6MHY1oRWnilHqi326+JzAxqX3l+hVTponJ79o4BGCISORE4ddZdVbc
bOv2X5ssTV2i40wiT2EZkaO1rYBZgud95r/sukvpkiwfDkvzeajL6Ui84QM3v6od
3d3cphCmbZusO1Yko9lizV9vnsvts3DWqKmASU6CUpjNjd5fMfEgRYLFdPU3XVG4
QHlfpd0xYbyYg4ybINauZpU+EERqyBUtP7x3n9WPW6idpTwKChad/3zy2ZRjQFoy
vIaVfuT5oD87q8DpRVF1F8mNTLABGFDw4KBgE88QEsNX6sYpO2vU6Ljv6JXROTLr
DosiHFNNwn5z4T1fS2hEA18LyVNXMRl+Y87tvMSKjy5WivGKLmXVSVyniz8+XqPq
ZHspSINpwf2qGSDC8qW9yMLlSuHul3B7cRRhVveSZkQtQrtcXfLwKbhz0Q5zr0Kz
WZU7kLR2h1UrJ74c/0ourcx1MfC2006qE1dNgwxek9QUESAz+ZQgnAR9cZfCMoR1
WuoPruCAwQCLdkVQ/H4nPazMDNGwplyIOiYtWIy0ywBFDybBCe71JmC6Au/vTSUQ
qRjs8NtIBXPITomftrxS8ayrma1JUXuDfQonC5si/ckHmHxcsDwalXQKA6IutCkn
2AK5y/bZ6SbOZgPZrnbf
=6rEr
-----END PGP SIGNATURE-----

--uoz2scjs6reg45vo--
