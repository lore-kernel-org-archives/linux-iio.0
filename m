Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718F2DCBE3
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 18:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779560891; cv=none; b=KWVPFZJbKmHF/ibilK3GMwf4MjrJXnuv9rotqfkRafMB1NtLjoVEOt/3tAopStlcsbCBmp9Dr/3DXfnzImXsB1xnEsXenHtAWsc1zNXL9pV5At0MOKjIwMSq/x64Me4lseY1eQDpxMnnQwCMUf94uS1ZClz5VCTBrB7Emcc2Wus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779560891; c=relaxed/simple;
	bh=nZaVnh/OlERIInqGCAv8xTshgr42sAt10OyrBuKWrOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QqsbxtvzFBL4pO9/0TsUjhQWCfq9S3ZVF3MKvhHmNsuaCeHRKCnh+yGqe22OFtsxVCgTiVOxtEg8ArtT72o+jsuuYWkg+5Y9DwqXIExKrw9mKaJHnzOM1rN9qX+/v3VjN4dvqbHd33b3ju43h8fq8jh58ihprJS97FMN+tTaHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QS/O7V1h; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QS/O7V1h"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5873983d19eso1614574e0c.2
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 11:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779560888; x=1780165688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=o498sRAJSIJ+FtL0naElfrtr5FUCGg3qCQLRHFME+8k=;
        b=QS/O7V1h8++xacZysZZOU+FRn7tLtW1fIWt8Qlfobli3b5KwBsmAOkNpZ3bW456Qc4
         UlPabp1X4fy/p5eM1YzuI455JJTK2mGPR/bfNdIVwOjMTlXHM+OJCW8XctovGT1M8t0A
         Ih9e/PiLrcaoDNZbF4oRdJIBJoDhhi/5cDaQ3iVSK52y/HuqysKI2BPiEbTUc3zJYXto
         HaycaasTrt4Ld2f2m7lhgR+eGuObZKwUdVOenVsAwRHHcVnq5Cd9BcFV04MeNN1mP7gK
         5ZuMgvxkbwIxN3+b1XMeBhnQwKA8Yg+y/pNabyeOlywT1Wnt0L/PSg9HjEq5v16awvn4
         +aKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779560888; x=1780165688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o498sRAJSIJ+FtL0naElfrtr5FUCGg3qCQLRHFME+8k=;
        b=U4kOuDiJ6bBESS4Gy9JYfBCVrzo3pVnqkv3msyhs364a0HM6/2vZNcE41plqXCNyW7
         fOBJ188p6XL43X3bGMashCx2Ml2uSXISXtEjI/CbNzf9phDh/YbvFHnkioIvYANtR77e
         kLE4l1I2K10KigndZeH6z6M/MlPmII5tWl2Xqm5pXRb6QPieuO1mcM8PrchhPyOrq806
         9hv8D6D0FjFBQ3dg2byPNgClpdT71G5oTzCvaG5YSnN6DCnHCqj81lrlou+CUIO7PEci
         dTN+RVGqXypqByUFo13+JFkagCGjdwfwDpHJWz/DaQ+jym0h6q7M16kcsYSBEM4k6qy5
         JUhw==
X-Forwarded-Encrypted: i=1; AFNElJ9896jY18qaCsxkOXnhQDCYbQpMKyRtuuWBY0KVXqipve0uaB5mDroNlSwQjs4K2zm/wnYv301RIjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9VXBAnSFuCtiB5CosWHKkuZIuat+j0jmdZCYkoQ0wcRhjJK4u
	oEIXzpMutqJIXtfOL/sxpgmgk1gx7RHpv93Th+VhwMiEF0W4ow3l+FMK
X-Gm-Gg: Acq92OHWXdCePitOq81UWCKMuLHjw8SzI4r29ep9/n4uaLQo9cX1ksD/Jig8Ss3OZtn
	myUzRMdlQDoFTgsE+FvAbSUQe4q7aRnZ9P4jzKSOpf8yCDSlazrU6u4qb/wyWsbHmkPIEq7XDmm
	Sh+VL4cvA0RlRSVDfOiXzqxFY1dQMUnJmDAH/Uiit0FVASfTLD+wOpXmWZXKRis+alJIB4Wv0yM
	ysq2SQbnXIs/uF/LBdlDrfM5y8/2BQ0YSEk2D658PyUCwRGxeLUV+uhLXOzvtlRCrXqCwwZ8XzO
	CU9w5Wnsk1MLk1yDqcMae9NrkfXSwwn/cdcEZv5d1RTbyp5IY1o0gn+EgIXNfG+xurJp21RMoDk
	fpltT1JGIPHFeQmxIqG6SdOBi4UP4u3AnWEJOSLAxxAlWN0RX+p3Wty/XFr9GUNusmpSyp34bZs
	5e5nrL523XbO8Y1pen6UzNW3Cwrkqhlw==
X-Received: by 2002:a05:6122:6608:b0:56c:d5cd:1e7c with SMTP id 71dfb90a1353d-5865fbfd0f5mr4771397e0c.5.1779560888452;
        Sat, 23 May 2026 11:28:08 -0700 (PDT)
