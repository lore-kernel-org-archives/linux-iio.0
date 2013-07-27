Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:60594 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab3G0PcE (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 27 Jul 2013 11:32:04 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH 2/9] staging:iio:hmc5843: Remove id register #defines, not used anymore
Date: Sat, 27 Jul 2013 17:31:45 +0200
Message-Id: <1374939112-18237-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index e5999d4..c281342 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -42,9 +42,6 @@
 #define HMC5883_DATA_OUT_Y_MSB_REG		0x07
 #define HMC5883_DATA_OUT_Y_LSB_REG		0x08
 #define HMC5843_STATUS_REG			0x09
-#define HMC5843_ID_REG_A			0x0A
-#define HMC5843_ID_REG_B			0x0B
-#define HMC5843_ID_REG_C			0x0C
 
 enum hmc5843_ids {
 	HMC5843_ID,
-- 
1.8.3.4

