Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332B121256C
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 00:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804768; cv=none; b=REbbXrAB8v9FrUC23KlkGWffqFEk9zmm+RH79/8bY9iep6wZA/WvUd122jdekEC6nMNUW8FN2bkOWRasuQuLfpwiBIQBylwSszyxUjRdB0GZ1YmCecFKAtMRoSjaPb5WGpvQroEWsT4BoWbj0R2Ny5IwIUJiWc44vmZKGuJGVUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804768; c=relaxed/simple;
	bh=960mmdZ10+VRr6ojDdsFC4Fu1NMpdova7+/JQ7LPyjc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pDAD/aaeFrRpDTL3ePUFQDnzsWAnz8Igz7WE2yKWLxdfQ7LBKuSNeRb94YrCu8c1T85wl2L+jjEsxBO61cxPO7AwV1ZhcPb5h6UKnBKTiEALd226t2KBIe2rQ9RErzIHlg1P/8dFlqf1EkmECRY35guGizIdDVMTTfjQvY1BV9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SRcdEPvk; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SRcdEPvk"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7dbd23bc684so4906470a34.2
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 17:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778804765; x=1779409565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1D8EIaTvhurFdcQdzA1NHz+PUGfMQPi1KksBFexnNFk=;
        b=SRcdEPvkshsuMr/nhvi6qedIeVe28Dgx15prva19mgqo5L8vuHCQa+f5UnyLK4UkyS
         C5SF7oaswDDiweCNjyxs5v7J0i9B0Vp1jh0FDhfDebJFRPZjm1/0motbrAPj/bGRt6+1
         DuvMgAmtMeZ0tu7YwWrK1uhcv6Ft1mGx3mSt/P+MaWf6wZxB4Spm5qEdxZdqD0/ZM9kt
         YyWSt/rdD3QLm+Z5zNUfkNoP7kU3XkXKdacVnzkv8PLZisTwgB2lgeWFgYNOEmZQ0uqn
         f/CQTOTA93LQDj6VW3F2YF8zZmXnvu9JFXPv2OwA8b9t91NTBohc1e2rDub9W3f79HsG
         PJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778804765; x=1779409565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1D8EIaTvhurFdcQdzA1NHz+PUGfMQPi1KksBFexnNFk=;
        b=gcu/A6T+QOPeL+fNp3dqz0ak2i5kBFUhm11jUNTgXE6maTFms+6uRaAtWBSAVL5tLM
         FsSL9yqaPh1zu53jew3DFFTSXPhvqYMBbBzIBC2bwgOFNl9Px5J5E+goWSRpwr0mbkn1
         0EaXTH+6DX7Z7G7upfTrK/9IuoV3kf/YwN7knoumcIjnHPbBuP6sTttpTAr6FbfPe9fX
         2YS1Jc1WSeQFhDF+ksrud+b1Y9i0cmPizIKkcsz+7yVKgPxSlCR3yHeE+R0TSt85t+5Q
         86/y9Z2qOvz4WPNGZI+F2Wl1U542P1qPqIVT06+mjC+k0M1eK2SJGUyezRWIPYrvb93h
         S5Ew==
X-Forwarded-Encrypted: i=1; AFNElJ/KdBL6MewvEAZV9IXYA75KwLRw/bypF1GvmmeswOeFirBRZd3zhH9qwr+iPPFWBqz1LOXPFvz6bRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkXGpeTI65LaFnk2CU4Ml8FeP2DVhgjerTkDlzO7+nlT8w46BP
	DfEyvTkmOOM0su3dTa5CTesi/2tVfV6hWSiC2sReNADGsu7M7q5tdeDs
X-Gm-Gg: Acq92OE2yZPxduKrUjeMz+JNGNMkJOpG1voYF+lnZ4HaXHuEjT3s2852WJxwMdLATU+
	XQRvzw1+eax371p62+zAeSOhtqJaK79I0BGjtbKKqrt3nWJc8a228AkVEgW+9nvvPQgbDn15uGe
	XET6ZIe0omOHZSExpbnfr9hQ7ZSsC2U1jdrxd5kiZWJD1yfRib8jVlWrUuy+YV6uwHpKIM6mX5d
	HMiVhpVhylPgRRUu7z5g0feNi0zJWvwS7hGVHvEx6urTpZ2pkG+YrkK0YlGCTu+f3G8aGu0DS56
	N02X+TBzQb7vvTtMGqog22A3bCMtORwssZimbpZe1JkXYPrYbDMhZ+B0UNgqX4lq0iUjYHj4lW4
	hpLJ72Qb5Hx4gJEcXAkR+PHSoYTzvGe9s63MD+CV8hGVLIzijKW2TSQk+GX0AIxsgStotQxV8sP
	UBDim7FVjw82dXoDMEpVrBHh3EO8BMMxP9Ul4g+gqZHOQ6VcdJBVLVFQof/pTllrkJcZ96
X-Received: by 2002:a05:6830:6615:b0:7d7:fbe2:9725 with SMTP id 46e09a7af769-7e4ea087eecmr1096245a34.5.1778804765093;
        Thu, 14 May 2026 17:26:05 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e55b7c6b38sm55442a34.2.2026.05.14.17.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 17:26:04 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] iio: chemical: scd30: Replace manual locking with RAII locking
Date: Thu, 14 May 2026 19:26:03 -0500
Message-ID: <20260515002603.19240-1-m32285159@gmail.com>
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

In addition, minor refactors in control logic to remove gotos where the
guard(mutex)() calls would be used, and replace the "?:" operator with
regular if/else returns.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/chemical/scd30_core.c | 53 +++++++++++++++++--------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..a24c95874fd3 100644
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
@@ -590,19 +598,16 @@ static irqreturn_t scd30_trigger_handler(int irq, void *p)
 	} scan = { };
 	int ret;
 
-	mutex_lock(&state->lock);
+	guard(mutex)(&state->lock);
+
 	if (!iio_trigger_using_own(indio_dev))
 		ret = scd30_read_poll(state);
 	else
 		ret = scd30_read_meas(state);
 	memcpy(scan.data, state->meas, sizeof(state->meas));
-	mutex_unlock(&state->lock);
-	if (ret)
-		goto out;
-
-	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
-				    iio_get_time_ns(indio_dev));
-out:
+	if (!ret)
+		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
+					    iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
 }
-- 
2.54.0

