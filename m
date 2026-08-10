Received: from out-175.mta1.migadu.com (out-175.mta1.migadu.com [95.215.58.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC6D384CEF
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348381; cv=none; b=JvSmegUpskoml1dKhOCUZdUEou8AnBZs+7h6thfaR3A/ex66v8I+N342xayU6ZRhtvYXcThXppcd6ygmXoDs2183KlpLTA1IIg2/N7O5YVgXIak7ijVKGgYqHhX4Oc0ltwCxQtrt2UNMBLWnH8yrjaOLx6vY0qGxHOMTCqCxh1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348381; c=relaxed/simple;
	bh=LVed4bWdf2HKOqT4E1kfml0ufefVYA2isaxiE90fZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCkgwZiTLETj93oI0DX+LZyxw3DkI82zzNbkprVkLH92xgeDLmvuUMd9hOFk4j2LnAMpDeGr9+d7899xRVNzrtb+M/Qi5niEVXMtM0sCVbZDwOpfqemz+5PL6WQ9OWloorQFI33butuFZlqB2v5JZXjfWfQ1cRL3SZ6rBdAxTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g1WsNOPC; arc=none smtp.client-ip=95.215.58.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g1WsNOPC"
Date: Mon, 10 Aug 2026 10:52:47 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348377; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=tDeZoVHDwPDrk337fTH2l5X9VG6M6V6h04Z+lCjgZPA=;
	b=g1WsNOPCTDsF0ib3EUwXx47K0R8o34BwIgcb6HY+9G7LgdzFNLk2OJ2sHvbZTfVEJfXS5O
	ruyuvv87XW1E120KETj03Xtk3TM9Y3gHYMd8LBW6+xYAqg9UOVRNWsN75lFRSUYCLBG9AG
	U5pce0rce+6BQk6/3tu7r/nFSpwcaUA=
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
Subject: [PATCH 06/12] iio: pressure: rohm-bm1390: Return error when read
 fails
Message-ID: <ba361c8c8405d5e4f9d94fe0ec34b6c316593472.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZtcSuXjKGftasQag"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--ZtcSuXjKGftasQag
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

The data reading function ignores the cached error value, and
unconditionally returns 0. Return cached 'ret' -value after stopping
the measurement so user knows if read failed and data is garbage.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: 534674463a59 ("iio: bm1390: simplify using guard(mutex)")
---
 drivers/iio/pressure/rohm-bm1390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm=
-bm1390.c
index b3be9de03678..d00d7ed54cb1 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -289,7 +289,7 @@ static int bm1390_read_data(struct bm1390_data *data,
 	if (warn)
 		dev_warn(data->dev, "Failed to stop measurement (%d)\n", warn);
=20
-	return 0;
+	return ret;
 }
=20
 static int bm1390_read_raw(struct iio_dev *idev,
--=20
2.55.0


--ZtcSuXjKGftasQag
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5g04ACgkQeFA3/03a
ocWoaQf/fYgd7oXgOisk8Ykc/Qx6QTYiXoH5T8Vz9986RJOct8H/aJlTQdeh2GUA
M7x9TrIQxAjyNwIp6ecO1Z2nNiWHbBx1C0yxxet+sQXqi4m2ACdW6vMQIf9SlZ91
5Abe7CgXKoLNm5c4+FjYsuKR+x45ErzvTUICHFaXghw5NKMumPozHyOdF+Ll9ioc
ZMsDoAxTZFArIyQEBpCCL6ZswA8nIBnxvtqmoQQjJ3LEzsftYW+iblDd+G3KpVDP
v9egcu6OY92M3n4gS7b55OATWieiN1l+AE++mEy4ZqoyvtrR6Me/cGlichnYSxPD
M5XwDpf9Nhhbc6Qxzdg4LIsfjrfhYw==
=2uDx
-----END PGP SIGNATURE-----

--ZtcSuXjKGftasQag--
