Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E404FD7AA
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015506; cv=none; b=SrjIL9y+Y2rbZVggbMyfPmOrZLoHvhADV2SVnJtKU7Ex4TKVb2VVKqYgek/UOxp5Y1liuepEQG42m1QQzHQZQK1XR+ln416doQ9RE9fSWTMScMVc9FHCmi8erlAigxbH7AhJR7pRumW0I3kYqjsyGk7TUu9xbFwL7Hz8h5tIEXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015506; c=relaxed/simple;
	bh=M8fIINHnIxZB6qEGrsAABH8P+wRPzJ0kqqIWTT4CBow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgE4nwIU4cm+3x4JsEKGydx4KXdGO/K6OynlK+DCU7GLIga28CCOZu7m6hhLi7KS/XuXT7mEvAz7aI8JwJ4BcuVTtUtjs3DtIWomcTEpoa2QyWsEi4L2HbtFb5f35vbEbHTNOiQKuZUFi66N3HL6lvMwG0GgPAuE2C/Xn3KHMiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iYMAXGOW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iYMAXGOW"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a5a0703ae7so1391441fa.0
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015503; x=1790620303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ceWGBhcz2v2+A70YlsGrXNu+jmKzqHeUxRvhPX+bxg=;
        b=iYMAXGOWOQdmd0Z/Gtjdd6t3XcDgjiUn1kLCZNgALI9r5nvem/coZXPFrHoCdwoNnz
         TQWSqQD493hHVA4/AQp+qlXsdfD6w2/ydMzeK90i7ZAKGYmEHepU4GbuUXL8XVM24NcI
         XeOWjOhjYJNl35i3mJ9I+CBqWT90jlnRs/ZaZRBJEOKut0fMtZAyv+bLHoO8JwzvWjY/
         XhSB9FUIJ74QtS41w9zDYPbOr7LFmynyQfymCaSKIhCG4VGuiFiVMLzWylGtUiT4RFF+
         as0QIGzImM2DIUIOvujPJiKIuDBEmhk102seXfbo9CCL51z0eb1omGtNpjadtnizhFbO
         W4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015503; x=1790620303;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ceWGBhcz2v2+A70YlsGrXNu+jmKzqHeUxRvhPX+bxg=;
        b=UotWy9QTvV8sdRc64ef3Q+cGc8RbQ1cFRIs43M9cnarOgpxzSpGRuZ759HRDktOIvS
         1TshDKoYzk/QwPLWsxIhwBF9m3dSFNiqW1C3t9+8H3ozMnIXw09HUy2O7PBvPhayuysr
         1F/zOdx7CFNizcizP13Ec4jjJYoK0kGcJasEdurB0iITpU0MVPxu1Ft2r8ls5oN8I/2/
         lzO871bh7nIYNywHJXYaC+b1bTKevRgnPNZGtUOP+FftPm5VVTvqZ/OZXn+xG7c3saQK
         DHtwxsGdnRBJ5u9yHBhMqylTS+laNDctYyCX/cDLyL3pngcLBbvP3q0SajNfaVI+4ndg
         NCxQ==
X-Gm-Message-State: AFuF++nFn4vQT7rZ73Ykou2EUhK14/TA9urlIuBrcPk1pttpX6olKSBQ
	tGodsjEtCsMBYnczzkXUzCkYrXAaWdvCxfa4hqfm1VP/Vrme8qpFI28/
X-Gm-Gg: AYBFou2nE4RCj93PyCi4q7K88Lnc00kpJjEPM7hr/nUJLDDjjex0FCVwb04coOIHM7i
	O/j+RZfCG7MEQgZEp4tLqjINka1ws0cs5t9BcrVgoBE9GgVTcB5kj2myYqXcitIPaLIWolAKQvp
	iXitsLblKf4aJl5HdJ0zO0Y+pI3ksq4VLAcds2cagIcy4tjbWQMgourX0nAN8DMnyxhibERXYyt
	bO7fNse8fK1HnBtYJivGNsfx7pSw/q1tww6oFUDb85I3+L6jWy2PS8tA5yYcy8vytUi0SNEFpp0
	+Puc/jMIXDnL2IOyG9tdMvkVWa7+Vc5OR85ytIB3lpfnp6pyB46sP6iOtf7go0T6x2FhvI581JE
	q8xhQLbXs2YiPh+jnAsuMIW+zh7khFNRRFoEr8m7uGp0Wzsk0KpQxvca6u+DxcFags6fy2tkszM
	OwTDudR1W7y4yXDZ3pDh6tRMF64K3lGdigsj8QEr+prYE55rSDPo9BpzUXzpz48kFDXDa2l0ox+
	dsURxlKgrCQEP6Q/vVsROKSSzzkUSQ+8Bx9p0W/9AWiPQeCY87JFV0rRKzwJYaGKqzDTA==
