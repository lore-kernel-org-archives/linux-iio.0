Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85893B27D6
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 19:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778354509; cv=none; b=kvzv5lebLsIRr10qcARz87S4zWi1gT8oXxfDVa/vl6M4vnAZqu6z8rDKKdjCSCmh8WXVnOADM/4tno+r6UKUeFfE7IBmMuEm/bYwt4nNiodaXYEwIJCnp6ojXrkBDxUcEz9X34hFPzibhEzFMoPuANHd0UUmp40sskbNdQR5aaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778354509; c=relaxed/simple;
	bh=BwmmUrCJk/evyJ36X5GQhBrKdqU4dWSDDMhmuE+P/Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cFlcuHNFk9lOz9HCUaQm1LCOCCHJhgop1PXL/P1MGHsSuexfAkqG/VETtrfg5z6K583vG5I12y2qID22hUHopRSVz5wK0D51NObbdCawnvvpOCuPG5j69DEvwE3IdPKjCyZmzaZ/Xf42F9vBkgVnd880MMKzRF5Wej51FfefaMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/eue12h; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/eue12h"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-694932346a1so1109976eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778354505; x=1778959305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8cAxdIM1hCpdxsTlA9AKLH6BR1F5DCS0vdHxOxQXqA=;
        b=N/eue12hP7PXFq9rG5U9ks6m7BFYrE09TLiwVQJEJ5KWkuSBKx1myD1RoOP9Gx5/5F
         s6wfMLmcSUdnuuZeoVypjmGaPP8nAKaNPsgzlXjrsv4n5J28hqq3YScpk+Pie5mXDvcY
         /JFHQnYA/CnIWIZBc0/ZDhNGxAorQpHGHfl9R4fzgdnWWZlVZnjNqrCli8bhjQXnCnXk
         HuGsA5HhsrySbk9zbgrrSHbFt9oXIhwoWUUn8uTbgsDqf5Q4CvOfWhhkOqC4a9R84k6O
         k1rwgTLF3AGhBScwTzhE7uWco/auIWXLDTOlGJN+WY3djjAZ5Z8Z7G5nMR5EpL7sE1Ru
         LTjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778354505; x=1778959305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8cAxdIM1hCpdxsTlA9AKLH6BR1F5DCS0vdHxOxQXqA=;
        b=l3/V2E2OvDh2qSmOZX6bXKLuN1VYrGn2kscn8/eLKkPq2tyFaJ1K9ufdtXYMPfEXJu
         OuuAE2V5ZGm1V3PTtJabKeQsMrvn7cCov1nHePWN51WhunPlm5k+/l/ArL48HjCLUkPt
         +HQ8AU2hopJpvptw64UrIkvnJMiNOJCuWO+aUGnPVdCZ9Ce915bDLmWvxX937VX7vqbv
         Ld7xWHsM7PzCd1zNAMyyQT1Qu7FcF550u/prVzV/Y8Q+zBoyu5j/Uj/MuUGv8FeM4loA
         vA3acawt4+3oOm7zFugWDGAuHm9it+1HGS6lzmH0rlF4VejdVufHIn1DOb2xp5vq/zGa
         R8aw==
X-Gm-Message-State: AOJu0YxeQxyRYOWJaYuMqSr1A41zrj9kgZEyuVwIE9D6+AshWB86pd1X
	2fzi2G7myZ2XIC9O6z9qPAyubTvRdskU6ZiSKPg7HbVwZgqn7sCITbR86x9+xw==
X-Gm-Gg: Acq92OE+cFC4zT1vIkVH7RRqLwSKGbwO8YY3UeSfugfayTj0sIYMZ1WHlfyb3oWBWyD
	KeG9I5v7aTm+ddc2NGwvhxfmQiwjotxNl5soiEkumt+45KXs9uU0XknZNsMtoUTHjkLRBrq+fUU
	Pv0sRkdab2G7N9LWDgovs/6RbPIrWtQQo9cIaYWN6FqR6yaAlt92+ufowKy+FxeyHCj7K+4KsbV
	L6JMfSw/LL3xhuO94W4mGq9HOECwIlYqZ6qS/X9RXfIpG9hPbsLw707eR7WuEQnF1luHR6zQukd
	gVK6SDB7LFqCF/hB09xFc7ckdwMeuf6GHfVywUdrFYCMx+i3cry3xGt/vSSRQXDBUpS3Fh/3B0R
	gqOyjmRSfBW2cACybTC4JoBRejoK8D/7kvmL7xe0MHcn3xO+fIjNFiEETI0eG9pNVcBC4wn4iQ4
	6MjMxIeV8WoD0BdI9G+1JayGsuvO/vHMc=
