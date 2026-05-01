Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE7F372EF0
	for <linux-iio@vger.kernel.org>; Fri,  1 May 2026 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777673669; cv=none; b=iy2a3lTnFC9shXL+NMG4cC2CWVXOnb/vKtfXkMlIs1h+PgTV/BQDPk7uByXLjCuOBJTr0ebKyQ0/CRs+TwPh139KFMqO3kto39MIbyosmLErrIFztyPNq2VQNAeHDiAmSYniWIODTX8EFGhmIK+KORKH005UfbXTwATQ60krYEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777673669; c=relaxed/simple;
	bh=lF7QCedSOkUGcSE2cP+szB/JK3hiS6PXZeJOMQ/AptY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8dme2rXAbujCtmZG1L2WS1+6BWeBDXhFSJN9Nv/jpRHQfx7XJJvoxGTjF58mT7WPd4WJfutTuQiBxqvUe6DsxSZPruBEGHGTJ2wHNk1xhn6uzXLMoawlo60J58MYMZWavzopfBh6oHOZAuCXhxD20rJyLOihNUoJLHJVYlb8GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sn1/K0hl; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sn1/K0hl"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7d4c383f2fcso2170088a34.0
        for <linux-iio@vger.kernel.org>; Fri, 01 May 2026 15:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777673666; x=1778278466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z30Dd0FKTgRVmezmpD8QgJ9YedwBpf1mjTnGZwNNn3Y=;
        b=sn1/K0hlgXz7KOnR7XPrEQLFg0D70pQAKwT8gGoPPqOp6B689Gwg5fPRlKJECKtjxO
         bAONGkPHYjSykPG1nGeOFS0czMVIDmsNyaPEWd1AupnSz0y1oSz+3dnFDZZuNr7hf2RZ
         s0mfPLB32aInFL99dtZXq/eTa1+ma6lDgrbsaAghYqDoaAJAl3gbigd63KGoCCD+8QZa
         ZIwWjrYMqtVVG64MZq5fPT0YxvPFFlS8VIidK7sH6SsrueZQTdTS9SyGSjemrzx9WNqu
         f3NDDo/GBFyJfWw+9K6Vm1J8NeFRGUy+NIKmCrvd+pL/cferV+Nsh709EU9roVYRs/Hv
         I5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777673666; x=1778278466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z30Dd0FKTgRVmezmpD8QgJ9YedwBpf1mjTnGZwNNn3Y=;
        b=m/kHDmyRyfTaIrY1cv8M5eUNhcGgCLthGrd+EmlJLa5Psci7Npc+2LgWD1zLwYNqi0
         CixO5xXmMyeIZAXxK/CiPTb2/bpKYrkdrUOpwB5Th0Q9r4Rg6zKAkNFCvY31m4eVp+HX
         D+KPF3PvnSb2+NTexAmBusZ5UVaIOWXEsGboTuYmuvPdoD4LwTlB2wK9Nj3EQ1Goi9dv
         mrN6ecU0a9fMpHgHg6yQ5JsWv5mbEJNonuFnJXnRztbVOI5wjIwL5wQ/MCPiutf2bUeI
         aiek5fvY53rzxb/syOEhC6n3xPkcRZFUdpJO4kaWlwiItzlS/M0qXqHhiTaPKs1fjrFw
         Y3rg==
X-Gm-Message-State: AOJu0YzlrqYRdIgN030qxTwKG711qxad/alBUJ5TTU77fM1lArecZg8V
	qotMt79BX2uYNZjpO8wxid4AiY6Aw7PueOWzRU30+ptKwv4KaPdJV7KM9a0Mhg==
X-Gm-Gg: AeBDievtZF4y6s1MbKoXiTLUa82deLkdI1hPynNcTWqUIgrM1PF09CA5oKnLhL/3bkp
	/3BU1545T2ui0JSJn4RBhI1A8t4lDd4hgJskuZik5uu00X3Ehh+7wEvXxgQKlY3FwtL7ONdJ39S
	itN4IRa8wCOelw2iJcB2Mfeia6s/IMogNbeks5MnCeJecDHm5iYB3Dyy72RJz+WRPCdc6rp4lS1
	JXRdHr/OCyEgit5fcDPpxUHysj++652mKgv9i5Kh8xU9CMUFVUiWaH/UXke+6kly+HMk7wDNM7p
	4cbIUbg/43+HkI7BAQGc+3NJvTtJsSoY/7K4kKXi0kPkwsO3dG6JWWCe/r1cMIZVcIJ85gJS9Jk
	Mhbw3GywsS/yVpF7D8ADUgP5JoyPTmYmZGd50Q7xeDmvAtKNhWRIDP1B/qCbhYt1j9u5OFcA71J
	SOQqHsW8u/88Ls2T7qSenOasjI7NlPgKI=
X-Received: by 2002:a05:6830:3142:b0:7dc:d2ad:fb29 with SMTP id 46e09a7af769-7dee14654edmr892564a34.24.1777673666546;
        Fri, 01 May 2026 15:14:26 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ded51a9612sm1827337a34.26.2026.05.01.15.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 15:14:25 -0700 (PDT)
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
Subject: [PATCH V4 06/10] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Fri,  1 May 2026 17:11:45 -0500
Message-ID: <20260501221152.194251-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501221152.194251-1-macroalpha82@gmail.com>
References: <20260501221152.194251-1-macroalpha82@gmail.com>
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
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  3 +
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 17 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 81 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 30 +++++++
 5 files changed, 132 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index 3c9d08509793..ccb8e007cdeb 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -3,6 +3,7 @@
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
 inv-icm42607-y += inv_icm42607_buffer.o
+inv-icm42607-y += inv_icm42607_temp.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index fd860685d0ad..05b5a246e384 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -399,6 +399,9 @@ extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms);
+
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 7b9c05df820a..77b9a633d31a 100644
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
 
 int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
 			     unsigned int writeval, unsigned int *readval)
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
new file mode 100644
index 000000000000..bcc11620c74c
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
+	raw = &st->buffer[0];
+	ret = regmap_bulk_read(st->map, INV_ICM42607_REG_TEMP_DATA1, raw, sizeof(*raw));
+	if (ret)
+		return ret;
+
+	*temp = be16_to_cpup(raw);
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
+		return IIO_VAL_INT_PLUS_NANO;
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

