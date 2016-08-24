Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:52539 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750954AbcHXGj0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 02:39:26 -0400
Date: Wed, 24 Aug 2016 08:38:53 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, wens@csie.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com,
        antoine.tenart@free-electrons.com
Subject: Re: [PATCH v3 3/4] mfd: mfd-core: reattach mfd of_node to cells
 without of_compatible
Message-ID: <20160824063853.GB8103@lukather>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-4-git-send-email-quentin.schulz@free-electrons.com>
 <20160809134847.GJ5243@dell>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
In-Reply-To: <20160809134847.GJ5243@dell>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Tue, Aug 09, 2016 at 02:48:47PM +0100, Lee Jones wrote:
> On Tue, 26 Jul 2016, Quentin Schulz wrote:
>=20
> > When an MFD cell has an of_compatible (meaning it is present in the Dev=
ice
> > Tree), other nodes can reference it using a phandle.
> >=20
> > However when the MFD cell is not declared in the Device Tree, the only =
way
> > other nodes can reference it are by using a phandle to the MFD. Then wh=
en
> > this MFD cell tries to register itself in one framework, the registrati=
on
> > is denied by the framework because it is not matching the of_node of the
> > node which is referenced by the phandle in one of the other nodes.
> >=20
> > This reattaches the of_node of the MFD to the MFD cell device structure
> > when the MFD cell has no of_compatible.
> >=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > ---
> >=20
> > We need this modification to register the thermal sensor in the thermal
> > framework.
> >=20
> > Added in v3.
> >=20
> >  drivers/mfd/mfd-core.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
>=20
> Can you show me the DT code where this is used?
>=20
> Is it used by a patch in this series?

Yes and no.

This is not used directly by any code found in those patches.

However, those patches are actually a rewrite of an existing driver
that was there before (drivers/input/touchscreen/sun4i-ts.c), that
already had some DT bindings and was enabled in a few DT already [1].

The issue here is that for the new driver to be able to follow the
phandles as it used to (which is also already used [2]). Obviously, in
the usual mechanism (at least when you don't declare the mfd childs in
the DT), the childs won't have any of_node associated to it, and this
is fine in most cases.

This is where things get messy. The MFD childs will also register to
their framework without, and then the whole phandle lookup goes nuts,
because the phandles will point to the MFD's of_node, but no one will
actually be registered anywhere with that of_node, which means that we
broke all the links expressed by the phandles.

Maxime

1: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm/boot/dts/sun7i-a20.dtsi#n1520
2: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arc=
h/arm/boot/dts/sun7i-a20.dtsi#n130

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXvUD9AAoJEBx+YmzsjxAgd+MP/0tiPZM/bcQt1pZXVq//4Kxy
XAiyxiaWjN/cZj7dCGHFh0hotr7ShiaxQrFV0V+rKC0KdHP3chG13SHzu3KHM+fx
FI3JySJa21+ysLRYMo0lJSbFB3cXkqJ+2MFr2BDEBi6yq0o3yEQwYiaFWbhuoN4B
HFkmKDvjhHoGhX5C0RP7rdO7dMRzM3JzH1LIdnSziNUeutSjrMjt0WMbSdPWauWN
OrG48uN2C+CvWjoyi3tswHaeTLlUQCDK4e/SjRBn3Q4sB34Y/kJQB2MWbsK8M1pi
E6p2srUXMRRS6h4ANnFbN1UE5tB1YWjnPc9dvCI3pDE4IxI0b4YW9dqCak6z27jV
XzZ/srCwnWH4tgOdaKVmEPY5vyeBTquBkjSSzWht9m2MW6hkTxOwt0CENM4cDntX
7lI+KmaZPa0YNZeGP9TG1KlRJ8eyA1n50fqvLfx7K6ErtGdWPQmEtjP/ErecbNG+
5hMixCKsU5tubSrOGw3QK5eBcrMY3pAJNfwlXP9f0l+4dRly4bVuKJ0P6QwyT2Nz
7SpHolN6/BnKuot32bXvu9gOI3sb6bK8CAyx9g3uKACo6FDSTL91iXCA6GI6+uq1
8wYpmi7QQfgPjeWPCnw7BhWno5lpeMdt3eiEI2CfE1RTCL5t4/DPIoB2VbYDbOEz
zt29oz1BOdOXoMIUuZho
=rt5N
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
