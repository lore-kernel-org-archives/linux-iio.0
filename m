Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:37804 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754708Ab1HZKI1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 06:08:27 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 03/12] staging:iio:scan element types: introduce endian description to the data format.
Date: Fri, 26 Aug 2011 11:16:26 +0100
Message-Id: <1314353795-7437-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
References: <1314353795-7437-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If not set in chan_spec, cpu endianness used.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    8 ++++++++
 drivers/staging/iio/industrialio-ring.c |   15 ++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index f423870..daaea94 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -80,6 +80,12 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_QUADRATURE_CORRECTION_RAW_SEPARATE,
 };
 
+enum iio_endian {
+	IIO_CPU,
+	IIO_BE,
+	IIO_LE,
+};
+
 /**
  * struct iio_chan_spec - specification of a single channel
  * @type:		What type of measurement is the channel making.
@@ -95,6 +101,7 @@ enum iio_chan_info_enum {
  *			storage_bits:	Realbits + padding
  *			shift:		Shift right by this before masking out
  *					realbits.
+ *			endianness:	little or big endian
  * @info_mask:		What information is to be exported about this channel.
  *			This includes calibbias, scale etc.
  * @event_mask:	What events can this channel produce.
@@ -123,6 +130,7 @@ struct iio_chan_spec {
 		u8	realbits;
 		u8	storagebits;
 		u8	shift;
+		enum iio_endian endianness;
 	} scan_type;
 	long			info_mask;
 	long			event_mask;
diff --git a/drivers/staging/iio/industrialio-ring.c b/drivers/staging/iio/industrialio-ring.c
index e844246..23967d4 100644
--- a/drivers/staging/iio/industrialio-ring.c
+++ b/drivers/staging/iio/industrialio-ring.c
@@ -25,6 +25,10 @@
 #include "sysfs.h"
 #include "ring_generic.h"
 
+static const char * const iio_endian_prefix[] = {
+	[IIO_BE] = "be",
+	[IIO_LE] = "le",
+};
 
 /**
  * iio_ring_read_first_n_outer() - chrdev read for ring buffer access
@@ -96,7 +100,16 @@ static ssize_t iio_show_fixed_type(struct device *dev,
 				   char *buf)
 {
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	return sprintf(buf, "%c%d/%d>>%u\n",
+	u8 type = this_attr->c->scan_type.endianness;
+
+	if (type == IIO_CPU) {
+		if (__LITTLE_ENDIAN)
+			type = IIO_LE;
+		else
+			type = IIO_BE;
+	}
+	return sprintf(buf, "%s:%c%d/%d>>%u\n",
+		       iio_endian_prefix[type],
 		       this_attr->c->scan_type.sign,
 		       this_attr->c->scan_type.realbits,
 		       this_attr->c->scan_type.storagebits,
-- 
1.7.3.4

