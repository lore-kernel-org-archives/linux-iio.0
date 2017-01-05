Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34341 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761160AbdAEQlo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 11:41:44 -0500
Date: Thu, 5 Jan 2017 17:40:47 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        lee.jones@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: Re: [PATCH 01/22] dt-bindings: iio: adc: add AXP20X/AXP22X ADC DT
 binding
Message-ID: <20170105164047.ksaww7punkcyrl2t@lukather>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-2-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yfaedtjmyrcaqnge"
In-Reply-To: <20170102163723.7939-2-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--yfaedtjmyrcaqnge
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 02, 2017 at 05:37:01PM +0100, Quentin Schulz wrote:
> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose the
> battery voltage, battery charge and discharge currents, AC-in and VBUS
> voltages and currents, 2 GPIOs muxable in ADC mode and PMIC temperature.
>=20
> This adds the device tree binding documentation for the X-Powers AXP20X
> and AXP22X PMICs ADCs.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--yfaedtjmyrcaqnge
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYbncPAAoJEBx+YmzsjxAgoZkP/2M78NSaTbG++99eZf8pEhDA
ncr5S6Ydy/eLV6yg3e0H5uGh39Hj6C/WnmyvLeQ9fwNUl5O+nkrXZBOt+bsTRcCk
OrECsueqFMR/VigyzRDm8k+KEvkpoEOfLV0OlrjaFESdUhYOnY5mnuYj1pGGU8kZ
F88rxPAC/EogcieWVaWDldCuVYTVhr7ltUtels1bqWE52hY3RbVb0KBmPldd/QcA
1u+ZtjTNnK8gENC4QSlpsE8jIHyJL30eLrM2Z+v9WK887uMktH/6yyX+amX0PEgr
S2fingkWz2C588XTDuvf2AWx1ABAGnH+oVTKDox+8ZoZoP5b8y2DtLUgrvAPeoIf
Khbr0975ozHFfIFrgBcF8/D9TKYZwV4UpOI2U2hXVjFMN19JDSMPp/Rcyj6XIJzB
ShdfR6yIEd0ae6CLOuCb91eK+ypjJd59AF1rwXv8LZNWIA+6DsypVab2jiHST5HD
zYRPwPKcfPRqHbywGukD0YBFO9OQ2Xhhyj4jriQWoQfEFS/i4n2a75QRspZ9U9s8
RIJNP7kPuxle3q1c+WFeRHmCCJlW3i67o4WXR7edaLMGcMSgEyGLclcaxno9CD44
ieYHWRAneMzQb2CAAEdkWYkFfI3bYTfvfLX4MjMoNUOQErC0ua8wna87cZA7fni8
DkzhQutkhwEqtV5kKwgH
=R8go
-----END PGP SIGNATURE-----

--yfaedtjmyrcaqnge--
