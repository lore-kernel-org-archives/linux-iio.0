Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B679C258CE5
	for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 04:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512264; cv=none; b=hJyXEmtmhAIYwSYHK66tJvW7e5mWVYFOf4H1EFk7O31/USLLY/M3IIUE49X06DcOEd4WQ0oJY/aCDmeIKpm2N+02E4tjbmJ376Sq1qAEIQOVtxAAaA5nLsE/xZG1AwJxXkTwvSr6UCOAmOqZfECiMUDbMY4F4/NiG97Dl0uo0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512264; c=relaxed/simple;
	bh=AibGuK02mewGLsMoI5Ej9fpXEH3UuYsIlpptGZJ+P6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bw9NUdcia4gTuPC+xAAI0KyHFhNgTTUF9X4O3tIkKFDnHZqLpW6PitICueRodhpMYGAWECZr88dlNdvja29CtQubqdkQKf1InjTR+fKq5hDHLjxUkBksqvDNyJNnJ67WOPGLdAPGA6MOhKDpscqOlz9tEESZU+m4lPdqb39oOfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShlrLF83; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShlrLF83"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65e15fb394bso5724628d50.2
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 21:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512261; x=1780117061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5syWGl+5MvohUYzgLrTITJDD9QNFSwgW5FKEfbY3xMs=;
        b=ShlrLF83aWpgNZlV8GnGbOxnyllMrkgBlW/odKMeWbnJDQwl3aEFQ5ewGEsvpIIcMs
         /sEHyEWeyHWsji2wTfi0A1Hu1N+dIz10H3yEp4RGXKvoyK5hiyrB3cjbIVQen7cb9XnU
         jSuuWOAfqZhNxNDQnM55V2ALv1v0q8nTa4chwU7unAjiXzO12bMl+gV1EiEd+CSGrlXX
         sNTKshfNzaARATRIa3eZy0f2zmlnhEpyZJQT9qZ0ZWakurjRwChrUKFFq0DYonM6ECDm
         jNmDTeWf1kAIWKIH+CP24usZNi5jBkZM20giwNRJn3N/K+GsuUNhniS6ZMSHxrQc0aSk
         QV2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512261; x=1780117061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5syWGl+5MvohUYzgLrTITJDD9QNFSwgW5FKEfbY3xMs=;
        b=dfiMs8I7Y8bFd0rQndfazdMFXsO/0o/Jj8GlWHx2DPRcKZS6Fk6fTXCLsMiovJqi7Y
         coHCDqlKeKaP3N+gzW0V+v1+rYqHADxIgU1GYEITD+UFynEnJgmdPJxPruGsdN0nVFM7
         cF6XV9xHSN56IFuM5HcQ+VvN9McRm84zFPPuP/dXDb4dbNbGDMlWwCQlrFlk0pCbudJk
         YGAlbCy6A6z1GPfqgp35ap02fdzC8+rwg4rAQTmwPI3tWVrNyEzqZ9Q6BJCHCVHT7wnf
         CBLYEtIQs4lhCcF1Fpuv3wC0mDWShXrfXenLPsMfa8x5rR87Ah8bUXNwCWZzuCedsNkW
         H6sw==
X-Forwarded-Encrypted: i=1; AFNElJ9HnVt+Q/7F8uBLmgxM7QEbyrZ6AKQnA4fyH0MK+0xvo5UmrJKHuOo5+HeIt3HqacnNUAjzNq79BFE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4xoe68hCtrbvfi1ffvJ/XNftTou4kBvDJltYLv/0jeSvfDXpe
	VcUyP5REuUyuK6awuUFQmpP9p3+/G2U10B95VFDSaV9IbOMLudtfSs4E
X-Gm-Gg: Acq92OE14mYwMovcZUeippCkYiEsTdXEQ5eOgLNPxiTDJ2a2f/0XMK24uvZaNJLxXgz
	z8ObhZjhTMcCDH5O2kYOTO+7chb2YZ7w4tpb7FXSERAB+yEaEW+FsUYa+7ONND+TFK7lvNBlW4C
	2F/AFm0//zZr2VeQ7hWVxsbwZEnESKraBn7drCi7aCMwundEq4xF/r1xdNPcBTyCZerm1FOsZ2l
	x4lNL8776QAIP7dLRXxrlHZVGVAp0LZyPtCMgRvVZu0rhXuVmgT76Ezg24cGHnNb0wlzZFBw/Tu
	4HuhjWI8XyOO32SYhO5OThTZEUfj7RcAiAR3r+RR03uZDyHCeAXbiJX/h5gSQVBmRbrkECPJmns
	vd7/DQT9yH7wLwizmtMfqJ/ES9+0wyzH2tcsYebE9XG+jNMwsG1HhAZXFK3wDAfLOP4kIaSNMbA
	qXgmdKbXlU0i4OZKiXnYrgxnQ4cg==
X-Received: by 2002:a05:690e:4090:b0:65e:421f:25a with SMTP id 956f58d0204a3-65ec9938b9dmr5900496d50.53.1779512260714;
        Fri, 22 May 2026 21:57:40 -0700 (PDT)
Received: from i-use-arch-btw ([12.216.126.78])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65ecfd5c17csm1615321d50.10.2026.05.22.21.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 21:57:40 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] iio: chemical: scd30: Replace manual locking with RAII locking
Date: Fri, 22 May 2026 23:56:09 -0500
Message-ID: <20260523045610.30925-1-m32285159@gmail.com>
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

 drivers/iio/chemical/scd30_core.c | 66 ++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..bb8bdea7c833 100644
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
+	memcpy(scan_data, state->meas, arr_size);
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

