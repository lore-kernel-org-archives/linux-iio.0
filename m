Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:38505 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935646AbdCJMZs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Mar 2017 07:25:48 -0500
Date: Fri, 10 Mar 2017 13:25:44 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        mark.rutland@arm.com, wens@csie.org, lee.jones@linaro.org,
        linux@armlinux.org.uk, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, stefan.mavrodiev@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-sunxi@googlegroups.com, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH v2 05/11] Documentation: DT: bindings: mfd: add A33 GPADC
 binding
Message-ID: <20170310122544.wkbqnzq2twfciyaw@lukather>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-6-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ajqoqo3jtkceco4e"
In-Reply-To: <20170310103921.19469-6-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--ajqoqo3jtkceco4e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 11:39:15AM +0100, Quentin Schulz wrote:
> This patch adds documentation for the A33 GPADC binding.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> ---
>=20
> added in v2
>=20
>  .../devicetree/bindings/mfd/sun4i-gpadc.txt        | 59 ++++++++++++++++=
++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt b/Docu=
mentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> new file mode 100644
> index 0000000..17242c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sun4i-gpadc.txt
> @@ -0,0 +1,59 @@
> +Allwinner SoCs' GPADC Device Tree bindings
> +------------------------------------------
> +The Allwinner SoCs all have an ADC that can also act as a thermal sensor
> +and sometimes as a touchscreen controller.
> +
> +Required properties:
> +  - compatible: "sun8i-a33-gpadc-iio",

This doesn't match your example, and you shouldn't have IIO in
there. Compatibles shouldn't be tied to a given framework, since that
is Linux specific (and might even change in the future).

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ajqoqo3jtkceco4e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYwptEAAoJEBx+YmzsjxAg1m4QAL/NSfQabAExd2onE/i0lWd6
3EtecP5Al6RefWxLx6c4adkXuhE2utIZMJyEmsP46WJD0Ajoo4gLpCEj8y37gSEI
FGnMiins3vEGbZsI159lAWpAFVOvsGGbuQsFFwJLJZpv9o+tR1w8KttTz4XNXdpX
6NWF6yfQqcFg4CywP3vBWkY19azAdmRjsYfuAa8q92PkWWq6+2+VLBjud6xZFe8X
jYAc5BjlE4sV/QxCbB2fUGb9sHqDzPtmVz3LCIg6t5BGVjh+utw5RhuQJpeyRAh0
9XvpvrZI3eAN4qSWc/HoiSgkBVMgdTMHsvvL9/uCQTo3k7n+1kM9cx5isg3G8Lct
3m7DCHvsFa6YFt95NF2fK/WZLcl9GhjsrsM5s1dll6zzijIr4fN314JEEZH/wy7p
ouC9+v1AjI5sz9lBwKchJWmpFxUWgJ+EbIxjTHuCyIa3QbBvKVIr3vD2P8hYIPsX
gEex4gPJPjgLTpvQZWomkXFyzTAEWj6OxMEu/8zmVSueT824bhAkq8dwnZDhGWQ0
dFfKD3oxFf5c2ckAXkfgdgt8CQ8W0m39XJ9yopaimt2WCP2sW8ULG+639OUnNSyX
EYXmpDNjqY5S7PIDhlzY5Y/KO5Jce5xnuAnwUmY+X//0lamZl67mJX84ExrWeanb
HANs0/LwZ/DWkqG1ZQsd
=owWc
-----END PGP SIGNATURE-----

--ajqoqo3jtkceco4e--
