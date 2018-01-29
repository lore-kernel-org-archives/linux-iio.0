Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:57529 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751127AbeA2JV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Jan 2018 04:21:57 -0500
Date: Mon, 29 Jan 2018 10:21:45 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Philipp Rossak <embed3d@gmail.com>
Cc: lee.jones@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        davem@davemloft.net, hans.verkuil@cisco.com, mchehab@kernel.org,
        rask@formelder.dk, clabbe.montjoie@gmail.com, sean@mess.org,
        krzk@kernel.org, quentin.schulz@free-electrons.com,
        icenowy@aosc.io, edu.molinas@gmail.com, singhalsimran0@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 02/16] arm: config: sunxi_defconfig: enable SUN4I_GPADC
Message-ID: <20180129092145.4pagdnfmhilwaj2r@flea.lan>
References: <20180128232919.12639-1-embed3d@gmail.com>
 <20180128232919.12639-3-embed3d@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghx2bibyvxgzclks"
In-Reply-To: <20180128232919.12639-3-embed3d@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ghx2bibyvxgzclks
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 29, 2018 at 12:29:05AM +0100, Philipp Rossak wrote:
> This commit enables the SUN4I_GPADC config option and
> sets the value to yes. This is needed to enable the ths sensors.
>=20
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/configs/sunxi_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_de=
fconfig
> index 5caaf971fb50..52c3990b9d91 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -131,6 +131,7 @@ CONFIG_DMA_SUN6I=3Dy
>  CONFIG_EXTCON=3Dy
>  CONFIG_IIO=3Dy
>  CONFIG_AXP20X_ADC=3Dy
> +CONFIG_SUN4I_GPADC=3Dy

Unfortunately, we can't do that since TOUCHSCREEN_SUN4I is already
enabled and we have a depends on !TOUCHSCREEN_SUN4I.

One more reason to stop worrying about replacing that driver DT
binding.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ghx2bibyvxgzclks
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlpu56gACgkQ0rTAlCFN
r3RYKA//aUhK3FL/1rSXZzsp89IzUa32qotaLWJeyMx8QxFgF/FKKjstCbE0i+4Y
GozTJZWar87piRyMAUBBOz3RHB8PKLOBlROifVCcqOYZefJrQeyfC40c9uJ+CQLf
mt0xFo7q0oZdmAv/cyR/pMiZvfuNQm1l7cZYmZvqJsVdHjYF+Hn3Ut8xkIYMv9qy
XMBkvymktcEVN0IkQFvpC7Ic1cUIRDVCLWCfFpOefV32+adDabnRhiIBiwA+m9Vk
W2n7vA3FHeenJP9f1ArHKcDy9ixs6VGIrm4nXk42cgPxvnGabt6nNjQ1eDZ3vm9R
ZaN+ZpCQLlDhkvo0zjY/ngBj0cWRn+oHkrk5AMhHWSC/vvNRdeDBUs5oRrgy5h+f
wk7BzGp89t9oaMHKNCFHFzWym9IRcoZZg3n9xOl8pdDK6ZwSiH3ebU0rhx3iRwVW
f4okd6v5D/o5I3REggQGFd/45siEEulXAT5lkfAGJd9KIV+o90P16eBjyMiQmbNG
HFe2Gai1h1p/Qv07+kbpnEXx48jzZvMSBlig9/vSP5aiQHHzKceE2X4ZKEc9AZBH
56Bcl4fMRW+G36R7bEJSG2ffVNcByBtdyoiXWSvCNHZxiVsVbegp86NOAxtPHZ17
XmeLwnWE6CRLXAjiC0htH79/7jRnZIrSfUsgiv/b/MbB9kup0IQ=
=hDsn
-----END PGP SIGNATURE-----

--ghx2bibyvxgzclks--
