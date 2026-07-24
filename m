Received: from MTA-13-4.privateemail.com (mta-13-4.privateemail.com [198.54.127.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DA53B14CD;
	Fri, 24 Jul 2026 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924922; cv=none; b=ueQF90cdoSsnSB82TOd2i1pabbraKvovfJWr6OypLAg7OSKjT54lFKrYb2jRg9mSJwkwcHdMSBsHmyczOWqYl26SGy/kIjfcfoLfonh6nL7uZ7+LTy1nfllE/yIBnRbdAToBs03NNKfmTXtfoVYCEcLjn0Uk+9MVT6NsD00JZxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924922; c=relaxed/simple;
	bh=v0etaXw1S/chPUzBhWK6v2uYzeoygcIlmvq3BkEUI4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9Cmzjows+brSHqn/GvTqktkxoNFpD7k4WOzKnDzO1zlTsSbdPoK9Iv8uleo4CanngpZhU1ZZJ2jUZ+vRK3uXki6mvub86AQA2iTttlX/4pV3Px0iYmC/OxEpH3QA9X4XaAWLWowK24zKOmPIxdsNMYLKTSajEXUeSKVpu0S9y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-08 [87.215.145.39])
	by mta-13.privateemail.com (Postfix) with ESMTPA id 4h6KLw6r1pz3hhTR;
	Fri, 24 Jul 2026 16:28:23 -0400 (EDT)
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
Subject: [PATCH v2 4/4] iio: imu: inv_icm42600: add support for icm42630
Date: Fri, 24 Jul 2026 22:27:08 +0200
Message-ID: <20260724202708.128267-5-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
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
family default configuration like the ICM-42631. Devicetrees describe
the part with an icm42631 fallback; the dedicated entries bind the
exact part where the kernel knows it.

Tested on the Fairphone 6 via a backport of this change to the
device's 7.1-based kernel (only the id-table style and entry placement
adjusted to that base), on a bit-banged SPI bus with INT1 wired to the
SoC: probe, accelerometer, gyroscope and temperature raw reads, all
full-scale ranges, multiple sampling frequencies, and watermark-paced
FIFO reads through the INT1 interrupt.

Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
v2: place the match entries in numeric position (the only code
change); kept the Acked-by.
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
index f306e3ffca48..da7bc0f1155c 100644
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
index e44ed6dcde02..672b19d2e41c 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -78,6 +78,7 @@ static const struct i2c_device_id inv_icm42600_id[] = {
 	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
 	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
 	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
+	{ .name = "icm42630", .driver_data = INV_CHIP_ICM42630 },
 	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
 	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
 	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
@@ -98,6 +99,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
+	}, {
+		.compatible = "invensense,icm42630",
+		.data = (void *)INV_CHIP_ICM42630,
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index 3e2f4eb42e97..3707460d77e1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -75,6 +75,7 @@ static const struct spi_device_id inv_icm42600_id[] = {
 	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
 	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
 	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
+	{ .name = "icm42630", .driver_data = INV_CHIP_ICM42630 },
 	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
 	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
 	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
@@ -95,6 +96,9 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
+	}, {
+		.compatible = "invensense,icm42630",
+		.data = (void *)INV_CHIP_ICM42630,
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
-- 
2.55.0

