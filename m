Return-Path: <SRS0=B0fY=57=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 1/2] iio: light: tcs3472: add link to datasheet
Date: Tue, 27 Jun 2017 00:44:54 +0900
Message-Id: <1498491895-19393-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1498491895-19393-1-git-send-email-akinobu.mita@gmail.com>
References: <1498491895-19393-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add a link to the TCS3472 datasheet in the AMS's website.

Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/light/tcs3472.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index a9e153b..09e6ca5 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -11,6 +11,8 @@
  * 7-bit I2C slave address 0x39 (TCS34721, TCS34723) or 0x29 (TCS34725,
  * TCS34727)
  *
+ * Datasheet: http://ams.com/eng/content/download/319364/1117183/file/TCS3472_Datasheet_EN_v2.pdf
+ *
  * TODO: interrupt support, thresholds, wait time
  */
 
-- 
2.7.4
