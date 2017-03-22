Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:48782 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758514AbdCVHSF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 03:18:05 -0400
Date: Wed, 22 Mar 2017 08:16:46 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Russell King <linux@armlinux.org.uk>,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Icenowy Zheng <icenowy@aosc.xyz>
Subject: Re: [PATCH v3 01/11] ARM: sun8i: a33: add operating-points-v2
 property to all nodes
Message-ID: <20170322071646.stljnmlnfrhpchm2@lukather>
References: <20170321153611.16228-1-quentin.schulz@free-electrons.com>
 <20170321153611.16228-2-quentin.schulz@free-electrons.com>
 <CAGb2v65qMod+k5Uo-Z4qG=7kMx_FiHhR_01XS+Bn+m3T=JH6bg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jvv2xw3p2ulabnrb"
In-Reply-To: <CAGb2v65qMod+k5Uo-Z4qG=7kMx_FiHhR_01XS+Bn+m3T=JH6bg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--jvv2xw3p2ulabnrb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2017 at 11:32:28AM +0800, Chen-Yu Tsai wrote:
> On Tue, Mar 21, 2017 at 11:36 PM, Quentin Schulz
> <quentin.schulz@free-electrons.com> wrote:
> > The OPP are declared as shared but no operating points are declared for
> > cpu1, 2 and 3. Thus, the following error happens during the boot:
> >
> > cpu cpu1: dev_pm_opp_of_get_sharing_cpus: Couldn't find tcpu_dev node.
> >
> > This patch applies the operating points to each cpu of the A33.
> >
>=20
> This should have
>=20
> Fixes: 03749eb88e63 ("ARM: dts: sun8i: add opp-v2 table for A33")
>=20
> and be merged as fixes for 4.11.
>=20
> > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>=20
> Acked-by: Chen-Yu Tsai <wens@csie.org>

I just queued it as a fix for 4.11, with the fixes tag.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--jvv2xw3p2ulabnrb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJY0iTaAAoJEBx+YmzsjxAgUfMP/3cM5HhuASoPvt8nDYczy99H
eqIrVk9rOGxUvpRpwl8dNvffpEYexgFCyPB2L+tP1ncyg+Wjx+9AOK8xkJLdPvyG
FbsnVql3NOTQyT8T6koSPX4nLLjdIQpcCAbhjvRMPKkD+FIbB+n+y6ZAbo4WCU2K
ByqkJ1ZOKbILz12iBZPBJ4G14mSyV7LqeS1N56bPwg34vrM9LKGK8geKOp/Ek8UH
cbpEVQBdFG5fV/R+jHiDjUfgLBpVDF/5MrhG1A58rOU0i8Pd5MlVgR95/mC7gG6x
/ixVyq9HG9DcnzwxbSE81uWNwxcgxaFaaCG38a54TSMAl5g/eSmmclOaLm1RtTxD
QrbqfnG8fSpwD2kJgOS+V0r5yLlyMk3L/SZL+2psKFC8ZIUDp/XIfVkzO5r5/pzl
bExCH+aHi+Gf9N5od+k+d3N3MITxvzXmXi+1ow33VLIsKrqKIAmMONKTsdhm5Klo
9gudaqFaHd+C8sKRGjpA1BeN89k/RLbD6oGaJPI+P186TXdt7GTacjh3WfWpfpuw
e+rjtGeM2UPx8Wmzk2c/0sNbKjZUYYSza/jWsKc95J8m6W7db8apVYm1Y7r7QRKF
g+WI343VEWNtmQRdEYyu27H3+yweuZpS7ury1rY5PrLUB1o9bVz5m6f7BAwlCpAC
Y1CK67GxRQsTcKI/VcyL
=fhcu
-----END PGP SIGNATURE-----

--jvv2xw3p2ulabnrb--
