Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC969339843
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 23:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766796; cv=none; b=JEN56txOZwuM4flH+JiozjXoB2jdroTgYCMTyUynruuG3OzEFN8FpiNL5qpahlWAAU+qL+n4xh8FX6zwmS6cd8sefEV8VASGSVDZljEX7R/oC5pG6CJOsVcobzlrS2/Iek2Ec1j66eo0g7vcLGZ6RTFt8SFHL0eJFnFcDGDw+6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766796; c=relaxed/simple;
	bh=oN1PmeqnJcYZ+K6CeMFEVz3TMZG4CcujIBzbSF8qGn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fwsBKyYDHW7TZyNK18PtyoxnszszxybISA+Dw4kP1f6LG4IXRLmP9Jw3HtpOq19VMOzjCbFbUphn+EOLMCNw6EY0y1uO4hCdCyTBaEATVlmnUYGa280oPZRr+nY/6JusUVA8VlKQGGzSqpf6msn4sKeGgtvVYvjwtZOAM5BEUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S35lZXrK; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S35lZXrK"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-503347dea84so56256381cf.3
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 15:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770766793; x=1771371593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yar4GAzxasIOJH8BAQ12LR2P5MS8WSAHcu1zPRwg9lk=;
        b=S35lZXrKTaLe5Rlp59GDaYQvNUJYdOG2b4e9kILpVXc+vQdLAxNvAvHkALtK2SFAf/
         lGBBD6b85XyG+gIIA4tOPI5MWNo1JW1UygS45Hj4o+iaQtUqDuSPgodwCaHg+tVXlkPS
         NJMXS0Eu7gXlXfDALDlZ9KjmNZv+qewDRXjPhbA37aOw2j0nKYNno8M080KC8EhezHxQ
         ValsrS92ewWf8X90TwjVj94cCySGBfzCqjF0L0UOy6zvKO1XjUhe8oikNMks3Xi4ycIS
         8f5YUwL2HO6NR2SfWgYiRtm3EHW4CWYFBVZQ7ffVJTzzpudoTwcNbAx8pwfsEPW+3VZB
         Bwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770766793; x=1771371593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yar4GAzxasIOJH8BAQ12LR2P5MS8WSAHcu1zPRwg9lk=;
        b=Ubwzz5QEizvRvFQwrWeG0ciKthdJz2PF40pHIVXPuBn2qMsJlHgqTLyKIVefT4R41G
         GwbNtqZT6kMr1ynbkbLOb3ql3oPiEhiOBKoprMbANzz5Oft8V5FSIWmWag/qRyI0NxmT
         NCJdLAPv2DDOt3t7JKzh5TPMrRRkxLm9RzsLtwU+isrsw6ZbVOngmSKsSuNzxyIyHW+V
         WTBDj72FXLi24KeaQsrv0cwKFfAYMQDYz3dYEYjFQKqzURPEPpf7arQVrx8TdnDM9n76
         LnzLIZMKMOt9P9xaqmw5AT3GyfhR5wAdo5G32GR1twDCPN4ethKuyeG4vhaOJXs+nlYZ
         cnIw==
X-Forwarded-Encrypted: i=1; AJvYcCWb4B2U8RvBO++GSrJD+U1zfbRrLH85kG5WHqaEbY6SjqUPJCHgW6H7BzqscD9r772vXLu19FjKll4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkUae5KeavBcd1JLyeFr8Uzpuqcp1kMQ0AMa5B8DFLLvRdSw4A
	ELmUmv7qwimiI3kPWZWffNL1EZ1jyg8pcD/fKv/GITAP9hX3/9BR71Ey
X-Gm-Gg: AZuq6aKEwBvSWGzv2FYvNLO5XDx/dvoDQC/0gl68mgBce1dqXVj5QhlPq0wwpFdlwVO
	3roFC3sCPHVa/MmEbpeIFJNFHo6EgpYt6MBAWz7gO4hYwiCEVHKnSp3wTzH7kHxD0k7hdjhPooL
	I4vSMSXO2j+hRNnTAr7v4uhB2Q5T2WD9tRx3DC3qKcw+DL8FbVsNQfc84QAYO7vl29fG1DPjqW7
	ssiNVHFw1Rsi8K+Ud+l7aTxDEh/poKsgN7/4hOTyKnkk2THbDkDO+pgkrKs2++BS2U4fU18I9Gf
	JAaUypERQPOvkIkcRFAagJTSaq0g3/rPPcCW+9e3qfFz6CSGlK81zhSgvvJfyBxsgsmj2rBO7s9
	Syn+Y3J5egjuhzgQbWJnRkmRw0RpfFCgWfdJ/KcBn3LUmIj7h8qPcUDe87FBigkiSPNHgIuuA3S
	A9hHPNPkZ2X9a/TvXVXpJrSXbFyB6+pVmoHi6ysugCVdt5yZMNscVZ
