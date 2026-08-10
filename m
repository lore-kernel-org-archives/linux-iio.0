Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317331DDA18
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348241; cv=none; b=hZ9UtY5PGin9iITaPbK435HfZVS4QEh+Iq+9V10MVWudy+14nQoWbZ+7LkoBbJ95lcHU39nweM2rPZmeUnyzqyfDBieEdtsb1tRWJ9jm+mDDyBsZch2Pb5OHYzfKDmU2aQIlckb2PUbeODOh1SaEPQuv0XzpeYDo2SOypZbv2zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348241; c=relaxed/simple;
	bh=2j0SdMfFMU38+CTsQO4UceXiRjokHyw731gIkPFYLvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YD/oJXTJ0DK/X715j1AVOI6aZInlyJV+mV5QE0JASHk8a0nskAQC9Iv+FpxXl1A1S549vAblYtOw/SARYirW6dULcKCaQQi6GqVSBEWCK6j36m08vxcuLQLvECz46WgzyMSwqR7YtPPbkwzCPXfRBVOT1mfAT23FXdmbOHfCy24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wKYLyPic; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wKYLyPic"
Date: Mon, 10 Aug 2026 10:50:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348237; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=l2+Pp38OdG5aA+L8Hocx58bkKM9cYRU7AmkrJmDzu+k=;
	b=wKYLyPicmd30qb9OZycUnFNSaqzFYDVl9hP3huUVLaDAcw/Rq4jbu+QQG0/tyXRsd4Vp7e
	973LhZqj7qlh4KChJmchd/nnbkknqJTsxtS7/d3q8P1ZNmlvLQP03pwjRAZc8J1Zdm5hyz
	zngv+h2ObnpdQJvFpCozpXZbq6Jl40I=
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
Subject: [PATCH 02/12] iio: adc: rohm-bd79124: Fix channel initialization
Message-ID: <4abf69bc827f57d301839d123ae184cfdfc31953.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RFAzpDowJDyemkY3"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--RFAzpDowJDyemkY3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The alarm limit register on BD79124 span to two consecutive registers.
The first register for high-limit containing also hysteresis
configuration. The initialization in driver writes only one 8-bit
register, overwriting the hysteresis and leaving the other limit
register uninitialized.

Fix the limit initialization by using the bd79124_write_int_to_reg(),
which correctly initializes the limit on both of the registers.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
---
 drivers/iio/adc/rohm-bd79124.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index f703c74309cc..72207e0c60b8 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -920,13 +920,13 @@ static int bd79124_chan_init(struct bd79124_data *dat=
a, int channel)
 {
 	int ret;
=20
-	ret =3D regmap_write(data->map, BD79124_GET_HIGH_LIMIT_REG(channel),
-			   BD79124_HIGH_LIMIT_MAX);
+	ret =3D bd79124_write_int_to_reg(data, BD79124_GET_HIGH_LIMIT_REG(channel=
),
+				       BD79124_HIGH_LIMIT_MAX);
 	if (ret)
 		return ret;
=20
-	return regmap_write(data->map, BD79124_GET_LOW_LIMIT_REG(channel),
-			    BD79124_LOW_LIMIT_MIN);
+	return bd79124_write_int_to_reg(data, BD79124_GET_LOW_LIMIT_REG(channel),
+					BD79124_LOW_LIMIT_MIN);
 }
=20
 static int bd79124_get_gpio_pins(const struct iio_chan_spec *cs, int num_c=
hannels)
--=20
2.55.0


--RFAzpDowJDyemkY3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5gr0ACgkQeFA3/03a
ocUpXAf9FMCB8qWxWv5NdTfRnmRYUJOmkG6thaRBnomZpmp2vfJskacIbIGFAQw+
EkA5cSi9btg1xqejot5oTWVgi0WwgLgSN0kPH+B77lSiF2sqwXtGkSm37KbnlOOq
VYAeroqukMUC/8aCelvSvh4gzgFoZL0fsfK+Alf4fCCxYYoNpQOp2qCpyG7VERfP
pBh5XHIWez0226FYMM1kyoHid4qz3mbSQhejyz4SU98Nc5dckAfvilBQvCQrn6uy
19bWrolvMiXujBMFzl28U1xUjD21IGF5oX0bf75earGw5YcFecHmtAQnF7eqeZ+X
8oYqp0wnLZLP/paQB5l7k791vgoVwA==
=4xAQ
-----END PGP SIGNATURE-----

--RFAzpDowJDyemkY3--
