Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ch1ehsobe004.messaging.microsoft.com ([216.32.181.184]:13688
	"EHLO CH1EHSOBE014.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752085Ab1FGLaQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2011 07:30:16 -0400
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: industrialio-core: iio_write_channel_info accept IIO_VAL_INT_PLUS_NANO
Date: Tue, 7 Jun 2011 13:21:28 +0200
Message-ID: <1307445688-23126-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Allow iio_write_channel_info() to accept IIO_VAL_INT_PLUS_NANO

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/industrialio-core.c |   27 +++++++++++++++++++++------
 1 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index e5a7663..74158c1 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -412,25 +412,40 @@ static ssize_t iio_write_channel_info(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
-	int ret, integer = 0, micro = 0, micro_mult = 100000;
+	int ret, fract_digits, integer = 0, fract = 0, fract_mult;
 	bool integer_part = true, negative = false;
 
 	/* Assumes decimal - precision based on number of digits */
 	if (!indio_dev->info->write_raw)
 		return -EINVAL;
+
+	fract_digits = strnchr(buf, len, '\n') - strnchr(buf, len, '.') - 1;
+
+	switch (fract_digits) {
+	case 6:	/* IIO_VAL_INT_PLUS_MICRO */
+		fract_mult = 100000;
+		break;
+	case 9: /* IIO_VAL_INT_PLUS_NANO */
+		fract_mult = 100000000;
+		break;
+	default:
+		return -EINVAL;
+	}
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