X-Received: by 2002:a05:622a:1981:b0:4ed:2164:5018 with SMTP id d75a77b69052e-5068128d805mr14605521cf.80.1770766792761;
        Tue, 10 Feb 2026 15:39:52 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50682f13f20sm1850561cf.14.2026.02.10.15.39.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Feb 2026 15:39:52 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v6 1/3] iio: magnetometer: bmc150_magn: use automated cleanup for mutex
Date: Tue, 10 Feb 2026 18:39:43 -0500
Message-ID: <20260210233945.40975-2-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260210233945.40975-1-neelb2403@gmail.com>
References: <20260210233945.40975-1-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use guard() and scoped_guard() to replace manual mutex lock/unlock
calls. This simplifies error handling and ensures RAII-style cleanup.

scoped_guard() is used in read_raw IIO_CHAN_INFO_RAW case for a
multi-statement mutex-protected block, as well as in remove,
runtime_suspend, and suspend where a short mutex-protected scope
is needed for a single function call.

guard() is used in write_raw and trig_reen where the mutex scope
extends to the end of the function or case block. Case blocks in
write_raw are wrapped in braces to ensure clear scope for the
cleanup guards.

The trigger_handler function is left unchanged as mixing guard()
with goto error paths can be fragile.

Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
---
 drivers/iio/magnetometer/bmc150_magn.c | 130 ++++++++++---------------
 1 file changed, 52 insertions(+), 78 deletions(-)

diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetometer/bmc150_magn.c
index 6a73f6e2f1f0..5eb710eb020d 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -11,6 +11,7 @@
 
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/cleanup.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
@@ -456,29 +457,22 @@ static int bmc150_magn_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		if (iio_buffer_enabled(indio_dev))
 			return -EBUSY;
