Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3E939FCD0
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624352; cv=none; b=G9U2lmqRlls3T0TBmZwZMBJM8W4qH1uq7hyzYCUNPSi4xcLZz5B/U8q6bKESYKcvvN2RXLlybhz+WU9PVAvqlRxtSzUO9bEuxcT75t21eyL9TKQpJRoMwTciKxNisoHeTutMocC/Ysq9YL8xBofpbgvgHFoiwO8/SYgVBEXsUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624352; c=relaxed/simple;
	bh=5tiygP0MyEibSSmzdl4sLfnDQPESqajswGrCcjbgRws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ht4pTGtlS7zz88yudRPz3x79wBPTHBuWpPsKFV41noJA9Fn1WHCadWR44wQHXESt3jpW2KvXEKsbB0u78iKRfk5uRx4LrvmkvBkwyFk4CNu7JeF2hXGNqvUkg03k9SjRs7VygU1pGvErKvW6J+fiNHx97sB8JjR0HpXeHAhrLY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvYXWOzg; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvYXWOzg"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-47c35be02fdso2416081b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778624349; x=1779229149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQUiNWCZX1aYVWDbsAKqRULLbV3tGsxfbdOEdlotGO4=;
        b=cvYXWOzg51XE7ZtYKLs19v7AxiTJWeNok4ElCtwSlFgVvc2A9EMa6pnXDCZ0RixKn1
         QXJ2vxSn0EeBXzPiLXoyrAbHMTwlEFCCMJyARN/M5SP+sx0ZE4d8BAIxdrcnfzjI0oi8
         l/kKUpk8aCmKU6+m5b1NOGiIId3uf1HAq/Rpk/xgJ5yyxBJXxA4Dd+Ffr2fwqfxA0Cj/
         yTNHWs8T9cwjN32G/3vIq2uyKtVsTg952D4JF2Z+/5BlnIDXhHJDexAbGHbxI8jZllji
         Ocja4eva0NQ6vY5eKjfXNvRInBdJSNqw63vr36nKSo5U4+RPbqiHLEkZAtHf+d0cT7GB
         l20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624349; x=1779229149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LQUiNWCZX1aYVWDbsAKqRULLbV3tGsxfbdOEdlotGO4=;
        b=JI5LKTG08x6wrLc/rBnVSsTfKHWOuyOOyFrDzn0KisJfkFWubv8Rf5z4AEDr8fOIdC
         7fFpzxutzOGiZRaMAXCcy5skMjgtIwNdb6zaCQ9T21F2k9tcNunsba/DE9L4YUip109b
         6Bl8uP25IKx31egFyTm/dxh9D5/diTXQmzlIXBoc6WPYokeM41C/a42wiTH0bFgjM19g
         IZpZ87AWRe5CuL03tCv1Q1tXOvjhBuwZ2tSFRT1bk65kxOrfrgZKENFifuXMMaMpLAsg
         nqoP9t4YRj1GoVzZpF2lNrmGodjWRUm6Dit6v0Ldr9xAhhB+v9JhCeRT3oO4N6FcHRrY
         Vwqg==
X-Gm-Message-State: AOJu0Yxj3PBDNc4hrtqfCN4rxnpQ43NuewKoTF8SNLyPcOZmbeHweU9v
	H+FBUGP2CYkE2dWlAeKOadNfaNaUTH1RiBDU2LP0ES/yM3ntxzbnxVwkpHLNFpyp
X-Gm-Gg: Acq92OFPT5pZ0Ma3lrI+SLUp5MafxnxtbBM/rx/pq1dHkPbgSK0JT2H8gDKOUEmInJ5
	fFoFe8V1WqR6lzFrbAv7fXLB0YgirooYsfy5DtnZA9elGRSENDJrDUUAGIHgadK/TUcy+7i1x2S
	8oqONzrnk5VPrTU129fmgwSoqEUbG82F4akOYAz6Fx5R64GrVWUSiJU1+12OfNImwUZIOPAkWq+
	8I0Tx7tv+joaWEKOXMwDNIeWlLfMehDaFsi77bNuKgb0Klv4hww4ZFUsZn8Tpd9jPTrHs4p0cMR
	MoLbVxdOtzhczrhvgfK+oYBfE/LsW1SZfJwpaNHteyZ/+7A3g5MiUcJwtrXlEB/HtN2EZ55qOOb
	9ISEqj+SCWHMUJee5IxrJfVYUTMuobov5KK5BOePjW4VtJp5hgjdwQP4h2H/p3QlUk+QbNgeTfA
	WLF/+6tMSNlxiPo9cUiyZ3
X-Received: by 2002:a05:6808:144d:b0:460:f435:2aa1 with SMTP id 5614622812f47-482b2e43247mr575511b6e.46.1778624349583;
        Tue, 12 May 2026 15:19:09 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f87sm23291473b6e.13.2026.05.12.15.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:19:09 -0700 (PDT)
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
Subject: [PATCH V6 07/11] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Tue, 12 May 2026 17:16:28 -0500
Message-ID: <20260512221634.256747-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512221634.256747-1-macroalpha82@gmail.com>
References: <20260512221634.256747-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 18 +++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 80 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 33 ++++++++
 5 files changed, 135 insertions(+)
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
index b00ee6a4d451..4e053281dc55 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -379,6 +379,9 @@ extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms);
+
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 3b5d5722ae39..9b10722af3ae 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -164,6 +164,24 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
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
index 000000000000..7e9cb072a011
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -0,0 +1,80 @@
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
index 000000000000..e03924e30866
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h
@@ -0,0 +1,33 @@
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

