Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1DA385539
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 07:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786348463; cv=none; b=U0B/9zpof/epb+/UboDUwABDmod5qdkbWP464bsfU2H5DmQUgUSNtwU8wQat0IIWYzFyrfuKMqUayEv6XQAXswMFB8rm3K0OJRa98+W5CTzyI+vSE4JzfXChEqcvaAmP+fcPZwSYS8B0u4z4xk7lX6HNECWcgMOYbBOcDobR8Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786348463; c=relaxed/simple;
	bh=mlqr9GcX2IDi1zaW8m2/E9Nxt7miAYZhD24amXdb1MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7WVdlf2FwtyH4by9lDHZBr4At9tbgm8L3IdEGN5Q+u8Y6s01yKlhUOiTnbf9Lj8dA9vr7Pf7bEu12Kcl2GyP39MoH60wq9C4bg7EPt7nkDKAQ8DWB37sS77mwpdRwid7p8EDR8Ws7bxjMpJd1Sx1aiTEo6VuqzVd+B7wtyK1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JFu9ejSQ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JFu9ejSQ"
Date: Mon, 10 Aug 2026 10:54:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786348458; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=Zpjf0DAE++YUbowsbux4tZWqdckIRO+0LNKEgxNzkqg=;
	b=JFu9ejSQKZICiPjiGOfkszUXD6foCmwVCd+qSwYjjYz8jex2kNokJ5zQBZ4BGOiZhh6PLt
	ZLZl1D4POAGSlrZsaQCWHE6OCAsqihi6J6IyPgBKkl+0woLGSD7oErEsXEUIhvu3uuYZXg
	l3Pnlp3KgkE7kFBLCyt3jmU84HkdRDI=
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
Subject: [PATCH 09/12] iio: light: rohm-bu27034: Fix infinite delay on error
Message-ID: <2601f407f145ea77733280fd1e2370dcdb4b69e2.1786347811.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1786347811.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ub1i837GTMXb8Q0F"
Content-Disposition: inline
In-Reply-To: <cover.1786347811.git.mazziesaccount@gmail.com>
X-Migadu-Flow: FLOW_OUT

--Ub1i837GTMXb8Q0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

When reading an integration-time fails, the code will use error code to
compute the sleep time.

Fix this by using the smallest integration time as a default if
reading fails.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
---
 drivers/iio/light/rohm-bu27034.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index f9a421618406..e6efb8adfe37 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -137,6 +137,7 @@ static const struct iio_gain_sel_pair bu27034_gains[] =
=3D {
 #define BU27034_MEAS_MODE_200MS		2
 #define BU27034_MEAS_MODE_400MS		4
=20
+#define BU27034_INT_TIME_MIN 55000
 static const struct iio_itime_sel_mul bu27034_itimes[] =3D {
 	GAIN_SCALE_ITIME_US(400000, BU27034_MEAS_MODE_400MS, 8),
 	GAIN_SCALE_ITIME_US(200000, BU27034_MEAS_MODE_200MS, 4),
@@ -1162,6 +1163,15 @@ static int bu27034_buffer_thread(void *arg)
 	data =3D iio_priv(idev);
=20
 	wait_ms =3D bu27034_get_int_time(data);
+
+	/*
+	 * If reading the integration time fails, default to the minimum so we
+	 * don't lose samples. This may waste CPU cycles, but as a hardening
+	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
+	 */
+	if (wait_ms < 0)
+		wait_ms =3D BU27034_INT_TIME_MIN;
+
 	wait_ms /=3D 1000;
=20
 	wait_ms -=3D BU27034_MEAS_WAIT_PREMATURE_MS;
--=20
2.55.0


--Ub1i837GTMXb8Q0F
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmp5g5wACgkQeFA3/03a
ocV6lAf8CsxDR7p0x59qYkztZdv4XB5fjIByeTS9+dMEIU0alQV+cchhDyLT3mNJ
JMjJdv+ceGnAIycts2Wtn4E3Nw8kqVa/c4xVIPovWHIU3wbsRNf5imehcWRTccX6
h63/tLSLnNR0098MOKJ8EtuqX3gEf6C7PWWJLM9OdgYvZgrZP0O/UYXH7a53yufV
+RPZazIRCzjWuvl/ybk1zm60NhQ11vptIyLOegyZ3ASfxRqQNxvoOI7dOEF11Ai4
LMD4UVsqu5szvQVlv3eagOKTw0olCpq1/DSir5McIs167ClNO9eaqpi4EKK8nL13
4zH2nM0pXUp9kgnK28Q9vZOgRGy0EA==
=3sDS
-----END PGP SIGNATURE-----

--Ub1i837GTMXb8Q0F--
