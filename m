Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:33381 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759202Ab3ICBFd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Sep 2013 21:05:33 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 06/18] staging:iio:hmc5843: Remove unused LSB register #defines
Date: Tue,  3 Sep 2013 03:05:08 +0200
Message-Id: <1378170320-27538-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
References: <1378170320-27538-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index d8a5c01..ddfc5a5 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -29,16 +29,11 @@
 #define HMC5843_CONFIG_REG_B			0x01
 #define HMC5843_MODE_REG			0x02
 #define HMC5843_DATA_OUT_X_MSB_REG		0x03
-#define HMC5843_DATA_OUT_X_LSB_REG		0x04
 #define HMC5843_DATA_OUT_Y_MSB_REG		0x05
-#define HMC5843_DATA_OUT_Y_LSB_REG		0x06
 #define HMC5843_DATA_OUT_Z_MSB_REG		0x07
-#define HMC5843_DATA_OUT_Z_LSB_REG		0x08
 /* Beware: Y and Z are exchanged on HMC5883 */
 #define HMC5883_DATA_OUT_Z_MSB_REG		0x05
-#define HMC5883_DATA_OUT_Z_LSB_REG		0x06
 #define HMC5883_DATA_OUT_Y_MSB_REG		0x07
-#define HMC5883_DATA_OUT_Y_LSB_REG		0x08
 #define HMC5843_STATUS_REG			0x09
 
 enum hmc5843_ids {
@@ -61,8 +56,6 @@ enum hmc5843_ids {
  */
 #define HMC5843_DATA_READY			0x01
 #define HMC5843_DATA_OUTPUT_LOCK		0x02
-/* Does not exist on HMC5883, not used */
-#define HMC5843_VOLTAGE_REGULATOR_ENABLED	0x04
 
 /*
  * Mode register configuration
-- 
1.7.9.5

