Received: from out-2uec-a89.jellyfish.systems (out-2uec-a89.jellyfish.systems [63.250.43.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B4306746
	for <linux-iio@vger.kernel.org>; Sun, 23 Aug 2026 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787446512; cv=none; b=eMfCCAM3sjVEGGCGm5s+6PIi+I8qdtxsU4zpyvwNd3beyeJ6q4lc+Rpz39RnnctrSG4JilXwca9YV4pdP0zv9bJ6sAgakuaFVe4pR3209B1PsYXwvfyhTT3OQZWjI8+wUyluT3YyDf9IMZRY6fhWHEDCtUt2i87Q6IajkNoihh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787446512; c=relaxed/simple;
	bh=SxZs0TJQm02I5QajaGKaSLCF9zExMU4iJ4Nbjpo/Lls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HziAUnnAKnaJn0cfNdUOeCsDyhqUZYDoMGzTkgxUX6aXYiu2KCH03DTHIkjfuiHOwo7CfIgCFtojS7H08jNdGqJyZJacyekP3NOUksBGcRPv4krmr+ZXM+Bp1J10LRkLIqhWkamlavUz5aUJoVl3RC+nOHpjh3YFS0p4CUZT65M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=63.250.43.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hSFQN6pt3z8sWP;
	Sun, 23 Aug 2026 00:33:32 +0000 (UTC)
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
Subject: [PATCH v5 1/3] iio: imu: inv_icm42600: sort device id tables numerically
Date: Sun, 23 Aug 2026 02:33:18 +0200
Message-ID: <20260823003320.62192-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
References: <20260823003320.62192-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: jorijnvdgraaf@catcrafts.net

The I2C, SPI and OF device id tables list the parts in the chip enum's
declaration order, which is neither numeric nor alphabetical. Sort the
entries numerically by part number so new entries have an unambiguous
position.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Link: https://lore.kernel.org/all/20260724012505.02029e51@jic23-huawei/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
No changes in v5.

 drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c | 16 ++++++++--------
 drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
index 28552d2db91d..e44ed6dcde02 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
@@ -77,10 +77,10 @@ static const struct i2c_device_id inv_icm42600_id[] = {
 	{ .name = "icm42600", .driver_data = INV_CHIP_ICM42600 },
 	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
 	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
-	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
 	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
-	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
 	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
+	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
+	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, inv_icm42600_id);
@@ -95,18 +95,18 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42605",
 		.data = (void *)INV_CHIP_ICM42605,
-	}, {
-		.compatible = "invensense,icm42686",
-		.data = (void *)INV_CHIP_ICM42686,
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
-	}, {
-		.compatible = "invensense,icm42688",
-		.data = (void *)INV_CHIP_ICM42688,
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
+	}, {
+		.compatible = "invensense,icm42686",
+		.data = (void *)INV_CHIP_ICM42686,
+	}, {
+		.compatible = "invensense,icm42688",
+		.data = (void *)INV_CHIP_ICM42688,
 	},
 	{ }
 };
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
index faf743bc6444..3e2f4eb42e97 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
@@ -74,10 +74,10 @@ static const struct spi_device_id inv_icm42600_id[] = {
 	{ .name = "icm42600", .driver_data = INV_CHIP_ICM42600 },
 	{ .name = "icm42602", .driver_data = INV_CHIP_ICM42602 },
 	{ .name = "icm42605", .driver_data = INV_CHIP_ICM42605 },
-	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
 	{ .name = "icm42622", .driver_data = INV_CHIP_ICM42622 },
-	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
 	{ .name = "icm42631", .driver_data = INV_CHIP_ICM42631 },
+	{ .name = "icm42686", .driver_data = INV_CHIP_ICM42686 },
+	{ .name = "icm42688", .driver_data = INV_CHIP_ICM42688 },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, inv_icm42600_id);
@@ -92,18 +92,18 @@ static const struct of_device_id inv_icm42600_of_matches[] = {
 	}, {
 		.compatible = "invensense,icm42605",
 		.data = (void *)INV_CHIP_ICM42605,
-	}, {
-		.compatible = "invensense,icm42686",
-		.data = (void *)INV_CHIP_ICM42686,
 	}, {
 		.compatible = "invensense,icm42622",
 		.data = (void *)INV_CHIP_ICM42622,
-	}, {
-		.compatible = "invensense,icm42688",
-		.data = (void *)INV_CHIP_ICM42688,
 	}, {
 		.compatible = "invensense,icm42631",
 		.data = (void *)INV_CHIP_ICM42631,
+	}, {
+		.compatible = "invensense,icm42686",
+		.data = (void *)INV_CHIP_ICM42686,
+	}, {
+		.compatible = "invensense,icm42688",
+		.data = (void *)INV_CHIP_ICM42688,
 	},
 	{ }
 };
-- 
2.55.0

