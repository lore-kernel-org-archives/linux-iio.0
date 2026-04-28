Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D090366823
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415165; cv=none; b=u4KnABmI3EINUV/YsDWqXCLddrS0cizX6ofVWNttF/m3rjS1qIxEFWBd6t5QFAuKR33czq7epodEowcLkKqEm0XkJZNaCpU7ZMMXt9Hb7UwNRvgUiMWQymq9qpFucFonyOIi8SnljdITI458OccX85CZGPREZtodxilK2Enl+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415165; c=relaxed/simple;
	bh=BQ/QZ7TTu/bVg1T1gMYT4a/sRWF/sM4Ml1GAxl44sY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=beiAJX9ns1ga3+DN+kMYBywbSb/2NBtBOHN+XC6zQVZlYzP1Vyc5pf9BFYgnQp1oiHoFmmO/q7sbZh0Z8simixjCEcD3z5/H0LwdShz5j5uO44LPlZIGw7mU1i0VCdFqG+P3JyT76jqgt6nMTA3bo40TAE9qqKJtEhf/PpOfIHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dgBuDOXI; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dgBuDOXI"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4648447e29bso3585080b6e.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 15:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777415163; x=1778019963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dQF0aWny2Cm03y0Eka5Rg1n3akR8zJQ37ygWRK1ad48=;
        b=dgBuDOXIZUjkZfem8cOOVqfUJPxMu00B/ojguKCfY7w7CpH9IBmDBrIcuto2MYBNEC
         HybchUebvYZ+UpvwugllcWxaAEejb5fTG3+CVM8jpIbcium56/cMT9wUAlALk2tu8OnJ
         M5PQFpGn1evWfxSzQ6RWGBf5/HxZhw0hZGGM6d6aTLDCwucCvANjcohdJYZcNhFpvKOU
         ovt8xfKX3G2Qf2H6p5bXehLK42CBOdPTbp3rktp4bFLaAExcj+Qq4EFhuoGczMnGokRG
         AvHdpq1Ig6Uraw/j50lMKbpIIJI4kN2kKVpGFfWldRsiXH/unSLxSRrjNtplO7Ms+Lr+
         U6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777415163; x=1778019963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dQF0aWny2Cm03y0Eka5Rg1n3akR8zJQ37ygWRK1ad48=;
        b=J2M+UR7aN9MkwyttlNnV6En2VuT/ruYc7Rw4lkEFmqLCIs4z8dr/gE1JAqqYTIEgTX
         zQob/h+ZkXQ2dx3N+e0O+FJexYoNDlbDs4150x6mQLZMYwFXN+ZOeyMe4SToR6fp/8md
         991cmYOoQgZCyj7yoBi8WUk/71feGLExJv1g2gXXaQDWUsSTyo86BULyGO2T2p4gAHs4
         LKLbF8WalMUCHYktaehH8YUyZbaiuy4BzvUdrwPPmjPUa2A9FJjpF6tO7XVMYC/vM7mF
         +cDKNGaArXPRXliCg9sl0dH2s4vqHxSDfngM7OE1MZw5FfXNqf/GZaKoK+E2lFY4OFdk
         nAyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9H0bdoUcP9ISKrDcK2Nf1ZTAg+8We6LACEuZaB0wLD88mNDRHTGEORy48DCtxsjVr3GmLHZL5u1/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YylF5HryTni4a3BTBPMl7fduo1ZT+ADRU2LrC5wFxXoo5GAxqi4
	QK6MaDUXcDX8fIxKI3XZ4KOQWN4iTOvHQnMRhtuZ/p8MsjvbdOMQ3l8d
