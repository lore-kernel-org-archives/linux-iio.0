Return-Path: <SRS0=KJFL=5L=gmail.com=jeff.dagenais@kernel.org>
From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To: michal.simek@xilinx.com,
	rajnikant.bhojani@xilinx.com,
	linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH] iio: adc: xilinx-ams: add missing break in AMS_SUPPLY[78] cases
Date: Tue,  6 Jun 2017 15:21:21 -0400
Message-Id: <1496776881-5265-1-git-send-email-jeff.dagenais@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This would otherwise lead supply 7 and 8 to scale to 3V instead of
6V

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/iio/adc/xilinx-ams.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index fd4eb6d..6b3ab56 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -255,6 +255,7 @@ static int ams_read_raw(struct iio_dev *indio_dev,
 			case AMS_SUPPLY7:
 			case AMS_SUPPLY8:
 				*val = AMS_SUPPLY_SCALE_6VOLT;
+				break;
 			case AMS_SUPPLY9:
 			case AMS_SUPPLY10:
 				if (chan->scan_index < PS_SEQ_MAX)
-- 
2.1.4
