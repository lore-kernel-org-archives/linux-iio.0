Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23512369D55
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007351; cv=none; b=UBQvx55WzsHkdHuwcbYtGg5Ixs3Lx8CPDQBpy12jSrrPr2MSw2UcK1fgOytbSUHeFikNT8bZXCRcd9eFg9MLZZFRcuGOqWrUlOH5mIUG5kF+IGjyQxiZr4wqp/fV52ixucHFioT/IGkSAqAt8LVhsdJsR5UEMLeA7NCTbiL6MTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007351; c=relaxed/simple;
	bh=rDeyzMJXO979faPEvGKzUCydD+AKhDwrae9AxvYno3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qIGb4qSp40DzokSW7eHTKqmdsQlTqHXfp3HjbR7jmdGrpYZ40yKkPlBPhEY8e5UC7qwWJGoKFqXkyJ71YDaIcb2Yp93QkSBfJII3VPsBH83wA1KhTbbeFi3ZppF3C/9hvKqnLThfYqIIsj69SpxdFwh1v8LQxGSt+gQ8D57W6ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czSRccnV; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czSRccnV"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-914bf787977so520102385a.2
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 15:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780007348; x=1780612148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BF/CcGwAcMn3gialDwAGFBOUWdz2cgvE1Ykftev8rrA=;
        b=czSRccnVX11bueILtqn3/uV2SZ1kPYuVoYaj8Ho2iVZBHmh0fbreFn1TF8SgkiL/lJ
         OIOlO88BU4oxwWb+kFUGCs1tfq7jmV1kxM3/jnSZtSNbX2Kzl6pnz7osigtCCRTJs2BR
         4AJLpoEEfRqfQz89hnv1ZUUKHMwQIREkb9hhMY7+5dsuarNbN1HGBqMzcGRjaUzdLlbk
         1KbNx7XIOIMrXuJiEd+VwNNDD/Myo7vxrQc3UooztCnuWv7bdwVwMzuMQ7IczUFlZi3c
         BuQ6E0GwEqn6ayZ7Ohp6xTFcDYAFopPGfQcKP39SBkHFxNelBvIFWeoIqXjBOl9S/MCG
         GSdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780007348; x=1780612148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF/CcGwAcMn3gialDwAGFBOUWdz2cgvE1Ykftev8rrA=;
        b=V5iozeopMvfLCfeJqUDYS6lzsU8cITp54w06l1tMLmRE9a3j0xxvhtAzel8DzH+rjH
         dXWNF5tw9153nuZRuIjEFnosyu3muF+LexOZYE/5OnNuab2ImGFsy4LVlHZVcYL0WMui
         yZv5P26Z6gY+hr3C3YCcGNf5TiuGaBuZUUtXuFnkGF66P99XRTsiPNfil1qPyVs7Wq6D
         ZigmEkGZCb+ZtPOzo1/02lfctL92X5GfymzPFq60aGyydOf5naveU8O+DitalRQoruDL
         +uXicVwv/rHotz5/cx5RF7/bUjLaa5Xgsm7JBA1b+r8yZ+Ll1Cp7I0fv1/U+H0t4Ok9j
         G1eg==
X-Forwarded-Encrypted: i=1; AFNElJ/9BGKA7RNhLUjQ+bg8cw0ofOXBXArl9JI9FlYz7SMzLGhXIVKrIjpGgAJUhYjUJdzSH4c6EKKMAlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0yHDXnY5P31aQs1HEGfGuA801y0QbFEDQ9+SyIwwYrj7y2O3S
	6EBk2Re4Ue/nBH3YghVFXp9Z2sn3339CUjvKEWD5WmuvX0qTdfV9tjpL
X-Gm-Gg: Acq92OHLd+f4++jklgO7dVUcfq1wBsTPguDW3yOeFCQXtoMzub+vu47yi1H6mLY5p/R
	dqFMXI70mOIGGxxwZpyloKqx8aSk5D9Br4Qf8fcDSdBLfxWAP7knX5EahkRGQq8Ul/NVX57k4Zz
	all79wklALETkXyhDp+q+aVxzIBdVeGzMvL9TqvNvPho5Xn5+EdGIpPqPyqlg8JuZc3kWdzQRsS
	ZSIt3AnoYdfPkydvFkb+pf5BED/u0mgGOlbu5xEju9Ddc3otBjIaB/8IcyVfPEbo0gRvevePrBl
	aTfe8MD9T08ZgOQAy4ltcbS/TD57L8HCIwolnnC2xmnR7+QlcLj3hr417HZmIgefmv8MeGzRF7N
	VKA8HG1FUzocjG06HYijsejJxAnt3J2XKqPGnledpiLe9knLXlEaeogiSJ9D6Pm1PTX0lr7GvGr
	WOkVea380pq38SAfJr9wBjXWq9qZY0P8RvpJP3M8SG7B9cnyzp+AB6x6yYQ2kenNJKkUy8
X-Received: by 2002:a05:620a:404e:b0:914:afa9:a41e with SMTP id af79cd13be357-9152fd031dcmr42430285a.22.1780007348051;
        Thu, 28 May 2026 15:29:08 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9152fd416c7sm19409085a.11.2026.05.28.15.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 15:29:07 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5] iio: chemical: scd30: Replace manual locking with RAII locking
Date: Thu, 28 May 2026 17:29:06 -0500
Message-ID: <20260528222906.61561-1-m32285159@gmail.com>
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

 drivers/iio/chemical/scd30_core.c | 66 ++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..20258059f915 100644
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
+	ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
 	if (ret)
 		goto out;
 
-- 
2.54.0

