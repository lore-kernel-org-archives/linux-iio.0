Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-054.synserver.de ([212.40.185.54]:1101 "EHLO
	smtp-out-054.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753911Ab3AKKsz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 11 Jan 2013 05:48:55 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:gyro: Remove stale Makefile entry
Date: Fri, 11 Jan 2013 11:49:30 +0100
Message-Id: <1357901370-1170-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit a301d425e ("staging:iio:gyro remove adis16251 driver as now supported by
adis16260 driver") removed the adis16251, but left its Makefile entry intact.
This patch removes the unused Makefile entry.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/gyro/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/Makefile b/drivers/staging/iio/gyro/Makefile
index 1303569..79bef4e 100644
--- a/drivers/staging/iio/gyro/Makefile
+++ b/drivers/staging/iio/gyro/Makefile
@@ -14,8 +14,5 @@ obj-$(CONFIG_ADIS16130) += adis16130.o
 adis16260-y             := adis16260_core.o
 obj-$(CONFIG_ADIS16260) += adis16260.o
 
-adis16251-y             := adis16251_core.o
-obj-$(CONFIG_ADIS16251) += adis16251.o
-
 adxrs450-y             := adxrs450_core.o
 obj-$(CONFIG_ADXRS450) += adxrs450.o
-- 
1.8.0

