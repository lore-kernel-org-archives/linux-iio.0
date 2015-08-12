Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40283 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbbHLLUm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:20:42 -0400
Date: Wed, 12 Aug 2015 12:20:35 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812112035.GX10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tgO4DUqb0GCKXXLG"
In-Reply-To: <1439374365-20623-10-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 09/20] regmap: _regmap_raw_write fix for busses without
 write()
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--tgO4DUqb0GCKXXLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2015 at 12:12:34PM +0200, Markus Pargmann wrote:

> @@ -1229,6 +1229,11 @@ int _regmap_raw_write(struct regmap *map, unsigned=
 int reg,
>  		}
>  	}
> =20
> +	if (!map->bus->write && val_len =3D=3D map->format.val_bytes) {
> +		ret =3D _regmap_bus_reg_write(map, reg, *(unsigned int *)val);
> +		return ret;
> +	}

This is broken - you can't use a raw value as a register value.  The
endianness of the device may not be the same as the endianness of the
system and you can't cast a value to unsigned int, the value may be of
any size.

> @@ -1340,7 +1345,7 @@ int _regmap_raw_write(struct regmap *map, unsigned =
int reg,
>  	 * send the work_buf directly, otherwise try to do a gather
>  	 * write.
>  	 */
> -	if (val =3D=3D work_val) {
> +	if (val =3D=3D work_val && map->bus->write) {
>  		ret =3D map->bus->write(map->bus_context, map->work_buf,
>  				      map->format.reg_bytes +
>  				      map->format.pad_bytes +

This appears to be another case of merging an unrelated change :(

--tgO4DUqb0GCKXXLG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyywCAAoJECTWi3JdVIfQmR4H+wVcO7r1GeBFJoY+3IrlwD1T
U4c8wvoQnwJeTm/UPmjoyoP7YXvfj/yTRZvONH1dMGHSyR4zIaFSIyyjh5U0wL4j
4gj0OoIyPfBVZhjV5h91MybniYOnn3HLccjv+2M27TfMER46QFWYEmYm9jsb7onT
BU7wx2wZvsXm/d5EtahyMlC2m0nAItFF3tZPLkpMvbOYGcfsG6BCZHi7P46qkGzN
mNp/K/qh28HXHk9l4cXijl1EDCZhRmfrWbYXbVIZYYBNL+Xt2fP6hXB95+ZnvTEN
Zbfk/u3cQOtnGKvmXI2c/frB99M1ywl+T+1BUzMWJT07AsKAVzQGBeWUxZxAI0I=
=yNjz
-----END PGP SIGNATURE-----

--tgO4DUqb0GCKXXLG--