X-Received: by 2002:a05:6820:190e:b0:67e:251a:bd3e with SMTP id 006d021491bc7-69998cc5fcemr9472300eaf.18.1778354505185;
        Sat, 09 May 2026 12:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm5243896fac.12.2026.05.09.12.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:21:44 -0700 (PDT)
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
Subject: [PATCH V5 08/11] iio: imu: inv_icm42607: Add Accelerometer for icm42607
Date: Sat,  9 May 2026 14:19:02 -0500
Message-ID: <20260509191907.24734-9-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509191907.24734-1-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add icm42607 accelerometer sensor for icm42607.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/Makefile         |   1 +
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  27 +
 .../iio/imu/inv_icm42607/inv_icm42607_accel.c | 574 ++++++++++++++++++
 .../imu/inv_icm42607/inv_icm42607_buffer.c    |  63 +-
 .../imu/inv_icm42607/inv_icm42607_buffer.h    |   4 +-
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  |  74 +++
 6 files changed, 739 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c

diff --git a/drivers/iio/imu/inv_icm42607/Makefile b/drivers/iio/imu/inv_icm42607/Makefile
index ccb8e007cdeb..e908d77c4219 100644
--- a/drivers/iio/imu/inv_icm42607/Makefile
+++ b/drivers/iio/imu/inv_icm42607/Makefile
@@ -2,6 +2,7 @@
 
 obj-$(CONFIG_INV_ICM42607) += inv-icm42607.o
 inv-icm42607-y += inv_icm42607_core.o
+inv-icm42607-y += inv_icm42607_accel.o
 inv-icm42607-y += inv_icm42607_buffer.o
 inv-icm42607-y += inv_icm42607_temp.o
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
index 06deebae5230..cfda60905d71 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -82,6 +82,17 @@ enum inv_icm42607_filter_bw {
 	INV_ICM42607_FILTER_BW_16HZ
 };
 
+enum inv_icm42607_filter_avg {
+	/* Low-Power mode sensor data filter (averaging) */
+	INV_ICM42607_FILTER_AVG_2X = 0,
+	INV_ICM42607_FILTER_AVG_4X,
+	INV_ICM42607_FILTER_AVG_8X,
+	INV_ICM42607_FILTER_AVG_16X,
+	INV_ICM42607_FILTER_AVG_32X,
+	INV_ICM42607_FILTER_AVG_64X
+	/* values 7 and 8 also correspond to 64x. */
+};
+
 struct inv_icm42607_sensor_conf {
 	int mode;
 	int fs;
@@ -120,6 +131,7 @@ struct inv_icm42607_suspended {
  *  @suspended:		suspended sensors configuration.
  *  @indio_gyro:	gyroscope IIO device.
  *  @indio_accel:	accelerometer IIO device.
+ *  @timestamp:         interrupt timestamps.
  *  @fifo:		FIFO management structure.
  *  @buffer:		data transfer buffer aligned for DMA.
  */
@@ -134,6 +146,9 @@ struct inv_icm42607_state {
 	struct inv_icm42607_suspended suspended;
 	struct iio_dev *indio_gyro;
 	struct iio_dev *indio_accel;
+	struct {
+		s64 accel;
+	} timestamp;
 	struct inv_icm42607_fifo fifo;
 	__be16 buffer[3] __aligned(IIO_DMA_MINALIGN);
 };
@@ -373,12 +388,24 @@ extern const struct inv_icm42607_hw inv_icm42607_hw_data;
 extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
 extern const struct dev_pm_ops inv_icm42607_pm_ops;
 
+const struct iio_mount_matrix *
+inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan);
+
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
 
+int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
+				struct inv_icm42607_sensor_conf *conf,
+				unsigned int *sleep_ms);
+
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms);
 
 int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw *hw,
 			    inv_icm42607_bus_setup bus_setup);
 
+struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st);
+
+int inv_icm42607_accel_parse_fifo(struct iio_dev *indio_dev);
+
 #endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
