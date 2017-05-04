Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:56612 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbdEDMOw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 08:14:52 -0400
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <jic23@kernel.org>,
        <alexandre.belloni@free-electrons.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ludovic.desroches@microchip.com>, <eugen.hristev@microchip.com>
Subject: [PATCH v2 3/3] iio: tools: generic_buffer: increase trigger length
Date: Thu, 4 May 2017 15:13:20 +0300
Message-ID: <1493900000-26220-4-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
References: <1493900000-26220-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Increased trigger length to 64 in order to cope with trigger names
like fc030000.adc-dev0-external-rising

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 Changes in v2:
 - Modified trigger name length to 64

 tools/iio/iio_utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index 780f201..8b379da 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -13,7 +13,7 @@
 #include <stdint.h>
 
 /* Made up value to limit allocation sizes */
-#define IIO_MAX_NAME_LENGTH 30
+#define IIO_MAX_NAME_LENGTH 64
 
 #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
 #define FORMAT_TYPE_FILE "%s_type"
-- 
2.7.4

