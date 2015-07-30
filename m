Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41450 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750879AbbG3LoW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2015 07:44:22 -0400
Date: Thu, 30 Jul 2015 13:44:15 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 2/7] iio: bmg160: Use i2c regmap instead of direct i2c
 access
Message-ID: <20150730114415.GP30895@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
 <1438177569-18772-3-git-send-email-mpa@pengutronix.de>
 <20150729183738.GL30895@pengutronix.de>
 <1438253368.15571.31.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3hAdtgBjtgL7p0NQ"
In-Reply-To: <1438253368.15571.31.camel@tiscali.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--3hAdtgBjtgL7p0NQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2015 at 12:49:28PM +0200, Paul Bolle wrote:
> On wo, 2015-07-29 at 20:37 +0200, Markus Pargmann wrote:
> > On Wed, Jul 29, 2015 at 03:46:04PM +0200, Markus Pargmann wrote:
> > > +struct regmap_config bmg160_regmap_i2c_conf =3D {
> >=20
> > This should probably be static const ...
>=20
> Likewise for "bmg160_regmap_conf", which you add in 7/7, right?

Yes, thanks.

Best regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--3hAdtgBjtgL7p0NQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVug4PAAoJEEpcgKtcEGQQe2AP/ijpYaNWUSqQ4EjJblUjCRKk
C7qBrnYHRMrqriJau05isyEAHz/MZnZxwsj938S8HFBvxyo6TgnlrnhdbKDMcAv/
xsrfnOfGNzRzXazzQWfIZ6vlXNVbjty5eKK2gNOTrK/XPiZB7SWGrrE9pVzBnuSp
ACmL2FXjENLpoGldPB/s/N+tst/lq96EQ8FmejTO5xDBvU+OAfZhKu5XdPxtaC2b
gsd+NRVNvL0Cmd1z8SQTLk7W8WYNioOBDgskavitl2KKJgNeiNx3LwgtaH0uQ4xF
S09CvjnFWlmgDJ9Pm/AZKrx/kjr+gwIWeueGDMDECBU068H3m5hYID9vkAY+/h59
eVOk0Hjxv2fh6Pn5WC9fQoudDJrRc/UgdQ0ryJcJRP6Y8bzr0ZXA49ht46Lrwyjt
ddihC3wERmxJcAsWBqqdI3cs0l0mVUGPCnQDqEACJilX56wjyk1qS4bnOunp0RkF
dDRibFJMvCOF8lpZK9SYphTicAxaDsJ38MoCCpIfXo6Wq3f2zpVz4uDwhfUp0nwb
KTFN7+JctU9BZXmSQdDwE7CiLDbU2MCm8a1Qz69XNx4tKudd40NSmDVVtXgIo76Z
yp4qeeHgP9UxaClBMFeeu98MGS9A9wLwoZEC1Ep8ex73JMDXUqeQUeE2dq9xx/+a
qphctoj5FBm9sgrYiTZC
=+Fcn
-----END PGP SIGNATURE-----

--3hAdtgBjtgL7p0NQ--