new file mode 100644
index 000000000000..f90ba46bd7e4
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
@@ -0,0 +1,574 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <linux/iio/common/inv_sensors_timestamp.h>
+#include "inv_icm42607.h"
+#include "inv_icm42607_temp.h"
+#include "inv_icm42607_buffer.h"
+
+#define INV_ICM42607_ACCEL_CHAN(_modifier, _index, _ext_info)		\
+{									\
+	.type = IIO_ACCEL,						\
+	.modified = 1,							\
+	.channel2 = _modifier,						\
+	.info_mask_separate =						\
+		BIT(IIO_CHAN_INFO_RAW),					\
+	.info_mask_shared_by_type =					\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE),				\
+	.info_mask_shared_by_all =					\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.info_mask_shared_by_all_available =				\
+		BIT(IIO_CHAN_INFO_SAMP_FREQ),				\
+	.scan_index = _index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = 16,						\
+		.storagebits = 16,					\
+		.endianness = IIO_BE,					\
+	},								\
+	.ext_info = _ext_info,						\
+}
+
+#define INV_ICM42607_ACCEL_EVENT_CHAN(_modifier, _events, _events_nb)	\
+	{								\
+		.type = IIO_ACCEL,					\
+		.modified = 1,						\
+		.channel2 = _modifier,					\
+		.event_spec = _events,					\
+		.num_event_specs = _events_nb,				\
+		.scan_index = -1,					\
+	}
+
+enum inv_icm42607_accel_scan {
+	INV_ICM42607_ACCEL_SCAN_X,
+	INV_ICM42607_ACCEL_SCAN_Y,
+	INV_ICM42607_ACCEL_SCAN_Z,
+	INV_ICM42607_ACCEL_SCAN_TEMP,
+	INV_ICM42607_ACCEL_SCAN_TIMESTAMP,
+};
+
+static const struct iio_chan_spec_ext_info inv_icm42607_accel_ext_infos[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, inv_icm42607_get_mount_matrix),
+	{ }
+};
+
+static const struct iio_chan_spec inv_icm42607_accel_channels[] = {
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_X, INV_ICM42607_ACCEL_SCAN_X,
+				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Y, INV_ICM42607_ACCEL_SCAN_Y,
+				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_ACCEL_CHAN(IIO_MOD_Z, INV_ICM42607_ACCEL_SCAN_Z,
+				inv_icm42607_accel_ext_infos),
+	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM42607_ACCEL_SCAN_TIMESTAMP),
+};
+
+static const struct iio_event_spec inv_icm42607_motion_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE),
+	},
+};
+
+struct inv_icm42607_accel_buffer {
+	struct inv_icm42607_fifo_sensor_data accel;
+	s16 temp;
+	aligned_s64 timestamp;
+};
+
+#define INV_ICM42607_SCAN_MASK_ACCEL_3AXIS				\
+	(BIT(INV_ICM42607_ACCEL_SCAN_X) |				\
+	 BIT(INV_ICM42607_ACCEL_SCAN_Y) |				\
+	 BIT(INV_ICM42607_ACCEL_SCAN_Z))
+
+#define INV_ICM42607_SCAN_MASK_TEMP	BIT(INV_ICM42607_ACCEL_SCAN_TEMP)
+
+static const unsigned long inv_icm42607_accel_scan_masks[] = {
+	INV_ICM42607_SCAN_MASK_ACCEL_3AXIS,
+	INV_ICM42607_SCAN_MASK_TEMP,
+	INV_ICM42607_SCAN_MASK_ACCEL_3AXIS | INV_ICM42607_SCAN_MASK_TEMP,
+	0
+};
+
+/* enable accelerometer sensor and FIFO write */
+static int inv_icm42607_accel_update_scan_mode(struct iio_dev *indio_dev,
+					       const unsigned long *scan_mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	unsigned int fifo_en = 0;
+	unsigned int sleep_temp = 0;
+	unsigned int sleep_accel = 0;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	if (*scan_mask & INV_ICM42607_SCAN_MASK_TEMP) {
+		/* enable temp sensor */
+		ret = inv_icm42607_set_temp_conf(st, true, &sleep_temp);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42607_SENSOR_TEMP;
+	}
+
+	if (*scan_mask & INV_ICM42607_SCAN_MASK_ACCEL_3AXIS) {
+		/* enable accel sensor */
+		conf.mode = accel_st->power_mode;
+		conf.filter = accel_st->filter;
+		ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_accel);
+		if (ret)
+			goto out_unlock;
+		fifo_en |= INV_ICM42607_SENSOR_ACCEL;
+	}
+
+	/* update data FIFO write */
+	ret = inv_icm42607_buffer_set_fifo_en(st, fifo_en | st->fifo.en);
+
+out_unlock:
+	mutex_unlock(&st->lock);
+	/*
+	 * Choose the highest enable-delay time of the two sensors being
+	 * enabled, and sleep for that amount of time.
+	 */
+	msleep(max(sleep_accel, sleep_temp));
+
+	return ret;
+}
+
+static int inv_icm42607_accel_read_sensor(struct iio_dev *indio_dev,
+					  struct iio_chan_spec const *chan,
+					  s16 *val)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->map);
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	unsigned int reg;
+	__be16 *data;
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (chan->channel2) {
+	case IIO_MOD_X:
+		reg = INV_ICM42607_REG_ACCEL_DATA_X1;
+		break;
+	case IIO_MOD_Y:
+		reg = INV_ICM42607_REG_ACCEL_DATA_Y1;
+		break;
+	case IIO_MOD_Z:
+		reg = INV_ICM42607_REG_ACCEL_DATA_Z1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	guard(mutex)(&st->lock);
+
+	/* enable accel sensor */
+	conf.mode = accel_st->power_mode;
+	conf.filter = accel_st->filter;
+	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	/* read accel register data */
+	data = &st->buffer[0];
+	ret = regmap_bulk_read(st->map, reg, data, sizeof(*data));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpup(data);
+	if (*val == INV_ICM42607_DATA_INVALID)
+		ret = -EINVAL;
+
+	return 0;
+}
+
+static const int inv_icm42607_accel_scale_nano[][2] = {
+	[INV_ICM42607_ACCEL_FS_16G] = { 0, 4788403 },
+	[INV_ICM42607_ACCEL_FS_8G] = { 0, 2394202 },
+	[INV_ICM42607_ACCEL_FS_4G] = { 0, 1197101 },
+	[INV_ICM42607_ACCEL_FS_2G] = { 0, 598550 }
+};
+
+static int inv_icm42607_accel_read_scale(struct iio_dev *indio_dev,
+					 int *val, int *val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	unsigned int idx;
+
+	idx = st->conf.accel.fs;
+
+	*val = inv_icm42607_accel_scale_nano[idx][0];
+	*val2 = inv_icm42607_accel_scale_nano[idx][1];
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int inv_icm42607_accel_write_scale(struct iio_dev *indio_dev,
+					  int val, int val2)
+{
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	size_t scales_len = ARRAY_SIZE(inv_icm42607_accel_scale_nano);
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+
+	for (idx = 0; idx < scales_len; idx++) {
+		if (val == inv_icm42607_accel_scale_nano[idx][0] &&
+		    val2 == inv_icm42607_accel_scale_nano[idx][1])
+			break;
+	}
+	if (idx >= scales_len)
+		return -EINVAL;
+
+	conf.fs = idx;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	guard(mutex)(&st->lock);
+
+	return inv_icm42607_set_accel_conf(st, &conf, NULL);
+}
+
+/* IIO format int + micro */
+static const int inv_icm42607_accel_odr[][2] = {
+	[INV_ICM42607_ODR_1_5625HZ_LP] = { 1, 562500 },
+	[INV_ICM42607_ODR_3_125HZ_LP] = { 3, 125000 },
+	[INV_ICM42607_ODR_6_25HZ_LP] = { 6, 250000 },
+	[INV_ICM42607_ODR_12_5HZ] = { 12, 500000 },
+	[INV_ICM42607_ODR_25HZ] = { 25, 0 },
+	[INV_ICM42607_ODR_50HZ] = { 50, 0 },
+	[INV_ICM42607_ODR_100HZ] = { 100, 0 },
+	[INV_ICM42607_ODR_200HZ] = { 200, 0 },
+	[INV_ICM42607_ODR_400HZ] = { 400, 0 },
+	[INV_ICM42607_ODR_800HZ] = { 800, 0 },
+	[INV_ICM42607_ODR_1600HZ] = { 1600, 0 }
+};
+
+static int inv_icm42607_accel_read_odr(struct inv_icm42607_state *st,
+				       int *val, int *val2)
+{
+	unsigned int odr;
+	unsigned int i;
+
+	odr = st->conf.accel.odr;
+
+	for (i = 0; i < ARRAY_SIZE(inv_icm42607_accel_odr); ++i) {
+		if (i == odr)
+			break;
+	}
+	if (i >= ARRAY_SIZE(inv_icm42607_accel_odr))
+		return -EINVAL;
+
+	*val = inv_icm42607_accel_odr[i][0];
+	*val2 = inv_icm42607_accel_odr[i][1];
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int inv_icm42607_accel_write_odr(struct iio_dev *indio_dev,
+					int val, int val2)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
+	struct device *dev = regmap_get_device(st->map);
+	unsigned int idx;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
+	int ret;
+
+	for (idx = 0; idx < ARRAY_SIZE(inv_icm42607_accel_odr); ++idx) {
+		if (val == inv_icm42607_accel_odr[idx][0] &&
+		    val2 == inv_icm42607_accel_odr[idx][1])
+			break;
+	}
+	if (idx >= ARRAY_SIZE(inv_icm42607_accel_odr))
+		return -EINVAL;
+
+	conf.odr = idx;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return -ENXIO;
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_sensors_timestamp_update_odr(ts, inv_icm42607_odr_to_period(conf.odr),
+					       iio_buffer_enabled(indio_dev));
+	if (ret)
+		return ret;
+
+	ret = inv_icm42607_set_accel_conf(st, &conf, NULL);
+	if (ret)
+		return ret;
+
+	inv_icm42607_buffer_update_fifo_period(st);
+	inv_icm42607_buffer_update_watermark(st);
+
+	return 0;
+}
+
+static int inv_icm42607_accel_read_raw(struct iio_dev *indio_dev,
+				       struct iio_chan_spec const *chan,
+				       int *val, int *val2, long mask)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	s16 data;
+	int ret;
+
+	switch (chan->type) {
+	case IIO_ACCEL:
+		break;
+	case IIO_TEMP:
+		return inv_icm42607_temp_read_raw(indio_dev, chan, val, val2, mask);
+	default:
+		return -EINVAL;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42607_accel_read_sensor(indio_dev, chan, &data);
+		iio_device_release_direct(indio_dev);
+		if (ret)
+			return ret;
+		*val = data;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		return inv_icm42607_accel_read_scale(indio_dev, val, val2);
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_accel_read_odr(st, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_read_avail(struct iio_dev *indio_dev,
+					 struct iio_chan_spec const *chan,
+					 const int **vals,
+					 int *type, int *length, long mask)
+{
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)inv_icm42607_accel_scale_nano;
+		*type = IIO_VAL_INT_PLUS_NANO;
+		*length = ARRAY_SIZE(inv_icm42607_accel_scale_nano) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = (const int *)inv_icm42607_accel_odr;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		*length = ARRAY_SIZE(inv_icm42607_accel_odr) * 2;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_write_raw(struct iio_dev *indio_dev,
+					struct iio_chan_spec const *chan,
+					int val, int val2, long mask)
+{
+	int ret;
+
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		if (!iio_device_claim_direct(indio_dev))
+			return -EBUSY;
+		ret = inv_icm42607_accel_write_scale(indio_dev, val, val2);
+		iio_device_release_direct(indio_dev);
+		return ret;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return inv_icm42607_accel_write_odr(indio_dev, val, val2);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_write_raw_get_fmt(struct iio_dev *indio_dev,
+						struct iio_chan_spec const *chan,
+						long mask)
+{
+	if (chan->type != IIO_ACCEL)
+		return -EINVAL;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		return IIO_VAL_INT_PLUS_NANO;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return IIO_VAL_INT_PLUS_MICRO;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int inv_icm42607_accel_hwfifo_set_watermark(struct iio_dev *indio_dev,
+						   unsigned int val)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	guard(mutex)(&st->lock);
+
+	st->fifo.watermark.accel = val;
+	return inv_icm42607_buffer_update_watermark(st);
+}
+
+static int inv_icm42607_accel_hwfifo_flush(struct iio_dev *indio_dev,
+					   unsigned int count)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	int ret;
+
+	if (count == 0)
+		return 0;
+
+	/* Make sure we don't try to count more than the buffer can hold. */
+	count = min(count, sizeof(st->fifo.data));
+
+	guard(mutex)(&st->lock);
+
+	ret = inv_icm42607_buffer_hwfifo_flush(st, count);
+	if (ret)
+		return ret;
+
+	return st->fifo.nb.accel;
+}
+
+static const struct iio_info inv_icm42607_accel_info = {
+	.read_raw = inv_icm42607_accel_read_raw,
+	.read_avail = inv_icm42607_accel_read_avail,
+	.write_raw = inv_icm42607_accel_write_raw,
+	.write_raw_get_fmt = inv_icm42607_accel_write_raw_get_fmt,
+	.update_scan_mode = inv_icm42607_accel_update_scan_mode,
+	.hwfifo_set_watermark = inv_icm42607_accel_hwfifo_set_watermark,
+	.hwfifo_flush_to_buffer = inv_icm42607_accel_hwfifo_flush,
+};
+
+struct iio_dev *inv_icm42607_accel_init(struct inv_icm42607_state *st)
+{
+	struct device *dev = regmap_get_device(st->map);
+	const char *name;
+	struct inv_icm42607_sensor_state *accel_st;
+	struct inv_sensors_timestamp_chip ts_chip;
+	struct iio_dev *indio_dev;
+	int ret;
+
+	name = devm_kasprintf(dev, GFP_KERNEL, "%s-accel", st->hw->name);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*accel_st));
+	if (!indio_dev)
+		return ERR_PTR(-ENOMEM);
+	accel_st = iio_priv(indio_dev);
+
+	accel_st->power_mode = INV_ICM42607_SENSOR_MODE_LOW_NOISE;
+	accel_st->filter = INV_ICM42607_FILTER_AVG_16X;
+
+	/*
+	 * clock period is 32kHz (31250ns)
+	 * jitter is +/- 2% (20 per mille)
+	 */
+	ts_chip.clock_period = 31250;
+	ts_chip.jitter = 20;
+	ts_chip.init_period = inv_icm42607_odr_to_period(st->conf.accel.odr);
+	inv_sensors_timestamp_init(&accel_st->ts, &ts_chip);
+
+	iio_device_set_drvdata(indio_dev, st);
+	indio_dev->name = name;
+	indio_dev->info = &inv_icm42607_accel_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = inv_icm42607_accel_channels;
+	indio_dev->num_channels = ARRAY_SIZE(inv_icm42607_accel_channels);
+	indio_dev->available_scan_masks = inv_icm42607_accel_scan_masks;
+
+	ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
+					  &inv_icm42607_buffer_ops);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_iio_device_register(dev, indio_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	/* accel events are wakeup capable */
+	ret = devm_device_init_wakeup(&indio_dev->dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return indio_dev;
+}
+
+int inv_icm42607_accel_parse_fifo(struct iio_dev *indio_dev)
+{
+	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(indio_dev);
+	struct inv_sensors_timestamp *ts = &accel_st->ts;
+	ssize_t i, size;
+	unsigned int no;
+	const void *accel, *gyro, *timestamp;
+	const int8_t *temp;
+	unsigned int odr;
+	int64_t ts_val;
+	struct inv_icm42607_accel_buffer buffer = { };
+
+	/* parse all fifo packets */
+	for (i = 0, no = 0; i < st->fifo.count; i += size, ++no) {
+		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
+				&accel, &gyro, &temp, &timestamp, &odr);
+		/* quit if error or FIFO is empty */
+		if (size <= 0)
+			return size;
+
+		/* skip packet if no accel data or data is invalid */
+		if (accel == NULL || !inv_icm42607_fifo_is_data_valid(accel))
+			continue;
+
+		/* update odr */
+		if (odr & INV_ICM42607_SENSOR_ACCEL)
+			inv_sensors_timestamp_apply_odr(ts, st->fifo.period,
+							st->fifo.nb.total, no);
+
+		memcpy(&buffer.accel, accel, sizeof(buffer.accel));
+		/* convert 8 bits FIFO temperature in high resolution format */
+		buffer.temp = temp ? (*temp * 64) : 0;
+		ts_val = inv_sensors_timestamp_pop(ts);
+		iio_push_to_buffers_with_ts(indio_dev, &buffer,
+					    sizeof(buffer), ts_val);
+	}
+
+	return 0;
+}
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
index d8784ccf2672..eb629b86446b 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.c
@@ -40,7 +40,7 @@ struct inv_icm42607_fifo_2sensors_packet {
 
 ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
 					const void **gyro, const int8_t **temp,
-					const void **timestamp)
+					const void **timestamp, unsigned int *odr)
 {
 	const struct inv_icm42607_fifo_1sensor_packet *pack1 = packet;
 	const struct inv_icm42607_fifo_2sensors_packet *pack2 = packet;
@@ -52,9 +52,17 @@ ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
 		*gyro = NULL;
 		*temp = NULL;
 		*timestamp = NULL;
+		*odr = 0;
 		return 0;
 	}
 
