Received: from mta1.migadu.com (out-59.mta1.migadu.com [95.215.58.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53813C1400
	for <linux-iio@vger.kernel.org>; Fri, 28 Aug 2026 07:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.59
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787902848; cv=none; b=aQMZiPwGBGMohTnAcwj9MPtlVx5Gsi+8ZFIYs32Dfui7oLb9gSxWeUtW0tQbu3i3e9LmEzfg3kGUxxwQ4JGUyxbhwF23oB+rMdy/9UpLDf5/oMNTLFo1elumo7d97RwgBY49j/TTynT91Bw+ktJ/Wl3MllLoVPTgIsI5caCq/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787902848; c=relaxed/simple;
	bh=CWanOnGG+UyjZ4ed1HNy/1QZ5KYEbVCpitfQSakJMhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmmAMRlvhmhhR913LZj6Te22Xl6HceFv5vwie3I0CcW8nrVgEm6BwIUpprdojE8zekSx9qUqJLoJ0APJW51HYqyS8+0T29bLkL8RYuLDKhTyPcrRifdt8Hu4f8EPSZ5yr/vfmSlZF9hKBGLKpdPuhG0wQ3+hzhINqalDWwgn5k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uI3TkJZc; arc=none smtp.client-ip=95.215.58.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uI3TkJZc"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CWanOnGG+UyjZ4ed1HNy/1QZ5KYEbVCpitfQSakJMhw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787902844; v=1; x=1788507644;
 b=uI3TkJZcR5HgbFgaXAES8+amdOkqZu7PjdIwVBSNfbm4LeqCzEIzNxct/kh7cnEqGlptZvse
 dvxJVn9TIxtja678znWWRR5JVJqU2RmuM/w1HOcaAMlq7YsfOdEJuSlhgx5+X9YMeZpJQJ1aVCN
 B39aG8OMBzsQ9JBsKEW0UiJ8=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 87aaefbaeb70aad9;
	Fri, 28 Aug 2026 07:40:44 +0000
X-Mizu-Trace-ID: 87aaefbaeb70aad9
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 10:40:36 +0300
From: Matti Vaittinen <matti.vaittinen@linux.dev>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Matti Vaittinen <matti.vaittinen@linux.dev>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mehdi Djait <mehdi.djait.k@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] iio: light: rohm-bu27034: Fix infinite delay on error
Message-ID: <7f0d8efb3578cd4f23a7c70fa4a8f7a967c9df8e.1787901813.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1787901813.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iPlJb4LuCnClPMEz"
Content-Disposition: inline
In-Reply-To: <cover.1787901813.git.mazziesaccount@gmail.com>

--iPlJb4LuCnClPMEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

When reading an integration-time fails, the code will use error code to
compute the sleep time.

Fix this by using the smallest integration time as a default if
reading fails.

Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---
Revision history:
v1 =3D> v2:
 - Moved Fixes before SOB
 - Clarified units for the smallest integration time as suggested by Andy
---
 drivers/iio/light/rohm-bu27034.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index f9a421618406..cb2afddc75f6 100644
--- a/drivers/iio/light/rohm-bu27034.c
+++ b/drivers/iio/light/rohm-bu27034.c
@@ -137,6 +137,7 @@ static const struct iio_gain_sel_pair bu27034_gains[] =
=3D {
 #define BU27034_MEAS_MODE_200MS		2
 #define BU27034_MEAS_MODE_400MS		4
=20
+#define BU27034_INT_TIME_US_MIN (55 * USEC_PER_MSEC)
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
+		wait_ms =3D BU27034_INT_TIME_US_MIN;
+
 	wait_ms /=3D 1000;
=20
 	wait_ms -=3D BU27034_MEAS_WAIT_PREMATURE_MS;
--=20
2.55.0


--iPlJb4LuCnClPMEz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqRO3QACgkQeFA3/03a
ocWprwgAuMW+8SNHkdRXkBD2VPg+Vc/UYBgwtxBoLA9zia1FuMgwyslAaLb42L67
O3tsgKScB0y6RZ2gIBFw+d0Jpd8/3vTrRa3ai12ueHzAbqUJu+EtXZnKFPRKCrJQ
pmcEFhwPaDeDdkuEMPmk+9gFE9CgZuKYbCc6tAZFQ1Y1MAjO9C4Y/SVHp7E+MH+3
FJlATNWkjaUc0Mb4XufFR8B+enfBliNt2Y0lyyHsNbWUy0+/4do5nDiWMN0JjVXh
F5xc5g/xYRTDBTjT4JkRv71tUpjFXzaZkHsLzXO2s3TBAbYksIkgvAmemR2PFbqS
rqX9OY7PdsnyDuFNHKuz0tZyT7ordQ==
=bbX1
-----END PGP SIGNATURE-----

--iPlJb4LuCnClPMEz--
