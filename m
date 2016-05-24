Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:49624 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbcEXMnD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 24 May 2016 08:43:03 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH] iio: magnetometer: bmc150: Document Bosch supported chips
Date: Tue, 24 May 2016 15:42:28 +0300
Message-Id: <1464093748-4798-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

bmc150 driver supports also BMC156 and BMM150 chips.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 84e6559..1f842ab 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -44,6 +44,7 @@ config BMC150_MAGN_I2C
 	  This driver is only implementing magnetometer part, which has
 	  its own address and register map.
 
+	  This driver also supports I2C Bosch BMC156 and BMM150 chips.
 	  To compile this driver as a module, choose M here: the module will be
 	  called bmc150_magn_i2c.
 
@@ -60,6 +61,7 @@ config BMC150_MAGN_SPI
 	  This driver is only implementing magnetometer part, which has
 	  its own address and register map.
 
+	  This driver also supports SPI Bosch BMC156 and BMM150 chips.
 	  To compile this driver as a module, choose M here: the module will be
 	  called bmc150_magn_spi.
 
-- 
2.5.0