Received: from i-use-arch-btw ([2600:1006:b017:e193:bca5:670c:e4c:71ed])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f25d708bsm6870334e0c.1.2026.05.23.11.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 11:28:08 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org,
	m32285159@gmail.com
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4] iio: chemical: scd30: Replace manual locking with RAII locking
Date: Sat, 23 May 2026 13:25:32 -0500
Message-ID: <20260523182531.10146-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scd30_core.c currently uses manual mutex_lock() and mutex_unlock()
calls. Replace them with the newer guard(mutex)() for cleaner RAII
patterns and to improve maintainability.

Add new helper function scd30_trigger_handler_helper_locked() containing
the critical section for scd30_trigger_handler(). After moving
scd30_trigger_handler()'s critical section into the new helper, tune up
control logic to return ret early and not memcpy() if it's an error
condition.

In addition, small refactor to replace "?:" operator with regular
if/else returns.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Fix callback issue as noted by Jonathan v1.
 - Refactor critical section of scd30_trigger_handler() into helper
   called scd30_trigger_handler_helper_locked().
 - Revert removal of goto in scd30_trigger_handler().

 v3:
 - Tune up helper to return early on failure condition per Jonathan's
   suggestion.

 v4:
 - Forgot to commit changes listed in v3, now fixed.

 drivers/iio/chemical/scd30_core.c | 68 ++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..8dbba9a7c426 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -368,11 +368,13 @@ static ssize_t calibration_auto_enable_show(struct device *dev, struct device_at
 	int ret;
 	u16 val;
 
-	mutex_lock(&state->lock);
-	ret = scd30_command_read(state, CMD_ASC, &val);
-	mutex_unlock(&state->lock);
+	guard(mutex)(&state->lock);
 
-	return ret ?: sysfs_emit(buf, "%d\n", val);
+	ret = scd30_command_read(state, CMD_ASC, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t calibration_auto_enable_store(struct device *dev, struct device_attribute *attr,
@@ -387,11 +389,13 @@ static ssize_t calibration_auto_enable_store(struct device *dev, struct device_a
 	if (ret)
 		return ret;
 
-	mutex_lock(&state->lock);
-	ret = scd30_command_write(state, CMD_ASC, val);
-	mutex_unlock(&state->lock);
+	guard(mutex)(&state->lock);
 
-	return ret ?: len;
+	ret = scd30_command_write(state, CMD_ASC, val);
+	if (ret)
+		return ret;
+
+	return len;
 }
 
 static ssize_t calibration_forced_value_show(struct device *dev, struct device_attribute *attr,
@@ -402,11 +406,13 @@ static ssize_t calibration_forced_value_show(struct device *dev, struct device_a
 	int ret;
 	u16 val;
 
-	mutex_lock(&state->lock);
-	ret = scd30_command_read(state, CMD_FRC, &val);
-	mutex_unlock(&state->lock);
+	guard(mutex)(&state->lock);
 
-	return ret ?: sysfs_emit(buf, "%d\n", val);
+	ret = scd30_command_read(state, CMD_FRC, &val);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t calibration_forced_value_store(struct device *dev, struct device_attribute *attr,
@@ -424,11 +430,13 @@ static ssize_t calibration_forced_value_store(struct device *dev, struct device_
 	if (val < SCD30_FRC_MIN_PPM || val > SCD30_FRC_MAX_PPM)
 		return -EINVAL;
 
-	mutex_lock(&state->lock);
-	ret = scd30_command_write(state, CMD_FRC, val);
-	mutex_unlock(&state->lock);
+	guard(mutex)(&state->lock);
 
-	return ret ?: len;
+	ret = scd30_command_write(state, CMD_FRC, val);
+	if (ret)
+		return ret;
+
+	return len;
 }
 
 static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
@@ -579,24 +587,36 @@ static irqreturn_t scd30_irq_thread_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+/* Meant ONLY for scd30_trigger_handler() */
+static int scd30_trigger_handler_helper_locked(struct iio_dev *indio_dev,
+					       int *scan_data, int arr_size)
+{
+	struct scd30_state *state = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&state->lock);
+
+	if (!iio_trigger_using_own(indio_dev))
+		ret = scd30_read_poll(state);
+	else
+		ret = scd30_read_meas(state);
+	if (ret)
+		return ret;
+	memcpy(scan_data, state->meas, arr_size);
+	return 0;
+}
+
 static irqreturn_t scd30_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct scd30_state *state = iio_priv(indio_dev);
 	struct {
 		int data[SCD30_MEAS_COUNT];
 		aligned_s64 ts;
 	} scan = { };
 	int ret;
 
-	mutex_lock(&state->lock);
-	if (!iio_trigger_using_own(indio_dev))
-		ret = scd30_read_poll(state);
-	else
-		ret = scd30_read_meas(state);
-	memcpy(scan.data, state->meas, sizeof(state->meas));
-	mutex_unlock(&state->lock);
+	ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
 	if (ret)
 		goto out;
 
-- 
2.54.0

