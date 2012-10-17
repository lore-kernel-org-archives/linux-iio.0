Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:37165 "HELO
	vsp-authed-01-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756532Ab2JQK2y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Oct 2012 06:28:54 -0400
From: Andreas Larsson <andreas@gaisler.com>
To: linux-iio@vger.kernel.org
Cc: software@gaisler.com
Subject: [PATCH] iio: Remove duplicates for light/ in Kconfig and Makefile
Date: Wed, 17 Oct 2012 10:36:35 +0200
Message-Id: <1350462995-18347-1-git-send-email-andreas@gaisler.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 drivers/iio/Kconfig  |    1 -
 drivers/iio/Makefile |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 6e3f143..fc937ac 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -60,9 +60,8 @@ source "drivers/iio/amplifiers/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/frequency/Kconfig"
 source "drivers/iio/dac/Kconfig"
 source "drivers/iio/common/Kconfig"
 source "drivers/iio/gyro/Kconfig"
-source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
 
 endif # IIO
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index f7fa3c0..761f2b6 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -16,7 +16,6 @@ obj-y += amplifiers/
 obj-y += light/
 obj-y += frequency/
 obj-y += dac/
 obj-y += common/
 obj-y += gyro/
-obj-y += light/
 obj-y += magnetometer/
-- 
1.7.0.4

