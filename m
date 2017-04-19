Return-Path: <SRS0=MhQT=33=microchip.com=Eugen.Hristev@kernel.org>
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <nicolas.ferre@microchip.com>, <alexandre.belloni@free-electrons.com>,
	<linux-iio@vger.kernel.org>, <jic23@kernel.org>, <lars@metafoo.de>,
	<linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <ludovic.desroches@microchip.com>, <eugen.hristev@microchip.com>
Subject: [PATCH 3/3] iio: tools: generic_buffer: increase trigger length
Date: Wed, 19 Apr 2017 11:20:45 +0300
Message-ID: <1492590045-17329-4-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1492590045-17329-1-git-send-email-eugen.hristev@microchip.com>
References: <1492590045-17329-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Increased trigger length to 50 in order to cope with trigger names like
fc030000.adc-dev0-external-rising

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 tools/iio/iio_utils.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index 780f201..9d59771 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -13,7 +13,7 @@
 #include <stdint.h>
 
 /* Made up value to limit allocation sizes */
-#define IIO_MAX_NAME_LENGTH 30
+#define IIO_MAX_NAME_LENGTH 50
 
 #define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
 #define FORMAT_TYPE_FILE "%s_type"
-- 
2.7.4
