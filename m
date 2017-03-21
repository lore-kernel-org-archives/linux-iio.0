Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34887 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757986AbdCUPHF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 11:07:05 -0400
From: Arushi Singhal <arushisinghal19971997@gmail.com>
To: linux-fbdev@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com, Michael.Hennerich@analog.com,
        teddy.wang@siliconmotion.com, gregkh@linuxfoundation.org,
        speakup@linux-speakup.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        linux-iio@vger.kernel.org,
        Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: [PATCH v2 1/2] staging: sm750fb: Remove typedef from "typedef struct _mode_parameter_t"
Date: Tue, 21 Mar 2017 20:36:37 +0530
Message-Id: <20170321150638.9175-2-arushisinghal19971997@gmail.com>
In-Reply-To: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
References: <20170321150638.9175-1-arushisinghal19971997@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch removes typedefs from struct and renames it from "typedef
struct _mode_parameter_t" to "struct mode_parameter" as per kernel
coding standards."

Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
---
changes in v2
 -change the subject and commit message of PATCH.

 drivers/staging/sm750fb/ddk750_mode.c | 8 +++++---
 drivers/staging/sm750fb/ddk750_mode.h | 8 +++-----
 drivers/staging/sm750fb/sm750_hw.c    | 2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index eea5aef2956f..9665bb9478dc 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -12,7 +12,8 @@
  * HW only supports 7 predefined pixel clocks, and clock select is
  * in bit 29:27 of Display Control register.
  */
-static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam, unsigned long dispControl)
+static unsigned long displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
+						  unsigned long dispControl)
 {
 	unsigned long x, y;
 
@@ -72,7 +73,8 @@ static unsigned long displayControlAdjust_SM750LE(mode_parameter_t *pModeParam,
 }
 
 /* only timing related registers will be  programed */
-static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *pll)
+static int programModeRegisters(struct mode_parameter *pModeParam,
+				struct pll_value *pll)
 {
 	int ret = 0;
 	int cnt = 0;
@@ -198,7 +200,7 @@ static int programModeRegisters(mode_parameter_t *pModeParam, struct pll_value *
 	return ret;
 }
 
-int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock)
+int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock)
 {
 	struct pll_value pll;
 	unsigned int uiActualPixelClk;
diff --git a/drivers/staging/sm750fb/ddk750_mode.h b/drivers/staging/sm750fb/ddk750_mode.h
index 6d204b8b4a01..9dc4d6c5a779 100644
--- a/drivers/staging/sm750fb/ddk750_mode.h
+++ b/drivers/staging/sm750fb/ddk750_mode.h
@@ -9,7 +9,7 @@ typedef enum _spolarity_t {
 }
 spolarity_t;
 
-typedef struct _mode_parameter_t {
+struct mode_parameter {
 	/* Horizontal timing. */
 	unsigned long horizontal_total;
 	unsigned long horizontal_display_end;
@@ -31,9 +31,7 @@ typedef struct _mode_parameter_t {
 
 	/* Clock Phase. This clock phase only applies to Panel. */
 	spolarity_t clock_phase_polarity;
-}
-mode_parameter_t;
-
-int ddk750_setModeTiming(mode_parameter_t *parm, clock_type_t clock);
+};
 
+int ddk750_setModeTiming(struct mode_parameter *parm, clock_type_t clock);
 #endif
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index fab3fc9c8330..baf1bbdc92ff 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -252,7 +252,7 @@ int hw_sm750_crtc_setMode(struct lynxfb_crtc *crtc,
 {
 	int ret, fmt;
 	u32 reg;
-	mode_parameter_t modparm;
+	struct mode_parameter modparm;
 	clock_type_t clock;
 	struct sm750_dev *sm750_dev;
 	struct lynxfb_par *par;
-- 
2.11.0