+	/* handle odr flags */
+	*odr = 0;
+	if (header & INV_ICM42607_FIFO_HEADER_ODR_GYRO)
+		*odr |= INV_ICM42607_SENSOR_GYRO;
+	if (header & INV_ICM42607_FIFO_HEADER_ODR_ACCEL)
+		*odr |= INV_ICM42607_SENSOR_ACCEL;
+
 	/* accel + gyro */
 	if ((header & INV_ICM42607_FIFO_HEADER_ACCEL) &&
 	    (header & INV_ICM42607_FIFO_HEADER_GYRO)) {
@@ -337,6 +345,7 @@ static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
 	struct device *dev = regmap_get_device(st->map);
 	unsigned int sensor;
 	unsigned int *watermark;
+	struct inv_icm42607_sensor_conf conf = INV_ICM42607_SENSOR_CONF_INIT;
 	unsigned int sleep_temp = 0;
 	unsigned int sleep_sensor = 0;
 	unsigned int sleep;
@@ -363,6 +372,16 @@ static int inv_icm42607_buffer_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		goto out_unlock;
 
+	conf.mode = INV_ICM42607_SENSOR_MODE_OFF;
+	if (sensor != INV_ICM42607_SENSOR_GYRO)
+		ret = inv_icm42607_set_accel_conf(st, &conf, &sleep_sensor);
+	if (ret)
+		goto out_unlock;
+
+	/* if FIFO is off, turn temperature off */
+	if (!st->fifo.on)
+		ret = inv_icm42607_set_temp_conf(st, false, &sleep_temp);
+
 out_unlock:
 	mutex_unlock(&st->lock);
 
@@ -388,6 +407,7 @@ int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
 {
 	const void *accel, *gyro, *timestamp;
 	size_t i, max_count, size;
+	unsigned int odr;
 	const s8 *temp;
 	int ret;
 
@@ -427,7 +447,7 @@ int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
 	/* compute number of samples for each sensor */
 	for (i = 0; i < st->fifo.count; i += size) {
 		size = inv_icm42607_fifo_decode_packet(&st->fifo.data[i],
-				&accel, &gyro, &temp, &timestamp);
+				&accel, &gyro, &temp, &timestamp, &odr);
 		if (size <= 0)
 			break;
 		if (gyro != NULL && inv_icm42607_fifo_is_data_valid(gyro))
@@ -440,9 +460,33 @@ int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
 	return 0;
 }
 
+int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st)
+{
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct inv_sensors_timestamp *ts;
+	int ret;
+
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	/* handle accelerometer timestamp and FIFO data parsing */
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.watermark.eff_accel,
+						st->timestamp.accel);
+		ret = inv_icm42607_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 				     unsigned int count)
 {
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
+	struct inv_sensors_timestamp *ts;
 	s64 gyro_ts, accel_ts;
 	int ret;
 
@@ -450,8 +494,21 @@ int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 	accel_ts = iio_get_time_ns(st->indio_accel);
 
 	ret = inv_icm42607_buffer_fifo_read(st, count);
+	if (ret)
+		return ret;
 
-	return ret;
+	if (st->fifo.nb.total == 0)
+		return 0;
+
+	if (st->fifo.nb.accel > 0) {
+		ts = &accel_st->ts;
+		inv_sensors_timestamp_interrupt(ts, st->fifo.nb.accel, accel_ts);
+		ret = inv_icm42607_accel_parse_fifo(st->indio_accel);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 int inv_icm42607_buffer_init(struct inv_icm42607_state *st)
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
index b77deb66f8bd..4160076bbf77 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_buffer.h
@@ -71,7 +71,7 @@ inv_icm42607_fifo_is_data_valid(const struct inv_icm42607_fifo_sensor_data *s)
 
 ssize_t inv_icm42607_fifo_decode_packet(const void *packet, const void **accel,
 					const void **gyro, const s8 **temp,
-					const void **timestamp);
+					const void **timestamp, unsigned int *odr);
 
 extern const struct iio_buffer_setup_ops inv_icm42607_buffer_ops;
 
@@ -87,6 +87,8 @@ int inv_icm42607_buffer_update_watermark(struct inv_icm42607_state *st);
 int inv_icm42607_buffer_fifo_read(struct inv_icm42607_state *st,
 				  unsigned int max);
 
+int inv_icm42607_buffer_fifo_parse(struct inv_icm42607_state *st);
+
 int inv_icm42607_buffer_hwfifo_flush(struct inv_icm42607_state *st,
 				     unsigned int count);
 
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
index 90b3db1de8a5..ce59f9337ed9 100644
--- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -69,6 +69,15 @@ const struct inv_icm42607_hw inv_icm42607p_hw_data = {
 };
 EXPORT_SYMBOL_NS_GPL(inv_icm42607p_hw_data, "IIO_ICM42607");
 
+const struct iio_mount_matrix *
+inv_icm42607_get_mount_matrix(struct iio_dev *indio_dev,
+			      const struct iio_chan_spec *chan)
+{
+	const struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
+
+	return &st->orientation;
+}
+
 u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
 {
 	static const u32 odr_periods[INV_ICM42607_ODR_NB] = {
@@ -159,6 +168,53 @@ static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
 	return 0;
 }
 
+int inv_icm42607_set_accel_conf(struct inv_icm42607_state *st,
+				struct inv_icm42607_sensor_conf *conf,
+				unsigned int *sleep_ms)
+{
+	struct inv_icm42607_sensor_conf *oldconf = &st->conf.accel;
+	unsigned int val;
+	int ret;
+
+	if (conf->mode < 0)
+		conf->mode = oldconf->mode;
+	if (conf->fs < 0)
+		conf->fs = oldconf->fs;
+	if (conf->odr < 0)
+		conf->odr = oldconf->odr;
+	if (conf->filter < 0)
+		conf->filter = oldconf->filter;
+
+	if (conf->fs != oldconf->fs || conf->odr != oldconf->odr) {
+		val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->fs);
+		val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->odr);
+		ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
+		if (ret)
+			return ret;
+		oldconf->fs = conf->fs;
+		oldconf->odr = conf->odr;
+	}
+
+	if (conf->filter != oldconf->filter) {
+		if (conf->mode == INV_ICM42607_SENSOR_MODE_LOW_POWER) {
+			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, conf->filter);
+			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
+						 INV_ICM42607_ACCEL_CONFIG1_AVG_MASK, val);
+		} else {
+			val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK,
+					 conf->filter);
+			ret = regmap_update_bits(st->map, INV_ICM42607_REG_ACCEL_CONFIG1,
+						 INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, val);
+		}
+		if (ret)
+			return ret;
+		oldconf->filter = conf->filter;
+	}
+
+	return inv_icm42607_set_pwr_mgmt0(st, st->conf.gyro.mode, conf->mode,
+					  st->conf.temp_en, sleep_ms);
+}
+
 int inv_icm42607_set_temp_conf(struct inv_icm42607_state *st, bool enable,
 			       unsigned int *sleep_ms)
 {
@@ -376,6 +432,11 @@ int inv_icm42607_core_probe(struct regmap *regmap, const struct inv_icm42607_hw
 	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 
+	/* Initialize IIO device for Accel */
+	st->indio_accel = inv_icm42607_accel_init(st);
+	if (IS_ERR(st->indio_accel))
+		return PTR_ERR(st->indio_accel);
+
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
@@ -391,6 +452,8 @@ static int inv_icm42607_suspend(struct device *dev)
 
 	guard(mutex)(&st->lock);
 
+	st->suspended.accel = st->conf.accel.mode;
+	st->suspended.temp = st->conf.temp_en;
 	if (pm_runtime_suspended(dev))
 		return 0;
 
@@ -418,6 +481,7 @@ static int inv_icm42607_suspend(struct device *dev)
 static int inv_icm42607_resume(struct device *dev)
 {
 	struct inv_icm42607_state *st = dev_get_drvdata(dev);
+	struct inv_icm42607_sensor_state *accel_st = iio_priv(st->indio_accel);
 	int ret;
 
 	guard(mutex)(&st->lock);
@@ -429,9 +493,19 @@ static int inv_icm42607_resume(struct device *dev)
 	if (ret)
 		return ret;
 
+	/* restore sensors state, noting gyro still not yet supported.  */
+	ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
+					 st->suspended.accel,
+					 st->suspended.temp, NULL);
+	if (ret)
+		return ret;
+
 	if (st->fifo.on) {
+		inv_sensors_timestamp_reset(&accel_st->ts);
 		ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
 				   INV_ICM42607_FIFO_CONFIG1_MODE);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
-- 
2.43.0

