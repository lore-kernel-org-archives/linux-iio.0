Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90F03B83E1
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781209721; cv=none; b=qqi4nSfbRZLLU2HW4UwRoBnaOjVKfOJyZiFKhv5Alv56IVtzYmg9VxePEbJjpxFoqbWN4qIJk1acNFgP888Ddz24lirYrKg6qimNX2LcUyvsZeh79T0cznOnpkhMxkvWx5GwdS6CrY6JiGhqTjphmpjDxrTx7BoRWnAixEWqRzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781209721; c=relaxed/simple;
	bh=0QOVa3pStVNNy0veAb2LnzvDbthlBzr5GBIDtYYTCzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myq2IV0adlj87GMS1EC87NLw23NVceBCev1sEnYlIgjCBhBbap7vri8HnDsH3WyyIljo/QVYrrxtGOCSsIdJbeD6U0/aWaA/NnEReKW46WWj2gGW/I+fL1vKDCg6RsU44cR9Sv0diJEAuJvH0D4TojDKbjX04E43XJUkpUdC29w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d2oeFTHk; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2oeFTHk"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso263772fac.0
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 13:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781209719; x=1781814519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3drPuY5PzoCtryIiTMlVEx3wvYfkASMOVU2JDCtxa8=;
        b=d2oeFTHkStEjREhb0WbqgzQw2u00NXJwnfI77Og4EG8utiW9dQyRmaeh6DfqytvZNl
         A0e5dfv8KoYd12S9YfG0RK/+r9D7wbGrNVqh0B3WO2QuYyni2klIU2mNIciSWTrzV/Tb
         AUAS5CZyaqV0MpgbpeCu/7PbSV+hts7s4k+HGUxcs1QKTlZGFSYQcj1pL3hUFDqfCpnx
         j+IdBOwINFS9Cc2fFvVRxhDjsBwK6mZlYJsnGBvTW1B8NPsYV8t60oMnByf1/IIxsEoQ
         X82qIWoMK/Kbp6o+vpauArxPTtxCgZr+/upfN0J4NKf9VY+PFCsLgFXEUnitGDqCaFkD
         RReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781209719; x=1781814519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F3drPuY5PzoCtryIiTMlVEx3wvYfkASMOVU2JDCtxa8=;
        b=FCdTGafPONJG4M1YHlMn3LbqnIlMsTTDiK3zo0eWZYX7g6V0MspTSaUksbGcVIyGkZ
         dWLxERTXqm6gHtzO1AgFtsaz/DEfCewDVkPJX1gob0qx/yGMJuSilFDAPKQXZnR0mTrK
         OQ+3a4PZLpHSt/dTyl21zUyvTz3/WV4Bj7Lljg805tnDkRC4OT7Faa745CaKfVYMzI2X
         dmw+/5C8AJsTrkrm0safktmtFkdC9ZgpQgYgQy8s4/fw2G4lz1/6Ulw5QihR3IK+vaI9
         6kpYmVgn5yKD6z5rFHPKzlJDEC40Yo0roERTT6e8rDYCHfu8UnzsO2z5HDmtaieEgYD/
         X/3w==
X-Gm-Message-State: AOJu0YyGx2rUqxQIGNSICzm43gmUsQjBPRp8/kZP36WAju5+WBNfkU2T
	7fBBtQkTB+ArVCW5wRZspzWDGOjlogFW2padt/4taILt7dAnqvjUVNcscIl/tAhH
X-Gm-Gg: Acq92OGvltPIG3cP48a7hZIQr8Gc7+FOzdIvct6gbAS4Gj4JrhksCiE3zaN/2UgE+Gp
	34bGEiyWBgLZ66/y6e5D21s/iaBp+TeAMQs+TM2YYa3W6wRX8MlXMYrc5xvoQST0C5zGygmA7UV
	htLYu+y9Q/PdlrErGmOZ4/IIlzdUYW7swSu5jhDdD0a/DqIaCZmI2+eRDlWAQmMxrvWc6Yecaxw
	Vkg7oswrba+dYlclZtpL6n3Igq73boJLLDH28S00Kk/IFplLnIpuuQSMvDprwpZTrYN2IV5k4qZ
	hCTPdIngMMsSzYpFix9R1HquGbbr1PdzDxN4525ctz6KHUwWP6iz8+ZR34QxUheevR31roYRAah
	FXcG2+XZhKs5xBvqDpMC+SlueIgIFbO3ziu8lL+IfHhLDJLJfWYn1PAQ4Xile5FZ8iSDINecOtb
	AQScBUg0kxbMynmL8RrYxqqzLItc3VF/aq
