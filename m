Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BA3340408
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196788; cv=none; b=Bep6s/8QLrITymhrGtKBRKDUdfLwXqCny1KAX8/3dX7O82l2vuXCpBPW5uv/0cI4hp8qLTsePvHeFhxlKQ5Wb/QBYvphLD0H1kNPxzzD6UTVTFMn6oC0/w7EQgxVG/w8yje8u77X9WBcSfU8QbVPjy3reD0YHOq3k0smTBx5T0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196788; c=relaxed/simple;
	bh=yRBLnOu2D2TEtY48hS/pBbjA7tsgUERhIz6SqgvMB/0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8i8E1XUT6yUMmhaxzk+DdcS6/4r1LzIGW5AQJv4fjJ8yu07EDboME5k5A81uPxHmp4FsZXQmtAdc/ZSLv5ynLzEo4PPcQCAir6+GdkxlolDaav9tu0+QBXdqPzmUKt4kRK1vJICtNXDgW7HwQupg5kLUO9j54yu95CT1+H0u9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkvtWZ0S; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkvtWZ0S"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-408778a8ec4so2164243fac.0
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779196786; x=1779801586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w96kHrphpa3rQc4FeLDCOWrWTTQn4xzjAAyJPXRHqJc=;
        b=kkvtWZ0SnDnBB9/GLXrce274xl//u0e9bN1+iwAcefqerXT4v3se5DtERY7RiYB48g
         gqwKCT7HragHWmXqunKKpO4GmCjtAxp9VwzkuEsHjRWM4utGfsOxdfnupGQImwWOG5yn
         J2d5Rxwg7DVe1Dl/ZsHuenWGUyAdv14eosFFEcqRYkfjKGqqIlXnWm8MJUReqRTUn2m/
         VCFv4nbIH7lTt7I+cM1rbuw+X6+CVG1QAxTPjUTJusSqWN8C+xsDakouwFF4EH8jTI0c
         85RfSC5ldWjjpccBLKCFmMD+8iwagCW5Y9OOf/eCECCPsR0J15RAoW2U/fM5aX2CzQaI
         MN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779196786; x=1779801586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w96kHrphpa3rQc4FeLDCOWrWTTQn4xzjAAyJPXRHqJc=;
        b=sS/Wsz/uIZ9oeRMqpbrnnc22cH3z5iITse/uT96352/CM877lcnaxufGoeprv9PHW9
         1wSeumDiWP1JOxdoDEYXK0EcSHTrWL9o7wcTooKeEmpWpUFqmaPBJc5DxfN7cmXsbsXm
         kzh9/tt8CpuN81P4Cl1FoYtcgPZIW8DZOuiW2AB4ySx9heRHJ/TB+XlPEyQ7ndJye1vR
         I6qEIUTMnFzASPx7RriEeoDNycE93GPk9o0aRs3FgBUEGDqTuskTftex7KTpt9KDJWR2
         dUgWP9s9jKb6O7e6enVSL9E4tq+7vEI1YhueA5jkYqaa9drt35l4UJCPjUt5sr6k9Fkv
         4shg==
X-Forwarded-Encrypted: i=1; AFNElJ+vuqU3LSLjR2V4aELF7+Ldb7S39IkZIyB34uXe6wq5Xmd4eHNUNZIBepduPI4Ipxp538bAmX/cMkc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt6PwJS6TQqjKS6eFUWvxyFlp6TLIeQ2edNZljoGZZZ6bBX+JW
	VJBpXooIwYBGNvKVk6rcH/dYj1D4fGjrwZxsre58ePoc6CDd0bTLxCzpe90877TQgSw=
X-Gm-Gg: Acq92OEA/AsNBBsDmksP7IlKzFcg0GMnoXqUVoMcSogJS8GfsSxHkNi5JxVvC3BJa48
	uZaPR1Ufp/cxKOz8Sh3xVSGIFP4YDhu/H6jCT1khcHEMFfWEm9syWK46ob0J7NMs97/HLgxJOs5
	i2kYccua7w9i9eIHqdH9pDEwHCudGr93xigcs1AdQzKhB7GQ6XJdZv4BK+ye+XbR9VR0gnQI1+F
	7LmFw5Mu+70x6xXH/oHiCO6aGOvy82d1sfdeYuCJa3ytNLCcbYC7Gj4xAjPSjfGBDuzUmCCyuSS
	xHbgeOZPHOKP8va5wRrpQoy1pMH5862Rs3Zg6yR6y2vISm0iY7tH7U4zpxrhfQt1NKf1TIIh/AU
	TG9SDOD77/9q7uJzXo5l6N4AUQg61DLYvwrHBU0E3MDosDXmlPmQKAfIRfbl36Z8kouz5TA3dUJ
	pqyV+LFkfrx44N9aeJCxeaB0odChruqKb5phXKdYcW+YmAMQHf1leYHZ8GKmKc2mZFoh8w
X-Received: by 2002:a05:6870:a093:b0:439:b6a0:5125 with SMTP id 586e51a60fabf-43a2de07a22mr12503222fac.30.1779196786074;
        Tue, 19 May 2026 06:19:46 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a957b84fdsm7146229fac.18.2026.05.19.06.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 06:19:45 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: chemical: scd30: Replace manual locking with RAII locking
Date: Tue, 19 May 2026 08:19:43 -0500
Message-ID: <20260519131944.25174-1-m32285159@gmail.com>
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

