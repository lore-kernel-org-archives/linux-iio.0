Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA9385539
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348399; cv=none; b=I2RTzZRdW2iXFm2vICYX15/4narXWyQLYvXLAalZFuEtpz2M5PyntjIlLPV9WCLaLDB2wuWcGqFnqM/WVUPAvQid828QJFedym3uIFluFM5qCjk3FeR+SZqUSKJ2sboZ29su3LZsUDQsYEbH4RFlNeuA0AfFeZ5+dD+CeeNpKsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348399; c=relaxed/simple;
	bh=Z1iVgCBnI7rXPv4+in4EiqMrCDStBpAuaisn8RsY4U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sX3XzDAbcgJd852WEvVIiKlwZy6upIQhDkONIvXlLPRpEIR81+RRDVNbswBG9iKUaSn0Cf609CpvUs1kXpV5WQLlxc90cEqT1Lj/8HOw0ouZyhZKEP26Bqam6GXhhXTQuFIhXDq0sKtm2vmFBCq/gp8qvghaHqIiq5L/fzEmFZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WjnZDT5I; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WjnZDT5I"
Date: Mon, 10 Aug 2026 10:53:07 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348395; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=ld8firE/E8hbzBR080ohm8SFPRY+SLjFJ7lWSnovIFI=;
	b=WjnZDT5ImzblUJrB8g8cK1n2VxG7hWALmw1Ui8CsHKG8+VsNmQ+ToYly7nZ8ljVVwpizqx
	RTMU/NbNSqY3NpcWAndnzNSqQxhz8oVHGaO5pLddlZhqUlVS7zcxEk8HRjsdzmb7J2RM5u
	2pSlma5Tdc9d4y18QwlJCj8xzTSSq/g=
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
Subject: [PATCH 07/12] iio: pressure: rohm-bm1390: Fix AVE_NUM initialization
Message-ID: <7784e12793187a75dc10b0e84471f0cefe4d28b9.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4M9x3AXcv/9rH5I1"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--4M9x3AXcv/9rH5I1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The BM1390 tries to initialize the AVE_NUM to 110b at the start-up. The
field location is not taken into account, and value is written unsifted.
This causes the AVE_NUM to be initialized to zero.

Use FIELD_PREP() to shift the intended AVE_NUM value to correct field.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 81ca5979b6ed ("iio: pressure: Support ROHM BU1390")
---
 drivers/iio/pressure/rohm-bm1390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm=
-bm1390.c
index d00d7ed54cb1..29454570f257 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -479,6 +479,7 @@ static const struct iio_info bm1390_info =3D {
=20
 static int bm1390_chip_init(struct bm1390_data *data)
 {
+	u8 regval;
 	int ret;
=20
 	ret =3D regmap_write_bits(data->regmap, BM1390_REG_POWER,
@@ -512,8 +513,9 @@ static int bm1390_chip_init(struct bm1390_data *data)
 	 * Default to use IIR filter in "middle" mode. Also the AVE_NUM must
 	 * be fixed when IIR is in use.
 	 */
+	regval =3D FIELD_PREP(BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
 	ret =3D regmap_update_bits(data->regmap, BM1390_REG_MODE_CTRL,
-				 BM1390_MASK_AVE_NUM, BM1390_IIR_AVE_NUM);
+				 BM1390_MASK_AVE_NUM, regval);
 	if (ret)
 		return ret;
=20
--=20
2.55.0


--4M9x3AXcv/9rH5I1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5g2MACgkQeFA3/03a
ocVvrAf+Ohyf86sR2E0/0nlQmJFpSsXJDM/7dM1eWXMcGwGU2ocB3qzOQKn+R0eq
hIGYlg7lLst6QYkihm+J3LhXVXOLCIFy7YX4HdgRRrhwvSW+zdsO+L/jhxPjzPZu
haNqnHiSL09zgcZ8evrNmEwfjy4CxGma5nA0YXmEGfOUGos2hrIW/bxmIAt59Q+Y
rHvDvUXa8jAyCLeQhZA8I37EnH8nhLWJzMnboMMn8TpNpyq3+U1t0lgBpzhKURzZ
dczhH2tguQsMsgAOvjCIihz9knX/PeZEmN1vm7wf0q26DuiTTnrnPWZCay2pVsxj
LSQa4hz3coGPyBoYLq5LH4PP7jY1Yw==
=jCUJ
-----END PGP SIGNATURE-----

--4M9x3AXcv/9rH5I1--
