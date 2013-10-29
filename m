Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:35480 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756651Ab3J2BAD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Oct 2013 21:00:03 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/4] staging:iio: Fix hmc5843 Kconfig dependencies
Date: Tue, 29 Oct 2013 01:59:57 +0100
Message-Id: <1383008397-8721-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
References: <1383008397-8721-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

trigger / buffer handling was introduced in changeset
cb9b9a82 staging:iio:hmc5843: Add trigger handling

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/magnetometer/Kconfig b/drivers/staging/iio/magnetometer/Kconfig
index a3ea69e..34634da 100644
--- a/drivers/staging/iio/magnetometer/Kconfig
+++ b/drivers/staging/iio/magnetometer/Kconfig
@@ -6,6 +6,8 @@ menu "Magnetometer sensors"
 config SENSORS_HMC5843
 	tristate "Honeywell HMC5843/5883/5883L 3-Axis Magnetometer"
 	depends on I2C
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here to add support for the Honeywell HMC5843, HMC5883 and
 	  HMC5883L 3-Axis Magnetometer (digital compass).
-- 
1.8.4.1

