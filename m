Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-243.synserver.de ([212.40.185.243]:1130 "EHLO
	smtp-out-243.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755026Ab2LFNtF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Dec 2012 08:49:05 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: fengguang.wu@intel.com, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:adis16260: Select adislib
Date: Thu,  6 Dec 2012 14:48:39 +0100
Message-Id: <1354801719-12641-1-git-send-email-lars@metafoo.de>
In-Reply-To: <50bda6c1.YyzaM05r7Y5H3Jeo%fengguang.wu@intel.com>
References: <50bda6c1.YyzaM05r7Y5H3Jeo%fengguang.wu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 9d5e9fdf ("staging:iio:adis16260: Use adis library") switched over the
adis16260 driver to use the common adis library but neglected to update the
Kconfig entry to reflect the change.

This leads to the following compile error if no other driver selects the adis
library:

	drivers/built-in.o: In function `adis16260_write_frequency':
		adis16260_core.c:(.text+0x5a83bf): undefined reference to `adis_write_reg_8'
	drivers/built-in.o: In function `adis16260_read_frequency':
		adis16260_core.c:(.text+0x5a8433): undefined reference to `adis_read_reg_16'
	drivers/built-in.o: In function `adis16260_write_raw':
		adis16260_core.c:(.text+0x5a8538): undefined reference to `adis_write_reg_16'
		adis16260_core.c:(.text+0x5a856b): undefined reference to `adis_write_reg_16'
	drivers/built-in.o: In function `adis16260_read_raw':
		adis16260_core.c:(.text+0x5a85d3): undefined reference to `adis_single_conversion'
		adis16260_core.c:(.text+0x5a873e): undefined reference to `adis_read_reg_16'
		adis16260_core.c:(.text+0x5a87fb): undefined reference to `adis_read_reg_16'
	drivers/built-in.o: In function `adis16260_probe':
		adis16260_core.c:(.devinit.text+0x5c6b8): undefined reference to `adis_init'
		adis16260_core.c:(.devinit.text+0x5c799): undefined reference to `adis_initial_startup'
	drivers/built-in.o: In function `adis16260_remove':
		adis16260_core.c:(.devexit.text+0x9943): undefined reference to `adis_write_reg_16'

This patch updates the adis16260 Kconfig entry to select the adis library.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/gyro/Kconfig b/drivers/staging/iio/gyro/Kconfig
index ea295b2..87979a0 100644
--- a/drivers/staging/iio/gyro/Kconfig
+++ b/drivers/staging/iio/gyro/Kconfig
@@ -27,8 +27,8 @@ config ADIS16130
 config ADIS16260
 	tristate "Analog Devices ADIS16260 Digital Gyroscope Sensor SPI driver"
 	depends on SPI
-	select IIO_TRIGGER if IIO_BUFFER
-	select IIO_SW_RING if IIO_BUFFER
+	select IIO_ADIS_LIB
+	select IIO_ADIS_LIB_BUFFER if IIO_BUFFER
 	help
 	  Say yes here to build support for Analog Devices ADIS16260 ADIS16265
 	  ADIS16250 ADIS16255 and ADIS16251 programmable digital gyroscope sensors.
-- 
1.8.0

