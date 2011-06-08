Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:10526
	"EHLO VA3EHSOBE009.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756160Ab1FHOVk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 8 Jun 2011 10:21:40 -0400
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	<jic23@cam.ac.uk>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 3/4] iio: industrialio-core: iio_write_channel_info accept IIO_VAL_INT_PLUS_NANO
Date: Wed, 8 Jun 2011 16:12:43 +0200
Message-ID: <1307542364-7089-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1307542364-7089-1-git-send-email-michael.hennerich@analog.com>
References: <1307542364-7089-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Allow iio_write_channel_info() to accept IIO_VAL_INT_PLUS_NANO

Changes since V1:
use callback to query expected format/precision

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/iio.h               |    7 +++++++
 drivers/staging/iio/industrialio-core.c |   27 +++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 6e51baa..9ca89c7 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -220,6 +220,9 @@ struct iio_trigger; /* forward declaration */
  *			contain the elements making up the returned value.
  * @write_raw:		function to write a value to the device.
  *			Parameters are the same as for read_raw.
+ * @write_raw_get_fmt:	callback function to query the expected
+ *			format/precision. If not set by the driver, write_raw
+ *			returns IIO_VAL_INT_PLUS_MICRO.
  * @read_event_config:	find out if the event is enabled.
  * @write_event_config:	set if the event is enabled.
  * @read_event_value:	read a value associated with the event. Meaning
@@ -247,6 +250,10 @@ struct iio_info {
 			 int val2,
 			 long mask);

+	int (*write_raw_get_fmt)(struct iio_dev *indio_dev,
+			 struct iio_chan_spec const *chan,
+			 long mask);
+
 	int (*read_event_config)(struct iio_dev *indio_dev,
 				 int event_code);

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e5a7663..744153e 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -412,25 +412,40 @@ static ssize_t iio_write_channel_info(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret, integer = 0, micro = 0, micro_mult = 100000;
+	int ret, integer = 0, fract = 0, fract_mult = 100000;
 	bool integer_part = true, negative = false;

 	/* Assumes decimal - precision based on number of digits */
 	if (!indio_dev->info->write_raw)
 		return -EINVAL;
+
+	if (indio_dev->info->write_raw_get_fmt)
+		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
+			this_attr->c, this_attr->address)) {
+		case IIO_VAL_INT_PLUS_MICRO:
+			fract_mult = 100000;
+			break;
+		case IIO_VAL_INT_PLUS_NANO:
+			fract_mult = 100000000;
+			break;
+		default:
+			return -EINVAL;
+		}
+
 	if (buf[0] == '-') {
 		negative = true;
 		buf++;
 	}
+
 	while (*buf) {
 		if ('0' <= *buf && *buf <= '9') {
 			if (integer_part)
 				integer = integer*10 + *buf - '0';
 			else {
-				micro += micro_mult*(*buf - '0');
-				if (micro_mult == 1)
+				fract += fract_mult*(*buf - '0');
+				if (fract_mult == 1)
 					break;
-				micro_mult /= 10;
+				fract_mult /= 10;
 			}
 		} else if (*buf == '\n') {
 			if (*(buf + 1) == '\0')
@@ -448,11 +463,11 @@ static ssize_t iio_write_channel_info(struct device *dev,
 		if (integer)
 			integer = -integer;
 		else
-			micro = -micro;
+			fract = -fract;
 	}

 	ret = indio_dev->info->write_raw(indio_dev, this_attr->c,
-					 integer, micro, this_attr->address);
+					 integer, fract, this_attr->address);
 	if (ret)
 		return ret;

--
1.7.0.4


