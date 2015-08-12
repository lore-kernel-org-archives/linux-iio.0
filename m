Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40317 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbbHLL1P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 07:27:15 -0400
Date: Wed, 12 Aug 2015 12:27:07 +0100
From: Mark Brown <broonie@kernel.org>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Message-ID: <20150812112707.GY10748@sirena.org.uk>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
 <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5cJDuji44TeXTx+X"
In-Reply-To: <1439374365-20623-12-git-send-email-mpa@pengutronix.de>
Subject: Re: [PATCH 11/20] regmap: _regmap_raw_read: Add handling of busses
 without bus->read()
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--5cJDuji44TeXTx+X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 12, 2015 at 12:12:36PM +0200, Markus Pargmann wrote:

> +	/*
> +	 * There are busses that do not have a read function as it is optional.
> +	 * Use their reg_read function instead if the requested number of bytes
> +	 * is correct.
> +	 */
> +	if (!map->bus->read) {
> +		/*
> +		 * bus_reg_read() does not support reading values that are not
> +		 * exactly the size of format.val_bytes
> +		 */
> +		if (val_len != map->format.val_bytes)
> +			return -EINVAL;
> +		return _regmap_bus_reg_read(map, reg, val);
> +	}

No, this makes no sense - if the device doesn't have a read operation
then it doesn't support a raw data stream and hence can't support raw
access sensibly.  Callers that want to access a lot of registers at once
without knowing what the wire format for the device is should be using
the bulk or multi interfaces.

--5cJDuji44TeXTx+X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVyy2KAAoJECTWi3JdVIfQl08H/izEeSAejXwinsT9NYHcsMkI
jdX3FJMji39ZwLAaJ3a7O6IPvrkc9km1w8g8svLD7PuX8xkjxckpQUU8XDpBVahp
hlMCBBgHFavOzX7V982GeJWVtGoRmEUhw/biyX428vu6EV0gYPfC7/+QuSLdzwP1
xkCgHGbsxnDq8kaVleaFX07bzEy2TuSw/aCTeL3uxO8k1LhQzJ2HX1p/2Rm04SLN
uRGemt7Widp69njB+eq6Qc9hMgGXx3iRDlsaaIh44u/ZSKBVve871UfZT1ZIz/lk
UMxx3A1T1qNo0b2RTkvxoJXeuZ4qEV0zZ/5HBrey1L7VJ/9sqwfZ2KhVzsgK/OQ=
=lXny
-----END PGP SIGNATURE-----

--5cJDuji44TeXTx+X--
