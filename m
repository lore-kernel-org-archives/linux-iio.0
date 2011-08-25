Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:19506
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752204Ab1HYLBY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2011 07:01:24 -0400
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: ad7152: Fix differential channel return value and increase delay.
Date: Thu, 25 Aug 2011 12:58:50 +0200
Message-ID: <1314269930-5737-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

In differential mode zero scale equals to 0x8000.
Increase readout delay by 1ms.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7152.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
index 41c3102..42efc37 100644
--- a/drivers/staging/iio/adc/ad7152.c
+++ b/drivers/staging/iio/adc/ad7152.c
@@ -159,9 +159,9 @@ static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
 static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
 		       S_IWUSR, NULL, ad7152_start_gain_calib, 1);
 
-/* Values are Update Rate (Hz), Conversion Time (ms) */
+/* Values are Update Rate (Hz), Conversion Time (ms) + 1*/
 static const unsigned char ad7152_filter_rate_table[][2] = {
-	{200, 5}, {50, 20}, {20, 50}, {17, 60},
+	{200, 5 + 1}, {50, 20 + 1}, {20, 50 + 1}, {17, 60 + 1},
 };
 
 static ssize_t ad7152_show_filter_rate_setup(struct device *dev,
@@ -366,6 +366,9 @@ static int ad7152_read_raw(struct iio_dev *indio_dev,
 			goto out;
 		*val = swab16(ret);
 
+		if (chan->differential)
+			*val -= 0x8000;
+
 		ret = IIO_VAL_INT;
 		break;
 	case (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE):
-- 
1.7.0.4


