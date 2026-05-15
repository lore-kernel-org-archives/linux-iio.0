Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3853043C8
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850170; cv=none; b=HSeetcKdu7Z0dlvsfJG9vi4RySa06HpPoElGX25jD89VjGZYNtWT97GOaPJipeUDPRCWJaZ6IVn9EaK2Ie9rXh2SamoTUuvGgjz00Ns8jhsjZ7gNw+/AdBZAjIjZ5wgtS04c+Viws0q5LTwG+TScQvmRTanS9aiFqscJKVAl6kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850170; c=relaxed/simple;
	bh=e81UOSwt1ExtyN+K3gVhNgT6GRw+B3qxUtaA/JfLQJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hk4DpNFXfACs5CvdYRi0CMsSjly6jijaWUVXc0OEhBm9HQcLNo02tiKkUs4ErO6+9spbzqNK/tlyFmcipDOnjigqmOkvDvcTluvO7b1/V6WND0xHqrfcdKmkrof47/zem1rFMu2tgfZHo7rywesy5JwJowOBdNyeaIcfnwwhNTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILMwiZOn; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILMwiZOn"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dcdd1b492eso1189483a34.1
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778850168; x=1779454968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Y2OV2cc3iX7IKI47a9x0/0LXCU3agE/55sUdLS/+ps=;
        b=ILMwiZOn4ghhsxwUhVNofY/yAXTWZxo4i0jQ/8qpQTGTQJ+fg2Xsz5C5XTI+mXEWyP
         +QsJJxY7mt0PcOpOqrXqmZyGZnxSSkTQf0O0GIp65jrvXh6oN0GC84g4BfraS58dSnZM
         eRD/6DDiz8TonRSTmUO59ADL6ZMPWQ6jzYjT55Sro2Zq0AfP9N8Xf0wqA3QU5HswtfRq
         p7jDu1hVEv5CTRm6xxJMI8KwXyAIQMZm5t9GrGyI3GE3a9BIPb0R/5qEhT6PZA/vKpbk
         FkNGnt+E/cA/pyBh1mc4BCNciyROCs4yCLWi1vFRP/32P7DgsDoTOL2hTWt5NugRGvU/
         S9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778850168; x=1779454968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2Y2OV2cc3iX7IKI47a9x0/0LXCU3agE/55sUdLS/+ps=;
        b=sfWdwAOT2voVfUuIDW0LNy1BA08ANrz0T+IxxAXLFpbaRdFsqr8vvLHTROmzjO3vmF
         neUiSZJ2vZ1OUlT4QNqwAndkL9VM5f6w2Ecww4qVdjvaYLlHtQIKXe4ypp2t5TYnHJeT
         yjmHErQ+5bNAls3MIdOkvT6n72qD1SKMEynHanSlg4ENK1TTnP14JBtNWm8Fw3LWple+
         CYiHWdH/2Q7IsUWUAQA4o/x+WizKW3w19RIR/zntQ5TIGDd+rRcWxEdIJUHuYx3QSorE
         2v6u1h+r0T4MbGO3ilxQ0da9xd2fQ+oszczoSwmV5N5/VRQKH0EEm5OA/gYrf8JkyjMe
         /mnQ==
X-Gm-Message-State: AOJu0YyhFP7GYsf2UrRk6CogyrkOyjlB7kjoSaNMld4khZyVnUhKzoZn
	FK50B1eMIVYOD61+djU5ij26of/m/9DG7oYQaLouiJUAyxh0/OptbHuxnUH87WTu
X-Gm-Gg: Acq92OEKoKNzWFcrM5qdoKNFKwZyDioqpTae/H8xZV74yGYQ9NxEuF9thm6sDvpGatw
	fBhYHnJq+qe1ihn8WNYHRpPdImZY/2yKmtXwtTrmcX35zn8Lcu0FQwuq6f4IzCEq1ShtE87/jB3
	p4XHrvGjwf6Qua6H3pTc9AWYWAyvbIUK9dMjLa/U4vDLecDC2MnGGoFJanLdRrZxySpHgc50f4B
	OqohuTal8GPLZH5xPYnJOgjPFNoy77AzS4QVkA/zmEPNfSowDNa530brbbz/INXWINVFh2oYlje
	FSpXEVspr2Co1559H1rqAFaPCwm74ze+x/6FE9DWSz2VHyUGknSuyrmAJr7TJQhJAa2RXvxLYtI
	YFu8KuQ1zkBA+nCwIX4cHNwcco53ko9CeyqZ/ZXI+WtnYoliAOB2LfQ6tF7PlrCujEZp+anqckD
	t0fhZpzGTNRjeynE7aIKpS+M22fDGTylMd8hXagEk42Q==
X-Received: by 2002:a05:6830:658b:b0:7db:a297:9e62 with SMTP id 46e09a7af769-7e3f1030402mr4593862a34.8.1778850167599;
        Fri, 15 May 2026 06:02:47 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:8c2e:6a8e:445a:9169])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-439fc53f2acsm4155822fac.14.2026.05.15.06.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:02:47 -0700 (PDT)
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
Subject: [PATCH V7 07/11] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Fri, 15 May 2026 08:00:12 -0500
Message-ID: <20260515130018.237378-8-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515130018.237378-1-macroalpha82@gmail.com>
References: <20260515130018.237378-1-macroalpha82@gmail.com>
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
index d5885fc3f7da..9d6d7d13c9b9 100644
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

