Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38348 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbbHLMHR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 08:07:17 -0400
Date: Wed, 12 Aug 2015 14:07:09 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 06/20] regmap: Fix regmap_bulk_write for bus writes
Message-ID: <20150812120709.GD19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-7-git-send-email-mpa@pengutronix.de>
 <20150812111031.GV10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2zkT5PsbWu6kxoCU"
In-Reply-To: <20150812111031.GV10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--2zkT5PsbWu6kxoCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:10:31PM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:31PM +0200, Markus Pargmann wrote:
>=20
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
>=20
> I'm not sure why you're putting this in these commit messages...

Just to not forget that Stephen should be in Cc as he introduced the
switch case which removed the code that I add here again:
	f4298360a5c2 (regmap: Allow regmap_bulk_write() to work for "no-bus" regma=
ps)

>=20
> >  	if (!map->bus || map->use_single_rw) {
> > +		if (val_bytes !=3D 1 && val_bytes !=3D 2 && val_bytes !=3D 4)
> > +			return -EINVAL;
> > +
>=20
> switch statement please.  This also looks like a separate change to the
> handling of single writes.

Sorry this was a left-over of a previous arrangement. Will remove it.

>=20
> > +	} else if (map->use_single_rw) {
> > +		/*
>=20
> How are we ever going to fall into this else case?  The first check has
> an || map->use_single_rw it so if this is true then the first check will
> be too so we'd never end up in this else case.

Oh right, seems like another leftover of rebases :-/ sorry. The above
condition should just be
 	if (!map->bus) {

Otherwise we fall into to this second case which is also able to handle
for example 3 byte values.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--2zkT5PsbWu6kxoCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyzbtAAoJEEpcgKtcEGQQU0kP/3rEb7s2FG9pslBNZxev9prV
cQuMzg16qqxpLL972MXeBiZ1QKD2vMr2+zXgOP/JMzdgCMe4bfMNyV7xWnMTI+jc
eCkeEx820cPRjJu8a+HxqXZjS3KVnCPZbMMPyitn0d6tNYZZxoQJX0tHhiN73Qps
iAjNVlqwwOUn77cyleEEP6IMsBdSryIjlWJYB7xFeaZO6cYpibpl0HqmQiveLah+
XI7PtE3oih1hcZusFQglrudw3vrwmUbvKs30MWIvq0fL4Vz3/JGFz9Q0LSEoc19Z
VCTSuGxtQFPhtqwG/jqc0XdodYbh6hLSyiR/Y0q2CYBMnMkoo63GWMiUzl+YDoS8
WgyM1mLVgA/LGsUJ2ZFuyBNziyu2eX6IsLUI0ocgDbzWfwAUGT9f2ciucAgRdDT/
c5Yz/+BkvhfL/R8/mzksvQEQeOtuA8j2XYnyQ25U8SRQ60+6pnxWlXMSEM/KmnR5
3IqXBosDkX6wJiEP0LTD/SIVtOSO5Ow8EwkrWhPORau3RTza1ipn4Vbpge+xEebP
RQrMAnWvjE6plUAXVe6rVClt0w+KNaC+gqqXU4kL+4MC+PUtUAa1LgxHIFJ9zrQD
GG3wbVDqlOaGz3uB1+AhuPmjn38BK2XKim0RzmTPOPkcxZxcyGZfBQsnLdni/Fe0
OZOh9nNJnQVPZWLQcuLi
=+/7l
-----END PGP SIGNATURE-----

--2zkT5PsbWu6kxoCU--
