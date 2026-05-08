Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A024736E466;
	Fri,  8 May 2026 06:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220621; cv=none; b=oJmScFd44zglCRtpZJTOcnBMw7owGpyDo1s2X0W3N4Cwup7uFWvnMEHNeeV+bd+uRqmk+OShP0VJ+76t7G+totGkBn3a088FNfsqyDqf/2Qra2V8Wrc8CM0Gf8JRoaFXb5Rv1C0r2cNjc28YYGUkn4InInP9C8lXgEjyG/ijlJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220621; c=relaxed/simple;
	bh=UQ7TuSSpmlDmBRO5LDMRtSLfh2RDpIfhHmuSJRuC888=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FhLr6Rc8QDj4z1pnTfr9MHrhHxaQqXczRDov74QnvDoRrr3hoRMhwPsAV4NnKAbW9WK8Ph9p2lQb6K07kM6VNRKvYYn9uISjyL2Io25niSDtYzciKWddTlDPjyZeqAj43P55X8FKHRWYaUAsKR42zo256tQ18ZI4FsD8+hPahZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KrOg9H/i; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KrOg9H/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778220616; x=1809756616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UQ7TuSSpmlDmBRO5LDMRtSLfh2RDpIfhHmuSJRuC888=;
  b=KrOg9H/ikVQxu3VAlc97VXnrCPcx3XkUPMS8pxpqMD5it8kqFuVjmwRS
   m72PH177HklCwmepYP8iNpuxH2AvlBovn8bwB2pgoDpxOCYa3hCw25WsL
   nI//n6wRnAtzC5fvHApKy59Z18hLt2gnDLpfHJAF0CNjVL08tHvzCf8u6
   F3MllDcZ2V+B/dS18zh/zsFWjbPVw9YSjs5s5NByWbZipF9ql8194vkVx
   g2sgPbXwFBGYs8AyhPOissmVHgJBOK4nAsWFWzlLEoKQ6hsmv/W2/0Ui6
   v1qxe0c0jo95sXMlZPZQ4USJj3VgaRwIAMiT2ssnPnhve8WoGm4TvD6rm
   A==;
X-CSE-ConnectionGUID: Ib1rFm0IT/6dWPMJNqNFoA==
X-CSE-MsgGUID: Y3U0qkK0SZ6iEtY5OsqsSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="83031366"
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="83031366"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 23:10:04 -0700
X-CSE-ConnectionGUID: kvhKHEWkQfiQg7DNPhnpBQ==
X-CSE-MsgGUID: 5s4fH4m3RY2LxS7YVIDazw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,223,1770624000"; 
   d="scan'208";a="240669049"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa003.jf.intel.com with ESMTP; 07 May 2026 23:10:02 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7651699; Fri, 08 May 2026 08:10:01 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] iio: magnetometer: yamaha-yas530: Get rid of i2c_client_get_device_id()
Date: Fri,  8 May 2026 08:08:33 +0200
Message-ID: <20260508060958.1086818-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
References: <20260508060958.1086818-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of relying on the name from ID table, which might be ambiguous
in some cases, use explicit product label in the driver data. With that
being done, get rid of i2c_client_get_device_id() call.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/yamaha-yas530.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/yamaha-yas530.c b/drivers/iio/magnetometer/yamaha-yas530.c
index c8a04f185dbb..2ed0d1b93985 100644
--- a/drivers/iio/magnetometer/yamaha-yas530.c
+++ b/drivers/iio/magnetometer/yamaha-yas530.c
@@ -168,6 +168,7 @@ struct yas5xx;
 /**
  * struct yas5xx_chip_info - device-specific data and function pointers
  * @devid: device ID number
+ * @product_label: product label used in Linux
  * @product_name: product name of the YAS variant
  * @version_names: version letters or namings
  * @volatile_reg: device-specific volatile registers
@@ -189,6 +190,7 @@ struct yas5xx;
  */
 struct yas5xx_chip_info {
 	unsigned int devid;
+	const char *product_label;
 	const char *product_name;
 	const char *version_names[2];
 	const int *volatile_reg;
@@ -1323,6 +1325,7 @@ static int yas537_power_on(struct yas5xx *yas5xx)
 static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	[yas530] = {
 		.devid = YAS530_DEVICE_ID,
+		.product_label = "yas530",
 		.product_name = "YAS530 MS-3E",
 		.version_names = { "A", "B" },
 		.volatile_reg = yas530_volatile_reg,
@@ -1338,6 +1341,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	},
 	[yas532] = {
 		.devid = YAS532_DEVICE_ID,
+		.product_label = "yas532",
 		.product_name = "YAS532 MS-3R",
 		.version_names = { "AB", "AC" },
 		.volatile_reg = yas530_volatile_reg,
@@ -1353,6 +1357,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	},
 	[yas533] = {
 		.devid = YAS532_DEVICE_ID,
+		.product_label = "yas533",
 		.product_name = "YAS533 MS-3F",
 		.version_names = { "AB", "AC" },
 		.volatile_reg = yas530_volatile_reg,
@@ -1368,6 +1373,7 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 	},
 	[yas537] = {
 		.devid = YAS537_DEVICE_ID,
+		.product_label = "yas537",
 		.product_name = "YAS537 MS-3T",
 		.version_names = { "v0", "v1" }, /* version naming unknown */
 		.volatile_reg = yas537_volatile_reg,
@@ -1385,7 +1391,6 @@ static const struct yas5xx_chip_info yas5xx_chip_info_tbl[] = {
 
 static int yas5xx_probe(struct i2c_client *i2c)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 	struct iio_dev *indio_dev;
 	struct device *dev = &i2c->dev;
 	struct yas5xx *yas5xx;
@@ -1443,7 +1448,7 @@ static int yas5xx_probe(struct i2c_client *i2c)
 	if (id_check != ci->devid) {
 		ret = dev_err_probe(dev, -ENODEV,
 				    "device ID %02x doesn't match %s\n",
-				    id_check, id->name);
+				    id_check, ci->product_label);
 		goto assert_reset;
 	}
 
@@ -1469,7 +1474,7 @@ static int yas5xx_probe(struct i2c_client *i2c)
 	indio_dev->info = &yas5xx_info;
 	indio_dev->available_scan_masks = yas5xx_scan_masks;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->name = id->name;
+	indio_dev->name = ci->product_label;
 	indio_dev->channels = yas5xx_channels;
 	indio_dev->num_channels = ARRAY_SIZE(yas5xx_channels);
 
-- 
2.50.1