X-Gm-Gg: AeBDieuE85TTauf/h0qC7Ktl0EusDg7+O0KtYY1HFIhn/6BaNa/UxdFnblF9agocV5a
	NvejN961gEmcgmvMFSKyl6vl/3aFaDmoIdwDQE8qWyk0O31CPEu4aMfv57F0HPYZY+qd2u4SBp+
	Mt0KG8NjDW/QFBl//8hRtsFIVeAE+JMFGfStehe0wuKBrnLpZ3Z1u7Q0YH6yHfsaXUBMAXPI7qe
	oJu7BEKkQM6y/lzHnJUtn8S2CC5P9p7DtZIH3P4VT19kdML9skpa1CLpGL5BbpLimfuYZtxtTWJ
	RQ90c4mXJZBSReGyh2cepd3Ni+wGKUbwZQeAoWYDWcNEUsynRf2jZg+0N8HKpJ8ANBHePX+NMNh
	DMvMAqd0LMXF0ee0h9ibg3SboPfOm7AFYDkfuzXLcBw/3eMrHO0PVZCh8hHdPZMOPmPkcbBUtMy
	Qi8GT4ESOKu7Njt1Xgnf1s/Mcnc6GRw/QAZy+1Oiv5rGuR4P2Klnd+nzx8wFFOj2pkny2D
X-Received: by 2002:a05:6808:3185:b0:467:fa3b:b50f with SMTP id 5614622812f47-47c28f92430mr2927656b6e.24.1777415162943;
        Tue, 28 Apr 2026 15:26:02 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c43e6ae74sm49988b6e.3.2026.04.28.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 15:26:02 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] iio: magnetometer: rm3100: Modernize locking and refactor control flow
Date: Tue, 28 Apr 2026 17:26:00 -0500
Message-ID: <20260428222600.91322-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in rm3100-core.c with
the more modern guard(mutex)() family. This will help modernize the
driver and bring it up-to-date with modern available macros/functions.

While replacing mutex_lock() and mutex_unlock(), the critical sections
of rm3100_read_mag() and rm3100_get_samp_freq() have been extended to
include negligible operations for cleaner logic.

Add new helper-wrapper function rm3100_guarded_regmap_bulk_read() to
help keep rm3100_trigger_handler() switch-cases clean while maintaining
mutex locking and avoiding re-entrancy risks from potential callbacks.

While at it, remove redundant gotos where applicable, and use direct
returns instead.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - The following excerpts are from the original cover letter:
 - Added small style fixes per Andy's suggestions (Adding blank lines,
    moving an if statement in a scoped_guard block).
 - Switched out scoped_guard() for guard(mutex)() in certain commits.
 - Fixed error in commit 4 where deadlocks could occur, as goto
    ignores __attribute__((cleanup)). This has been fixed by the above.

 v3:
 - Added new helper-wrapper function rm3100_guarded_regmap_bulk_read(),
   see commit message.
 - Squashed commit into one commit rather than four.

 drivers/iio/magnetometer/rm3100-core.c | 94 ++++++++++++++------------
 1 file changed, 52 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 2b2884425746..9cad61e1df94 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -204,27 +204,23 @@ static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
 	u8 buffer[3];
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_write(regmap, RM3100_REG_POLL, BIT(4 + idx));
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	ret = rm3100_wait_measurement(data);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
 	if (ret < 0)
-		goto unlock_return;
-	mutex_unlock(&data->lock);
+		return ret;
 
 	*val = sign_extend32(get_unaligned_be24(&buffer[0]), 23);
 
 	return IIO_VAL_INT;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 #define RM3100_CHANNEL(axis, idx)					\
@@ -284,11 +280,12 @@ static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *val2)
 	unsigned int tmp;
 	int ret;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	ret = regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
-	mutex_unlock(&data->lock);
 	if (ret < 0)
 		return ret;
+
 	*val = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
 	*val2 = rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
 
@@ -338,56 +335,50 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	int ret;
 	int i;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	/* All cycle count registers use the same value. */
 	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	for (i = 0; i < RM3100_SAMP_NUM; i++) {
 		if (val == rm3100_samp_rates[i][0] &&
 		    val2 == rm3100_samp_rates[i][1])
 			break;
 	}
