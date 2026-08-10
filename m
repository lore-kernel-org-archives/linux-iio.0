Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B5B1DDA18
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348262; cv=none; b=ZfpJQBiGrTk2nYfm2IPegKhRebqG6FL9s3JtS3TbjT49Z8rkC5JX8qADdw7l9Zrsr+dPP+Txn7G8gNn6D6cKM/qAKw32qb9A6dtFnVH1Lzx+ggZpG/Cix36gyFJnDiKX/JgzA8CS6ypvfbcbuTFkVGYl4ndBbHK2EHztWjmjm4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348262; c=relaxed/simple;
	bh=pmEPY4uuMD/93Jyz8SMLZJrCuhzMw3ohmxTuyXaAkLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=omn6PHXjcd9qalzxJfI1BWiP9d8Pcz9te464kbDd5HKJPieVR+fB5Uk3My5BNRxQRQQ0ZyMAYu6uLxiipoq5v9FM9Lrq+Q3rzq+Afkk6zz6OAqSs1lOKotQW5YjGtnCTwQUctUbdfYIfB0UQRapdv6JMjq52RjFjhRahzYKgIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O/A1rSTf; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O/A1rSTf"
Date: Mon, 10 Aug 2026 10:50:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348259; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=Pv0bGALvhEBK9KopYXwuAV3r8qk/EvYo7FKT84DGw9I=;
	b=O/A1rSTfLuDT4QREr9xK1pEGrHLDtb2AqvU72rIAIB6ATcp/HnVhPy9AxKL47i2ujxAQ9r
	MtgOJiHcKcO5pP+VoBWYv4cR+qlmV8WQsprvfN1rqbcpc0Myn6yNIR6SfmRhr5vMfyzIHe
	mVdChwJUNAQ30sBdaQXLAYk5H7x8k80=
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
Subject: [PATCH 03/12] iio: adc: rohm-bd79124: Fix GPIO mask check
Message-ID: <02b3f620fb3aca640dd2c7f53cc5af1e52e68149.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AxbImmTjne7lh+0i"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--AxbImmTjne7lh+0i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The ROHM BD79124 has pins which can be configured as GPOs or as ADC
inputs. The bd79124gpo_set_multiple() is intended to ensure that a pin
which is requested to be toggled, is indeed configured as a GPO.

The check uses XOR, causing it to fail if mask is not exactly same as
GPO configuration. Eg, if not all GPOs are asked to be toggled at once.

Fix this by checking that mask does not contain pins that are not
configured as GPO, allowing some of the pins which are configured as
GPO to be untouched.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
---
 drivers/iio/adc/rohm-bd79124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index 72207e0c60b8..84ac7fc94581 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -201,7 +201,7 @@ static int bd79124gpo_set_multiple(struct gpio_chip *gc=
, unsigned long *mask,
 	if (ret)
 		return ret;
=20
-	if (all_gpos ^ *mask) {
+	if (*mask & ~all_gpos) {
 		dev_dbg(data->dev, "Invalid mux config. Can't set value.\n");
=20
 		return -EINVAL;
--=20
2.55.0


--AxbImmTjne7lh+0i
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5gtkACgkQeFA3/03a
ocUeyQgAj6g9lTPmAOu4ZWcLodOYjGZxcWWJYAQaYp8phzUssUTH0XRlYvlB3A8C
erZAeYceU6bp3D7f/i6y9/TKwNaDMBtyFYv/8Fr2aLTuXRKpFmZ8zpDr8vUG1IqF
t7lFFi8GwBuAFdumSVYWj0weW0wNSAQuvj+GFYJylQMq8UaJ9hzQKJde0B3KjqyI
U14nU3T3rp1f1aT7qM97elzAGIYJBnLf/IVAPnOEl10hF/On18LLl5lg2ZlHqjbc
n2vQ2BjlTOCNEvb/3V3OO0ccydb31BACSEq9SLQqg5ddv4GFGk6HYxTerbUV3Pj0
TeHqeZfNimb7mnpo8KYggLEh8Yzmdw==
=A5gw
-----END PGP SIGNATURE-----

--AxbImmTjne7lh+0i--
