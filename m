Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:8076 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbaKYMrS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 25 Nov 2014 07:47:18 -0500
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [RFC PATCH 4/4] iio: illustrate the use of a valid sample channel
Date: Tue, 25 Nov 2014 14:48:07 +0200
Message-Id: <1416919687-14271-5-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/staging/iio/iio_simple_dummy.c        | 18 +++++++++++++---
 drivers/staging/iio/iio_simple_dummy_buffer.c | 31 +++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index 2948900..0e2ea40 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -230,11 +230,22 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 			.shift = 0, /* zero shift */
 		},
 	},
+	{
+		.type = IIO_VALIDSAMPLE,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
+		.scan_index = 4,
+		.scan_type = {
+			.sign = 'u',
+			.realbits = 16,
+			.storagebits = 16,
+			.shift = 0,
+		},
+	},
 	/*
-	 * Convenience macro for timestamps. 4 is the index in
+	 * Convenience macro for timestamps. 5 is the index in
 	 * the buffer.
 	 */
-	IIO_CHAN_SOFT_TIMESTAMP(4),
+	IIO_CHAN_SOFT_TIMESTAMP(5),
 	/* DAC channel out_voltage0_raw */
 	{
 		.type = IIO_VOLTAGE,
@@ -647,7 +658,8 @@ static int iio_dummy_probe(int index)
 	 * number of channels by 1.
 	 */
 	ret = iio_simple_dummy_configure_buffer(indio_dev,
-						iio_dummy_channels, 5);
+						iio_dummy_channels,
+						indio_dev->num_channels);
 	if (ret < 0)
 		goto error_unregister_events;
 
diff --git a/drivers/staging/iio/iio_simple_dummy_buffer.c b/drivers/staging/iio/iio_simple_dummy_buffer.c
index fd74f91..89ed87c 100644
--- a/drivers/staging/iio/iio_simple_dummy_buffer.c
+++ b/drivers/staging/iio/iio_simple_dummy_buffer.c
@@ -48,6 +48,8 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	int len = 0;
 	u16 *data;
+	int validsample_idx = -1;
+	u16 validsample = 0;
 
 	data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
 	if (data == NULL)
@@ -78,12 +80,37 @@ static irqreturn_t iio_simple_dummy_trigger_h(int irq, void *p)
 		     i++, j++) {
 			j = find_next_bit(indio_dev->active_scan_mask,
 					  indio_dev->masklength, j);
-			/* random access read from the 'device' */
-			data[i] = fakedata[j];
+			if (indio_dev->channels[j].type == IIO_VALIDSAMPLE)
+				validsample_idx = i;
+			else
+				/* random access read from the 'device' */
+				data[i] = fakedata[j];
+			/*
+			 * Let's assume that the acceleration channel is
+			 * sampled twice as slow as the other ones.
+			 * Normally, you would check your device to
+			 * learn if data is available.
+			 */
+			if (indio_dev->channels[j].type == IIO_ACCEL) {
+				static bool accel_valid;
+				if (accel_valid) {
+					validsample |= 1 << i;
+					data[i] = fakedata[j];
+				} else {
+					data[i] = 0;
+				}
+				accel_valid = !accel_valid;
+			} else {
+				validsample |= 1 << i;
+				data[i] = fakedata[j];
+			}
 			len += 2;
 		}
 	}
 
+	if (validsample_idx != -1)
+		memcpy(data + validsample_idx, &validsample, 2);
+
 	iio_push_to_buffers_with_timestamp(indio_dev, data, iio_get_time_ns());
 
 	kfree(data);
-- 
1.9.1

