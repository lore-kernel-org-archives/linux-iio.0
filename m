Return-Path: <imrehg@gmail.com>
From: Gergely Imreh <imrehg@gmail.com>
To: jic23@kernel.org
Cc: michal.simek@xilinx.com,
	imrehg@gmail.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ola@adapteva.com
Subject: [PATCH 1/1] iio:adc: XADC: Set offset explicitly to zero on voltage channels
Date: Thu, 11 Jun 2015 16:22:26 +0800
Message-Id: <1434010946-8118-1-git-send-email-imrehg@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The Xilinx XADC driver has both a temperature channel and 8 voltage
channels. The voltage channels have no offset, but actually were still
set the same offset as the temperature channel. This did not cause
problems in /sys/bus/iio/ but can cause problems with other drivers
using iio data. For example iio-hwmon did return wrong voltage values
because of the offset.

Change tested with the Parallella board.

Signed-off-by: Gergely Imreh <imrehg@gmail.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index ab52be2..36efab7 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -877,9 +877,17 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OFFSET:
-		/* Only the temperature channel has an offset */
-		*val = -((273150 << 12) / 503975);
-		return IIO_VAL_INT;
+		switch (chan->type) {
+		case IIO_VOLTAGE:
+			*val = 0;
+			return IIO_VAL_INT;
+		case IIO_TEMP:
+			/* Only the temperature channel has an offset */
+			*val = -((273150 << 12) / 503975);
+			return IIO_VAL_INT;
+		default:
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
 		if (ret)
-- 
2.4.2
