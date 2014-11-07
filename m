Return-Path: <jpl@haddock.xiphos.ca>
From: Joshua Lamorie <joshua.lamorie@xiphos.com>
To: jic23@kernel.org
Cc: michal.simek@xilinx.com, lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soren.brinkmann@xilinx.com, Joshua Lamorie <joshua.lamorie@xiphos.com>
Subject: [PATCH] iio:xilinx-xadc:xadc_read_raw INFO_OFFSET
Date: Fri,  7 Nov 2014 14:11:56 -0500
Message-Id: <1415387516-15051-1-git-send-email-joshua.lamorie@xiphos.com>
List-ID: <linux-iio@vger.kernel.org>

Added a condition for a read of IIO_CHAN_INFO_OFFSET to
ensure that an offset is only provided for requests for XADC temperature. The
previous assumption was that only requests for temperature would include a
read of CHAN_INFO_OFFSET. However there is no way to restrict this in calling
functions, such as iio_convert_raw_to_processed_unlocked() which is called when
using the XADC as a device for iio_hwmon.

Signed-off-by: Joshua Lamorie <joshua.lamorie@xiphos.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 23c152e..2c549ab 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -877,9 +877,13 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 		}
 	case IIO_CHAN_INFO_OFFSET:
-		/* Only the temperature channel has an offset */
-		*val = -((273150 << 12) / 503975);
-		return IIO_VAL_INT;
+		if (chan->type == IIO_TEMP) {
+			/* Only the temperature channel has an offset */
+			*val = -((273150 << 12) / 503975);
+			return IIO_VAL_INT;
+		} else {
+			return -EINVAL;
+		}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
 		if (ret)
-- 
1.8.3.1
