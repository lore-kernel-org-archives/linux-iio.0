Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37538 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752310Ab3IHM5T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Sep 2013 08:57:19 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 4/5] staging:iio: dummy driver additions to show shared_by_dir infomask usage
Date: Sun,  8 Sep 2013 14:57:20 +0100
Message-Id: <1378648641-28280-5-git-send-email-jic23@kernel.org>
In-Reply-To: <1378648641-28280-1-git-send-email-jic23@kernel.org>
References: <1378648641-28280-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Note that as this driver has output as well as output channels an
example of info_mask_shared_by_all that makes any sense does not exist.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio_simple_dummy.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 0e8e02a..141ec61 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -90,6 +90,11 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		 * when converting to standard units (microvolts)
 		 */
 		BIT(IIO_CHAN_INFO_SCALE),
+		/*
+		 * sampling_frequency
+		 * The frequency in Hz at which the channels are sampled
+		 */
+		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		/* The ordering of elements in the buffer via an enum */
 		.scan_index = voltage0,
 		.scan_type = { /* Description of storage in buffer */
@@ -130,6 +135,10 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		 * input channels of type IIO_VOLTAGE.
 		 */
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		/*
+		 * sampling_frequency
+		 * The frequency in Hz at which the channels are sampled
+		 */
 		.scan_index = diffvoltage1m2,
 		.scan_type = { /* Description of storage in buffer */
 			.sign = 's', /* signed */
@@ -147,6 +156,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.channel2 = 4,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
+		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = diffvoltage3m4,
 		.scan_type = {
 			.sign = 's',
@@ -173,6 +183,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		 */
 		BIT(IIO_CHAN_INFO_CALIBSCALE) |
 		BIT(IIO_CHAN_INFO_CALIBBIAS),
+		.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 		.scan_index = accelx,
 		.scan_type = { /* Description of storage in buffer */
 			.sign = 's', /* signed */
@@ -272,6 +283,11 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 		*val2 = st->accel_calibscale->val2;
 		ret = IIO_VAL_INT_PLUS_MICRO;
 		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = 3;
+		*val2 = 33;
+		ret = IIO_VAL_INT_PLUS_NANO;
+		break;
 	default:
 		break;
 	}
-- 
1.8.4

