Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50662 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755074AbcKJJ0U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:20 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 11/28] staging: iio: tsl2583: fix alignment of #define values
Date: Thu, 10 Nov 2016 04:25:47 -0500
Message-Id: <1478769964-7065-12-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Most of the values in the #defines have their values aligned on a single
column, but some do not. This changes the remaining defines to use
consistent alignment with the majority to improve code readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5a82a26..d482a84 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -44,19 +44,19 @@
 /* tsl2583 cmd reg masks */
 #define TSL2583_CMD_REG			0x80
 #define TSL2583_CMD_SPL_FN		0x60
-#define TSL2583_CMD_ALS_INT_CLR	0X01
+#define TSL2583_CMD_ALS_INT_CLR		0x01
 
 /* tsl2583 cntrl reg masks */
-#define TSL2583_CNTL_ADC_ENBL	0x02
+#define TSL2583_CNTL_ADC_ENBL		0x02
 #define TSL2583_CNTL_PWR_OFF		0x00
 #define TSL2583_CNTL_PWR_ON		0x01
 
 /* tsl2583 status reg masks */
-#define TSL2583_STA_ADC_VALID	0x01
-#define TSL2583_STA_ADC_INTR	0x10
+#define TSL2583_STA_ADC_VALID		0x01
+#define TSL2583_STA_ADC_INTR		0x10
 
 /* Lux calculation constants */
-#define	TSL2583_LUX_CALC_OVER_FLOW		65535
+#define	TSL2583_LUX_CALC_OVER_FLOW	65535
 
 #define TSL2583_INTERRUPT_DISABLED	0x00
 
-- 
2.7.4

