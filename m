Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED8318ECD;
	Wed,  4 Feb 2026 16:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223342; cv=none; b=UbhTKt7T7jY55wV/5YEf1lPz5lVaJoJLL63l0SbNn2jxeIf4obTPPWbqxHzIBF6wh5j51PRbkr8LP6Oxz4m3ml/82F/sOYMi3yd9bHL6VKBfHf6mKx8MfH/vD98anvSh1qMdrhz0GrARX8rTqGQ1ytPauANX6g3XmskD/7gVnDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223342; c=relaxed/simple;
	bh=8vlCqZN8hg/vKDcQStitR8SkolD3k0bhlYMeJ63mYRA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgkdyKAgF6SeNQKqgOq6gEwYLuC0i5P9i0Mv7VPg3LylB32vIdydUnpJHbuMVqnpn7A1VRExGCFjLBrUHkeY7SgtOCNWISDVCpKvn6gCKFVGqRzrOtamilo/1hyjUz0+lNgiy0C2kTIK2GM2po70gZ6oCVlaIvJA9uu9BfwtnHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gm/kNNoV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gm/kNNoV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA6EC4CEF7;
	Wed,  4 Feb 2026 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770223342;
	bh=8vlCqZN8hg/vKDcQStitR8SkolD3k0bhlYMeJ63mYRA=;
	h=From:To:Cc:Subject:Date:From;
	b=Gm/kNNoVNwrjDDx2urSYktUZmEnqy0m934PRoaxD4nU8LRVk7/+a79twhIcIbWa4f
	 KNpKjCkzhKmLeP00WYgh6VreESUFatjOJwumsLg9tCR/aqRohAPG2/4MZr16aPBeFn
	 FQqLi8Z/fkY0iVbpoGpF/Fixy6qC4sX+0bTCZ4579EvyOu66fTpvbK2dzx8cPPOQNt
	 FJNtOaq4kxhB/pxDm0600TXTE2cVexQ8juM0yA14l2bzajYVjd9LEUk/ytj761sc6O
	 vtimFY8NVi3paqPz50vnJA4LiN4gMhOFVzniyxmU/uqgfs15dHTQc7mPU1oieRZOIE
	 IqhFgV9pphlMw==
From: Arnd Bergmann <arnd@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH] [v3, apply after -rc1] i3c: simplify combined i3c/i2c dependencies
Date: Wed,  4 Feb 2026 17:41:58 +0100
Message-Id: <20260204164216.544409-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All combined i2c/i3c drivers appear to suffer from the same link
time problem when CONFIG_I3C is set to 'm':

arm-linux-gnueabi-ld: drivers/iio/magnetometer/mmc5633.o: in function `mmc5633_i3c_driver_init':
mmc5633.c:(.init.text+0x30): undefined reference to `i3c_driver_register_with_owner'

This was previously fixed every time by marking individual
drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
tedious and is somewhat confusing.

Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
and use this in all the existing drivers that had already fixed it
as well as the new mmc5633 driver.

Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: restore accidentally deleted lines
v3: rebase on top of Jonathan's IIO patch in linux-next
---
 drivers/hwmon/Kconfig            |  6 ++----
 drivers/i3c/Kconfig              | 12 ++++++++++++
 drivers/iio/magnetometer/Kconfig |  3 +--
 drivers/misc/amd-sbi/Kconfig     |  3 +--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 41c381764c2b..ecfba861f66d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1493,8 +1493,7 @@ config SENSORS_LM73
 
 config SENSORS_LM75
 	tristate "National Semiconductor LM75 and compatibles"
-	depends on I2C
-	depends on I3C || !I3C
+	depends on I3C_OR_I2C
 	select REGMAP_I2C
 	select REGMAP_I3C if I3C
 	help
@@ -2392,8 +2391,7 @@ config SENSORS_TMP103
 
 config SENSORS_TMP108
 	tristate "Texas Instruments TMP108"
-	depends on I2C
-	depends on I3C || !I3C
+	depends on I3C_OR_I2C
 	select REGMAP_I2C
 	select REGMAP_I3C if I3C
 	help
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
index 30a441506f61..626c54b386d5 100644
--- a/drivers/i3c/Kconfig
+++ b/drivers/i3c/Kconfig
@@ -22,3 +22,15 @@ menuconfig I3C
 if I3C
 source "drivers/i3c/master/Kconfig"
 endif # I3C
+
+config I3C_OR_I2C
+	tristate
+	default m if I3C=m
+	default I2C
+	help
+	  Device drivers using module_i3c_i2c_driver() can use either
+	  i2c or i3c hosts, but cannot be built-in for the kernel when
+	  CONFIG_I3C=m.
+
+	  Add 'depends on I2C_OR_I3C' in Kconfig for those drivers to
+	  get the correct dependencies.
diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 9345fb6d5317..fb313e591e85 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -143,8 +143,7 @@ config MMC5633
 	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
 	select REGMAP_I2C
 	select REGMAP_I3C if I3C
-	depends on I2C
-	depends on I3C || !I3C
+	depends on I3C_OR_I2C
 	help
 	  Say yes here to build support for the MEMSIC MMC5633 3-axis
 	  magnetic sensor.
diff --git a/drivers/misc/amd-sbi/Kconfig b/drivers/misc/amd-sbi/Kconfig
index be022c71a90c..30e7fad7356c 100644
--- a/drivers/misc/amd-sbi/Kconfig
+++ b/drivers/misc/amd-sbi/Kconfig
@@ -1,10 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config AMD_SBRMI_I2C
 	tristate "AMD side band RMI support"
-	depends on I2C
+	depends on I3C_OR_I2C
 	depends on ARM || ARM64 || COMPILE_TEST
 	select REGMAP_I2C
-	depends on I3C || !I3C
 	select REGMAP_I3C if I3C
 	help
 	  Side band RMI over I2C/I3C support for AMD out of band management.
-- 
2.39.5

