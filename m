Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from zk223.dresearch-fe.de ([217.92.177.116]:32964 "EHLO
	zk223.dresearch-fe.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218AbaE0G1i (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 May 2014 02:27:38 -0400
From: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
To: linux-iio@vger.kernel.org, jic23@kernel.org, jbrenner@taosinc.com
Cc: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
Subject: [PATCH] staging: iio: tsl2x7x_core: fix proximity treshold
Date: Tue, 27 May 2014 08:19:55 +0200
Message-Id: <1401171595-13448-1-git-send-email-mario.schuknecht@dresearch-fe.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Consider high byte of proximity min and max treshold in function
'tsl2x7x_chip_on'. So far, the high byte was not set.

Signed-off-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
---
 drivers/staging/iio/light/tsl2x7x_core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 9e0f2a9..ab338e3 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -667,9 +667,13 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
 			chip->tsl2x7x_settings.prox_pulse_count;
 	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHLO] =
-	chip->tsl2x7x_settings.prox_thres_low;
+			(chip->tsl2x7x_settings.prox_thres_low) & 0xFF;
+	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHHI] =
+			(chip->tsl2x7x_settings.prox_thres_low >> 8) & 0xFF;
 	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHLO] =
-			chip->tsl2x7x_settings.prox_thres_high;
+			(chip->tsl2x7x_settings.prox_thres_high) & 0xFF;
+	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHHI] =
+			(chip->tsl2x7x_settings.prox_thres_high >> 8) & 0xFF;
 
 	/* and make sure we're not already on */
 	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
-- 
1.8.1.4

