Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0474EB86D
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734330; cv=none; b=XBO2MK4uZO1xbiVVuo/ASr5ztiJs4aXc19Y/sLJcnDqL0v/j9RNuZ6U5Ea07C55hOHZykKLiTFmRPMb3rJ9ZUk4VixmftOOrNOJDIau3civFPzKfVXmryhcSiuSePoPJdWVpl1CdDcIdmv8UWbQtfTLBwL20FppuVcRXzsUvZa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734330; c=relaxed/simple;
	bh=M8fIINHnIxZB6qEGrsAABH8P+wRPzJ0kqqIWTT4CBow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNSWOO0FMt1fhWc+doJ9/AkkRsSnudLr+0UVPiUcrspIWVC86bPDGNvg4MIp67Lm4mvdpKln2AoHEp6vfMvCrxZgHMrXSYh9CYeQfWBtvj1sjBwUcECbmnm2U18aBHjPARH/UcIPsNekqPVZ6dqrpbkrXiapZNRiqhWDJxfom04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXq3XYTY; arc=none smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXq3XYTY"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1b846so818978e87.0
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734324; x=1790339124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ceWGBhcz2v2+A70YlsGrXNu+jmKzqHeUxRvhPX+bxg=;
        b=nXq3XYTY6s/x0zRbVUrohCt+ZHA8MISkmwS7N1dZ4s8cgzuM1SaTfyNqfe3UqpFvEJ
         hpuCE9T76vwZ+yTobtHCmt2YBUrROFq3N+ABYPBphztof8yUU79OQT7kMFPaty83lTyz
         z1MFe9hG9hWTeWHdB9zWyQE4L5NW2DugwM0RZHYwEIkKlU0LYHsPBcYW9nFhxd3+Tgbr
         11tQyulCoF46UxT+5VHrMn6j1GhowYuLXXk3LIkke9w5AuBImDs79XgIzuOa1RhZx/tR
         9XV83Z+zWrip5BSKlLnvoxuXnckt6UyV2UtNfe/E8oGqO9qPnH2WApGF2/KHpf6FZFcB
         94eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734324; x=1790339124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ceWGBhcz2v2+A70YlsGrXNu+jmKzqHeUxRvhPX+bxg=;
        b=j70Vajn68azH7YOIYGXgW7GvWwhTCVZp5OY8yO1wp/ZOJLcEYxRy9W7l83yjeiIKFk
         D4UyHu0sO/Wzqx/5/mCg5iSg9wrJ8m2oQhHsZBkUN9r+M66hYtmB41DDvRC6SRWr9fky
         GF2kKtuJJmLdMxV3rOSQnIw/O7kUdE4obrG2XunnntCR9/gv5yGWFhPxro3mLvkHjxPq
         Z9k+4PFnMJysO9gHQ1tFqAZzxAo9IU/2EUeQdTFmjHoXMfb6jd+RR/2x0CLK+R92qEl5
         xwhA5te0w9hWM5/FcILZh+oN/SyxnywGT5/DgtdzfWcL66EE+H+aTYiDYX9jR2aCClsj
         AYGg==
X-Gm-Message-State: AFuF++lEGbqQDuQgM94eqOc28+7wZDo+MpCdGo17erkglKSQubl6lPKF
	xC81CsR9NWk6sgTY/7KyBXytSYt0RTPv8CqAHeRH3ZLyhtm/VItuHj4k
X-Gm-Gg: AYBFou3vVFlXBB20KJzXpLwnV20JkH+BmBvVyBzetTLuZ5K3ozU+L4ZAvtqJSS/tAD3
	JCshnZ2nLQUGnkXsWQZLIBazAJ5YJEEXBIw2if7fqNnKq9ZnVBHfhoaS2B25jangFFkVV+cD0aR
	rRba+Nvhwi/zbAVYHsQRaLwYDa0ufDQtPjH4H8Orh1uDWS88hGqBK04AlqvZyNYxjpM0+/ZHE7K
	+7tNEblO4qqlIbwf/S2iErze9QWN38asHhR0h4xQy2c4VEnZH0SzMwkFI9WaCDYKzkDSjX4HqZg
	tbZmvD1FiMn+sIdtfImh4nAAXwX7bscGtU9WkSwnRMGFx0nmJ0qOBCywt4TmmsITMjQkxWF6KCn
	VZpemTQUBK5PyG7R1l4CfxHKSWfZBl4PGgoh8ArnTCnVSxJhq6gJmzePZoav4Y8QmBDgR8Z8V1r
	ErkSMyDhqzowA6w9PWQ/G/Hnm66/aEj4pn/nwRrRTHAu+qNl0iG91b6ifDxmb3t3lZbHfHQM65h
	z1NV2nKaAX/mTvXdzlVsO0tFdqPmmAS2dBpm1T4yIcBeHvNJ/pSoUV+ac86zct+hZ4FgQ==
X-Received: by 2002:ac2:5681:0:b0:5b6:1a7c:aa24 with SMTP id 2adb3069b0e04-5b8c1986428mr845036e87.60.1789734323440;
        Fri, 18 Sep 2026 05:25:23 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:22 -0700 (PDT)
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
Subject: [PATCH v7 04/10] iio: pressure: dps310: take the lock once per raw read
Date: Fri, 18 Sep 2026 15:25:11 +0300
Message-ID: <20260918122517.377565-5-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918122517.377565-1-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
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

