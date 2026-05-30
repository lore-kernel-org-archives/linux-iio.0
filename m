Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA2346A1F
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 03:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780111221; cv=none; b=tZoPILPbGAz+uaoGX7yFzJJRyWzR+e4zIh8v/RI5/mO9hS2z7kkeTIo4oIsGkTG94+/EBGRrFXRWh6UhvD621OCLGKBMjYBiHBnG/v0T1+fWlU/D5T7T+FRiz74laN1WWP7cgkHGj5fAvMDjhS6bQaWQWqF3cKha5j5HSciXfg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780111221; c=relaxed/simple;
	bh=TJgEC4tnqsvE6UUBwL+s6vB4uXc7N1fXAqvX1SzpsRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BoMC6AZUA3m696mJvtJ3Jui8k5HDsCj0rwOkhO8NgUAp/iw6B3kkyVGa2O1LIzIlhFMJvGAQuFv+4On7owMj/o5WOGtrIzjiI8XpGEsPHAeXG3oU8Lq4BITxbxY4qQ5SRihnbx3kKyyKebO0acIZZ6lfiocpmdJrbpblv+KkSPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m+nzZWD4; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m+nzZWD4"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-43b6f782cfaso3627825fac.3
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 20:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780111218; x=1780716018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlxE7a7A1hYG8iJU+uhlIgot+rmDCOXv+BiMp386Qmg=;
        b=m+nzZWD41B6x05kwFh1BT7GvPCHUgUqL2IqjJHbiyKuOwd9GPMEzHit5ZJmtNGnWe+
         +sZVxy130TdsKnTBIM9ZC9vVK58RCayco909x01UuI9Ym15DkVRe/MvGc55unHKaoZS8
         f0/m2G+lh12zMT+f0YMe+et+DzyGBIPdu9yF+pVF6DPniknC+D+YVk3rNtcG1t5Oob4s
         TygHbrh6PJZtXkwIZujzwCkX9PCpF5S0Mb5m7BDUGXMFSUZ9QQT/qhLRc8UqiAUb5+hu
         KkrVRPQfHhX7HJ1y/ehBgMJijs1QF7TP4E1leQUQKG8/k4XrRWyrY3fCBddR3cJlEMZ7
         q8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780111218; x=1780716018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HlxE7a7A1hYG8iJU+uhlIgot+rmDCOXv+BiMp386Qmg=;
        b=C2w68Gwhyunn1PWSMEubm0kScmz9riP8sh7M82+srKfld+xCU39c/o4Zbgcxh6mGYD
         GPA5RyNI1+HcqW0iZX3Rpi0w4QyIfUQiD+CN9J9xyZjY8RYW4lliGCQHBWV0MnQhgEQV
         uwetOGMu2QF3+QDtRvPJZSNv9JjJDatxAtuW22OEA9fc/i/gMDxKUfw30CK8q+E/VPsP
         o/orbEtN1Z2UcB3V3PtsdJvvoQeTa6UNPOI6GBtnxgZJxGbnipoZRkdhdr/XUK87x3gO
         fPjigabhEEHey3Oe1ZwoaEvghRKaNsIF6kj27THvSifnyjkz3S5a29UvyDYUGhj3vL9v
         0VpA==
X-Gm-Message-State: AOJu0Yyy3QRRa44YYVaOoG1YlfsiXaj1etSOSOOJhy/LupM4KFSXWkD2
	1hbXvQGVaZdrp9inngkQ33EX5BrY2Mn8RZYY8e4GF0ZYbSMyppVCVR839huR1yeI
X-Gm-Gg: Acq92OFhwFK/JCK3T1Wlfjknh8bKume0C7GM345F9pqlUAMAcK7UE5VK4PdZggsGOgg
	p5wUhA5XFxt6hw+nduxnlOuvy62ay3XGlNd8IU0StSWSQ5JXxJ9w3ri9fGQkLZhrhItmD0SCnZ9
	Q8Gg3heKrvqDElENBr/ZDZ3xzACGj5oCBUwwKofqE2QZZ+91RaeFUTwI61Li0aQnJVU+c+tmdfN
	IXMHF3Yf/mPlXzRaD37EUu4h7xL3spV16yPY3B6FDbV/NW52A4fLY5j8vKftWtdwvRS3RhP1mIq
	miGkTO0M0Jz5t6neIfV7vTvJH1Cj+fxnYDJztdNvfj+UtGRrhywO9f0CyZLF8t8ofS/pCT8873z
	on+HQI0oL3LH2bYCCqO0AGa4EqA7d4HBrgliA7a33XOwTtRAag2fjDKZXpIROg34vfcI/G4pfCg
	6nkqjoG8YBy7kArtAv4WGh4iDSAkG7JpY=
