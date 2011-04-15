Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:55774 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755519Ab1DORyL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Apr 2011 13:54:11 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: jbrenner@taosinc.com, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 5/8] staging:iio:adc:max1363 fix timestamp handling.
Date: Fri, 15 Apr 2011 18:55:57 +0100
Message-Id: <1302890160-8823-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
References: <1302890160-8823-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not only was this not compliant with the abi, it was also missconfiguring
the buffer.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/max1363_core.c |   12 ++++++++++++
 drivers/staging/iio/adc/max1363_ring.c |   10 ++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/max1363_core.c b/drivers/staging/iio/adc/max1363_core.c
index 1703b2a..41af82c 100644
--- a/drivers/staging/iio/adc/max1363_core.c
+++ b/drivers/staging/iio/adc/max1363_core.c
@@ -72,6 +72,9 @@ static MAX1363_SCAN_EL_D(7, 6, 21);
 static MAX1363_SCAN_EL_D(9, 8, 22);
 static MAX1363_SCAN_EL_D(11, 10, 23);
 
+static IIO_SCAN_EL_TIMESTAMP(24);
+static IIO_CONST_ATTR_SCAN_EL_TYPE(timestamp, s, 64, 64);
+
 static const struct max1363_mode max1363_mode_table[] = {
 	/* All of the single channel options first */
 	MAX1363_MODE_SINGLE(0, 1 << 0),
@@ -402,6 +405,9 @@ static struct attribute *max1363_scan_el_attrs[] = {
 	&iio_const_attr_in1min0_index.dev_attr.attr,
 	&iio_scan_el_in3min2.dev_attr.attr,	&dev_attr_in3min2_type.attr,
 	&iio_const_attr_in3min2_index.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
@@ -515,6 +521,9 @@ static struct attribute *max1238_scan_el_attrs[] = {
 	&iio_const_attr_in9min8_index.dev_attr.attr,
 	&iio_scan_el_in11min10.dev_attr.attr,	&dev_attr_in11min10_type.attr,
 	&iio_const_attr_in11min10_index.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL,
 };
 
@@ -601,6 +610,9 @@ static struct attribute *max11608_scan_el_attrs[] = {
 	&iio_const_attr_in5min4_index.dev_attr.attr,
 	&iio_scan_el_in7min6.dev_attr.attr,	&dev_attr_in7min6_type.attr,
 	&iio_const_attr_in7min6_index.dev_attr.attr,
+	&iio_const_attr_timestamp_index.dev_attr.attr,
+	&iio_scan_el_timestamp.dev_attr.attr,
+	&iio_const_attr_timestamp_type.dev_attr.attr,
 	NULL
 };
 
diff --git a/drivers/staging/iio/adc/max1363_ring.c b/drivers/staging/iio/adc/max1363_ring.c
index d36fcc6..96894bd 100644
--- a/drivers/staging/iio/adc/max1363_ring.c
+++ b/drivers/staging/iio/adc/max1363_ring.c
@@ -76,7 +76,7 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 {
 	struct max1363_state *st = indio_dev->dev_data;
 	struct iio_ring_buffer *ring = indio_dev->ring;
-	size_t d_size;
+	size_t d_size = 0;
 	unsigned long numvals;
 
 	/*
@@ -92,11 +92,13 @@ static int max1363_ring_preenable(struct iio_dev *indio_dev)
 
 	numvals = hweight_long(st->current_mode->modemask);
 	if (ring->access.set_bytes_per_datum) {
+		if (ring->scan_timestamp)
+			d_size += sizeof(s64);
 		if (st->chip_info->bits != 8)
-			d_size = numvals*2 + sizeof(s64);
+			d_size += numvals*2;
 		else
-			d_size = numvals + sizeof(s64);
-		if (d_size % 8)
+			d_size += numvals;
+		if (ring->scan_timestamp && (d_size % 8))
 			d_size += 8 - (d_size % 8);
 		ring->access.set_bytes_per_datum(ring, d_size);
 	}
-- 
1.7.3.4

