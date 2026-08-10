Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020F37F8C1
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348291; cv=none; b=SnkmRJj/ckTglL1DEleaU9qhAykJ920X6/DVas6dqv5wy8riUjB3wzV5tq1TN8a/kr15MDYM0aN7afI2J5TMMOLxHpok6RwBZAa+S3/IvYhWBpPCVPctYwlJRbA28v1Nz4qo4Fb7Nv7RW56S3kM/wj5grOKUbYKMvSqwF7prXFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348291; c=relaxed/simple;
	bh=fRS7joZRLx04hcBEoTZ3nJDf4BLIXkrbe+qjmagvFcI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfskAvEVgs5CUkeGX+Op5Qn0imer4BMK8zaEbTwsciurIVUCxE1cdoJn7Llvkmk933R59sV0ck9cBOOKNWuhdTmwo6ubjDNDUHtJw836QSbrekuSmkjIJS0Y9hGvtnCLEj7u20i9xoY6K+kBbQu2MuHjPYU5tiRza+Eo4M7dLf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GtRNiehU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GtRNiehU"
Date: Mon, 10 Aug 2026 10:51:20 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348287; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=66/LoDmpfjuUWZ79fRWL5OkXp6BR5h7G++jOjO3VNSc=;
	b=GtRNiehUfIfSFVtwkqMQgRuicCnVJexua5wGe/oJYfZDAf/gBUoyiZPg+F0vD3tIB+yOPs
	8t9Q9xwIEZWMCo1lOuoDZM+Kd2kUKvQasYOvT4x6OwcVp4WV7f+a7lya1DW4KR6QZAve4c
	mBXQigb/B7h+xJSVs8kMaJubK983Fow=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kalle Niemi <kaleposti@gmail.com>,
	Topi =?iso-8859-1?Q?Sonkaj=E4rvi?= <sonkajarvi@hotmail.com>
Subject: [PATCH 04/12] iio: adc: rohm-bd79124: Catch regmap errors at
 measurement start/stop
Message-ID: <fc198eaf83319548317611ee128e78a542567156.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="irqx7jSrmSqtRjA1"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--irqx7jSrmSqtRjA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The bd79124_start_measurement() and bd79124_stop_measurement() ignore
errors from the regmap reads, causing potential use of uninitialized
stack variable when deciding whether the measurement is already
started/stopped. The bd79124_stop_measurement() may also ignore failure
to clear the sequencer state bits, which may make the hardware to ignore
the setting and leave hardware and driver states out of sync.

Check the return value and bail-out if error is detected.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
---
 drivers/iio/adc/rohm-bd79124.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index 84ac7fc94581..600354fe0ee0 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -382,6 +382,9 @@ static int bd79124_start_measurement(struct bd79124_dat=
a *data, int chan)
=20
 	/* See if already started */
 	ret =3D regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &val);
+	if (ret)
+		return ret;
+
 	if (val & BIT(chan))
 		return 0;
=20
@@ -421,11 +424,16 @@ static int bd79124_stop_measurement(struct bd79124_da=
ta *data, int chan)
=20
 	/* See if already stopped */
 	ret =3D regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &enabled_chans);
+	if (ret)
+		return ret;
+
 	if (!(enabled_chans & BIT(chan)))
 		return 0;
=20
 	ret =3D regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
 				BD79124_MSK_SEQ_START);
+	if (ret)
+		return ret;
=20
 	/* Clear the channel from the measured channels */
 	enabled_chans &=3D ~BIT(chan);
--=20
2.55.0


--irqx7jSrmSqtRjA1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5gvgACgkQeFA3/03a
ocXj9wgAsMAFnfVAOeOdsfa0tfIZGO/qSJXyFP6ibIqvktIBFvXpYla2serHEM7O
vovXSSiycWTWhgD7WodTONbFi2a9z3J841z9DTfdxCTr26lyh1ku8nCHPjiOzXAA
qhH5eS2sxoB8sUm2b+AFW/nqbLlhMwmad8TjKQE+0+4gjAD64WCfO1mvvs/4TEvU
dKEoemAJZVJle4uWC49MFOvXolRh4eeSO2145WsgSFjmRxeYTgOzUQNo2Ghb3H/H
4Nk25OCaGY+y3PUI2plH4h1p1LDorVU81XdE182aAMZGRf9M+wVMxbEPaqQkpMOb
N9THE5BgCTWVJRgQ/qRDOz8C/W0hfw==
=esq7
-----END PGP SIGNATURE-----

--irqx7jSrmSqtRjA1--
