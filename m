Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A255E38228E
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774900873; cv=none; b=eCqFihXqyyvNbz7kyNktVIWrdwJ/jnagJZfbUF31V45T4hOEr1hWkWjcq0uGsR03tUPI8p3i2iOEKJSQGLqZRftH+g8d+fL5cN34IwOXgQ2pgwc01UPMj/lPWlLQeeUSA9J9EPZlMk5lVwbWPkkqAMu6SHU8n64ZWIYjeykKUic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774900873; c=relaxed/simple;
	bh=Xs9lGcQr3vh2kOxJ0ps8lvdkpLVd0ZsYIGuNSTQXvvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AgA61hPSDIiEW4OuMb7diTSFGUNt33A8ZAcBIRbzhW3jFRqXltdo7RS8uSSBEpaYREsi6bSOtK3WbkkF4uVWYFTcCJ6thIKbzETECmed0lIgyo2qq/1G1/e9CqjK98TymxFb9QVEDG5H2PJGKg/mSEC+7TfNJb08ABSx6IUA3Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv01OlsH; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv01OlsH"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7d50516e9so3176424a34.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 13:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774900870; x=1775505670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lmj/IpYbpug3+Jmewmp2pYfCElRex/Cu53kFOv8ipzs=;
        b=gv01OlsHpcvDfhMXWQg349QJAG9l2GHaAFvvD6YONBIwaFaDHO9BWecRfSNZdCTkiP
         d4axw6NGi9c1umLmCGAL68nqWJxmVNXVZD+T3d4eyOeuqFraUWp1hELXGshVUmD0uaZh
         mDFUM+8l4OoamCDY3n0nI2SZUIN02CcBOnhpPe2T3+vnXHEKthFWML4gJapaAQDIs6xv
         pcTt+X+1fZhHhqfOumqTEb7OMxmoWkToqsc4hbvXgzNGpsgOHlRHEZg/yPlXeXT/ikFf
         LRgwop+XfGbyn92QfJ5axXWudZJzcK6iAFSiCYFPzqdwT5o1rNvEMx333yTcxIbi5ANs
         sBsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774900870; x=1775505670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Lmj/IpYbpug3+Jmewmp2pYfCElRex/Cu53kFOv8ipzs=;
        b=Wkh1ecJRQNu/wGIvF4eQ1n52/BYFVubKfUoIIh2zvlA+i1w3R6Na7nvsYsd2CDAInI
         Ta+sXB6gqJ8uKMLtAMI2Ck3T80lhjdQ85aDEXSsDT1zOv7Eg1eXEIir9atTMKRRNdayD
         Kt95Ba/kANwB4Q7EbTXubFjhxvhlr3CL/rktqZ/eg7p6CSX5AWWj0qqb5kByJBDCR1qj
         WIFNbFHK8s5G3V6Uk+6dAbkqXp8iwCyYt9II0qyjJdbmCAB8GmP/VGg5rtFnKGbOFoOT
         x0i1v/c86i0fiW4Doywq9POIoa1AzpYc4GccaF7Qh33QI3mmBWFi4CDi57x4JCPK2/w+
         ZP5A==
X-Gm-Message-State: AOJu0YyIRc0mR/+GgxKutz28AVl9kgKMX54CY5RjFRUxfBQxeq8Bn/Al
	X1l9TdS1c3bWaXsD4sf2ULtz6ES6y7nm6InVZW6F/q64Dkffm0PbukHWJwhQdChr
X-Gm-Gg: ATEYQzw0hwbocB42pvFx0o1ywBAzrOnAnkM3QA2uOT1aiMKGv5ORslEwPGeqg0UMIZD
	k8Ld0kSJqLe0nLRkdA5kvKJU+521kn8L1YOrdVuNwe1PYepvo0K98+/0AB3EpUX4N6ZMj51+Byd
	htI19BLrGx/nxHx4dzgNwPZ4Obl/p1XTrLIPM1o1PGlO9ll9ZzFVtQuligvagHIVwnqQLh1pEi4
	v7jdo2zhmkqXOCKiY862sb86r+04JLfLR3z1pSXpIEfYtYIp2VH2azLCkisLBqhRtb5rz5+PwFK
	32/liGhhZb42GuG3jGCm/EjNAat4eif0NCn//kU9xbCUKrJWBZINH2MV2dP8bdwQPnWoCWKKF2A
	FIrcTCrGHD0moFs+zawF4s8R49Gxqos4HhKvRR/4jm8zzcfjBZ25kSPGY9/idx68KbsKspL6i0P
	K4N6yXgNFT3+jXL9jGNGB2
X-Received: by 2002:a05:6830:3819:b0:7d7:e57a:bcd with SMTP id 46e09a7af769-7d9faee63b7mr7314213a34.20.1774900870107;
        Mon, 30 Mar 2026 13:01:10 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a336353sm6601068a34.2.2026.03.30.13.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 13:01:09 -0700 (PDT)
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
Subject: [PATCH V3 5/9] iio: imu: inv_icm42607: Add Temperature Support in icm42607
Date: Mon, 30 Mar 2026 14:58:49 -0500
Message-ID: <20260330195853.392877-6-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330195853.392877-1-macroalpha82@gmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  3 +
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 17 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 81 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 30 +++++++
 4 files changed, 131 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 5530fd3bc03f..086848c8fd3b 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -433,6 +433,9 @@ extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms);
+
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 344071089042..735a262dc103 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -164,6 +164,23 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms)
+{
+	unsigned int val;
+	int ret;
+
+	val = INV_ICM42607_TEMP_CONFIG0_FILTER(INV_ICM42607_FILTER_BW_34HZ);
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
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
 {
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
new file mode 100644
index 000000000000..b42eb78cd960
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/iio/iio.h>
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
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_set_temp_conf(st, true, NULL);
+	if (ret)
+		return ret;
+
+	raw = (__be16 *)&st->buffer[0];
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1, raw, sizeof(*raw));
+	if (ret)
+		return ret;
+
+	*temp = (s16)be16_to_cpup(raw);
+	if (*temp == INV_ICM42607_DATA_INVALID)
+		ret = -EINVAL;
+
+	return ret;
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
+	if (chan->type != IIO_TEMP)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42607_temp_read(st, &temp);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = temp;
+		return IIO_VAL_INT;
+	/*
+	 * T°C = (temp / 128) + 25
+	 * Tm°C = 1000 * ((temp * 100 / 12800) + 25)
+	 * scale: 100000 / 12800 ~= 7.8125
+	 * offset: 25000
+	 */
+	case IIO_CHAN_INFO_SCALE:
+		*val = 7;
+		*val2 = 812500;
+		return IIO_VAL_INT_PLUS_MICRO;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = 25000;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
new file mode 100644
index 000000000000..d0bd6c460ff2
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#ifndef INV_ICM42607_TEMP_H_
+#define INV_ICM42607_TEMP_H_
+
+#include <linux/iio/iio.h>
+
+#define INV_ICM42607_TEMP_CHAN(_index)				\
+{								\
+	.type = IIO_TEMP,					\
+	.info_mask_separate =					\
+		BIT(IIO_CHAN_INFO_RAW) |			\
+		BIT(IIO_CHAN_INFO_OFFSET) |			\
+		BIT(IIO_CHAN_INFO_SCALE),			\
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

