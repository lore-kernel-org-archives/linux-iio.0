Received: from out-zbxj-a83.jellyfish.systems (out-zbxj-a83.jellyfish.systems [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B6D43CEF3
	for <linux-iio@vger.kernel.org>; Mon, 10 Aug 2026 19:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389139; cv=none; b=fe6SxuI5S/EIAJkXtGm5pq+Vuy/TZXeOiAPi1pXq7Fc5Q101EM5eBXiYet9rbfRkMMigT8V69QizLwi4nk58+z280OvBTukspNP7LgwVuGqdJO8doEFv2XprS1LXjy1MB0V24iIhSDK6813mw+Digm1buqkg2Nazh4JF8UeQ/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389139; c=relaxed/simple;
	bh=c01oYPIoUPImO0NUGI8m3yJYizVhRUr/sKwDQIzfHYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDJVkYNQtgU/eWPOoB2RWr/msj/etczIoVJdm/9bqvpA2cqtFK+kS8oJSbHh7pfSp8SPNKY2O2xpvE+ohIQK0Rgl0qVG3e85zbS03snHk/Xla4pA21sReyehHf4oq0G7CFgY2nVCWPnvvzxwnHvqhYxPwnunuiJ5uYgDAyLr0Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.privateemail.com (Postfix) with ESMTPSA id 4hJks20yqQz2x99;
	Mon, 10 Aug 2026 19:12:05 +0000 (UTC)
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
Subject: [PATCH v4 1/3] iio: imu: inv_icm42600: sort device id tables numerically
Date: Mon, 10 Aug 2026 21:11:55 +0200
Message-ID: <20260810191157.125550-2-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
References: <20260810191157.125550-1-jorijnvdgraaf@catcrafts.net>
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
No changes in v4.

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

