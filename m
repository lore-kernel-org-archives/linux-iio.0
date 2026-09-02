Received: from mta1.migadu.com (out-102.mta1.migadu.com [95.215.58.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5FE3E7150
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338938; cv=none; b=bjujze9ch14fFkV4Tr05B1uQE+QbX9KylzFAnwRkcARQ1+rhgBocb+dTsjAkKcICeQ+SmKbJ9olSWxX7a1xEloE/GpeD9iWw0v0Q8RLSKLRKOerUDC+657/MEcEGZAxithxCQ37n1xEF3yKf17VYtGWRRxMjhVlex+eltlf5rNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338938; c=relaxed/simple;
	bh=QXx9mFoUJC8ulhUiCe0BLwO8FCobVwePgiwThut3sT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScHyKQPefkYd270QrB2NJgx+GaimbY9Aa0A2Xgt5EDVmko+M/2fwNB9SdD1R4PkaLbbJVbjyUr80Oj0+TnT988ExAo/cWPtiLDpNV63od7W2mh3paiUiF5NDY7MmOOPwslsFPLjtEQayG6RnrbrLhavZhnCK8/SLaqA1tcaOdLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ENPvW02t; arc=none smtp.client-ip=95.215.58.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ENPvW02t"
X-Envelope-To: linux-iio@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QXx9mFoUJC8ulhUiCe0BLwO8FCobVwePgiwThut3sT0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788338934; v=1; x=1788943734;
 b=ENPvW02tKLM4gGwS9TAuxocHzREJNJSI7pFTATOTWW7LSpmqRBWZrx//PdwqrMFSRcF4rk62
 UH/xG9Aslm26WV4KiieicPdsSe9sV3hTe0mN1EC76UUrsncqTuqYAnaISvyla3/5k7SkkOA2QDS
 GygpCKNZ/VHJik4OAQNMG8eM=
X-Envelope-To: linux-iio@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id f91dbd0a606b14d3;
	Wed, 02 Sep 2026 08:48:54 +0000
X-Mizu-Trace-ID: f91dbd0a606b14d3
X-Migadu-Flow: FLOW_OUT
Date: Wed, 2 Sep 2026 11:48:46 +0300
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
Subject: [PATCH v3 1/3] iio: light: rohm-bu27034: Fix infinite delay on error
Message-ID: <c8a41d775b7b83c87bd58cc7ea3e4a88160d2d2d.1788336588.git.mazziesaccount@gmail.com>
Reply-To: Matti Vaittinen <mazziesaccount@gmail.com>
References: <cover.1788336588.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n2rkCrTUGVjlzaNU"
Content-Disposition: inline
In-Reply-To: <cover.1788336588.git.mazziesaccount@gmail.com>

--n2rkCrTUGVjlzaNU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Matti Vaittinen <mazziesaccount@gmail.com>

When reading an integration-time fails, the code will use error code to
compute the sleep time.

Fix this by using the smallest integration time as a default if
reading fails.

Fixes: e52afbd61039 ("iio: light: ROHM BU27034 Ambient Light Sensor")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

---

I am not happy how intrusive this patch is for a fix. I really believe
what I suggested in discussion:

wait_ms =3D bu27034_get_int_time(data) / USEC_PER_MSEC;
if (wait_ms < BU27034_INT_TIME_MIN_MS)
                 wait_ms =3D BU27034_INT_TIME_MIN_MS;

https://lore.kernel.org/all/5d274bfb-2570-4336-af16-60640550e6c9@gmail.com/

would be better as a fix. Well, if this is what reviewers prefer, then I
can live with it.

Revision history:
v2 =3D> v3:
 - Changed the signature of the measurement time getter as suggested by
   Jonathan.
v1 =3D> v2:
 - Moved Fixes before SOB
 - Clarified units for the smallest integration time as suggested by Andy
---
 drivers/iio/light/rohm-bu27034.c | 60 +++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/light/rohm-bu27034.c b/drivers/iio/light/rohm-bu27=
034.c
index 28d111ac8c0a..9c7c7e118cbb 100644
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
@@ -296,7 +297,7 @@ static int bu27034_get_gain(struct bu27034_data *data, =
int chan, int *gain)
 	return 0;
 }
=20
-static int bu27034_get_int_time(struct bu27034_data *data)
+static int bu27034_get_int_time(struct bu27034_data *data, int *itime)
 {
 	int ret, sel;
=20
@@ -304,24 +305,30 @@ static int bu27034_get_int_time(struct bu27034_data *=
data)
 	if (ret)
 		return ret;
=20
-	return iio_gts_find_int_time_by_sel(&data->gts,
-					    sel & BU27034_MASK_MEAS_MODE);
+	ret =3D iio_gts_find_int_time_by_sel(&data->gts,
+					   sel & BU27034_MASK_MEAS_MODE);
+	if (ret < 0)
+		return ret;
+
+	*itime =3D ret;
+
+	return 0;
 }
=20
 static int _bu27034_get_scale(struct bu27034_data *data, int channel, int =
*val,
 			      int *val2)
 {
-	int gain, ret;
+	int gain, itime, ret;
=20
 	ret =3D bu27034_get_gain(data, channel, &gain);
 	if (ret)
 		return ret;
=20
-	ret =3D bu27034_get_int_time(data);
-	if (ret < 0)
+	ret =3D bu27034_get_int_time(data, &itime);
+	if (ret)
 		return ret;
=20
-	return iio_gts_get_scale(&data->gts, gain, ret, val, val2);
+	return iio_gts_get_scale(&data->gts, gain, itime, val, val2);
 }
=20
 static int bu27034_get_scale(struct bu27034_data *data, int channel, int *=
val,
@@ -397,12 +404,10 @@ static int bu27034_try_set_int_time(struct bu27034_da=
ta *data, int time_us)
 	int ret, int_time_old, i;
=20
 	guard(mutex)(&data->mutex);
-	ret =3D bu27034_get_int_time(data);
-	if (ret < 0)
+	ret =3D bu27034_get_int_time(data, &int_time_old);
+	if (ret)
 		return ret;
=20
-	int_time_old =3D ret;
-
 	if (!iio_gts_valid_time(&data->gts, time_us)) {
 		dev_err(data->dev, "Unsupported integration time %u\n",
 			time_us);
@@ -841,7 +846,7 @@ static int bu27034_meas_set(struct bu27034_data *data, =
bool en)
 static int bu27034_get_single_result(struct bu27034_data *data, int chan,
 				     int *val)
 {
-	int ret;
+	int ret, itime;
=20
 	if (chan < BU27034_CHAN_DATA0 || chan > BU27034_CHAN_DATA1)
 		return -EINVAL;
@@ -850,11 +855,11 @@ static int bu27034_get_single_result(struct bu27034_d=
ata *data, int chan,
 	if (ret)
 		return ret;
=20
-	ret =3D bu27034_get_int_time(data);
-	if (ret < 0)
+	ret =3D bu27034_get_int_time(data, &itime);
+	if (ret)
 		return ret;
=20
-	msleep(ret / 1000);
+	msleep(itime / 1000);
=20
 	return bu27034_read_result(data, chan, val);
 }
@@ -904,12 +909,10 @@ static int bu27034_calc_mlux(struct bu27034_data *dat=
a, __le16 *res, int *val)
 	if (ret)
 		return ret;
=20
-	ret =3D bu27034_get_int_time(data);
-	if (ret < 0)
+	ret =3D bu27034_get_int_time(data, &meastime);
+	if (ret)
 		return ret;
=20
-	meastime =3D ret;
-
 	d1_d0_ratio_scaled =3D (unsigned int)ch1 * (unsigned int)gain0 * 100;
 	helper64 =3D (u64)ch1 * (u64)gain0 * 100LLU;
=20
@@ -970,9 +973,9 @@ static int bu27034_read_raw(struct iio_dev *idev,
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
 		*val =3D 0;
-		*val2 =3D bu27034_get_int_time(data);
-		if (*val2 < 0)
-			return *val2;
+		ret =3D bu27034_get_int_time(data, val2);
+		if (ret)
+			return ret;
=20
 		return IIO_VAL_INT_PLUS_MICRO;
=20
@@ -1157,11 +1160,20 @@ static int bu27034_buffer_thread(void *arg)
 {
 	struct iio_dev *idev =3D arg;
 	struct bu27034_data *data;
-	int wait_ms;
+	int wait_ms, ret;
=20
 	data =3D iio_priv(idev);
=20
-	wait_ms =3D bu27034_get_int_time(data);
+	/*
+	 * If reading the integration time fails, default to the minimum so we
+	 * don't lose samples. This may waste CPU cycles, but as a hardening
+	 * against theoretical, once-in-a-blue-moon error, this should be Ok.
+	 */
+	wait_ms =3D BU27034_INT_TIME_US_MIN;
+	ret =3D bu27034_get_int_time(data, &wait_ms);
+	if (ret)
+		dev_warn(data->dev, "Failed to get integration time\n");
+
 	wait_ms /=3D 1000;
=20
 	wait_ms -=3D BU27034_MEAS_WAIT_PREMATURE_MS;
--=20
2.55.0


--n2rkCrTUGVjlzaNU
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmqX4u4ACgkQeFA3/03a
ocXsjgf+NZlr0Jj9ZksqzZVh+Y7R9Z7S9rVpb51l3d2Eap7SEQ8EsUmw85hQBgXa
n+RnmPdzzS+z9XNofh1YcZ7H+yTnZipgLt80OlLj108YGhFFh1dGT7DaYAENvaLy
q62ckLmULqbtCAVk5/oX1PckanhOz0eafYNMaio0fHjSQL7CLN15kVhgICAAXKBZ
FwNNnIScYPzYcDo8Z4g7gUgtF/Wc4gv0bDo3hT6lNPaFhT6YjHt9f/SyZN0g5l2R
ZOMMFKAy3+PB8pE3Fs9owxZLyKSd/mAJsbUisvmYBongKhZX+Yq8lEqhq63rRJAd
2qRPHqkIuOFZII0aGrOyqlsMEPTnVg==
=Uprp
-----END PGP SIGNATURE-----

--n2rkCrTUGVjlzaNU--
