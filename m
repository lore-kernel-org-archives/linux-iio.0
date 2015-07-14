Return-Path: <gizero@gmail.com>
From: Andrea Galbusera <gizero@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Andrea Galbusera <gizero@gmail.com>
Subject: [PATCH 1/4] iio: adc: mcp320x: add masking of unknown bits
Date: Tue, 14 Jul 2015 15:36:20 +0200
Message-Id: <1436880983-29017-1-git-send-email-gizero@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

According to the datasheet, the 2 MSBs for parts 3001 and 3201 are
unspecified and should be masked out

Signed-off-by: Andrea Galbusera <gizero@gmail.com>
---

This was already suggested but for some reason got lost during review of a
previous patch. See http://marc.info/?l=linux-iio&m=140748835509583&w=2
and following discussion

 drivers/iio/adc/mcp320x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 8d9c9b9..0673ee7 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -114,13 +114,13 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
 
 	switch (device_index) {
 	case mcp3001:
-		return (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
+		return ((adc->rx_buf[0] & 0x1f) << 5 | adc->rx_buf[1] >> 3);
 	case mcp3002:
 	case mcp3004:
 	case mcp3008:
 		return (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
 	case mcp3201:
-		return (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
+		return ((adc->rx_buf[0] & 0x1f) << 7 | adc->rx_buf[1] >> 1);
 	case mcp3202:
 	case mcp3204:
 	case mcp3208:
-- 
1.9.1
