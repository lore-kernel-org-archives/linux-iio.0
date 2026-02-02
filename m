Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988202BDC32;
	Mon,  2 Feb 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026195; cv=none; b=ae7MEM24RxsS1oWqUAmHQuvT7gKakHUhxJOpT4rGGgQLOLUuhT1Pt3ig8O3omt2DydLStEU2so/nEssTHw3vhlsUafnwFt2zHwKfMKIgpxU5kP69sDRTDZGlkGbzKKbUuzmbEQKckTQ2tv/J0UQ4DmgFriBvH+z69JmRkZoJ5A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026195; c=relaxed/simple;
	bh=To2VkYEmJRA5edR97P1H5WOqIjJetFQipCH+TeuvDts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8n4YB/WFfbaJt2q8xOAHK2E9zokq7mjuW5odStLFYog5s5023r8cR+lz/6v9K+0ya80UTRmm/ScIU8fsIOqCyqWo4DpmVcrFxd1rALzaQl673/txjmD8PjA7tWfnnLkpf2Wn7GDhuzbC8woPETHiMfkWggT/HMwqFQD9+OtEn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSt9BWUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSt9BWUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04864C116C6;
	Mon,  2 Feb 2026 09:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026195;
	bh=To2VkYEmJRA5edR97P1H5WOqIjJetFQipCH+TeuvDts=;
	h=From:To:Cc:Subject:Date:From;
	b=nSt9BWUbMiJWt4qXGFjiKVn+G4YzRpsAAXIRMaITA0qsHNCoL0T6YbzAR5yD5hhH2
	 0cntAZEQ1TDGFa6bTKUaTWG/ffkX2sBBWHmjMuaXNTKy9TDSf+mAJKjNNkJLeFDI2/
	 BczdybJXbPy4lmFX2Vh6JW1jKLl4aarTpIhveSDE/fJUgwBjwovtDvLf6tNW6tHxSp
	 HeqyV5i5f/c1sXxrurNxkT0OS5oZl2E0qeRzlEGK6eeBtv/Mmme//Rj5OlFh2SCNR4
	 vbl5M2aYbhJoBYvCUTEI9SJGVbk1D4nN1P02k5020Tq0jaLY4yyjyEeM4M2K4p1Nnv
	 YNsIGZI8ZGSFQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Frank Li <Frank.Li@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Carlos Song <carlos.song@nxp.com>,
	Adrian Fluturel <fluturel.adrian@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-i3c@lists.infradead.org,
	linux-iio@vger.kernel.org
Subject: [PATCH] i3c, iio: fix i3c driver dependencies
Date: Mon,  2 Feb 2026 10:55:31 +0100
Message-Id: <20260202095628.1254175-1-arnd@kernel.org>
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

This was previously fixed several times by marking individual
drivers as 'depends on I2C; depends on I3C || !I3C', but this gets
tedious and is somewhat confusing.

Add a Kconfig symbol 'I3C_OR_I2C' to help replace those dependencies,
and use this in all the existing drivers that had already fixed it
as well as the new mmc5633 driver.

Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/hwmon/Kconfig            | 17 ++---------------
 drivers/i3c/Kconfig              | 12 ++++++++++++
 drivers/iio/magnetometer/Kconfig |  2 +-
 drivers/misc/amd-sbi/Kconfig     |  3 +--
 4 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 41c381764c2b..1ddb3f73fdc0 100644
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
@@ -2381,19 +2380,7 @@ config SENSORS_TMP102
 
 config SENSORS_TMP103
 	tristate "Texas Instruments TMP103"
-	depends on I2C
-	select REGMAP_I2C
-	help
-	  If you say yes here you get support for Texas Instruments TMP103
-	  sensor chips.
-
-	  This driver can also be built as a module. If so, the module
-	  will be called tmp103.
-
-config SENSORS_TMP108
-	tristate "Texas Instruments TMP108"
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
index 2b81b22c9550..448fef4e5716 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -143,7 +143,7 @@ config MMC5633
 	tristate "MEMSIC MMC5633 3-axis magnetic sensor"
 	select REGMAP_I2C if I2C
 	select REGMAP_I3C if I3C
-	depends on I2C || I3C
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

