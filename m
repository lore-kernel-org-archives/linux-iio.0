Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] iio: industrialio-core: Add IIO_OUT type
Date: Fri, 10 Jun 2011 13:49:00 +0200
Message-ID: <1307706541-4750-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Add IIO_OUT type for DAC like devices
In case of IIO_OUT make sure the channel device attribute is writable

Ideally we add a flag to iio_chan_spec that tells the core that
the channel device attribute is writable...

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio.h               |    1 +
 drivers/staging/iio/industrialio-core.c |    4 +++-
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index 9ca89c7..7a6ce4d 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -30,6 +30,7 @@
 enum iio_chan_type {
 	/* real channel types */
 	IIO_IN,
+	IIO_OUT,
 	IIO_CURRENT,
 	IIO_POWER,
 	IIO_ACCEL,
diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 744153e..8fa2be6 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -47,6 +47,7 @@ static const char * const iio_chan_type_name_spec_shared[] = {
 	[IIO_TIMESTAMP] = "timestamp",
 	[IIO_ACCEL] = "accel",
 	[IIO_IN] = "in",
+	[IIO_OUT] = "out",
 	[IIO_CURRENT] = "current",
 	[IIO_POWER] = "power",
 	[IIO_IN_DIFF] = "in-in",
@@ -675,7 +676,8 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
 	else
 		ret = __iio_add_chan_devattr("raw", NULL, chan,
 					     &iio_read_channel_info,
-					     NULL,
+					     (chan->type == IIO_OUT ?
+					     &iio_write_channel_info : NULL),
 					     0,
 					     0,
 					     &dev_info->dev,
-- 
1.7.0.4
