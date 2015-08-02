Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:52480 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751614AbbHBUoG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:06 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 7/7] iio:accel:mma8452: reorder Kconfig entry
Date: Sun,  2 Aug 2015 22:43:52 +0200
Message-Id: <f2c8c8dd008120917ceb2c87367e2e1bd5bbaf93.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Move the entry in Kconfig to its alphabetically correct position.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 00e7bcbdbe24..b8fc12c7640b 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -86,18 +86,6 @@ config KXSD9
 	  To compile this driver as a module, choose M here: the module
 	  will be called kxsd9.
 
-config MMA8452
-	tristate "Freescale MMA8452Q Accelerometer Driver"
-	depends on I2C
-	select IIO_BUFFER
-	select IIO_TRIGGERED_BUFFER
-	help
-	  Say yes here to build support for the Freescale MMA8452Q 3-axis
-	  accelerometer.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called mma8452.
-
 config KXCJK1013
 	tristate "Kionix 3-Axis Accelerometer Driver"
 	depends on I2C
@@ -111,6 +99,18 @@ config KXCJK1013
 	  To compile this driver as a module, choose M here: the module will
 	  be called kxcjk-1013.
 
+config MMA8452
+	tristate "Freescale MMA8452Q Accelerometer Driver"
+	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
+	help
+	  Say yes here to build support for the Freescale MMA8452Q 3-axis
+	  accelerometer.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called mma8452.
+
 config MMA9551_CORE
 	tristate
 
-- 
2.4.6

