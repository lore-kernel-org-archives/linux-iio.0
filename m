Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35014 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757986AbdCUPH0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 11:07:26 -0400
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        linux-iio@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH v2 2/2] staging: sm750fb: Remove typedef from "typedef enum _spolarity_t"
Date: Tue, 21 Mar 2017 20:36:38 +0530
Message-Id: <20170321150638.9175-3-arushisinghal19971997@gmail.com>
In-Reply-To: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
References: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes typedefs from enum and renames it from "typedef enum
_spolarity_t" to "enum spolarity" as per kernel coding standards."

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
 -change the subject and commit message of PATCH.

 drivers/staging/sm750fb/ddk750_mode.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 9dc4d6c5a779..d5eae36d85cb 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -3,11 +3,10 @@
 
 #include "ddk750_chip.h"
 
-typedef enum _spolarity_t {
+enum spolarity {
 	POS = 0, /* positive */
 	NEG, /* negative */
-}
-spolarity_t;
+};
 
 struct mode_parameter {
 	/* Horizontal timing. */
@@ -15,14 +14,14 @@ struct mode_parameter {
 	unsigned long horizontal_display_end;
 	unsigned long horizontal_sync_start;
 	unsigned long horizontal_sync_width;
-	spolarity_t horizontal_sync_polarity;
+	enum spolarity horizontal_sync_polarity;
 
 	/* Vertical timing. */
 	unsigned long vertical_total;
 	unsigned long vertical_display_end;
 	unsigned long vertical_sync_start;
 	unsigned long vertical_sync_height;
-	spolarity_t vertical_sync_polarity;
+	enum spolarity vertical_sync_polarity;
 
 	/* Refresh timing. */
 	unsigned long pixel_clock;
@@ -30,7 +29,7 @@ struct mode_parameter {
 	unsigned long vertical_frequency;
 
 	/* Clock Phase. This clock phase only applies to Panel. */
-	spolarity_t clock_phase_polarity;
+	enum spolarity clock_phase_polarity;
 };
 
 int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock);
-- 
2.11.0

