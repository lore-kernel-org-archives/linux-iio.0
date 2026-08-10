Received: from out-173.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824F37C0F6
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348213; cv=none; b=UgDBs6w2kbLbarA7pScMAdtLOH6+WCckAxh6KSj+ABcWIRdc1LvJ69LWCLVuf/s6Wzs42RKAe4stxYDNNOvTv+IhpD1b+Oi+XHhhHCTxh4GxoSlXiBiAE6w/9ou9bVv9qc5nW+s77xrt2XKC5pGJvqETMnFf8o/U0BABf77+G9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348213; c=relaxed/simple;
	bh=111RdZsm5n3HpHBprU08HwbC11zxACACz0z1bDcFO2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6/jPaayXQV58je0tsNy/b3eW4Ov5Tm4coYHsqbq/MxV3/hw40sxKERizZ5tKloQNyISAA+Alhj6jyA+pmmX4oJmeH2d1vy62zF1kI29AcidUgNmc615kA/UyBfebqN5hzm68jcTHJUWbWghwROnSCqSNHR6rt4oxwLAsV56saQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tLITZCyL; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tLITZCyL"
Date: Mon, 10 Aug 2026 10:49:56 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348209; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=aA2jtwlO52nIvZCZu4zJthKMa7t4MR6SNIoGarpcQbA=;
	b=tLITZCyLhw29q6+MeN2cTbN76fe3dmePVfNeiYyJgRVXowZLrUX+2SlUoZJyyfiC6f/qL/
	Gwnlcai3M5F2tTscTjv7jFoU3V/NNz2COM88DdLCgDGUhufvamRJ1LtUt7sMxqTqpt4ehY
	m5x/LN45OBBvLqlzBJcr9NbZdzKK78I=
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
Subject: [PATCH 01/12] iio: adc: rohm-bd79124: Fix rising alarm
Message-ID: <b38dd82c759db17796054b6847fd7f770be27efd.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dGzkdkXLnrATO1NO"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--dGzkdkXLnrATO1NO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The rising alarm is using the cached falling alarm value causing wrong
value to be used.

Fix this by using the correct cached value for rising alarm.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
---
 drivers/iio/adc/rohm-bd79124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index 864f3b1366b5..f703c74309cc 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -525,7 +525,7 @@ static int bd79124_enable_event(struct bd79124_data *da=
ta,
 		return ret;
=20
 	if (dir =3D=3D IIO_EV_DIR_RISING) {
-		limit =3D &data->alarm_f_limit[channel];
+		limit =3D &data->alarm_r_limit[channel];
 		reg =3D BD79124_GET_HIGH_LIMIT_REG(channel);
 	} else {
 		limit =3D &data->alarm_f_limit[channel];
--=20
2.55.0


--dGzkdkXLnrATO1NO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5gqQACgkQeFA3/03a
ocXWVQf+NV25xXjCt2gTfw5t7SZ7bSgKn2rM+iSyqflAi6TaOuYJFZ7/tRzA7F57
lTzBRvHK7HjPZF/4MP+WC23xI8Q93H+SUsBBt8tEqzd0C4xALD6k7o2BLKy6evnV
EA8K1XtkZHxERKbrVXrf1VNnai1LND/NRnxmPL529JvwXqO2t1Z9OLH5XZpNQrVq
3cv/+QsaTkaK2cZ0DfVGPYZ8Joqdgay9obGiy+nKT3Ei+sBAyBxFObMrKlbvLrEv
mqvb9TTb0xJLHg2uCOs/sD2LGBP2cEm1jWZEcQJQiGOW199cB8po4QBPA/9AYmxH
tk1W3GBHuS9zkSwJqgalsCY6xFklQw==
=KtqD
-----END PGP SIGNATURE-----

--dGzkdkXLnrATO1NO--
