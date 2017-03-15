Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdCOXCh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Mar 2017 19:02:37 -0400
Date: Thu, 16 Mar 2017 00:02:29 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mark.rutland@arm.com, thomas.petazzoni@free-electrons.com,
        devicetree@vger.kernel.org, lars@metafoo.de,
        linux-pm@vger.kernel.org, liam@networkimprov.net,
        linux-sunxi@googlegroups.com, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bonbons@linux-vserver.org, robh+dt@kernel.org, icenowy@aosc.xyz,
        pmeerw@pmeerw.net, knaack.h@gmx.de,
        maxime.ripard@free-electrons.com, wens@csie.org,
        lee.jones@linaro.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 11/18] dt-bindings: power: supply: add AXP20X/AXP22X
 battery DT binding
Message-ID: <20170315230229.woqzt6dthzmpuohd@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315105537.22349-12-quentin.schulz@free-electrons.com>
 <20170315222852.z2qrwoexcsjt7vs6@earth>
 <761e35fc-932a-953c-cfad-7e967ea3d126@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="efz7gnmstlbr6cht"
In-Reply-To: <761e35fc-932a-953c-cfad-7e967ea3d126@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--efz7gnmstlbr6cht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 15, 2017 at 11:41:07PM +0100, Quentin Schulz wrote:
> Hi,
>=20
> On 15/03/2017 23:28, Sebastian Reichel wrote:
> > Hi,
> >=20
> > On Wed, Mar 15, 2017 at 11:55:30AM +0100, Quentin Schulz wrote:
> >> The X-Powers AXP20X and AXP22X PMICs can have a battery as power suppl=
y.
> >>
> >> This patch adds the DT binding documentation for the battery power
> >> supply which gets various data from the PMIC, such as the battery stat=
us
> >> (charging, discharging, full, dead), current max limit, current curren=
t,
> >> battery capacity (in percentage), voltage max and min limits, current
> >> voltage and battery capacity (in Ah).
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> >> Acked-by: Chen-Yu Tsai <wens@csie.org>
> >> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >=20
> > I suggest to do "s/battery-power-supply/battery-fuel-gauge/g"
> >=20
>=20
> The IP is way more than a simple fuel gauge, you have info about the
> voltage, current, you can set different things, even though you have the
> percentage of the battery returned by the PMIC.

Most chips sold under the label battery-fuel-gauges actually give
you that kind of information ;)

> Does it really make sense to rename it that way?

If everybody is fine with it I don't mind too much.

-- Sebastian

--efz7gnmstlbr6cht
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJyAUACgkQ2O7X88g7
+prY2RAAqBBGfmGVjadO5rHiZVPYsVmTI8iTOmhHRHap7rctKqVB1pboG0wyRNdd
ID3FrHRw+8f09DADrSj0Wa3aCs/SUWEqw3I4XzW8BEVWtEeY1vPOby52Aw3LKXHj
YRVfMb0tErw/kTuVnBFtY+dKWOB5/0253WlCy3jCBq4FEzBfBPGIfhDmzcHl4+dl
8aE66iNw4iC2MDdqhVVXDjcPknZQ9g6nc9mBCMBiNb7VpZGHEAaigzC648mWi7vT
dCEB6LWZJVwd6PLObpGsyjIh95EC0CsCDGJ934KTnlnTr8tVREiicxKWje2FnY9g
AEAVutVgKkEFh6th7gdA0J8Of2MzvtOth9DSEKaJitPM/1rhnel3SJ9qZuCwOriP
LA3qO8N/SrbKNqPwh/VCNyVvbYP6pmdCEPFv4N/8TLQIq16n6LW6D+I1cRGAULqD
vreCdGWWlaiuiwhmsyQuGBwRmHfi7df33DiRrgLFAwEH3/rOurUhXyqwU142Uy/x
dnS3jp9bDH+Y/LV+izfYivr+jkf7olL9UVgN3hKj8EC/2qD/YlM+G42St8YURoCL
f98yUUcg6YUEuAkMk09CJJlOIzvzFSWUcBts1O+KweYCPjyd62RXR90tV9C3HBMq
DphJIgeY3hbnZQm8ABbp++0yx5bQTK4mjZm6FmRJKospUKg/rug=
=KkxZ
-----END PGP SIGNATURE-----

--efz7gnmstlbr6cht--
