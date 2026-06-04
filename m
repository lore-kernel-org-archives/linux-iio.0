Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E349E3F6C5A
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 20:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604459; cv=none; b=JOEOY4p85egYu+aDopyOX5D7qX1k570Y8Gwi69Dx/OsAKjPGkJVSJ4nZHD7y15ipo9RH2ve4vYzfSvmIY/sD2LKuCbccpUBydkM2FWw6oL0JrKn54lMJcpMwVPY9tzLC0CtCNe8nnudzg288wPz2wVmhNn8jj6smN9bvJb1AT8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604459; c=relaxed/simple;
	bh=BTzJ924pmra3EwEcYOvG+V/PO924zZs6LGJaztLlGnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e//ytu8PKqFWez36Cp4eRTOAq4OXnZAyKij+Oai5f7hsW9vTOzbPSOEwZ8YaXBU58z2RiFAxb7eV7xmN8s5r9k0nrr8nUc7GvTOlaOQSbU5/FRcS8TRRCdNMDLU3QaJw7x7lAnu2ITHhwzvDMXMxKJEPCcucaJj/IdaLe+0DIm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxpGlfMh; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxpGlfMh"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e6b5e09a96so865342a34.3
        for <linux-iio@vger.kernel.org>; Thu, 04 Jun 2026 13:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780604457; x=1781209257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpQDLS8ZoARSZkj6MTlVfd7g2UIh+WsARYUcUwqipgs=;
        b=VxpGlfMhLf7F9DigpXTuwItEB9XEB/ZPxkOQQYoZoDN51zEwYAupCCsdjClcfHqvWF
         lvAfd0YgjlUN9no68+HIjgdhWoSP4dgOlVB+tYcBFQJ07BQ5t10/syzqUXXCdQSZw7EA
         E/sEr4CHfruvi2MQ2UPK6kJX1cpk0nd6sIUEXJPBdc/jiJLNu/FgMoWoLqbupJLFabYh
         HKYumc0ftFO2r3lyt/S5o/w+f6GaVjbZfBjjOJ+i1Fb43kWhCckSJmGUF93+dXDgG0O7
         FHMAxBkMnLEUTiD+IgF21RsM54Yr6yL/XBXshndlmMCocztLY08EVx7/NYkdey9PHa6j
         Q3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780604457; x=1781209257;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kpQDLS8ZoARSZkj6MTlVfd7g2UIh+WsARYUcUwqipgs=;
        b=EHrJZopWzUeH2aQH0p4qkgqhlHMqEC5Qi2WYBG2LIiuH+XE8rszwZzGGffHVrVkG2O
         xW/GQ+xV57aSrPvzbVAPKB8WYj3heRgu49POOIxEK209zo9TZG8r/uSzLEJGBJFYBhCp
         hE3evW4/0ADo2I7Irs6RmlMWY376ViD/u1lH/XYN6N4+rdBjPNYOnKKnxFMhWZBgIx37
         TvTSmkYFzyNr4n9NL1t2kylotS5BxqkN6VKRhGUpG/qOimNw2boECMlvD8V0Kmvx020K
         3HeTh3Abd1mBd3AZCPeGDALxNt+A4m0GqWUI4FD43tTa2ADXV0R4vl2LZeTl710qC3wg
         B90A==
X-Gm-Message-State: AOJu0YwmL9Q8ziaWMObK0IRbqvzRvNFWKvGHwG7azpbcwd70FOxsOUR4
	Jco3mssGP7c07+K4J3AcLYXJKciqTileiJ2do/l49cSeLNB1CSUjdVUMtSOxccp0
X-Gm-Gg: Acq92OGsObGXMuIbuacwAQ3BWIZQLodqdQryGoadJgXddzg8oV5T+9TVs04nIgG7VSP
	PRZJnm+7MHGtppCre1YvfYCm1OudJgeVp5uPphDLjwOw56Ypf/XeZqvUVaEr7JwJuGXn9WR4dVK
	HH4IgoBpRTA4ciQ9pY/sn2AVb+g+thilnpCW0IRrp0tCDTkNDTIzSNdtG1ONj5iaVcXNZkA6FoN
	AP3MG6vgRZyLZcQ9UTMVtUElu7g+15BHWLlHkyALCK40czYAAPr6xATeSksYj74veEcRMrsjDTK
	ntUIj0j96T8xWeOj2PXLMA/E5T7hEikSgIBN6/zoHfxJJatyf6uB8iTdqpJ6HK6Fdi2kulMKDkE
	qqcHVD1f4mZXPT0osp/Rbk65Ozv/gu8qLBR+zXvIJJHqp6Bnw4zXUtM357etEWwerp5+MP7W/us
	POLWla6NqHS8LukiKPGjEnIAnETaWyDcY=
X-Received: by 2002:a05:6830:829a:b0:7dc:dd58:50ab with SMTP id 46e09a7af769-7e70c7c8b1dmr140279a34.14.1780604456988;
        Thu, 04 Jun 2026 13:20:56 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e6e796c675sm4541800a34.24.2026.06.04.13.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 13:20:56 -0700 (PDT)
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
Subject: [PATCH V10 6/9] iio: imu: inv_icm42607: Add Temp Support in icm42607
Date: Thu,  4 Jun 2026 15:18:28 -0500
Message-ID: <20260604201832.60656-7-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604201832.60656-1-macroalpha82@gmail.com>
References: <20260604201832.60656-1-macroalpha82@gmail.com>
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
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 18 ++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.c  | 82 +++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_temp.h  | 33 ++++++++
 5 files changed, 139 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_temp.h

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index be109102e2035..c04953ed42ce9 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_temp.o
 
 obj-$(CONFIG_INV_ICM42607_I2C) += inv-icm42607-i2c.o
 inv-icm42607-i2c-y += inv_icm42607_i2c.o
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 72327381b6dbc..13a5b06e80142 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -120,6 +120,7 @@ struct inv_icm42607_suspended {
  *  @orientation:	sensor chip orientation relative to main hardware.
  *  @conf:		chip sensors configurations.
  *  @suspended:		suspended sensors configuration.
+ *  @buffer:		data transfer buffer aligned for DMA.
  */
 struct inv_icm42607_state {
 	struct mutex lock;
@@ -130,6 +131,7 @@ struct inv_icm42607_state {
 	struct iio_mount_matrix orientation;
 	struct inv_icm42607_conf conf;
 	struct inv_icm42607_suspended suspended;
+	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
 
 /* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
@@ -361,6 +363,9 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
+			       unsigned int *sleep_ms);
+
 int inv_icm42607_core_probe(struct regmap *regmap,
 			    const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 39620da92bd43..a438e6fbe508b 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -118,6 +118,24 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
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
index 0000000000000..55260082a19ed
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_temp.c
@@ -0,0 +1,82 @@
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
index 0000000000000..e03924e308662
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

