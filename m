Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:33836 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030698AbbKFJuA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 6 Nov 2015 04:50:00 -0500
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vesa =?ISO-8859-1?Q?J=E4=E4skel=E4inen?= <dachaac@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: IIO device indexing issue
Date: Fri, 06 Nov 2015 10:49:49 +0100
Message-ID: <5517276.dg3z7SpAvu@adelgunde>
In-Reply-To: <563BAA65.3020609@kernel.org>
References: <5637AFC5.7080007@gmail.com> <563A5412.4030102@gmail.com> <563BAA65.3020609@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2003490.G10ft2If60"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--nextPart2003490.G10ft2If60
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi,

On Thursday, November 05, 2015 07:13:41 PM Jonathan Cameron wrote:
> On 04/11/15 18:53, Vesa J=E4=E4skel=E4inen wrote:
> > To continue from this "label" property idea I was wondering if we
> > would add it as new optional(?) file node for IIO devices.>=20
> > One could then specify it like:
> >=20
> > tscadc: tscadc@44e0d000 {
> >     compatible =3D "ti,am3359-tscadc";
> > ...
> >     am335x_adc: adc {
> >         compatible =3D "ti,am3359-adc";
> > ...
> >         label =3D "Port A";
> >     };
> > };
> >=20
> > And this would generate file /sys/bus/iio/iio:deviceX/label with
> > contents of "Port A".
> >=20
> > Then during the application startup it would just need to scan all
> > devices under /sys/bus/iio and determine what labelled device it
> > wants to use.
> >=20
> > It would be up to device's developer to determine what labels to us=
e
> > in their designs. This would not break ABI and would be just an
> > extension for it.
> >=20
> > One could also auto-assign label "am335x_adc" in this case too. But=

> > if you include existing arch device tree then changing label in top=

> > level is kinda a bit annoying as you would then need to duplicate a=
ll
> > properties with another label and disable arch device tree's
> > settings. Could cause also conflict if there are references elsewhe=
re
> > to existing arch nodes.
> >=20
> > Having following in device's device tree file would allow one to
> > override label or just only specify that.
> >=20
> > #include "am33xx.dtsi"
> >=20
> > &tscadc {
> >     status =3D "okay";
> >=20
> >     adc {
> >         ti,adc-channels =3D <4 5 6 7>;
> >=20
> >         label =3D "Port A";
> >     };
> > };
> >=20
> > I think this "label" model would be simple to understand.
> >=20
> > Whether this needs to be implemented as per device driver feature o=
r
> > could be implemented as generic IIO functionality I do not know.
> The principal looks good to me.  It's not however only an IIO issue
> so perhaps we should expand the discussion to include other subsystem=
s
> likely to have similar issues (though perhaps to a lesser degree) suc=
h as
> hwmon and input?  Any others?
>=20
> We could also autobuild the label from other sources such as ACPI
> to uniquely describe the instance of the device (afterall all we real=
ly
> care about is that it always has the same name on the same hardware,=20=

> being able to assign meaningful simple names would just be the icing
> on the cake!)

There is a similar discussion for the new character device GPIO interfa=
ce.[1]

Simple labels have the problem that they could be the same for two devi=
cetree
overlays or chips that are connected via SPI.

Best Regards,

Markus


[1] http://thread.gmane.org/gmane.linux.kernel.gpio/11475

>=20
> Jonathan
> > Thanks,
> > Vesa J=E4=E4skel=E4inen
> >=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2003490.G10ft2If60
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWPHfCAAoJEEpcgKtcEGQQwmEQALuS3+YJXHk+LarmCfoB8y03
yrLLKC1R8lOj9YdSMHCm//rBmsw0WhNJMBVZBKiy2vOt19ozyqPZ0bOTgprB0OuN
UF64+JuIT8+iSiDmDaf2ZNDkBzkzChPDGpedR19sRpSw+FF4LPWHdeVofq/GU/tR
xTQQFNsTNrJQiLoyYKj2+fnkne7RAGYNrgougmIusAs5VuEk4a0KlIJAksrE3VSF
KW4QznDugfpHI4L9CfIqFod41CxN5WwjFOrhqz0danisuR47xhwk+vOmv7CzhkLe
vukwwI8lIbTT09T1nPLdYCVFW8TBxRoAe6qKA8/Mqm81FCHT7L9YpwhQnxCRflRl
r1JNpL1frwo93Vl3+tkHxqSP7cWClGjIkUaLTaAaXbaE5rjfzEIMDPWn2Bg/2K3r
KhfMLq85TAZXB+Lhf/x+hxDRnvjnS/xRkfhsdSaMQf0ie6hjjeviq1ptQSGqJQ3i
ul+o3a15Dup5QMNjvjrUGx0V0ZHqfbc5jjoj3TPpdtvXAF7Js74YVkYBUFan/eqB
UYRpg+ushvJZJ63RoH73T9Omy3sYhRjSn5b1hVGvTJ0c2egUwhyFvGJTEaO2injp
v92bHHQ9XP80kHEh4CRtM5LkCNlkaBWZw8UkD6VNM3fj5JLm1FycuhR4FFv8nx7c
83JX6IfltgRhezhLCyFc
=dAHY
-----END PGP SIGNATURE-----

--nextPart2003490.G10ft2If60--

