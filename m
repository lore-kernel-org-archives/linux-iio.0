Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:62422 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbbG2Vjz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 29 Jul 2015 17:39:55 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH v2 1/7] iio:accel:stk8312: add triggered buffer dependency
Date: Wed, 29 Jul 2015 23:39:34 +0200
Message-Id: <ab6ffe2a496adb1a1167e698e1c78ef7753d52ec.1438204273.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438204273.git.knaack.h@gmx.de>
References: <cover.1438204273.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438204273.git.knaack.h@gmx.de>
References: <cover.1438204273.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add the still missing dependencies for triggered buffer support.

Fixes: 	95c12bba51c37 ("iio: accel: Add buffer mode for Sensortek STK8312")
Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Reviewed-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/accel/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 00e7bcbdbe24..c99d8e242218 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -140,6 +140,8 @@ config MMA9553
 config STK8312
 	tristate "Sensortek STK8312 3-Axis Accelerometer Driver"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to get support for the Sensortek STK8312 3-axis
 	  accelerometer.
-- 
2.4.6

