Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421899;
	b=2wDIhHcIQfmAZ85ci7cMVfs3XHXPkjgVscAdgZwAjgZOSfxeo3StUb8VBw9IPOg2OU9o
	 EN/iUL554Tbnrpj4uavvruVbFfLwlZZQOtghJi5P0ZweXWGiMxaW+G/KlAZQ2iu4v9YYy
	 VBrDq8rmH9qct4cMyA5GJ7lVGvGeLVp3qMnBE6ttw45jZ7+liKN6sF/nhva/8Q0Br61V7
	 zHDy5q0BDwGPiH28q8kZpzY+5IPLWSTSzH6Rd0YQFkRMKNIqbqh2kNOFqyNlq8vXCL/7f
	 tvo8TYp+NjAgkQRhlH53poacUNUK2v+qRiNEKins7nvM6buZ/xdxbyAx0xJyehJpoCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421899;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:MIME-Version:Content-Type:Content-Disposition;
	bh=Z3QttmCelU4fh+RHdrJMM1o3nxRY1YISOypB/Kw5PIU=;
	b=HnRnBJ3wWEim8ezVuS/8aNvjMChq0KjXfRWjSyMGlFXTzJhYBQgVN/2XEpFmi3n2xxPp
	 x69k784rmQJDvq04XibCo5cXOOIWFBBsdIMbWd5Hv/ZK8PnxZsQ/fWNMAnnfVbcCm14YC
	 CVQYxLdkT+2m5MlEMeRHlPyyLT2FhPwTOiezCD8EHJdOcivsulfReh/bOvxJ0EJ1zxxVN
	 qWZ2gm+WD799kiQeeZeStDoBNwZHuqr8Aoty0WYuBJGyunGTOIJvnjVViJkaWFpOubibE
	 1DU1IkBlKS5TWxO2OUCCJEwjbKg4SNSqf6GVgFBZUZYVFr2fQMAycOSmhtJkGFJtqcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EiJxPAMP;
	arc=none smtp.remote-ip=91.218.175.64
Received: from mta0.migadu.com (out-64.mta0.migadu.com [91.218.175.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC64B606A31E
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC64B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=EiJxPAMP
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Kl7BLUrMrW5GdgYLUZN6g2j9PF1ge3efMGDYYuBtK3w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795421896; v=1; x=1796026696;
 b=EiJxPAMPmUTcXbCTVFF0TSr6RySGowbPhtRM8APPwzdo4MBmUS29hy9k0FSjZOUdjQGIHng+
 jdP7+3CrSuQaD6NmU4cnrOaaxnxuxjuwmDLbwyeC0kflYRA7zHv8eyID8nXvE+HcSwHX2K8EhHJ
 TPkzFoCUhaYDUeUDSorG3Jus=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 94410b9f1b958063;
	Mon, 23 Nov 2026 08:18:16 +0000
X-Mizu-Trace-ID: 94410b9f1b958063
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 10:17:58 +0200
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Salih Erim <salih.erim@amd.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Support ROHM BD79111 ADC/GPIO
Message-ID: <cover.1795421473.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a02bTfSpJ7pb+bT2"
Content-Disposition: inline

--a02bTfSpJ7pb+bT2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Support ROHM BD79111 ADC/GPIO

The ROHM BD79111 is a 12-bit, 16 channel SAR ADC / GPIO IC. Or, a "Signal
Monitor Hub IC" as data-sheet describes it. The key difference compared
to already supported BD79112 is the reduced number of channels (16,
BD79112 had 32) and halved sampling rate (500 KSPS when BD79112
data-sheet stated 1 MSPS).

Revision history:
 v2 =3D> v3:
  dt-bindings:
   - No changes
  driver:
   - move 'Return -ENODATA instead of -ENODEV when no SPI match data is
   found' -fix to the patch 2/3, which introduces the SPI match data
   usage.
   - Fix double semicolon and drop the unused macro.
   - Suffle comment wording as was requested by Andy.
 v1 =3D> v2:
  dt-bindings:
   - Don't drop the 'root-level' additionalProperties: false
  driver + Kconfig:
   - Styling as suggested by Andy / Jonathan
   - Split to two patches as suggested by Andy
   - Return -ENODATA instead of -ENODEV when no SPI match data is found

Matti Vaittinen (3):
  dt-bindings: iio: Support ROHM BD79111
  iio: adc: rohm-bd79112: Add chip info structure
  iio: adc: rohm-bd79112: Support ROHM BD79111

 .../bindings/iio/adc/rohm,bd79112.yaml        |  29 ++++-
 drivers/iio/adc/Kconfig                       |  10 +-
 drivers/iio/adc/rohm-bd79112.c                | 112 ++++++++++++++----
 3 files changed, 120 insertions(+), 31 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
--=20
2.56.1


--a02bTfSpJ7pb+bT2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmsD9rQACgkQeFA3/03a
ocUowwgAgkfw2swuzUe9ERFyOXwKz5reM4OGlRzFGjsiuBs/B9jrvmq6ecN5NiCb
oFL1sgNc+cFF9kA0ajmAV+Jvt73wE1sIb6oYqKxHMCeNyGxtUfnt1Dnl87EcvTCp
m77PYVP8/B0o0JKXhtU+oSTCUihWYwmCZhohDzYyZKXxnvPT44knpJN6V4D1sy4C
gD9bpdrrmhWkwXv/kZPOc1f2B4F91vfgaH7GJVNyEEUJtAQ5SxAHgpjuETezT7aC
oIW8BEvk+HxDkik09apW6ueIdCbJR73yN7D7M5+MMUWdcppK2oNJTJzN++2plUPr
7FmxC7vD76xr8pECVsSJPk35s7N7Vw==
=bNMM
-----END PGP SIGNATURE-----

--a02bTfSpJ7pb+bT2--
