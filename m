Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55692 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbbG2NrZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 09:47:25 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 1/7] iio: bmg160: IIO_BUFFER and IIO_TRIGGERED_BUFFER are required
Date: Wed, 29 Jul 2015 15:46:03 +0200
Message-Id: <1438177569-18772-2-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds selects for IIO_BUFFER and IIO_TRIGGERED_BUFFER. Without
IIO_BUFFER, the driver does not compile.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/gyro/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index b3d0e94f72eb..8d2439345673 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -53,7 +53,8 @@ config ADXRS450
 config BMG160
 	tristate "BOSCH BMG160 Gyro Sensor"
 	depends on I2C
-	select IIO_TRIGGERED_BUFFER if IIO_BUFFER
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Bosch BMG160 Tri-axis Gyro Sensor
 	  driver. This driver also supports BMI055 gyroscope.
-- 
2.1.4

