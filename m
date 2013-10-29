Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:35479 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756892Ab3J2BAD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Oct 2013 21:00:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: Fix tcs3472 Kconfig dependencies
Date: Tue, 29 Oct 2013 01:59:56 +0100
Message-Id: <1383008397-8721-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
References: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/light/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 5e60be4..f0035db 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -81,6 +81,8 @@ config SENSORS_LM3533
 config TCS3472
 	tristate "TAOS TCS3472 color light-to-digital converter"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	 If you say yes here you get support for the TAOS TCS3472
 	 family of color light-to-digital converters with IR filter.
-- 
1.8.4.1

