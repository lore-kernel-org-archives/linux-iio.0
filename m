Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E1B38910F
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348437; cv=none; b=O9C1vRAG/uHanj6glNd9V6eS5b6Ox3SM+C3FBH4gRgBe9+Un18rjS6oPjGJZAxnMrVVPJns8tzOvLIyVjezZVP9h+WQ+hTdtDCAR92ZGYqkUQ1ywQttly5T08kHkpHBPGMrGenU4NLi0FuCCFxHVsfrC6DNY/toUdw2J8s/P5ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348437; c=relaxed/simple;
	bh=NvAqxVCVl+o43PBxncHk89OIjzpQVqejdSjtE/6hyio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y17Saq1FwsY4Y0N4ztw291YqjeuF9SjaYIJyBn+QWMZ+7U0DDDvWocA90gjpBJ1znrfgVs3/bgBK01NhTWWUpux8r0wtkTtLusytxhnDFQMdPlA9bgwasxnUNB1bwdL8eWKCFcvzNpmP3DgDuSGqdMFpXA7q6Q++Byk5ZCb5/n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ibUdImxn; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ibUdImxn"
Date: Mon, 10 Aug 2026 10:53:35 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348434; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=fyIIkpJ1wM6nP/6D8IO6+sXMqHu80d+stYd/eBqLQgA=;
	b=ibUdImxndHTzXguU3gdfQ8g7FnsC1q282gAqGpCnOaeBlJLm0yu8NaSe393/AhuOOXqMM+
	6JGYyoT5rwWaew+s/MgPypTJkWdyStEyHDmwKtF4jkt+XseUlRasEkCS/H9xOufItFu9sh
	CpXen9bD/ClXtA6aMGWW412Mw4eXq4g=
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
Subject: [PATCH 08/12] iio: light: rohm-bu27034: Fix error return
Message-ID: <bfe7f9146960bf0fffb3ce09a14e7912394f5ad8.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ps2+aY4vUgKeycWv"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--ps2+aY4vUgKeycWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

When BU27034 fails to read gain value at integration-time setting, it
returns 0. This leaves caller unaware of the fact that setting the
integration time failed.

Fix this by returning the relevant error instead of zero.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 439c2cef8157 ("iio: bu27034: simplify using guard(mutex)")
---
 drivers/iio/light/rohm-bu27034.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 28d111ac8c0a..f9a421618406 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -415,7 +415,7 @@ static int bu27034_try_set_int_time(struct bu27034_data=
 *data, int time_us)
 	for (i =3D 0; i < numg; i++) {
 		ret =3D bu27034_get_gain(data, gains[i].chan, &gains[i].old_gain);
 		if (ret)
-			return 0;
+			return ret;
=20
 		ret =3D iio_gts_find_new_gain_by_old_gain_time(&data->gts,
 							     gains[i].old_gain,
--=20
2.55.0


--ps2+aY4vUgKeycWv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5g38ACgkQeFA3/03a
ocWY6Qf9FF8fQGHAYPGF7eXTDSY7Zqv6IehenTPxOWdVZR17cl14h5pF87ufsR5U
avc6KW4XJ2yygWEKDT5BbLt/7o4QlmqObHRVHRLvrHO63yGgCM4RdR5q8EFAZ9kx
Mc0Q1VuEnTJ77i0NNSh88tXvm5KEqYXMWANO/upLMRjbkoqNKL7C4qADSTgFBXkP
zXeTCzkPU65h9U8DZFe92GLDXNE41d/ArP3t75oHnzwiPy8FInVU29D/uB27pF9Z
SALKbuPVB62vVV8pB9b1JOMT3H+dnkvBKmy03wiM5LkKQ2+FTC8LMhdMkbJ7F/Wt
qO1uP3d4MJWf/Ck4hM8x91UN24wioQ==
=WjWi
-----END PGP SIGNATURE-----

--ps2+aY4vUgKeycWv--
