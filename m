Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42761 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab3FWVa3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:30:29 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] iio: move ABI specification for store_eeprom; is used by ad9523, mcp4725 and ds1077 devices
Date: Sun, 23 Jun 2013 23:30:20 +0200
Message-Id: <1372023020-18742-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net>
References: <1372023020-18742-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 Documentation/ABI/testing/sysfs-bus-iio                  | 8 ++++++++
 Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523 | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 0af1af0..d43ca5c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -793,3 +793,11 @@ Contact:	linux-iio@vger.kernel.org
 Description:
 		This attribute is used to read the amount of quadrature error
 		present in the device at a given time.
+
+What:		/sys/bus/iio/devices/iio:deviceX/store_eeprom
+KernelVersion:	3.4.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Writing '1' stores the current device configuration into
+		on-chip EEPROM. After power-up or chip reset the device will
+		automatically load the saved configuration.
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
index 2ce9c3f..a91aeab 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
@@ -18,14 +18,6 @@ Description:
 		Reading returns either '1' or '0'. '1' means that the
 		pllY is locked.
 
-What:		/sys/bus/iio/devices/iio:deviceX/store_eeprom
-KernelVersion:	3.4.0
-Contact:	linux-iio@vger.kernel.org
-Description:
-		Writing '1' stores the current device configuration into
-		on-chip EEPROM. After power-up or chip reset the device will
-		automatically load the saved configuration.
-
 What:		/sys/bus/iio/devices/iio:deviceX/sync_dividers
 KernelVersion:	3.4.0
 Contact:	linux-iio@vger.kernel.org
-- 
1.8.3.1

