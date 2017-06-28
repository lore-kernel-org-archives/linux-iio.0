Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35554 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751540AbdF1V7C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Jun 2017 17:59:02 -0400
Received: by mail-wm0-f65.google.com with SMTP id 131so13852394wmq.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Jun 2017 14:59:02 -0700 (PDT)
From: Angelo Compagnucci <angelo.compagnucci@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/3] iio: adc: mcp3422: cosmetic fixes
Date: Wed, 28 Jun 2017 23:53:11 +0200
Message-Id: <1498687088-28529-3-git-send-email-angelo.compagnucci@gmail.com>
In-Reply-To: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
References: <1498687088-28529-1-git-send-email-angelo.compagnucci@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes some cosmetics in source code, it uniforms
tabs after carriage return on methods and fixes formatting.

Signed-off-by: Angelo Compagnucci <angelo.compagnucci@gmail.com>
---
 drivers/iio/adc/mcp3422.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
index 63de705..866d02f 100644
--- a/drivers/iio/adc/mcp3422.c
+++ b/drivers/iio/adc/mcp3422.c
@@ -135,7 +135,7 @@ static int mcp3422_read(struct mcp3422 *adc, int *value, u8 *config)
 }
 
 static int mcp3422_read_channel(struct mcp3422 *adc,
-				struct iio_chan_spec const *channel, int *value)
+		struct iio_chan_spec const *channel, int *value)
 {
 	int ret;
 	u8 config;
@@ -157,14 +157,14 @@ static int mcp3422_read_channel(struct mcp3422 *adc,
 }
 
 static int mcp3422_read_raw(struct iio_dev *iio,
-			struct iio_chan_spec const *channel, int *val1,
-			int *val2, long mask)
+		struct iio_chan_spec const *channel, int *val1,
+		int *val2, long mask)
 {
 	struct mcp3422 *adc = iio_priv(iio);
 	int err;
 
 	u8 sample_rate = MCP3422_SAMPLE_RATE(adc->config);
-	u8 pga		 = MCP3422_PGA(adc->config);
+	u8 pga = MCP3422_PGA(adc->config);
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -174,7 +174,6 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-
 		*val1 = 0;
 		*val2 = mcp3422_scales[sample_rate][pga];
 		return IIO_VAL_INT_PLUS_NANO;
@@ -191,8 +190,8 @@ static int mcp3422_read_raw(struct iio_dev *iio,
 }
 
 static int mcp3422_write_raw(struct iio_dev *iio,
-			struct iio_chan_spec const *channel, int val1,
-			int val2, long mask)
+		struct iio_chan_spec const *channel, int val1,
+		int val2, long mask)
 {
 	struct mcp3422 *adc = iio_priv(iio);
 	u8 temp;
@@ -331,7 +330,7 @@ static const struct iio_info mcp3422_info = {
 };
 
 static int mcp3422_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
+		const struct i2c_device_id *id)
 {
 	struct iio_dev *indio_dev;
 	struct mcp3422 *adc;
-- 
2.7.4

