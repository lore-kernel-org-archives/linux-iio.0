Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37994 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754385AbbDOUjn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Apr 2015 16:39:43 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio:tcs4531: Fix leftover TCS3472_ prefix in tsl4531 driver
Date: Wed, 15 Apr 2015 22:39:36 +0200
Message-Id: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

just cleanup, no functional change

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/tsl4531.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index 0763b86..63c26e2 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -24,12 +24,12 @@
 
 #define TSL4531_DRV_NAME "tsl4531"
 
-#define TCS3472_COMMAND BIT(7)
+#define TSL4531_COMMAND BIT(7)
 
-#define TSL4531_CONTROL (TCS3472_COMMAND | 0x00)
-#define TSL4531_CONFIG (TCS3472_COMMAND | 0x01)
-#define TSL4531_DATA (TCS3472_COMMAND | 0x04)
-#define TSL4531_ID (TCS3472_COMMAND | 0x0a)
+#define TSL4531_CONTROL (TSL4531_COMMAND | 0x00)
+#define TSL4531_CONFIG (TSL4531_COMMAND | 0x01)
+#define TSL4531_DATA (TSL4531_COMMAND | 0x04)
+#define TSL4531_ID (TSL4531_COMMAND | 0x0a)
 
 /* operating modes in control register */
 #define TSL4531_MODE_POWERDOWN 0x00
-- 
1.9.1

