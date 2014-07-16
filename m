Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:41221 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934927AbaGPSdG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 14:33:06 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 05/13] iio:bma180: Rename BMA_180 to BMA180_
Date: Wed, 16 Jul 2014 20:32:48 +0200
Message-Id: <1405535576-26482-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
References: <1405535576-26482-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index d7f34b4..284598d 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -56,7 +56,7 @@
 /* We have to write this value in reset register to do soft reset */
 #define BMA180_RESET_VAL	0xb6
 
-#define BMA_180_ID_REG_VAL	0x03
+#define BMA180_ID_REG_VAL	0x03
 
 /* Chip power modes */
 #define BMA180_LOW_NOISE	0x00
@@ -258,7 +258,7 @@ static int bma180_chip_init(struct bma180_data *data)
 
 	if (ret < 0)
 		goto err;
-	if (ret != BMA_180_ID_REG_VAL) {
+	if (ret != BMA180_ID_REG_VAL) {
 		ret = -ENODEV;
 		goto err;
 	}
-- 
1.9.1

