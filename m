Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35723 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014Ab3CBQRe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:34 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH 06/67] iio:st_sensors move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:16:23 +0000
Message-Id: <1362241044-3534-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
cc: Denis Ciocca <denis.ciocca@st.com>
---
 include/linux/iio/common/st_sensors.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index 1f86a97..7c0c0d3 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -15,6 +15,7 @@
 #include <linux/spi/spi.h>
 #include <linux/irqreturn.h>
 #include <linux/iio/trigger.h>
+#include <linux/bitops.h>
 
 #define ST_SENSORS_TX_MAX_LENGTH		2
 #define ST_SENSORS_RX_MAX_LENGTH		6
@@ -45,8 +46,8 @@
 { \
 	.type = device_type, \
 	.modified = 1, \
-	.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT | \
-			IIO_CHAN_INFO_SCALE_SEPARATE_BIT, \
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
+			BIT(IIO_CHAN_INFO_SCALE), \
 	.scan_index = index, \
 	.channel2 = mod, \
 	.address = addr, \
-- 
1.8.1.4