X-Received: by 2002:a05:651c:198d:b0:3a4:68f1:8bee with SMTP id 38308e7fff4ca-3a624cb3235mr1051791fa.6.1790015502607;
        Mon, 21 Sep 2026 11:31:42 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:41 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v8 04/10] iio: pressure: dps310: take the lock once per raw read
Date: Mon, 21 Sep 2026 21:31:26 +0300
Message-ID: <20260921183132.233136-5-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A processed pressure read takes the lock twice: once in the raw read,
then again when dps310_calculate_pressure() trylocks to refresh the
temperature. The refresh is skipped whenever the lock is busy.

Split the raw reads into variants that expect the lock held and give each
channel a helper that takes it once for the whole sequence, so the
temperature refresh is unconditional. Buffered capture later in this
series needs the same shape.

Mark the functions that need the lock with __must_hold() rather than a
comment, and include cleanup.h, which ACQUIRE() needs and was coming in
transitively.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 143 ++++++++++++++++++----------------
 1 file changed, 77 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index e7f173e08e01..8cefca928077 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -14,6 +14,7 @@
  *  - Optionally support the FIFO
  */
 
+#include <linux/cleanup.h>
 #include <linux/i2c.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
@@ -287,8 +288,8 @@ static int dps310_get_temp_precision(struct dps310_data *data, int *val)
 	return 0;
 }
 
-/* Called with lock held */
 static int dps310_set_pres_precision(struct dps310_data *data, int val)
+	__must_hold(&data->lock)
 {
 	int rc;
 	u8 shift_en;
@@ -306,8 +307,8 @@ static int dps310_set_pres_precision(struct dps310_data *data, int val)
 				  DPS310_PRS_PRC_BITS, ilog2(val));
 }
 
-/* Called with lock held */
 static int dps310_set_temp_precision(struct dps310_data *data, int val)
+	__must_hold(&data->lock)
 {
 	int rc;
 	u8 shift_en;
@@ -325,8 +326,8 @@ static int dps310_set_temp_precision(struct dps310_data *data, int val)
 				  DPS310_TMP_PRC_BITS, ilog2(val));
 }
 
-/* Called with lock held */
 static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
+	__must_hold(&data->lock)
 {
 	u8 val;
 
@@ -339,8 +340,8 @@ static int dps310_set_pres_samp_freq(struct dps310_data *data, int freq)
 				  DPS310_PRS_RATE_BITS, val);
 }
 
-/* Called with lock held */
 static int dps310_set_temp_samp_freq(struct dps310_data *data, int freq)
+	__must_hold(&data->lock)
 {
 	u8 val;
 
@@ -439,6 +440,7 @@ static int dps310_ready_status(struct dps310_data *data, int ready_bit, int time
 }
 
 static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
+	__must_hold(&data->lock)
 {
 	int rc;
 
@@ -464,40 +466,36 @@ static int dps310_ready(struct dps310_data *data, int ready_bit, int timeout)
 	return 0;
 }
 
-static int dps310_read_pres_raw(struct dps310_data *data)
+static int dps310_read_pres_raw_locked(struct dps310_data *data)
+	__must_hold(&data->lock)
 {
 	int rc;
 	int rate;
 	int timeout;
 	u8 val[3];
 
-	if (mutex_lock_interruptible(&data->lock))
-		return -EINTR;
-
 	rc = dps310_get_pres_samp_freq(data, &rate);
 	if (rc)
-		goto done;
+		return rc;
 
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
 	rc = dps310_ready(data, DPS310_PRS_RDY, timeout);
 	if (rc)
-		goto done;
+		return rc;
 
 	rc = regmap_bulk_read(data->regmap, DPS310_PRS_BASE, val, sizeof(val));
 	if (rc < 0)
-		goto done;
+		return rc;
 
 	data->pressure_raw = sign_extend32(get_unaligned_be24(val), 23);
 
-done:
-	mutex_unlock(&data->lock);
-	return rc;
+	return 0;
 }
 
-/* Called with lock held */
 static int dps310_read_temp_ready(struct dps310_data *data)
+	__must_hold(&data->lock)
 {
 	int rc;
 	u8 val[3];
@@ -511,31 +509,40 @@ static int dps310_read_temp_ready(struct dps310_data *data)
 	return 0;
 }
 
-static int dps310_read_temp_raw(struct dps310_data *data)
+static int dps310_read_temp_raw_locked(struct dps310_data *data)
+	__must_hold(&data->lock)
 {
 	int rc;
 	int rate;
 	int timeout;
 
-	if (mutex_lock_interruptible(&data->lock))
-		return -EINTR;
-
 	rc = dps310_get_temp_samp_freq(data, &rate);
 	if (rc)
-		goto done;
+		return rc;
 
 	timeout = DPS310_POLL_TIMEOUT_US(rate);
 
 	/* Poll for sensor readiness; base the timeout upon the sample rate. */
 	rc = dps310_ready(data, DPS310_TMP_RDY, timeout);
 	if (rc)
-		goto done;
+		return rc;
+
+	return dps310_read_temp_ready(data);
+}
+
+/* Best effort: on error the previous temperature stands */
+static void dps310_refresh_temp_locked(struct dps310_data *data)
+	__must_hold(&data->lock)
+{
+	int rc;
+	int t_ready;
 
-	rc = dps310_read_temp_ready(data);
+	rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
+	if (rc)
+		return;
 
-done:
-	mutex_unlock(&data->lock);
-	return rc;
+	if (t_ready & DPS310_TMP_RDY)
+		dps310_read_temp_ready(data);
 }
 
 static bool dps310_is_writeable_reg(struct device *dev, unsigned int reg)
@@ -577,59 +584,47 @@ static int dps310_write_raw(struct iio_dev *iio,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long mask)
 {
-	int rc;
 	struct dps310_data *data = iio_priv(iio);
 
-	if (mutex_lock_interruptible(&data->lock))
+	ACQUIRE(mutex_intr, lock)(&data->lock);
+	if (ACQUIRE_ERR(mutex_intr, &lock))
 		return -EINTR;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		switch (chan->type) {
 		case IIO_PRESSURE:
-			rc = dps310_set_pres_samp_freq(data, val);
-			break;
+			return dps310_set_pres_samp_freq(data, val);
 
 		case IIO_TEMP:
-			rc = dps310_set_temp_samp_freq(data, val);
-			break;
+			return dps310_set_temp_samp_freq(data, val);
 
 		default:
-			rc = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->type) {
 		case IIO_PRESSURE:
-			rc = dps310_set_pres_precision(data, val);
-			break;
+			return dps310_set_pres_precision(data, val);
 
 		case IIO_TEMP:
-			rc = dps310_set_temp_precision(data, val);
-			break;
+			return dps310_set_temp_precision(data, val);
 
 		default:
-			rc = -EINVAL;
-			break;
+			return -EINVAL;
 		}
-		break;
 
 	default:
-		rc = -EINVAL;
-		break;
+		return -EINVAL;
 	}
-
-	mutex_unlock(&data->lock);
-	return rc;
 }
 
 static int dps310_calculate_pressure(struct dps310_data *data, int *val)
