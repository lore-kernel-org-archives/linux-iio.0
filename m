Return-Path: <martink@posteo.de>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	christoph.muellner@theobroma-systems.com,
	mfuzzey@parkeon.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH 1/4] iio: mma8452: coding style fixes
Date: Thu,  3 Mar 2016 09:24:01 +0100
Message-Id: <1456993444-21320-2-git-send-email-martink@posteo.de>
In-Reply-To: <1456993444-21320-1-git-send-email-martink@posteo.de>
References: <1456993444-21320-1-git-send-email-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

fix checkpatch issues like "space before tabs", too long lines or alignment.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 drivers/iio/accel/mma8452.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 7f4994f..17d72bc 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -357,7 +357,8 @@ static int mma8452_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_CALIBBIAS:
 		ret = i2c_smbus_read_byte_data(data->client,
-					      MMA8452_OFF_X + chan->scan_index);
+					       MMA8452_OFF_X +
+					       chan->scan_index);
 		if (ret < 0)
 			return ret;
 
@@ -418,7 +419,7 @@ fail:
 	return ret;
 }
 
-/* returns >0 if in freefall mode, 0 if not or <0 if an error occured */
+/* returns >0 if in freefall mode, 0 if not or <0 if an error occurred */
 static int mma8452_freefall_mode_enabled(struct mma8452_data *data)
 {
 	int val;
@@ -668,7 +669,8 @@ static int mma8452_read_event_config(struct iio_dev *indio_dev,
 		if (ret < 0)
 			return ret;
 
-		return !!(ret & BIT(chan->scan_index + chip->ev_cfg_chan_shift));
+		return !!(ret & BIT(chan->scan_index +
+				    chip->ev_cfg_chan_shift));
 	default:
 		return -EINVAL;
 	}
@@ -1003,7 +1005,7 @@ static const struct mma_chip_info mma_chip_info_table[] = {
 		 * bit.
 		 * The userspace interface uses m/s^2 and we declare micro units
 		 * So scale factor for 12 bit here is given by:
-		 * 	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
+		 *	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
 		 */
 		.mma_scales = { {0, 2394}, {0, 4788}, {0, 9577} },
 		.ev_cfg = MMA8452_TRANSIENT_CFG,
-- 
2.1.4