X-Received: by 2002:a05:6820:1506:b0:69d:f8ac:500a with SMTP id 006d021491bc7-69e1052b0cdmr1073835eaf.25.1780111218416;
        Fri, 29 May 2026 20:20:18 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e067e911csm2130737eaf.5.2026.05.29.20.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 20:20:18 -0700 (PDT)
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
Subject: [PATCH V9 03/11] iio: imu: inv_icm42607: Add inv_icm42607 Core Driver
Date: Fri, 29 May 2026 22:17:30 -0500
Message-ID: <20260530031739.109063-4-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530031739.109063-1-macroalpha82@gmail.com>
References: <20260530031739.109063-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the core component of a new inv_icm42607 driver. This includes
a few setup functions and the full register definition in the
header file.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 drivers/iio/imu/inv_icm42607/inv_icm42607.h   | 336 ++++++++++++++++++
 .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 206 +++++++++++
 2 files changed, 542 insertions(+)
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607.h
 create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
new file mode 100644
index 000000000000..fe565c423c98
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
@@ -0,0 +1,336 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#ifndef INV_ICM42607_H_
+#define INV_ICM42607_H_
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/iio/iio.h>
+#include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+enum inv_icm42607_sensor_mode {
+	INV_ICM42607_SENSOR_MODE_OFF,
+	INV_ICM42607_SENSOR_MODE_STANDBY,
+	INV_ICM42607_SENSOR_MODE_LOW_POWER,
+	INV_ICM42607_SENSOR_MODE_LOW_NOISE,
+	INV_ICM42607_SENSOR_MODE_NB
+};
+
+/* gyroscope fullscale values */
+enum inv_icm42607_gyro_fs {
+	INV_ICM42607_GYRO_FS_2000DPS,
+	INV_ICM42607_GYRO_FS_1000DPS,
+	INV_ICM42607_GYRO_FS_500DPS,
+	INV_ICM42607_GYRO_FS_250DPS,
+	INV_ICM42607_GYRO_FS_NB
+};
+
+/* accelerometer fullscale values */
+enum inv_icm42607_accel_fs {
+	INV_ICM42607_ACCEL_FS_16G,
+	INV_ICM42607_ACCEL_FS_8G,
+	INV_ICM42607_ACCEL_FS_4G,
+	INV_ICM42607_ACCEL_FS_2G,
+	INV_ICM42607_ACCEL_FS_NB
+};
+
+/* ODR values */
+enum inv_icm42607_odr {
+	INV_ICM42607_ODR_1600HZ = 5,
+	INV_ICM42607_ODR_800HZ,
+	INV_ICM42607_ODR_400HZ,
+	INV_ICM42607_ODR_200HZ,
+	INV_ICM42607_ODR_100HZ,
+	INV_ICM42607_ODR_50HZ,
+	INV_ICM42607_ODR_25HZ,
+	INV_ICM42607_ODR_12_5HZ,
+	INV_ICM42607_ODR_6_25HZ_LP,
+	INV_ICM42607_ODR_3_125HZ_LP,
+	INV_ICM42607_ODR_1_5625HZ_LP,
+	INV_ICM42607_ODR_NB
+};
+
+enum inv_icm42607_filter_bw {
+	/* Low-Noise mode sensor data filter (bandwidth) */
+	INV_ICM42607_FILTER_BYPASS,
+	INV_ICM42607_FILTER_BW_180HZ,
+	INV_ICM42607_FILTER_BW_121HZ,
+	INV_ICM42607_FILTER_BW_73HZ,
+	INV_ICM42607_FILTER_BW_53HZ,
+	INV_ICM42607_FILTER_BW_34HZ,
+	INV_ICM42607_FILTER_BW_25HZ,
+	INV_ICM42607_FILTER_BW_16HZ,
+	INV_ICM42607_FILTER_BW_NB
+};
+
+struct inv_icm42607_sensor_conf {
+	int mode;
+	int fs;
+	int odr;
+	int filter;
+};
+
+struct inv_icm42607_conf {
+	struct inv_icm42607_sensor_conf gyro;
+	struct inv_icm42607_sensor_conf accel;
+	bool temp_en;
+};
+
+struct inv_icm42607_hw {
+	uint8_t whoami;
+	const char *name;
+	const struct inv_icm42607_conf *conf;
+};
+
+/**
+ *  struct inv_icm42607_state - driver state variables
+ *  @lock:		lock for serializing multiple registers access.
+ *  @hw:		Hardware specific data.
+ *  @map:		regmap pointer.
+ *  @vddio_supply:	I/O voltage regulator for the chip.
+ *  @irq:		chip irq, required to enable/disable and set wakeup
+ *  @orientation:	sensor chip orientation relative to main hardware.
+ *  @conf:		chip sensors configurations.
+ */
+struct inv_icm42607_state {
+	struct mutex lock;
+	const struct inv_icm42607_hw *hw;
+	struct regmap *map;
+	struct regulator *vddio_supply;
+	int irq;
+	struct iio_mount_matrix orientation;
+	struct inv_icm42607_conf conf;
+};
+
+/* Virtual register addresses: @bank on MSB (4 upper bits), @address on LSB */
+
+/* Register Map for User Bank 0 */
+#define INV_ICM42607_REG_MCLK_RDY			0x00
+
+#define INV_ICM42607_REG_DEVICE_CONFIG			0x01
+#define INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE		BIT(2)
+#define INV_ICM42607_DEVICE_CONFIG_SPI_MODE		BIT(0)
+
+#define INV_ICM42607_REG_SIGNAL_PATH_RESET		0x02
+#define INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET	BIT(4)
+#define INV_ICM42607_SIGNAL_PATH_RESET_FIFO_FLUSH	BIT(2)
+
+#define INV_ICM42607_REG_DRIVE_CONFIG1			0x03
+#define INV_ICM42607_DRIVE_CONFIG1_I3C_DDR_MASK		GENMASK(5, 3)
+#define INV_ICM42607_DRIVE_CONFIG1_I3C_SDR_MASK		GENMASK(2, 0)
+
+#define INV_ICM42607_REG_DRIVE_CONFIG2			0x04
+#define INV_ICM42607_DRIVE_CONFIG2_I2C_MASK		GENMASK(5, 3)
+#define INV_ICM42607_DRIVE_CONFIG2_ALL_MASK		GENMASK(2, 0)
+
+#define INV_ICM42607_REG_DRIVE_CONFIG3			0x05
+#define INV_ICM42607_DRIVE_CONFIG3_SPI_MASK		GENMASK(2, 0)
+
+#define INV_ICM42607_REG_INT_CONFIG			0x06
+#define INV_ICM42607_INT_CONFIG_INT2_LATCHED		BIT(5)
+#define INV_ICM42607_INT_CONFIG_INT2_PUSH_PULL		BIT(4)
+#define INV_ICM42607_INT_CONFIG_INT2_ACTIVE_HIGH	BIT(3)
+#define INV_ICM42607_INT_CONFIG_INT2_ACTIVE_LOW		0x00
+#define INV_ICM42607_INT_CONFIG_INT1_LATCHED		BIT(2)
+#define INV_ICM42607_INT_CONFIG_INT1_PUSH_PULL		BIT(1)
+#define INV_ICM42607_INT_CONFIG_INT1_ACTIVE_HIGH	BIT(0)
+#define INV_ICM42607_INT_CONFIG_INT1_ACTIVE_LOW		0x00
+
+/* all sensor data are 16 bits (2 registers wide) in big-endian */
+#define INV_ICM42607_REG_TEMP_DATA1			0x09
+#define INV_ICM42607_REG_TEMP_DATA0			0x0A
+#define INV_ICM42607_REG_ACCEL_DATA_X1			0x0B
+#define INV_ICM42607_REG_ACCEL_DATA_X0			0x0C
+#define INV_ICM42607_REG_ACCEL_DATA_Y1			0x0D
+#define INV_ICM42607_REG_ACCEL_DATA_Y0			0x0E
+#define INV_ICM42607_REG_ACCEL_DATA_Z1			0x0F
+#define INV_ICM42607_REG_ACCEL_DATA_Z0			0x10
+#define INV_ICM42607_REG_GYRO_DATA_X1			0x11
+#define INV_ICM42607_REG_GYRO_DATA_X0			0x12
+#define INV_ICM42607_REG_GYRO_DATA_Y1			0x13
+#define INV_ICM42607_REG_GYRO_DATA_Y0			0x14
+#define INV_ICM42607_REG_GYRO_DATA_Z1			0x15
+#define INV_ICM42607_REG_GYRO_DATA_Z0			0x16
+#define INV_ICM42607_DATA_INVALID			-32768
+
+#define INV_ICM42607_REG_TMST_FSYNCH			0x17
+#define INV_ICM42607_REG_TMST_FSYNCL			0x18
+
+/* APEX Data Registers */
+#define INV_ICM42607_REG_APEX_DATA0			0x31
+#define INV_ICM42607_REG_APEX_DATA1			0x32
+#define INV_ICM42607_REG_APEX_DATA2			0x33
+#define INV_ICM42607_REG_APEX_DATA3			0x34
+#define INV_ICM42607_REG_APEX_DATA4			0x1D
+#define INV_ICM42607_REG_APEX_DATA5			0x1E
+
+#define INV_ICM42607_REG_PWR_MGMT0			0x1F
+#define INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL		BIT(7)
+#define INV_ICM42607_PWR_MGMT0_IDLE			BIT(4)
+#define INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK		GENMASK(3, 2)
+#define INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK		GENMASK(1, 0)
+
+#define INV_ICM42607_REG_GYRO_CONFIG0			0x20
+#define INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK		GENMASK(6, 5)
+#define INV_ICM42607_GYRO_CONFIG0_ODR_MASK		GENMASK(3, 0)
+
+#define INV_ICM42607_REG_ACCEL_CONFIG0			0x21
+#define INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK		GENMASK(6, 5)
+#define INV_ICM42607_ACCEL_CONFIG0_ODR_MASK		GENMASK(3, 0)
+
+#define INV_ICM42607_REG_TEMP_CONFIG0			0x22
+#define INV_ICM42607_TEMP_CONFIG0_FILTER_MASK		GENMASK(6, 4)
+
+#define INV_ICM42607_REG_GYRO_CONFIG1			0x23
+#define INV_ICM42607_GYRO_CONFIG1_FILTER_MASK		GENMASK(2, 0)
+
+#define INV_ICM42607_REG_ACCEL_CONFIG1			0x24
+#define INV_ICM42607_ACCEL_CONFIG1_AVG_MASK		GENMASK(6, 4)
+#define INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK		GENMASK(2, 0)
+
+#define INV_ICM42607_REG_APEX_CONFIG0			0x25
+#define INV_ICM42607_APEX_CONFIG0_DMP_POWER_SAVE_EN	BIT(3)
+#define INV_ICM42607_APEX_CONFIG0_DMP_INIT_EN		BIT(2)
+#define INV_ICM42607_APEX_CONFIG0_DMP_MEM_RESET_EN	BIT(0)
+
+#define INV_ICM42607_REG_APEX_CONFIG1			0x26
+#define INV_ICM42607_APEX_CONFIG1_SMD_ENABLE		BIT(6)
+#define INV_ICM42607_APEX_CONFIG1_FF_ENABLE		BIT(5)
+#define INV_ICM42607_APEX_CONFIG1_TILT_ENABLE		BIT(4)
+#define INV_ICM42607_APEX_CONFIG1_PED_ENABLE		BIT(3)
+#define INV_ICM42607_APEX_CONFIG1_DMP_ODR_MASK		GENMASK(1, 0)
+
+#define INV_ICM42607_REG_WOM_CONFIG			0x27
+#define INV_ICM42607_WOM_CONFIG_INT_DUR_MASK		GENMASK(4, 3)
+#define INV_ICM42607_WOM_CONFIG_INT_MODE		BIT(2)
+#define INV_ICM42607_WOM_CONFIG_MODE			BIT(1)
+#define INV_ICM42607_WOM_CONFIG_EN			BIT(0)
+
+#define INV_ICM42607_REG_FIFO_CONFIG1			0x28
+#define INV_ICM42607_FIFO_CONFIG1_MODE			BIT(1)
+#define INV_ICM42607_FIFO_CONFIG1_BYPASS		BIT(0)
+
+#define INV_ICM42607_REG_FIFO_CONFIG2			0x29
+#define INV_ICM42607_REG_FIFO_CONFIG3			0x2A
+#define INV_ICM42607_FIFO_WATERMARK_VAL(_wm)		\
+		cpu_to_le16((_wm) & GENMASK(11, 0))
+/* FIFO is 2048 bytes, let 12 samples for reading latency */
+#define INV_ICM42607_FIFO_WATERMARK_MAX			(2048 - 12 * 16)
+#define INV_ICM42607_FIFO_1SENSOR_PACKET_SIZE		8
+#define INV_ICM42607_FIFO_2SENSORS_PACKET_SIZE		16
+
+#define INV_ICM42607_REG_INT_SOURCE0			0x2B
+#define INV_ICM42607_INT_SOURCE0_ST_INT1_EN		BIT(7)
+#define INV_ICM42607_INT_SOURCE0_FSYNC_INT1_EN		BIT(6)
+#define INV_ICM42607_INT_SOURCE0_PLL_RDY_INT1_EN	BIT(5)
+#define INV_ICM42607_INT_SOURCE0_RESET_DONE_INT1_EN	BIT(4)
+#define INV_ICM42607_INT_SOURCE0_DRDY_INT1_EN		BIT(3)
+#define INV_ICM42607_INT_SOURCE0_FIFO_THS_INT1_EN	BIT(2)
+#define INV_ICM42607_INT_SOURCE0_FIFO_FULL_INT1_EN	BIT(1)
+#define INV_ICM42607_INT_SOURCE0_AGC_RDY_INT1_EN	BIT(0)
+
+#define INV_ICM42607_REG_INT_SOURCE1			0x2C
+#define INV_ICM42607_INT_SOURCE1_I3C_ERROR_INT1_EN	BIT(6)
+#define INV_ICM42607_INT_SOURCE1_SMD_INT1_EN		BIT(3)
+#define INV_ICM42607_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)
+
+#define INV_ICM42607_REG_INT_SOURCE3			0x2D
+#define INV_ICM42607_INT_SOURCE3_ST_INT2_EN		BIT(7)
+#define INV_ICM42607_INT_SOURCE3_FSYNC_INT2_EN		BIT(6)
+#define INV_ICM42607_INT_SOURCE3_PLL_RDY_INT2_EN	BIT(5)
+#define INV_ICM42607_INT_SOURCE3_RESET_DONE_INT2_EN	BIT(4)
+#define INV_ICM42607_INT_SOURCE3_DRDY_INT2_EN		BIT(3)
+#define INV_ICM42607_INT_SOURCE3_FIFO_THS_INT2_EN	BIT(2)
+#define INV_ICM42607_INT_SOURCE3_FIFO_FULL_INT2_EN	BIT(1)
+#define INV_ICM42607_INT_SOURCE3_AGC_RDY_INT2_EN	BIT(0)
+
+#define INV_ICM42607_REG_INT_SOURCE4			0x2E
+#define INV_ICM42607_INT_SOURCE4_I3C_ERROR_INT2_EN	BIT(6)
+#define INV_ICM42607_INT_SOURCE4_SMD_INT2_EN		BIT(3)
+#define INV_ICM42607_INT_SOURCE4_WOM_Z_INT2_EN		BIT(2)
+#define INV_ICM42607_INT_SOURCE4_WOM_Y_INT2_EN		BIT(1)
+#define INV_ICM42607_INT_SOURCE4_WOM_X_INT2_EN		BIT(0)
+
+#define INV_ICM42607_REG_FIFO_LOST_PKT0			0x2F
+#define INV_ICM42607_REG_FIFO_LOST_PKT1			0x30
+
+#define INV_ICM42607_REG_INTF_CONFIG0			0x35
+#define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_FORMAT	BIT(6)
+#define INV_ICM42607_INTF_CONFIG0_FIFO_COUNT_ENDIAN	BIT(5)
+#define INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN	BIT(4)
+#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK	GENMASK(1, 0)
+#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS	\
+	FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK, 2)
+#define INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS	\
+	FIELD_PREP(INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK, 3)
+
+#define INV_ICM42607_REG_INTF_CONFIG1			0x36
+#define INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN		BIT(3)
+#define INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN		BIT(2)
+#define INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK		GENMASK(1, 0)
+#define INV_ICM42607_INTF_CONFIG1_CLKSEL_INT		0
+#define INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL		1
+#define INV_ICM42607_INTF_CONFIG1_CLKSEL_OFF		2
+
+#define INV_ICM42607_REG_INT_STATUS_DRDY		0x39
+#define INV_ICM42607_INT_STATUS_DRDY_DATA_RDY		BIT(0)
+
+#define INV_ICM42607_REG_INT_STATUS			0x3A
+#define INV_ICM42607_INT_STATUS_ST			BIT(7)
+#define INV_ICM42607_INT_STATUS_FSYNC			BIT(6)
+#define INV_ICM42607_INT_STATUS_PLL_RDY			BIT(5)
+#define INV_ICM42607_INT_STATUS_RESET_DONE		BIT(4)
+#define INV_ICM42607_INT_STATUS_FIFO_THS		BIT(2)
+#define INV_ICM42607_INT_STATUS_FIFO_FULL		BIT(1)
+#define INV_ICM42607_INT_STATUS_AGC_RDY			BIT(0)
+
+#define INV_ICM42607_REG_INT_STATUS2			0x3B
+#define INV_ICM42607_INT_STATUS2_SMD			BIT(3)
+#define INV_ICM42607_INT_STATUS2_WOM_INT		GENMASK(2, 0)
+
+#define INV_ICM42607_REG_INT_STATUS3			0x3C
+#define INV_ICM42607_INT_STATUS3_STEP_DET		BIT(5)
+#define INV_ICM42607_INT_STATUS3_STEP_CNT_OVF		BIT(4)
+#define INV_ICM42607_INT_STATUS3_TILT_DET		BIT(3)
+#define INV_ICM42607_INT_STATUS3_FF_DET			BIT(2)
+
+/*
+ * FIFO access registers
+ * FIFO count is 16 bits (2 registers) big-endian
+ * FIFO data is a continuous read register to read FIFO content
+ */
+#define INV_ICM42607_REG_FIFO_COUNTH			0x3D
+#define INV_ICM42607_REG_FIFO_COUNTL			0x3E
+#define INV_ICM42607_REG_FIFO_DATA			0x3F
+
+#define INV_ICM42607_REG_ACCEL_WOM_X_THR		0x4b
+#define INV_ICM42607_REG_ACCEL_WOM_Y_THR		0x4c
+#define INV_ICM42607_REG_ACCEL_WOM_Z_THR		0x4d
+
+#define INV_ICM42607_REG_WHOAMI				0x75
+#define INV_ICM42607P_WHOAMI				0x60
+#define INV_ICM42607_WHOAMI				0x67
+
+/* Timings as listed in section 3 of datasheet */
+#define INV_ICM42607_POWER_UP_TIME_US			100000
+#define INV_ICM42607_RESET_TIME_MS			1
+#define INV_ICM42607_ACCEL_STARTUP_TIME_MS		10
+#define INV_ICM42607_GYRO_STARTUP_TIME_MS		30
+#define INV_ICM42607_TEMP_STARTUP_TIME_MS		77
+
+typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
+
+extern const struct regmap_config inv_icm42607_regmap_config;
+extern const struct inv_icm42607_hw inv_icm42607_hw_data;
+extern const struct inv_icm42607_hw inv_icm42607p_hw_data;
+
+int inv_icm42607_core_probe(struct regmap *regmap,
+			    const struct inv_icm42607_hw *hw,
+			    inv_icm42607_bus_setup bus_setup);
+
+#endif
diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
new file mode 100644
index 000000000000..4801ece28058
--- /dev/null
+++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 InvenSense, Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/interrupt.h>
+#include <linux/iio/iio.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include "inv_icm42607.h"
+
+static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
+				 const struct inv_icm42607_conf *conf)
+{
+	unsigned int val;
+	int ret;
+
+	val = FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, conf->gyro.mode);
+	val |= FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, conf->accel.mode);
+	/*
+	 * No temperature enable reg in datasheet, but BSP driver selected RC
+	 * oscillator clock in LP mode when temperature was disabled.
+	 */
+	if (!conf->temp_en)
+		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
+	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_FS_SEL_MASK, conf->gyro.fs);
+	val |= FIELD_PREP(INV_ICM42607_GYRO_CONFIG0_ODR_MASK, conf->gyro.odr);
+	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_FS_SEL_MASK, conf->accel.fs);
+	val |= FIELD_PREP(INV_ICM42607_ACCEL_CONFIG0_ODR_MASK, conf->accel.odr);
+	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_GYRO_CONFIG1_FILTER_MASK, conf->gyro.filter);
+	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG1, val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(INV_ICM42607_ACCEL_CONFIG1_FILTER_MASK, conf->accel.filter);
+	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG1, val);
+	if (ret)
+		return ret;
+
+	st->conf = *conf;
+
+	return 0;
+}
+
+/**
+ *  inv_icm42607_setup() - check and setup chip
+ *  @st:	driver internal state
+ *  @bus_setup:	callback for setting up bus specific registers
+ *
+ *  Returns 0 on success, a negative error code otherwise.
+ */
+static int inv_icm42607_setup(struct inv_icm42607_state *st,
+			      inv_icm42607_bus_setup bus_setup)
+{
+	const struct device *dev = regmap_get_device(st->map);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
+	if (ret)
+		return ret;
+
+	if (val != st->hw->whoami)
+		dev_warn(dev, "Unknown whoami %#02x expected %#02x (%s)\n",
+			 val, st->hw->whoami, st->hw->name);
+
+	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
+			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
+	if (ret)
+		return ret;
+
+	fsleep(INV_ICM42607_RESET_TIME_MS * 1000);
+
+	ret = regmap_read_poll_timeout(st->map, INV_ICM42607_REG_INT_STATUS,
+				       val, val & INV_ICM42607_INT_STATUS_RESET_DONE,
+				       INV_ICM42607_RESET_TIME_MS * 100,
+				       INV_ICM42607_RESET_TIME_MS * 10000);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "reset error, reset done bit not set\n");
+
+	/* Sync the regcache again after a reset. */
+	ret = regcache_sync(st->map);
+	if (ret)
+		return ret;
+
+	ret = bus_setup(st);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
+			      INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
+				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
+				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);
+	if (ret)
+		return ret;
+
+	return inv_icm42607_set_conf(st, st->hw->conf);
+}
+
+static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
+{
+	int ret;
+
+	ret = regulator_enable(st->vddio_supply);
+	if (ret)
+		return ret;
+
+	fsleep(INV_ICM42607_POWER_UP_TIME_US);
+
+	return 0;
+}
+
+static void inv_icm42607_disable_vddio_reg(void *_data)
+{
+	struct inv_icm42607_state *st = _data;
+
+	regulator_disable(st->vddio_supply);
+}
+
+int inv_icm42607_core_probe(struct regmap *regmap,
+			    const struct inv_icm42607_hw *hw,
+			    inv_icm42607_bus_setup bus_setup)
+{
+	struct device *dev = regmap_get_device(regmap);
+	struct inv_icm42607_state *st;
+	int irq;
+	int ret;
+
+	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "Unable to get INT1 interrupt\n");
+
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, st);
+
+	ret = devm_mutex_init(dev, &st->lock);
+	if (ret)
+		return ret;
+
+	st->hw = hw;
+	st->map = regmap;
+	st->irq = irq;
+
+	ret = iio_read_mount_matrix(dev, &st->orientation);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to retrieve mounting matrix %d\n", ret);
+
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get vdd regulator\n");
+
+	st->vddio_supply = devm_regulator_get(dev, "vddio");
+	if (IS_ERR(st->vddio_supply))
+		return dev_err_probe(dev, PTR_ERR(st->vddio_supply),
+				     "Failed to get vddio regulator\n");
+
+	ret = inv_icm42607_enable_vddio_reg(st);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, inv_icm42607_disable_vddio_reg, st);
+	if (ret)
+		return ret;
+
+	/* Setup chip registers (includes WHOAMI check, reset check, bus setup) */
+	ret = inv_icm42607_setup(st, bus_setup);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
+
+MODULE_AUTHOR("InvenSense, Inc.");
+MODULE_DESCRIPTION("InvenSense ICM-42607x device driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_INV_SENSORS_TIMESTAMP");
-- 
2.43.0

