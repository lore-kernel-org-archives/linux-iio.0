Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753448AbdCOWrD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 15 Mar 2017 18:47:03 -0400
Date: Wed, 15 Mar 2017 23:46:47 +0100
From: Sebastian Reichel <sre@kernel.org>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org,
        lars@metafoo.de, linux-pm@vger.kernel.org, liam@networkimprov.net,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        bonbons@linux-vserver.org, linux-iio@vger.kernel.org,
        wens@csie.org, robh+dt@kernel.org, icenowy@aosc.xyz,
        pmeerw@pmeerw.net, knaack.h@gmx.de, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 00/18] add support for AXP20X and AXP22X power supply
 drivers
Message-ID: <20170315224647.suhnptpczykuoffd@earth>
References: <20170315105537.22349-1-quentin.schulz@free-electrons.com>
 <20170315121450.bl5dxdjzazwsrvni@dell>
 <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qqlgowxaqelmwsf2"
In-Reply-To: <bc829791-c543-220a-8c42-1023b1a82963@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--qqlgowxaqelmwsf2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 02:18:56PM +0100, Quentin Schulz wrote:
> Hi Lee,
>=20
> On 15/03/2017 13:14, Lee Jones wrote:
> > On Wed, 15 Mar 2017, Quentin Schulz wrote:
> >=20
> >> The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
> >> information and data of the various power supplies they support such as
> >> ACIN, battery and VBUS. For example, they expose the current battery
> >> voltage, charge or discharge, as well as ACIN and VBUS current voltages
> >> and currents, internal PMIC temperature and ADC on 2 different GPIOs
> >> when in the right mode (for the AXP209 only).
> >=20
> > What are you missing from this set now?  What Acks etc?  And what's
> > the plan with regards to route to Mainline?  Where are the dependencies
> > etc?
> >=20
>=20
> Basically, a consensus on how we should named the DT property I added in
> patch 01 and 02 (which is used afterwards in battery driver). All other
> patches have ACKs.
>=20
> I added some logic to the battery driver so if anyone wants to review
> that you're welcome. I already got several ACKs from the v3 though.
>=20
> No dependencies except for the battery driver (and the first two
> patches) which needs the battery "framework" in the Power Supply
> subsystem. A v9 of this framework has been sent a little bit more than a
> week ago, I need this to be merged first or the battery driver will just
> not compile. I think the other patches are ready to be merged.

FWIW I expect, that the axp battery patches go through my tree, since
there doesn't seem to be a compile time dependency to the other
patches from this series nor vice versa. I'm aware of the dependency
to the bq27xxx series of course.

-- Sebastian

--qqlgowxaqelmwsf2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljJxFcACgkQ2O7X88g7
+poLow//UxsNCDYlVlqtYrJCVm5UnS1LA6KoiHQgzIwmCu9KFOD/inHgOz6bJcRy
tqDKT+LuL6O1pY2LIYPzCZosCYhBtpkindtSAP0Egmv4hcvl+z4V4nzg1vo3SzuY
l8/2nHa43R86ACYE/c/bg+XSTG3eTHVammWOTDfCv9CnYGdLXkiymlZ/42+R79jt
0HDnyBb/IbCZ+3RoFXnq1RKQrqQWj+JundGaYDjfSQbSCcExOaIBhmc7JBRnCG5e
K23djEvy2cR+Dn3DFWK0YOtLngHTWj6ai/+pX6CKp4dTL6oajSsfEMkBG8+ekMsy
fwDGfTypPKWSogz0vJ9+0Gxt5pEsuWGMCFCq15C1LXRb49Ib7y7/k3/9kyjPLlT6
7X3mU9cgpxm0RDsPBjzb4ukMIZ9i/T4Mk5hCruWul5uB1g2RLx6rqCF0WyfyvzJw
8dzmw6F+cv4hqxLuusWta2uYV3bsu/6UmcRZ/4ZyaZzwYw4Ojnh2D89iBm3LdDNy
uOG3oZx/1C/GPASVQfBDISZlkf7p6CgBG53KlIQ7zTnmKbPnlaHnHgaJEONDwy6O
GvABE3Dbo2l0tfTNXFSwpvi8eOltYlYW25KFsumcmnpJbV277SAz1Ksve/fktR+v
NvigfcqjG3fu6rCXL6JKNbElaVqdGwUCbTUA2tPOnEJm6Gi7np8=
=o2ES
-----END PGP SIGNATURE-----

--qqlgowxaqelmwsf2--