X-Received: by 2002:a05:6871:3313:b0:423:9219:4c6 with SMTP id 586e51a60fabf-4424195c681mr2963721fac.13.1781209718721;
        Thu, 11 Jun 2026 13:28:38 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-44244cd05c9sm1796134fac.18.2026.06.11.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 13:28:38 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V12 6/9] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Thu, 11 Jun 2026 15:26:03 -0500
Message-ID: <20260611202607.85376-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611202607.85376-1-macroalpha82@gmail.com>
References: <20260611202607.85376-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add functions for reading temperature sensor data.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Makefile         |  1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  5 ++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 18 +++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 76 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 37 +++++++++
 5 files changed, 137 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index be109102e203..c04953ed42ce 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_temp.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 28edc12d5373..53dd23509a53 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -114,6 +114,7 @@ struct inv_icm42607_suspended {
 
 /**
  *  struct inv_icm42607_state - driver state variables
+ *  @buffer:		data transfer buffer aligned for DMA.
  *  @hw:		Hardware specific data.
  *  @map:		regmap pointer.
  *  @vddio_supply:	I/O voltage regulator for the chip.
@@ -124,6 +125,7 @@ struct inv_icm42607_suspended {
  *  @orientation:	sensor chip orientation relative to main hardware.
  */
 struct inv_icm42607_state {
+	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
 	const struct inv_icm42607_hw *hw;
 	struct regmap *map;
 	struct regulator *vddio_supply;
@@ -363,6 +365,9 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms);
+
 int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 8073317088ec..549fe248e600 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -153,6 +153,24 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms)
+{
+	unsigned int val;
+	int ret;
+
+	val = FIELD_PREP(INV_ICM42607_TEMP_CONFIG0_FILTER_MASK,
+			 INV_ICM42607_FILTER_BW_34HZ);
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_TEMP_CONFIG0,
+				 INV_ICM42607_TEMP_CONFIG0_FILTER_MASK, val);
+	if (ret)
+		return ret;
+
+	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode,
+					  st->conf.accel.mode, enable,
+					  sleep_ms);
+}
+
 static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
 				 const struct inv_icm42607_conf *conf)
 {
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
new file mode 100644
index 000000000000..b259fc9c9fd2
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -0,0 +1,76 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+
+#include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
+
+static int inv_icm42607_temp_read(struct inv_icm42607_state *st, s16 *temp)
+{
+	struct device *dev = regmap_get_device(st->map);
+	__be16 *raw;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_set_temp_conf(st, true, NULL);
+	if (ret)
+		return ret;
+
+	raw = &st->buffer[0];
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1,
+			       raw, sizeof(*raw));
+	if (ret)
+		return ret;
+
+	*temp = be16_to_cpup(raw);
+	if (*temp == INV_ICM42607_DATA_INVALID)
+		return -EINVAL;
+
+	return 0;
+}
+
+int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	s16 temp;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = inv_icm42607_temp_read(st, &temp);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	/*
+	 * T°C = (temp / 128) + 25
+	 * Tm°C = 1000 * ((temp * 100 / 12800) + 25)
+	 * scale: 100000 / 12800 ~= 7.8125
+	 * offset: 3200
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 7;
+		*val2 = 812500000;
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 3200;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
new file mode 100644
index 000000000000..cb7b460ffb44
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#ifndef INV_ICM42607_TEMP_H_
+#define INV_ICM42607_TEMP_H_
+
+#include <linux/bitops.h>
+
+struct iio_dev;
+struct iio_chan_spec;
+
+#define INV_ICM42607_TEMP_CHAN(_index)				\
+{								\
+	.type = IIO_TEMP,					\
+	.info_mask_separate =					\
+		BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_OFFSET) |			\
+		BIT(IIO_CHAN_INFO_SCALE),			\
+	.info_mask_shared_by_all =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_all_available =			\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.scan_index = _index,					\
+	.scan_type = {						\
+		.sign = 's',					\
+		.realbits = 16,					\
+		.storagebits = 16,				\
+	},							\
+}
+
+int inv_icm42607_temp_read_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int *val, int *val2, long mask);
+
+#endif
-- 
2.43.0

