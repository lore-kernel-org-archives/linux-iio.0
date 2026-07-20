Received: from MTA-11-3.privateemail.com (mta-11-3.privateemail.com [198.54.122.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FCE44604A;
	Mon, 20 Jul 2026 17:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.122.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568917; cv=none; b=f27ANYHkvBGZx8HxM5aAGfFyjUlAHFrowSf66JlHkL8g5RkF193ubFgH4D18Pj0soBvuUqGGpX8zP6KmKu/34LAKT98AAQm7jwY2J52L90rRW2cvA+LGWhSNvAiY5JcEToEMdWdS1OxJVk4Jgxf3X+1MfirKNmXjX27zJBzQ2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568917; c=relaxed/simple;
	bh=IDOfjrWr7wHUUcBLcdqYMDC9KuN+4eO4gd+r/IghaGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBTfA4sTlf/xPoaGfhzQRtCfnOHTGvPcCvEDOpkVhT8mh/+n9jEVeB8WlJLJwUUTh/YSnwvpxO7kg5oXPFl0aVReml6i3c42pksx8c0ax4dDLsc9oS8cybjbyKc9j1pOcVNfH0RFpn//qi+d4hIgYq74YL1vzSdFNkvTLHfI9QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.122.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-10 [87.215.145.39])
	by mta-11.privateemail.com (Postfix) with ESMTPA id 4h3nhY32dLz3hhTG;
	Mon, 20 Jul 2026 13:34:52 -0400 (EDT)
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: imu: inv_icm42600: add support for icm42630
Date: Mon, 20 Jul 2026 19:34:11 +0200
Message-ID: <20260720173411.82979-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
References: <20260720173411.82979-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
found e.g. in the Fairphone 6. It is register-compatible with its
siblings (the existing driver works on it unmodified) and reports
WHOAMI value 0x0C.

The part appears to be a mobile SKU and has no public datasheet: the
identity comes from the Fairphone 6 platform documentation and
schematics naming the part, and the WHOAMI value was read from the
hardware, whose bank 0 register defaults match the ICM-42600 family
layout.

Add the chip id, WHOAMI value and I2C/SPI match entries, using the
family default configuration like the ICM-42631.

Tested on the Fairphone 6 via a backport of this change to the
device's 7.1-based kernel (only the id-table style adjusted to that
base), on a bit-banged SPI bus with INT1 wired to the SoC: probe,
accelerometer, gyroscope and temperature raw reads, all full-scale
ranges, multiple sampling frequencies, and watermark-paced FIFO reads
through the INT1 interrupt.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 ++
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  | 4 ++++
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index b55d993f0264..349de5458581 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -28,6 +28,7 @@ enum inv_icm42600_chip {
 	INV_CHIP_ICM42622,
 	INV_CHIP_ICM42688,
 	INV_CHIP_ICM42631,
+	INV_CHIP_ICM42630,
 	INV_CHIP_NB,
 };
 
@@ -386,6 +387,7 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_WHOAMI_ICM42622			0x46
 #define INV_ICM42600_WHOAMI_ICM42688			0x47
 #define INV_ICM42600_WHOAMI_ICM42631			0x5C
+#define INV_ICM42600_WHOAMI_ICM42630			0x0C
 
 /* User bank 1 (MSB 0x10) */
 #define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index dc97d8a274e3..9a31ca3615b3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -177,6 +177,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
 		.name = "icm42631",
 		.conf = &inv_icm42600_default_conf,
 	},
+	[INV_CHIP_ICM42630] = {
+		.whoami = INV_ICM42600_WHOAMI_ICM42630,
+		.name = "icm42630",
+		.conf = &inv_icm42600_default_conf,
+	},
 };
 
 const struct iio_mount_matrix *
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 28552d2db91d..c413904c8680 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -81,6 +81,7 @@ static const struct i2c_device_id inv_icm42600_id[] = {
 	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
 	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
 	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
+	{ .name = "icm42630", .driver_data = INV_CHIP_ICM42630 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
@@ -107,6 +108,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
+	}, {
+		.compatible = "invensense,icm42630",
+		.data = (void *)INV_CHIP_ICM42630,
 	},
 	{ }
 };
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index faf743bc6444..a1d12ce3bf87 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -78,6 +78,7 @@ static const struct spi_device_id inv_icm42600_id[] = {
 	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
 	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
 	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
+	{ .name = "icm42630", .driver_data = INV_CHIP_ICM42630 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
@@ -104,6 +105,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
+	}, {
+		.compatible = "invensense,icm42630",
+		.data = (void *)INV_CHIP_ICM42630,
 	},
 	{ }
 };
-- 
2.55.0

