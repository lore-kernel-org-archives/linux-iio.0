Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D396C36F8E6
	for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 23:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270713; cv=none; b=kAfGlrfQcW48YuQP8+2/5xDNAc6oK/11T2AMfk5DCA14b0e9HUYIDVnka4G6qJhPKar8WOYh+8bKDyAuJIuMgPcKPU3VgS4FLK/xA1AK+z+FIeZBaGEJ8u+/ZzY+98dY+3+Okxo/5EZeew7+M9ad00EQFfITnR44Gc8QWCe9ly8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270713; c=relaxed/simple;
	bh=fHqWV19oXCqGlI2EOqsCE+EXN7lxHzkbjLo867QIYXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZFRjd1M9YXAD1X/h0SKzixe2FvXHlSQG0COtSAgeFBWAaKD6Ct7SicICaQRqf0Y2QJuFa61g9fTZcOumjqrAlc6pOThMnWav/m10EckkRQG4nE9Sufn/F4UTLcdS45p7Y7eOMAeRcnRIf4X3Gx8wKoI6nQOXwu+b4H2SEt0ajjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rpWnyU7Q; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rpWnyU7Q"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-43b7e186a0cso2772916fac.0
        for <linux-iio@vger.kernel.org>; Sun, 31 May 2026 16:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270711; x=1780875511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nm+7GU3hrgghSnIgUtxrQiiCv52jyBJtJqXGQt8PmoU=;
        b=rpWnyU7QBXU79PHFJfPJOO+LRyCkA14sYva+0bETgUA+HhicS+Cei2cXgpOY13X7ZV
         QZTwAVPxho/sFMvx/JlvYOi+zfb9hpwaDX4ILBYvFZyd2G2Okj+RxFjjVpiKIQmZoSSJ
         yIfemj5/J4xBzjwAN/d1bERwmB56r6whC8PQ4QtPLWYuYd+3tWuWqcVG3d9JTviT5rxV
         AZQZmLUcw69dtSaqydnQLDvGlgp3VV4LMgrcIeMIrUAtfhinnNAEmKzWDgLgWhw+RgEn
         y6TCmkxS1gUq1C91exkIBMOFA1Q44ITSMfDzix17CqKrrga8D8Yyj7ql3FwJcesbgmFh
         EnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270711; x=1780875511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm+7GU3hrgghSnIgUtxrQiiCv52jyBJtJqXGQt8PmoU=;
        b=FqSvxZaUEFuibuNem24/sXfmensYiqTywGuaDKCS+ZiuXht6PXlpxU/UsGVFw5ORBB
         t0ryHIEIiM9/x/zxzrIAgSru6VhfGYuWLnS0YdpeGFMWS+tmV62Fsvdj7DNyXJwgtGI+
         T6lR/r4B8I34ny82PDjYjFXdKcz/P57hpW0mxKIL+NuKBp5c+VjghQ0fj7IpL1Oivtfi
         k15rcgDpH+Lzb6dxJ2F0tq/oX3lCUx7IeKLI+DomAlG85a1hafzmGULITMyjE0zJoLao
         Wr0a7n61hyf4uvq9V44NWMmYPowSWsQPvYGsKYBvoSOHVnCjY8o4Yod4K3DVKkVJTPax
         TazQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Kjh8boPqQV0/AIwshFkxlDkZUJxHww0M2oXcLNI51bxHgxv9b0Oj1VAZZGCntQbqbS6JW1EatR58=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHLRVkZQkVpjYzJQ4aJ7Nxyiwoy4sflF7vElYjRRrQqaen35a2
	+y+OlXxg2QS6Qa9L0Giw3q1dFCkJc2O6B7r1HcqY8CGnrtmbLf2rqOqO
X-Gm-Gg: Acq92OEb+P9HQOlwuT6+sgjDNz1GtgnmBSR266CrZHXFV3hTbk/874r1OC9I/Ezov4Q
	L/45bH0p46O14Yn9Nwmuii2ma6rwwJEr+zeTQh97ttAlxEp7T5qXcXQruK1QSYwNw1zpo4JqU1c
	8ASTIXoorhcb7cxpc6iE2vJxAy3U6mD4ye/Po0axhie1D/J/U7HR859qfiI8N6euG8EzxkoZJH3
	rJ5hDCqEi66Tkz6zg1Dxg4LPRPtHC+pn9TFtp7n4ct4oAHj7Hpp3lh6bOXmtjxoOKF7BIPf+KQq
	WfE40oalI6kVLs+AMNYco3GJQkd9Mq3UXrjmxqGtgjnUAPaNyCQK/vUAtksprjokmUvA42anQow
	naeVHPcs6XRJLK+hwssIg3jxFGEHoVUBH5vKGHHU3aM9loxw8VppBFw0jV/Jvg/jczR59mbtMrd
	ekuYEKC9DPmu9bin0NpnUmYGqZou5J/0Di2thNCYCYQcOr5RyrYUW57DBpljO8ANsPEx2a
X-Received: by 2002:a05:6808:c18d:b0:47b:beb4:6c80 with SMTP id 5614622812f47-485fb2fe0bdmr4878023b6e.8.1780270710799;
        Sun, 31 May 2026 16:38:30 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48605f6a2c6sm3246866b6e.3.2026.05.31.16.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:38:30 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6] iio: chemical: scd30: Replace manual locking with RAII locking
Date: Sun, 31 May 2026 18:38:28 -0500
Message-ID: <20260531233828.60697-1-m32285159@gmail.com>
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

Add new helper function scd30_trigger_handler_helper() containing
the critical section for scd30_trigger_handler().

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

 v5:
  - Remove unneeded comment for scd30_trigger_handler_helper() per
    Jonathan's suggestion.
  - Change name of arr_size to scan_data_size per Jonathan's suggestion.
  - Change type of scan_data_size to size_t per Jonathan's suggestion.
  - Added blank line between return and the rest of the function body in
    scd30_trigger_handler_helper().

 v6:
  - Fix issue where names for scd30_trigger_handler_helper() did not
    match per Jonathan.

 drivers/iio/chemical/scd30_core.c | 66 ++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..3949c27b9a3e 100644
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
@@ -579,24 +587,34 @@ static irqreturn_t scd30_irq_thread_handler(int irq, void *priv)
 	return IRQ_HANDLED;
 }
 
+static int scd30_trigger_handler_helper(struct iio_dev *indio_dev, int *scan_data,
+					size_t scan_data_size)
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
+	memcpy(scan_data, state->meas, scan_data_size);
+
+	return ret;
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
+	ret = scd30_trigger_handler_helper(indio_dev, scan.data, sizeof(scan.data));
 	if (ret)
 		goto out;
 
-- 
2.54.0

