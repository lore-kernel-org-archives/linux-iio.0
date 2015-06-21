Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: tmp006: Use GENMASK
Date: Sun, 21 Jun 2015 23:50:22 +0200
Message-Id: <1434923422-17609-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1434923422-17609-1-git-send-email-pmeerw@pmeerw.net>
References: <1434923422-17609-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/temperature/tmp006.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index 7a80509..a107087 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -36,9 +36,9 @@
 #define TMP006_CONFIG_DRDY_EN BIT(8)
 #define TMP006_CONFIG_DRDY BIT(7)
 
-#define TMP006_CONFIG_MOD_MASK 0x7000
+#define TMP006_CONFIG_MOD_MASK GENMASK(14, 12)
 
-#define TMP006_CONFIG_CR_MASK 0x0e00
+#define TMP006_CONFIG_CR_MASK GENMASK(11, 9)
 #define TMP006_CONFIG_CR_SHIFT 9
 
 #define MANUFACTURER_MAGIC 0x5449
-- 
1.9.1
