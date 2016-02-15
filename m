Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44416 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751481AbcBOJZf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Feb 2016 04:25:35 -0500
From: Markus Pargmann <mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
	Eric =?ISO-8859-1?Q?B=E9nard?= <eric@eukrea.com>,
	linux-iio@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Denis Carikli <denis@eukrea.com>,
	Sascha Hauer <kernel@pengutronix.de>,
	linux-input@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v10 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Mon, 15 Feb 2016 10:25:27 +0100
Message-ID: <6071608.sYYGeTKS0i@adelgunde>
In-Reply-To: <20160209103513.GC24522@x1>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de> <6151166.y0HMDdqtvF@adelgunde> <20160209103513.GC24522@x1>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2239312.bKi1lYvMfa"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--nextPart2239312.bKi1lYvMfa
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tuesday, February 09, 2016 10:35:13 AM Lee Jones wrote:
> On Tue, 02 Feb 2016, Markus Pargmann wrote:
>=20
> > Hi,
> >=20
> > On Monday, January 11, 2016 06:54:41 AM Lee Jones wrote:
> > > On Mon, 14 Dec 2015, Markus Pargmann wrote:
> > >=20
> > > > This is the core driver for imx25 touchscreen/adc driver. The m=
odule
> > > > has one shared ADC and two different conversion queues which us=
e the
> > > > ADC. The two queues are identical. Both can be used for general=
 purpose
> > > > ADC but one is meant to be used for touchscreens.
> > > >=20
> > > > This driver is the core which manages the central components an=
d
> > > > registers of the TSC/ADC unit. It manages the IRQs and forwards=
 them to
> > > > the correct components.
> > > >=20
> > > > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > > > Signed-off-by: Denis Carikli <denis@eukrea.com>
> > > >=20
> > > > [ensure correct ADC clock depending on the IPG clock]
> > > > Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> > > > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > > > ---
> > > >=20
> > > > Notes:
> > > >     Changes in v7:
> > > >      - Cleanup bit defines in header files to be more readable
> > > >      - Fix irq check to return with an error for irq <=3D 0
> > > >      - Add COMPILE_TEST in Kconfig file
> > > >    =20
> > > >     Changes in v5:
> > > >      - Remove ifdef CONFIG_OF as this driver is only for DT usa=
ge
> > > >      - Remove module owner
> > > >      - Add Kconfig dependencies ARCH_MX25 and OF
> > > >=20
> > > >  drivers/mfd/Kconfig             |   9 ++
> > > >  drivers/mfd/Makefile            |   2 +
> > > >  drivers/mfd/fsl-imx25-tsadc.c   | 203 ++++++++++++++++++++++++=
++++++++++++++++
> > > >  include/linux/mfd/imx25-tsadc.h | 140 ++++++++++++++++++++++++=
+++
> > > >  4 files changed, 354 insertions(+)
> > > >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> > > >  create mode 100644 include/linux/mfd/imx25-tsadc.h
> > >=20
> > > For my own reference:
> > >   Acked-by: Lee Jones <lee.jones@linaro.org>
> > >=20
> > > I will apply this and sent out pull-requests to the relevant
> > > maintainers once -rc1 is out.
> >=20
> > Thanks. Do you mean just this patch or the whole series?
>=20
> I will take all of the /driver patches.  The ARM patches need to go i=
n
> through ARM-SoC via the relevant sub-arch maintainer(s).
>=20
> > Shall I resend the whole series to fix the commit title of the firs=
t
> > patch?
>=20
> No, that's fine.  I'll handle that *this time*.

Thank you.

Best Regards,

Markus

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2239312.bKi1lYvMfa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWwZmHAAoJEEpcgKtcEGQQWYwP/iVVLrpmbUIdQbUZwdgOrl15
c3+7ZYml5nvAgEwnvPOYL8xxLPILY0VZkt8qxh6DDIkrYi+JKtZiIBQubb15q+hZ
ODuc6F0vSyKh1FE7XXybHb0YnPfRKziMdsKgnuxOzFJajdABdMYNVhM0vfenBVPc
hMWG932vglOWqFekqrs4O/zOP2Hnp5Ue5g6Gv52Nnn/EpufshCrwNXI+iNNBsWBJ
sTKdaF3LpnQVWmur4M78o7NcDuxkCXtHNUW0Tknynsq2QPQmT75eiA/cgnAx2T5z
NcstdxW4PvoQrl4lL4GPD2jo+tMPHgSUKvQKd8fSrR6pGKYm1pb5sbzjna/t5ncQ
dqn7lhrwoVJrZZ3jte8LMeQOcwC7N/E4SvHHBo8mwuOKT3aKxTunjv6XCNPvAy2U
fXdaTXzzchhG8VwzQIuYC7Wbw4L9GwKeDNeNAgvQfe0gRCIPahrqGbt4szzVVjr2
fDV/Mha86ICSxvuCB53rt45kmbK1/yB2w+NYND50B56aqpBjMHhD/UJACPX6d2dM
pgrzCOKuri+khFdZBh8pBat7On4KAV346/RmoIavAB3Z6xS7/BLsb5l/ru0kSIBT
xvVA+lp4D+IPOnwza3SjbrvLyuaX82LaHgvbiTXIwU56vm+9tskYP7Xb6gyhRy8C
W955ZkrLqbxGHoygjSik
=zHg+
-----END PGP SIGNATURE-----

--nextPart2239312.bKi1lYvMfa--

