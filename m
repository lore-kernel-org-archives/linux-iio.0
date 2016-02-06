Return-Path: <rakhish1994@gmail.com>
From: Rakhi Sharma <rakhish1994@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	michal.simek@xilinx.com,
	linux-iio@vger.kernel.org,
	Rakhi Sharma <rakhish1994@gmail.com>
Subject: [PATCH 2/2] drivers: iio: adc: xilinx-xadc-events: Fixed a coding style warning.
Date: Sun,  7 Feb 2016 01:30:35 +0530
Message-Id: <1454788835-11707-1-git-send-email-rakhish1994@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fixed a warning.
WARNING: else is not generally useful after a break or return

Signed-off-by: Rakhi Sharma <rakhish1994@gmail.com>
---
 drivers/iio/adc/xilinx-xadc-events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index edcf3aa..61309b3 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -92,7 +92,7 @@ static unsigned int xadc_get_alarm_mask(const struct iio_chan_spec *chan)
 {
 	if (chan->type == IIO_TEMP) {
 		return XADC_ALARM_OT_MASK;
-	} else {
+	}
 		switch (chan->channel) {
 		case 0:
 			return XADC_ALARM_VCCINT_MASK;
-- 
1.9.1
