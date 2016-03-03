Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:39056 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756805AbcCCQJM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Mar 2016 11:09:12 -0500
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <nicolas.ferre@atmel.com>,
	Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH 1/3] iio:adc:at91-sama5d2: fix typo
Date: Thu, 3 Mar 2016 17:09:13 +0100
Message-ID: <1457021355-23898-2-git-send-email-ludovic.desroches@atmel.com>
In-Reply-To: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
References: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix typo in the name of a macro.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index dbee13a..33bacec 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -140,7 +140,7 @@
 /* Version Register */
 #define AT91_SAMA5D2_VERSION	0xfc
 
-#define AT91_AT91_SAMA5D2_CHAN(num, addr)				\
+#define AT91_SAMA5D2_CHAN(num, addr)					\
 	{								\
 		.type = IIO_VOLTAGE,					\
 		.channel = num,						\
@@ -185,18 +185,18 @@ struct at91_adc_state {
 };
 
 static const struct iio_chan_spec at91_adc_channels[] = {
-	AT91_AT91_SAMA5D2_CHAN(0, 0x50),
-	AT91_AT91_SAMA5D2_CHAN(1, 0x54),
-	AT91_AT91_SAMA5D2_CHAN(2, 0x58),
-	AT91_AT91_SAMA5D2_CHAN(3, 0x5c),
-	AT91_AT91_SAMA5D2_CHAN(4, 0x60),
-	AT91_AT91_SAMA5D2_CHAN(5, 0x64),
-	AT91_AT91_SAMA5D2_CHAN(6, 0x68),
-	AT91_AT91_SAMA5D2_CHAN(7, 0x6c),
-	AT91_AT91_SAMA5D2_CHAN(8, 0x70),
-	AT91_AT91_SAMA5D2_CHAN(9, 0x74),
-	AT91_AT91_SAMA5D2_CHAN(10, 0x78),
-	AT91_AT91_SAMA5D2_CHAN(11, 0x7c),
+	AT91_SAMA5D2_CHAN(0, 0x50),
+	AT91_SAMA5D2_CHAN(1, 0x54),
+	AT91_SAMA5D2_CHAN(2, 0x58),
+	AT91_SAMA5D2_CHAN(3, 0x5c),
+	AT91_SAMA5D2_CHAN(4, 0x60),
+	AT91_SAMA5D2_CHAN(5, 0x64),
+	AT91_SAMA5D2_CHAN(6, 0x68),
+	AT91_SAMA5D2_CHAN(7, 0x6c),
+	AT91_SAMA5D2_CHAN(8, 0x70),
+	AT91_SAMA5D2_CHAN(9, 0x74),
+	AT91_SAMA5D2_CHAN(10, 0x78),
+	AT91_SAMA5D2_CHAN(11, 0x7c),
 };
 
 static unsigned at91_adc_startup_time(unsigned startup_time_min,
-- 
2.5.0

