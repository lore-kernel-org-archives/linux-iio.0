Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:35343 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932825AbdHVNdx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Aug 2017 09:33:53 -0400
Message-Id: <a47443b08deb1a159ec0b2943465907b681b5863.1503407738.git.lukas@wunner.de>
In-Reply-To: <cover.1503407738.git.lukas@wunner.de>
References: <cover.1503407738.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 22 Aug 2017 15:33:00 +0200
Subject: [PATCH 2/6] iio: adc: mcp320x: Fix readout of negative voltages
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Mathias Duckeck <m.duckeck@kunbus.de>,
        Phil Elwell <phil@raspberrypi.org>,
        Oskar Andero <oskar.andero@gmail.com>,
        Andrea Galbusera <gizero@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Manfred Schlaegl <manfred.schlaegl@gmx.at>,
        Michael Welling <mwelling@ieee.org>,
        Soeren Andersen <san@rosetechnology.dk>,
        linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit f686a36b4b79 ("iio: adc: mcp320x: Add support for mcp3301")
returns a signed voltage from mcp320x_adc_conversion() but neglects that
the caller interprets a negative return value as failure.  Only mcp3301
(and the upcoming mcp3550/1/3) is affected as the other chips are
incapable of measuring negative voltages.

Fix and while at it, add mcp3301 to the list of supported chips at the
top of the file.

Fixes: f686a36b4b79 ("iio: adc: mcp320x: Add support for mcp3301")
Cc: Andrea Galbusera <gizero@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/iio/adc/mcp320x.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 45d043c9a888..071dd23a33d9 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -17,6 +17,8 @@
  * MCP3204
  * MCP3208
  * ------------
+ * 13 bit converter
+ * MCP3301
  *
  * Datasheet can be found here:
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21293C.pdf  mcp3001
@@ -96,7 +98,7 @@ static int mcp320x_channel_to_tx_data(int device_index,
 }
 
 static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
-				  bool differential, int device_index)
+				  bool differential, int device_index, int *val)
 {
 	int ret;
 
@@ -117,19 +119,25 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 
 	switch (device_index) {
 	case mcp3001:
-		return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
+		*val = (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
+		return 0;
 	case mcp3002:
 	case mcp3004:
 	case mcp3008:
-		return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
+		*val = (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
+		return 0;
 	case mcp3201:
-		return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
+		*val = (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
+		return 0;
 	case mcp3202:
 	case mcp3204:
 	case mcp3208:
-		return (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
+		*val = (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
+		return 0;
 	case mcp3301:
-		return sign_extend32((adc->rx_buf[0] & 0x1f) << 8 | adc->rx_buf[1], 12);
+		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
+				    | adc->rx_buf[1], 12);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -150,12 +158,10 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		ret = mcp320x_adc_conversion(adc, channel->address,
-			channel->differential, device_index);
-
+			channel->differential, device_index, val);
 		if (ret < 0)
 			goto out;
 
-		*val = ret;
 		ret = IIO_VAL_INT;
 		break;
 
-- 
2.11.0

