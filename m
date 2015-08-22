Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:36617 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750744AbbHVEDS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 22 Aug 2015 00:03:18 -0400
Date: Sat, 22 Aug 2015 06:02:59 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc: "mpa@pengutronix.de" <mpa@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"Tirdea, Irina" <irina.tirdea@intel.com>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v5 6/8] iio: gyro: bmg160: optimize i2c transfers in
 trigger handler
Message-ID: <20150822040258.GA1605@katana>
References: <1439389900-10108-1-git-send-email-irina.tirdea@intel.com>
 <1439389900-10108-7-git-send-email-irina.tirdea@intel.com>
 <55D056DF.5020201@kernel.org>
 <20150817090943.GO19600@pengutronix.de>
 <20150821102125.GA1656@katana>
 <1440172701.4081.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
In-Reply-To: <1440172701.4081.1.camel@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > > The series[1] I am working on implements a i2c smbus block data=20
> > > regmap
> > > bus driver. Regmap should then automatically do a block read in
> > > regmap_bulk_read.
> >=20
> > Hmm, so doesn't your series make Irina's series obsolete? It=20
> > addresses
> > the same problem only at a different layer (i2c core vs. regmap), or?=
=20
> > It
> > would mean that i2c client drivers which want to support byte, word,=20
> > or
> > block transfers should be converted to regmap. I assume most of the
> > potential candidates are register based devices anyhow. Then, regmap
> > would be the proper abstraction layer. Have I overlooked something?
> >=20
> This is the only driver converted to use regmap, because of SPI mode
> support. The other drivers will still use Irina's changes.

The question is if they should. Or rather be converted to regmap. It is
an open question and I am seeking for further input.


--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV1/RxAAoJEBQN5MwUoCm2Y28P/2AnnqIsvBK2u0QO/Y755hcx
/gJeEsVQBqh9cAx5fr5jpV94IDpHvgsD8LNRBUV7KbtmZelawTS8t140ucaG7h17
UdYimIJBByXT4b8/Zf+qlh2u/fjHFCHQDO2gaNCOvXzTZr8qJLnqv5N6EyTdVlUQ
e2fZPvmBxdeUk3ndMqPr0kPo9pR+jB5Dfh556/0RjkVXXNZQNfryuV3Qia00H3o9
hvxLN+TPx0hGo03MeeBCxDQ3iwNbqLyYvHHe7QEEfa/GmxEP8b8FHRuODNYbgBAB
s/7coH0yY6UCyH1GGm1uRIXAUOXjdd5dg127OZexynLGEv7Pjwb0xv2XNYD9Jl4U
+2Dp5LaNVXaArRuwKlq6Y2LHiZU7BTd1fTfy8RkI+Jtecp9ZBCS+fpRAMYrJbtSu
Ing2+mdqVqQ9BchoYyaLkUGqjeMbis4mSemFC/JdqQaqa9I6naLi/F6F8Nj7g9Gw
KGRmNDcNS+G3NdGgLoq7yXvBRGx/rb2CTUAEy8Wh6reGtU9qUKWkWIHTUpD6YX/g
2Im0CAt1byCMJ+jyawjlCD9CiMuCAN8gXrXJAsW0HVkMtoWdIrhcr01hpvQV3jOr
+BctbS8NsyP9vhCnXZKNPjQ6Qah/mDwzQMQNXD/JC+DaHSTd9780GhjX5hjogm3h
bm23kO7ceqBMPL28uT/Q
=XcGM
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