-		mutex_lock(&data->mutex);
-
-		ret = bmc150_magn_set_power_state(data, true);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
+		scoped_guard(mutex, &data->mutex) {
+			ret = bmc150_magn_set_power_state(data, true);
+			if (ret < 0)
+				return ret;
 
-		ret = bmc150_magn_read_xyz(data, values);
-		if (ret < 0) {
-			bmc150_magn_set_power_state(data, false);
-			mutex_unlock(&data->mutex);
-			return ret;
-		}
-		*val = values[chan->scan_index];
+			ret = bmc150_magn_read_xyz(data, values);
+			if (ret < 0) {
+				bmc150_magn_set_power_state(data, false);
+				return ret;
+			}
+			*val = values[chan->scan_index];
 
-		ret = bmc150_magn_set_power_state(data, false);
-		if (ret < 0) {
-			mutex_unlock(&data->mutex);
-			return ret;
+			ret = bmc150_magn_set_power_state(data, false);
+			if (ret < 0)
+				return ret;
 		}
-
-		mutex_unlock(&data->mutex);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/*
@@ -530,45 +524,37 @@ static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val > data->max_odr)
 			return -EINVAL;
-		mutex_lock(&data->mutex);
-		ret = bmc150_magn_set_odr(data, val);
-		mutex_unlock(&data->mutex);
-		return ret;
+		guard(mutex)(&data->mutex);
+		return bmc150_magn_set_odr(data, val);
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
 		switch (chan->channel2) {
 		case IIO_MOD_X:
 		case IIO_MOD_Y:
 			if (val < 1 || val > 511)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
-			ret = bmc150_magn_set_max_odr(data, val, 0, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
-				return ret;
+			{
+				guard(mutex)(&data->mutex);
+				ret = bmc150_magn_set_max_odr(data, val, 0, 0);
+				if (ret < 0)
+					return ret;
+				return regmap_update_bits(data->regmap,
+							 BMC150_MAGN_REG_REP_XY,
+							 BMC150_MAGN_REG_REP_DATAMASK,
+							 BMC150_MAGN_REPXY_TO_REGVAL(val));
 			}
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_REP_XY,
-						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPXY_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
 		case IIO_MOD_Z:
 			if (val < 1 || val > 256)
 				return -EINVAL;
-			mutex_lock(&data->mutex);
-			ret = bmc150_magn_set_max_odr(data, 0, val, 0);
-			if (ret < 0) {
-				mutex_unlock(&data->mutex);
-				return ret;
+			{
+				guard(mutex)(&data->mutex);
+				ret = bmc150_magn_set_max_odr(data, 0, val, 0);
+				if (ret < 0)
+					return ret;
+				return regmap_update_bits(data->regmap,
+							 BMC150_MAGN_REG_REP_Z,
+							 BMC150_MAGN_REG_REP_DATAMASK,
+							 BMC150_MAGN_REPZ_TO_REGVAL(val));
 			}
-			ret = regmap_update_bits(data->regmap,
-						 BMC150_MAGN_REG_REP_Z,
-						 BMC150_MAGN_REG_REP_DATAMASK,
-						 BMC150_MAGN_REPZ_TO_REGVAL
-						 (val));
-			mutex_unlock(&data->mutex);
-			return ret;
 		default:
 			return -EINVAL;
 		}
@@ -782,9 +768,8 @@ static void bmc150_magn_trig_reen(struct iio_trigger *trig)
 	if (!data->dready_trigger_on)
 		return;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 	ret = bmc150_magn_reset_intr(data);
-	mutex_unlock(&data->mutex);
 	if (ret)
 		dev_err(data->dev, "Failed to reset interrupt\n");
 }
@@ -794,32 +779,28 @@ static int bmc150_magn_data_rdy_trigger_set_state(struct iio_trigger *trig,
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
+
+	guard(mutex)(&data->mutex);
 
-	mutex_lock(&data->mutex);
 	if (state == data->dready_trigger_on)
-		goto err_unlock;
+		return 0;
 
 	ret = regmap_update_bits(data->regmap, BMC150_MAGN_REG_INT_DRDY,
 				 BMC150_MAGN_MASK_DRDY_EN,
 				 state << BMC150_MAGN_SHIFT_DRDY_EN);
 	if (ret < 0)
-		goto err_unlock;
+		return ret;
 
 	data->dready_trigger_on = state;
 
 	if (state) {
 		ret = bmc150_magn_reset_intr(data);
 		if (ret < 0)
-			goto err_unlock;
+			return ret;
 	}
-	mutex_unlock(&data->mutex);
 
 	return 0;
-
-err_unlock:
-	mutex_unlock(&data->mutex);
-	return ret;
 }
 
 static const struct iio_trigger_ops bmc150_magn_trigger_ops = {
@@ -980,9 +961,8 @@ void bmc150_magn_remove(struct device *dev)
 	if (data->dready_trig)
 		iio_trigger_unregister(data->dready_trig);
 
-	mutex_lock(&data->mutex);
-	bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SUSPEND, true);
 
 	regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
 }
@@ -995,10 +975,9 @@ static int bmc150_magn_runtime_suspend(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
-					 true);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
+						 true);
 	if (ret < 0) {
 		dev_err(dev, "powering off device failed\n");
 		return ret;
@@ -1026,10 +1005,9 @@ static int bmc150_magn_suspend(struct device *dev)
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
 	int ret;
 
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
-					 true);
-	mutex_unlock(&data->mutex);
+	scoped_guard(mutex, &data->mutex)
+		ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_SLEEP,
+						 true);
 
 	return ret;
 }
@@ -1038,14 +1016,10 @@ static int bmc150_magn_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_magn_data *data = iio_priv(indio_dev);
-	int ret;
-
-	mutex_lock(&data->mutex);
-	ret = bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
-					 true);
-	mutex_unlock(&data->mutex);
 
-	return ret;
+	guard(mutex)(&data->mutex);
+	return bmc150_magn_set_power_mode(data, BMC150_MAGN_POWER_MODE_NORMAL,
+					  true);
 }
 #endif
 
-- 
2.44.0