-	if (i == RM3100_SAMP_NUM) {
-		ret = -EINVAL;
-		goto unlock_return;
-	}
+	if (i == RM3100_SAMP_NUM)
+		return -EINVAL;
 
 	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	/* Checking if cycle count registers need changing. */
 	if (val == 600 && cycle_count == 200) {
 		ret = rm3100_set_cycle_count(data, 100);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	} else if (val != 600 && cycle_count == 100) {
 		ret = rm3100_set_cycle_count(data, 200);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
 
 	if (iio_buffer_enabled(indio_dev)) {
 		/* Writing TMRC registers requires CMM reset. */
 		ret = regmap_write(regmap, RM3100_REG_CMM, 0);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 		ret = regmap_write(data->regmap, RM3100_REG_CMM,
 			(*indio_dev->active_scan_mask & 0x7) <<
 			RM3100_CMM_AXIS_SHIFT | RM3100_CMM_START);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
-	mutex_unlock(&data->lock);
 
 	data->conversion_time = rm3100_samp_rates[i][2] * 2;
 	return 0;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static int rm3100_read_raw(struct iio_dev *indio_dev,
@@ -458,6 +449,28 @@ static const struct iio_buffer_setup_ops rm3100_buffer_ops = {
 	.postdisable = rm3100_buffer_postdisable,
 };
 
+/**
+ * rm3100_guarded_regmap_bulk_read() - Wrapper around regmap_bulk_read() with a mutex
+ *
+ * @lock: Mutex to lock while performing operations
+ * @map: Register map to read from, passed to regmap_bulk_read()
+ * @reg: First register to be read from, passed to regmap_bulk_read()
+ * @val: Pointer to store read value, in native register size for device,
+ * passed to regmap_bulk_read()
+ * @val_count: Number of registers to read, passed to regmap_bulk_read()
+ *
+ * Intended for use only in rm3100_trigger_handler().
+ *
+ * A value of zero will be returned on success, a negative errno will
+ * be returned in error cases.
+ */
+static int rm3100_guarded_regmap_bulk_read(struct mutex *lock, struct regmap *map,
+					   unsigned int reg, void *val, size_t val_count)
+{
+	guard(mutex)(lock);
+	return regmap_bulk_read(map, reg, val, val_count);
+}
+
 static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
@@ -468,11 +481,10 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 	struct regmap *regmap = data->regmap;
 	int ret, i, bit;
 
-	mutex_lock(&data->lock);
 	switch (scan_mask) {
 	case BIT(0) | BIT(1) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
+		ret = rm3100_guarded_regmap_bulk_read(&data->lock, regmap, RM3100_REG_MX2,
+						      data->buffer, 9);
 		if (ret < 0)
 			goto done;
 		/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
@@ -480,36 +492,34 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 			memmove(data->buffer + i * 4, data->buffer + i * 3, 3);
 		break;
 	case BIT(0) | BIT(1):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
-		mutex_unlock(&data->lock);
+		ret = rm3100_guarded_regmap_bulk_read(&data->lock, regmap, RM3100_REG_MX2,
+						      data->buffer, 6);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 3, 3);
 		break;
 	case BIT(1) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
-		mutex_unlock(&data->lock);
+		ret = rm3100_guarded_regmap_bulk_read(&data->lock, regmap, RM3100_REG_MY2,
+						      data->buffer, 6);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 3, 3);
 		break;
 	case BIT(0) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
+		ret = rm3100_guarded_regmap_bulk_read(&data->lock, regmap, RM3100_REG_MX2,
+						      data->buffer, 9);
 		if (ret < 0)
 			goto done;
 		memmove(data->buffer + 4, data->buffer + 6, 3);
 		break;
 	default:
 		for_each_set_bit(bit, &scan_mask, mask_len) {
-			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
-					       data->buffer, 3);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
+			ret = rm3100_guarded_regmap_bulk_read(&data->lock, regmap,
+							      RM3100_REG_MX2 + 3 * bit,
+							      data->buffer, 3);
+			if (ret < 0)
 				goto done;
-			}
 		}
-		mutex_unlock(&data->lock);
 	}
 	/*
 	 * Always using the same buffer so that we wouldn't need to set the
-- 
2.53.0

