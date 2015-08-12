Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:34447 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755014AbbHLKom (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:44:42 -0400
Date: Wed, 12 Aug 2015 12:44:36 +0200
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 02/20] regmap: Remove regmap_bulk_write 64bit support
Message-ID: <20150812104436.GA19600@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-3-git-send-email-mpa@pengutronix.de>
 <20150812102550.GQ10748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G32kpiKURVjWs3Ul"
In-Reply-To: <20150812102550.GQ10748@sirena.org.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--G32kpiKURVjWs3Ul
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 11:25:50AM +0100, Mark Brown wrote:
> On Wed, Aug 12, 2015 at 12:12:27PM +0200, Markus Pargmann wrote:
> > Regmap does not support 64bit. The ival that is used to write the 64bit
> > data to, is unsigned int and can't hold 64bit. _regmap_write also just
> > supports unsigend int.
>=20
> What makes you say that unsigned int can't hold 64 bit?  An architecture
> can have 64 bit ints if it likes.

I wasn't aware that any 64 bit architecture actually has unsigned ints
that are 64 bit in size. So wouldn't at least on x86_64 this would lead
to a compiler warning as unsigned int is 4 byte and u64 8 bytes?

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--G32kpiKURVjWs3Ul
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVyyOUAAoJEEpcgKtcEGQQijUP/An7vweVDwpChKFyMeKkL993
FYJ59AVdyulZsLlacve1eWoC2q/fitxFgiLim50VzzO6eSYzjbLcBNLczc2GMK8O
egjuO+tUmj0qNNRBYaE++7QMihIODhMFWbKdw1Q3Tb8hmSWrcSNPd+7WmdE1aziO
YxBhXCPjwizgC9ACJ1BfF/lPlMUkiAO+dDVAH5D5fOUrv9HBJEII0q+nztJjVwZd
R6Wtu9iAtyPqKXnTki5dN/xucEJjFFQ45NhuZSSBKGuSmSX37EY4OnIR+SiloKC9
UP5eAhQ0PeaeYsj0O6F+u4mRHE3lWqo7LLgQBEnaRKkcdW7DgbxIZiX8J0rt1eU3
OI5DmQr0iItIXoiFD3Wv9YYnKB/lvoGaOKRCDvTMu2bkhUkA96wniJ/wIH53POj1
XyHb2UV//MXU8HWlagDuMQW9ToKQojRBk/bqIPBjs/0dS2WjjTVkZCEfeR42NX2f
GJlLOYqqavFAUl0l0zSDvowHi6pXMwD3+OQt/qECJh5TnoaTDM02vnRDWS518qcO
70NEko1tWrllmRGOwRa0eHnRMA1CwIVR3eQxNMVmnq8ua7M0enVVcVaN/y8VUfMZ
ZthU7rl9e0JDib68IiPZTBoaggBDnro7YO2QGQDn7qirLP6sbenmLD73q8Zbj25A
6z7lkYnc/G+dZAJ77Tmq
=jxJ0
-----END PGP SIGNATURE-----

--G32kpiKURVjWs3Ul--
