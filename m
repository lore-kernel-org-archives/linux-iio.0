Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A83377EA2
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348196; cv=none; b=NNzuYQistrHDv1kTFDVtxrDM9roERSaTYlJTMxdIImux8cdx5xu3FG/UyYHriHFjG4aLRTJvERz5Zztta2dJWvoR8fTO25Wupgt01/zIVYHtKxH1a8Qb2L4Rfpvn4RGEQFAX9dpwIu+KNxujMRDYxyO7eb5ZrqelALPOUp+llHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348196; c=relaxed/simple;
	bh=wAvYSzqDJhvKzUXfeLcsQzrLHs1CZIaOqXP0NRLKhUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s+vdBkGMM45NiaV8XxA9zmK8o9G2UBvmhofZGbatrmpYqIvq8ZN/N5ks5zkzzcLpBy+y95874p7hYd8xExOnm/N4U8riIOwV9Rb9+m74urnh2G81LK/zb3VxnC6VOdfTjRzCsPXM2EYE3thKO4ZVMi5qvBLVsJBsfbQGLrOOMdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=owqlS9Yp; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="owqlS9Yp"
Date: Mon, 10 Aug 2026 10:49:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348182; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type; bh=/4Hko42W1ERoWfD1oR0O6YYo/pXBqvtxITIamBMTiGI=;
	b=owqlS9YpLQOTkDPl1QTFq6xtaf6D5FFEBRZQPQ83cN+eQ4eSTjq4cyXgXtnnO3ywXqkUct
	KG1B1i1vje76snXBxllU8SeNMiP3D1OHqHHAunqeeP6zAw0Gr85FVWFm2nWDTEKZJc8KxC
	3shCbNaIsYiR8PLJqZPjgrLIK8wynik=
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
Subject: [PATCH 00/12] ROHM IIO fixes
Message-ID: <cover.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QjqCo3Kv3nrLx3Om"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

--QjqCo3Kv3nrLx3Om
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix a few issues from IIO drivers for ROHM components.

I hired couple of gnomes to work for me. :) (Ran AI reviews).
Unsurprizingly some bugs were spotted. Time to try fix mess (mostly) I
have authored.

Bugs were found by AI review but fixes are made by hand. Hence no
AI-tooling tags are added. Please, let me know if one is needed.

---

NOTE: Only _very_ shallow testing is done. Some of the fixes are not
tested in the hardware at all. All reviewing and testing is appreciated
as usual!

Matti Vaittinen (12):
  iio: adc: rohm-bd79124: Fix rising alarm
  iio: adc: rohm-bd79124: Fix channel initialization
  iio: adc: rohm-bd79124: Fix GPIO mask check
  iio: adc: rohm-bd79124: Catch regmap errors at measurement start/stop
  iio: dac: rohm-bd79703: Do not allow writing SCALE
  iio: pressure: rohm-bm1390: Return error when read fails
  iio: pressure: rohm-bm1390: Fix AVE_NUM initialization
  iio: light: rohm-bu27034: Fix error return
  iio: light: rohm-bu27034: Fix infinite delay on error
  iio: accel: kionix-kx022a: Fix array boundary check
  iio: accel: kionix-kx022a: Prevent memory leak and fix state
  iio: accel: kionix-kx022a: Fix IPOL macro name

 drivers/iio/accel/kionix-kx022a.c  | 29 +++++++++++++++++++++++------
 drivers/iio/accel/kionix-kx022a.h  |  2 +-
 drivers/iio/adc/rohm-bd79124.c     | 20 ++++++++++++++------
 drivers/iio/dac/rohm-bd79703.c     |  3 +++
 drivers/iio/light/rohm-bu27034.c   | 12 +++++++++++-
 drivers/iio/pressure/rohm-bm1390.c |  6 ++++--
 6 files changed, 56 insertions(+), 16 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
--=20
2.55.0


--QjqCo3Kv3nrLx3Om
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5gnoACgkQeFA3/03a
ocU02gf/T8DREGoKYp2nhPmomyHgM3yEMECX5bjfDGaR53zYxK8ORFDtlnprybfu
Q0cdxku/UH1dITJTFKq2JVz75rEn1vFsMcFdzevpox9QXY3plmQYH7NJuWW4+9cu
746L0ibPiaF4IlISiRSchsL6yiXS0ZqaGA6UXAMBGu16y8jJSz5ZEzaeK98wdKtC
7VsD1MFQbC5bj+AXOoQ1ky5i6G4FB0ikaz1XbzEbX6S/YbInffD9qmgMOeLksymD
qpxayFI2ztGXgbItFJcG4GH9VPeFkzovdkBdKpAk+Pb3rQ/RSPLvsV8ImuffHLsi
lmy/e31UXEVvVwnbFLIgcL+AjR3YlA==
=m3vA
-----END PGP SIGNATURE-----

--QjqCo3Kv3nrLx3Om--
