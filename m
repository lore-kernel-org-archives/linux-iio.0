Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt0-f195.google.com ([209.85.216.195]:34952 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751445AbdF0BpY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Jun 2017 21:45:24 -0400
Received: by mail-qt0-f195.google.com with SMTP id w12so2273327qta.2
        for <linux-iio@vger.kernel.org>; Mon, 26 Jun 2017 18:45:24 -0700 (PDT)
Message-ID: <1498527922.31066.3.camel@gmail.com>
Subject: [PATCH] iio: sca3000: Remove trailing whitespace
From: Reno Farnesi <nfarnesi4@gmail.com>
To: "jic23@kernel.org" <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Date: Mon, 26 Jun 2017 21:45:22 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Removes trailing whitespace to fix checkpatch errors

Signed-off-by: Reno Farnesi <nfarnesi4@gmail.com>
---
 drivers/iio/accel/sca3000.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index cb1d83fa19a0..39ab210c44f6 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -36,7 +36,7 @@
 #define   SCA3000_LOCKED				BIT(5)
 #define   SCA3000_EEPROM_CS_ERROR			BIT(1)
 #define   SCA3000_SPI_FRAME_ERROR			BIT(0)
- 
+
 /* All reads done using register decrement so no need to 
directly access LSBs */
 #define SCA3000_REG_X_MSB_ADDR				0x05
 #define SCA3000_REG_Y_MSB_ADDR				0x07
@@ -74,7 +74,7 @@
 #define SCA3000_REG_INT_STATUS_ADDR			0x16
 #define   SCA3000_REG_INT_STATUS_THREE_QUARTERS		BIT(7)
 #define   SCA3000_REG_INT_STATUS_HALF			BIT(6)
-	
+
 #define SCA3000_INT_STATUS_FREE_FALL			BIT(3)
 #define SCA3000_INT_STATUS_Y_TRIGGER			BIT(2)
 #define SCA3000_INT_STATUS_X_TRIGGER			BIT(1)
@@ -124,7 +124,7 @@
 
 #define SCA3000_REG_INT_MASK_ADDR			0x21
 #define   SCA3000_REG_INT_MASK_PROT_MASK		0x1C
- 
+
 #define   SCA3000_REG_INT_MASK_RING_THREE_QUARTER	BIT(7)
 #define   SCA3000_REG_INT_MASK_RING_HALF		BIT(6)
 
-- 
2.13.1

