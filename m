Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:35477 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756893Ab3J2BAD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Oct 2013 21:00:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: Fix mag3110 Kconfig dependencies
Date: Tue, 29 Oct 2013 01:59:55 +0100
Message-Id: <1383008397-8721-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
References: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index 0cf0963..d86d226 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -19,6 +19,8 @@ config AK8975
 config MAG3110
 	tristate "Freescale MAG3110 3-Axis Magnetometer"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the Freescale MAG3110 3-Axis
 	  magnetometer.
-- 
1.8.4.1

