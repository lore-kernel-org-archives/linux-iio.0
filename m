Return-Path: <ludovic.desroches@atmel.com>
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <nicolas.ferre@atmel.com>, Ludovic
 Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 2/3] iio:adc:at91-sama5d2: fix identation
Date: Thu, 3 Mar 2016 17:09:14 +0100
Message-ID: <1457021355-23898-3-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
References: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Remove some extra tabs.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 33bacec..5bc038f 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -92,13 +92,13 @@
 /* Last Converted Data Register */
 #define AT91_SAMA5D2_LCDR	0x20
 /* Interrupt Enable Register */
-#define AT91_SAMA5D2_IER		0x24
+#define AT91_SAMA5D2_IER	0x24
 /* Interrupt Disable Register */
-#define AT91_SAMA5D2_IDR		0x28
+#define AT91_SAMA5D2_IDR	0x28
 /* Interrupt Mask Register */
-#define AT91_SAMA5D2_IMR		0x2c
+#define AT91_SAMA5D2_IMR	0x2c
 /* Interrupt Status Register */
-#define AT91_SAMA5D2_ISR		0x30
+#define AT91_SAMA5D2_ISR	0x30
 /* Last Channel Trigger Mode Register */
 #define AT91_SAMA5D2_LCTMR	0x34
 /* Last Channel Compare Window Register */
@@ -106,17 +106,17 @@
 /* Overrun Status Register */
 #define AT91_SAMA5D2_OVER	0x3c
 /* Extended Mode Register */
-#define AT91_SAMA5D2_EMR		0x40
+#define AT91_SAMA5D2_EMR	0x40
 /* Compare Window Register */
-#define AT91_SAMA5D2_CWR		0x44
+#define AT91_SAMA5D2_CWR	0x44
 /* Channel Gain Register */
-#define AT91_SAMA5D2_CGR		0x48
+#define AT91_SAMA5D2_CGR	0x48
 /* Channel Offset Register */
-#define AT91_SAMA5D2_COR		0x4c
+#define AT91_SAMA5D2_COR	0x4c
 /* Channel Data Register 0 */
 #define AT91_SAMA5D2_CDR0	0x50
 /* Analog Control Register */
-#define AT91_SAMA5D2_ACR		0x94
+#define AT91_SAMA5D2_ACR	0x94
 /* Touchscreen Mode Register */
 #define AT91_SAMA5D2_TSMR	0xb0
 /* Touchscreen X Position Register */
@@ -130,7 +130,7 @@
 /* Correction Select Register */
 #define AT91_SAMA5D2_COSR	0xd0
 /* Correction Value Register */
-#define AT91_SAMA5D2_CVR		0xd4
+#define AT91_SAMA5D2_CVR	0xd4
 /* Channel Error Correction Register */
 #define AT91_SAMA5D2_CECR	0xd8
 /* Write Protection Mode Register */
-- 
2.5.0
