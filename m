Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-la0-f47.google.com ([209.85.215.47]:36574 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755206AbbIBTDK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Sep 2015 15:03:10 -0400
Received: by lanb10 with SMTP id b10so13644859lan.3
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2015 12:03:06 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Denis CIOCCA <denis.ciocca@st.com>
Subject: [PATCH] iio: st_accel: fix interrupt handling on LIS3LV02
Date: Wed,  2 Sep 2015 21:02:58 +0200
Message-Id: <1441220578-25647-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This accelerometer accidentally either emits a DRDY signal or an
IRQ signal. Accidentally I activated the IRQ signal as I thought
it was analogous to the interrupt generator on other ST
accelerometers. This was wrong. After this patch generic_buffer
gives a nice stream of accelerometer readings.

Fixes: 3acddf74f807778f "iio: st-sensors: add support for lis3lv02d accelerometer"
Cc: Denis CIOCCA <denis.ciocca@st.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/st_accel_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 058c87d9f564..6765eebb7c0a 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -149,8 +149,6 @@
 #define ST_ACCEL_4_BDU_MASK			0x40
 #define ST_ACCEL_4_DRDY_IRQ_ADDR		0x21
 #define ST_ACCEL_4_DRDY_IRQ_INT1_MASK		0x04
-#define ST_ACCEL_4_IG1_EN_ADDR			0x21
-#define ST_ACCEL_4_IG1_EN_MASK			0x08
 #define ST_ACCEL_4_MULTIREAD_BIT		true
 
 /* CUSTOM VALUES FOR SENSOR 5 */
@@ -484,10 +482,6 @@ static const struct st_sensor_settings st_accel_sensors_settings[] = {
 		.drdy_irq = {
 			.addr = ST_ACCEL_4_DRDY_IRQ_ADDR,
 			.mask_int1 = ST_ACCEL_4_DRDY_IRQ_INT1_MASK,
-			.ig1 = {
-				.en_addr = ST_ACCEL_4_IG1_EN_ADDR,
-				.en_mask = ST_ACCEL_4_IG1_EN_MASK,
-			},
 		},
 		.multi_read_bit = ST_ACCEL_4_MULTIREAD_BIT,
 		.bootime = 2, /* guess */
-- 
2.4.3

