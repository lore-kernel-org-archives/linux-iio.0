Received: from MTA-09-4.privateemail.com (mta-09-4.privateemail.com [198.54.127.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA3F46D542;
	Tue, 28 Jul 2026 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785264293; cv=none; b=MHTM0FPNbJFOA0ynBmgl7FTzWp9CrjLcwEeeQT4YUlRZSinlQNR9bLyyQKF9u6KJ02aCumUkl8A5eeSe9LQa2j/1mtU9X1E8ccVlSkthdvxXjO4DfVsgt+JAo2bDGs3zGEXSWVt89d2FTN0yL9Pk+Qh1qfHwLSv+UIoO9j0eANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785264293; c=relaxed/simple;
	bh=kKMcubiiOS+lCVTOGzJrzA4ZXNhlHZmIZfk5ttNZltE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ijtJUVwThnCut8q61e5xWb5kZwhOiKlV4yWuBEuR/15tR0e31v3ZJoq3hKRIpKMXEva4gOZs4eW22LSx5zFHFoQCf/D9eknET0PK/YOOfHEPfxufRa681M4Wm5JlVi3xP/OVBNj7CZLaYcQsYUFLFY0gLOcsez/yLiZinp7Wq90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net; spf=pass smtp.mailfrom=catcrafts.net; arc=none smtp.client-ip=198.54.127.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Received: from mail.privateemail.com (K8S-PROD-WORKER-14 [87.215.145.39])
	by mta-09.privateemail.com (Postfix) with ESMTPA id 4h8ksF0xG9z3hhTG;
	Tue, 28 Jul 2026 14:44:31 -0400 (EDT)
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
	linux-kernel@vger.kernel.org,
	Conor Dooley <conor@kernel.org>
Subject: [PATCH v3 2/3] iio: imu: inv_icm42600: drop the whoami check
Date: Tue, 28 Jul 2026 20:43:50 +0200
Message-ID: <20260728184351.75015-3-jorijnvdgraaf@catcrafts.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
References: <20260728184351.75015-1-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A WHOAMI value differing from the one the compatible implies aborts
probe with -ENODEV, preventing a register-compatible part described
with a fallback compatible from probing at all.

The devicetree compatible is authoritative for which part is fitted:
drop the check, and with it the now-unused whoami definitions. No
warning replaces it, since probing via a fallback compatible is
legitimate use, not a condition to report. This changes the probe
outcome on mismatch for all parts the driver supports.

Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
and matched as icm42631, probes silently, and accelerometer, gyroscope
and temperature reads work.

Suggested-by: Conor Dooley <conor@kernel.org>
Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@spud/
Link: https://lore.kernel.org/all/20260728-extradite-yanking-42d918637f61@spud/
Assisted-by: Claude:claude-fable-5
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
v3: drop the check and the now-unused whoami definitions instead of
demoting the mismatch error to a warning (Conor); retested on the
device.
New in v2, as a demotion of the error to a warning.
 drivers/iio/imu/inv_icm42600/inv_icm42600.h     |  9 ---------
 .../iio/imu/inv_icm42600/inv_icm42600_core.c    | 17 -----------------
 2 files changed, 26 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index b55d993f0264..88acdbab14c3 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -378,15 +378,6 @@ struct inv_icm42600_sensor_state {
 #define INV_ICM42600_INT_SOURCE1_SMD_INT1_EN		BIT(3)
 #define INV_ICM42600_INT_SOURCE1_WOM_INT1_EN		GENMASK(2, 0)
 
-#define INV_ICM42600_REG_WHOAMI				0x0075
-#define INV_ICM42600_WHOAMI_ICM42600			0x40
-#define INV_ICM42600_WHOAMI_ICM42602			0x41
-#define INV_ICM42600_WHOAMI_ICM42605			0x42
-#define INV_ICM42600_WHOAMI_ICM42686			0x44
-#define INV_ICM42600_WHOAMI_ICM42622			0x46
-#define INV_ICM42600_WHOAMI_ICM42688			0x47
-#define INV_ICM42600_WHOAMI_ICM42631			0x5C
-
 /* User bank 1 (MSB 0x10) */
 #define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
 #define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE		BIT(5)
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index dc97d8a274e3..963c9425e31a 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -103,7 +103,6 @@ const struct regmap_config inv_icm42600_spi_regmap_config = {
 EXPORT_SYMBOL_NS_GPL(inv_icm42600_spi_regmap_config, "IIO_ICM42600");
 
 struct inv_icm42600_hw {
-	u8 whoami;
 	const char *name;
 	const struct inv_icm42600_conf *conf;
 };
@@ -143,37 +142,30 @@ static const struct inv_icm42600_conf inv_icm42686_default_conf = {
 
 static const struct inv_icm42600_hw inv_icm42600_hw[INV_CHIP_NB] = {
 	[INV_CHIP_ICM42600] = {
-		.whoami = INV_ICM42600_WHOAMI_ICM42600,
 		.name = "icm42600",
 		.conf = &inv_icm42600_default_conf,
 	},
 	[INV_CHIP_ICM42602] = {
-		.whoami = INV_ICM42600_WHOAMI_ICM42602,
 		.name = "icm42602",
 		.conf = &inv_icm42600_default_conf,
 	},
 	[INV_CHIP_ICM42605] = {
-		.whoami = INV_ICM42600_WHOAMI_ICM42605,
 		.name = "icm42605",
 		.conf = &inv_icm42600_default_conf,
 	},
 	[INV_CHIP_ICM42686] = {
-		.whoami = INV_ICM42600_WHOAMI_ICM42686,
 		.name = "icm42686",
 		.conf = &inv_icm42686_default_conf,
 	},
 	[INV_CHIP_ICM42622] = {
-		.whoami = INV_ICM42600_WHOAMI_ICM42622,
 		.name = "icm42622",
 		.conf = &inv_icm42600_default_conf,
 	},
 	[INV_CHIP_ICM42688] = {
-		.whoami = INV_ICM42600_WHOAMI_ICM42688,
 		.name = "icm42688",
 		.conf = &inv_icm42600_default_conf,
 	},
 	[INV_CHIP_ICM42631] = {
-		.whoami = INV_ICM42600_WHOAMI_ICM42631,
 		.name = "icm42631",
 		.conf = &inv_icm42600_default_conf,
 	},
@@ -505,15 +497,6 @@ static int inv_icm42600_setup(struct inv_icm42600_state *st,
 	unsigned int val;
 	int ret;
 
-	/* check chip self-identification value */
-	ret = regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val);
-	if (ret)
-		return ret;
-	if (val != hw->whoami) {
-		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
-			val, hw->whoami, hw->name);
-		return -ENODEV;
-	}
 	st->name = hw->name;
 
 	/* reset to make sure previous state are not there */
-- 
2.55.0

