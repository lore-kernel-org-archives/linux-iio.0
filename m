Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37993 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754439AbbDOUjn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 15 Apr 2015 16:39:43 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio:tmp006: Prefix #defines with TMP006_
Date: Wed, 15 Apr 2015 22:39:38 +0200
Message-Id: <1429130378-19941-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net>
References: <1429130378-19941-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

just cleanup, no functional change

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/temperature/tmp006.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 84a0789..fcc49f8 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -41,8 +41,8 @@
 #define TMP006_CONFIG_CR_MASK 0x0e00
 #define TMP006_CONFIG_CR_SHIFT 9
 
-#define MANUFACTURER_MAGIC 0x5449
-#define DEVICE_MAGIC 0x0067
+#define TMP006_MANUFACTURER_MAGIC 0x5449
+#define TMP006_DEVICE_MAGIC 0x0067
 
 struct tmp006_data {
 	struct i2c_client *client;
@@ -191,7 +191,7 @@ static bool tmp006_check_identification(struct i2c_client *client)
 	if (did < 0)
 		return false;
 
-	return mid == MANUFACTURER_MAGIC && did == DEVICE_MAGIC;
+	return mid == TMP006_MANUFACTURER_MAGIC && did == TMP006_DEVICE_MAGIC;
 }
 
 static int tmp006_probe(struct i2c_client *client,
-- 
1.9.1