+	__must_hold(&data->lock)
 {
 	int i;
 	int rc;
-	int t_ready;
 	int kpi;
 	int kti;
 	s64 rem = 0ULL;
@@ -653,15 +648,6 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	kp = (s64)kpi;
 	kt = (s64)kti;
 
-	/* Refresh temp if it's ready, otherwise just use the latest value */
-	if (mutex_trylock(&data->lock)) {
-		rc = regmap_read(data->regmap, DPS310_MEAS_CFG, &t_ready);
-		if (rc >= 0 && t_ready & DPS310_TMP_RDY)
-			dps310_read_temp_ready(data);
-
-		mutex_unlock(&data->lock);
-	}
-
 	p = (s64)data->pressure_raw;
 	t = (s64)data->temp_raw;
 
@@ -707,6 +693,23 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	return 0;
 }
 
+static int dps310_read_pressure_value(struct dps310_data *data, int *val)
+{
+	int rc;
+
+	ACQUIRE(mutex_intr, lock)(&data->lock);
+	if (ACQUIRE_ERR(mutex_intr, &lock))
+		return -EINTR;
+
+	rc = dps310_read_pres_raw_locked(data);
+	if (rc)
+		return rc;
+
+	dps310_refresh_temp_locked(data);
+
+	return dps310_calculate_pressure(data, val);
+}
+
 static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 				long mask)
 {
@@ -721,11 +724,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
-		rc = dps310_read_pres_raw(data);
-		if (rc)
-			return rc;
-
-		rc = dps310_calculate_pressure(data, val);
+		rc = dps310_read_pressure_value(data, val);
 		if (rc)
 			return rc;
 
@@ -744,6 +743,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 }
 
 static int dps310_calculate_temp(struct dps310_data *data, int *val)
+	__must_hold(&data->lock)
 {
 	s64 c0;
 	s64 t;
@@ -765,6 +765,21 @@ static int dps310_calculate_temp(struct dps310_data *data, int *val)
 	return 0;
 }
 
+static int dps310_read_temp_value(struct dps310_data *data, int *val)
+{
+	int rc;
+
+	ACQUIRE(mutex_intr, lock)(&data->lock);
+	if (ACQUIRE_ERR(mutex_intr, &lock))
+		return -EINTR;
+
+	rc = dps310_read_temp_raw_locked(data);
+	if (rc)
+		return rc;
+
+	return dps310_calculate_temp(data, val);
+}
+
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 			    long mask)
 {
@@ -779,11 +794,7 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_PROCESSED:
-		rc = dps310_read_temp_raw(data);
-		if (rc)
-			return rc;
-
-		rc = dps310_calculate_temp(data, val);
+		rc = dps310_read_temp_value(data, val);
 		if (rc)
 			return rc;
 
-- 
2.43.0

