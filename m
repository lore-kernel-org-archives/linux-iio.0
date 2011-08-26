Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53052 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754854Ab1HZKLY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 06:11:24 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/16] staging:iio:adc:ad7152: Fix differential channel return value and increase delay.
Date: Fri, 26 Aug 2011 11:19:30 +0100
Message-Id: <1314353973-7662-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

In differential mode zero scale equals to 0x8000.
Increase readout delay by 1ms.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
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
1.7.3.4

