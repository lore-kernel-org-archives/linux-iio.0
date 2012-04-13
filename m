Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-152.synserver.de ([212.40.185.152]:1040 "EHLO
	smtp-out-147.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752819Ab2DMOta (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 10:49:30 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] staging:iio: Add IIO_CHAN_INFO_RAW entries to the dummy driver
Date: Fri, 13 Apr 2012 16:51:08 +0200
Message-Id: <1334328669-31201-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Precursor to making value read / write attribute optional.
No processed values in resolvers at the moment.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/iio_simple_dummy.c |   19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index e3a9457..dbeb04c 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -73,6 +73,12 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		/* What other information is available? */
 		.info_mask =
 		/*
+		 * in_voltage0_raw
+		 * Raw (unscaled no bias removal etc) measurement
+		 * from the device.
+		 */
+		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		/*
 		 * in_voltage0_offset
 		 * Offset for userspace to apply prior to scale
 		 * when converting to standard units (microvolts)
@@ -114,6 +120,12 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		.channel2 = 2,
 		.info_mask =
 		/*
+		 * in_voltage1-voltage2_raw
+		 * Raw (unscaled no bias removal etc) measurement
+		 * from the device.
+		 */
+		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		/*
 		 * in_voltage-voltage_scale
 		 * Shared version of scale - shared by differential
 		 * input channels of type IIO_VOLTAGE.
@@ -135,6 +147,7 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		.channel = 3,
 		.channel2 = 4,
 		.info_mask =
+		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		IIO_CHAN_INFO_SCALE_SHARED_BIT,
 		.scan_index = diffvoltage3m4,
 		.scan_type = {
@@ -154,6 +167,7 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 		/* Channel 2 is use for modifiers */
 		.channel2 = IIO_MOD_X,
 		.info_mask =
+		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
 		/*
 		 * Internal bias correction value. Applied
 		 * by the hardware or driver prior to userspace
@@ -177,6 +191,7 @@ static struct iio_chan_spec iio_dummy_channels[] = {
 	/* DAC channel out_voltage0_raw */
 	{
 		.type = IIO_VOLTAGE,
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
 		.output = 1,
 		.indexed = 1,
 		.channel = 0,
@@ -203,7 +218,7 @@ static int iio_dummy_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->lock);
 	switch (mask) {
-	case 0: /* magic value - channel value read */
+	case IIO_CHAN_INFO_RAW: /* magic value - channel value read */
 		switch (chan->type) {
 		case IIO_VOLTAGE:
 			if (chan->output) {
@@ -290,7 +305,7 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 	struct iio_dummy_state *st = iio_priv(indio_dev);
 
 	switch (mask) {
-	case 0:
+	case IIO_CHAN_INFO_RAW:
 		if (chan->output == 0)
 			return -EINVAL;
 
-- 
1.7.9.5

