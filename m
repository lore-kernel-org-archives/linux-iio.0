Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] iio: Always compute masklength
Date: Fri, 29 May 2015 18:14:20 +0200
Message-Id: <1432916062-15195-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1432916062-15195-1-git-send-email-lars@metafoo.de>
References: <1432916062-15195-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Even if no userspace consumer buffer is attached to the IIO device at
registration we still need to compute the masklength, since it is possible
that a in-kernel consumer buffer is going to get attached to the device at
a later point.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 1129125..a72db00 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -968,6 +968,15 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 	int ret, i, attrn, attrcount, attrcount_orig = 0;
 	const struct iio_chan_spec *channels;
 
+	channels = indio_dev->channels;
+	if (channels) {
+		int ml = indio_dev->masklength;
+
+		for (i = 0; i < indio_dev->num_channels; i++)
+			ml = max(ml, channels[i].scan_index + 1);
+		indio_dev->masklength = ml;
+	}
+
 	if (!buffer)
 		return 0;
 
@@ -1011,12 +1020,6 @@ int iio_buffer_alloc_sysfs_and_mask(struct iio_dev *indio_dev)
 			if (channels[i].scan_index < 0)
 				continue;
 
-			/* Establish necessary mask length */
-			if (channels[i].scan_index >
-			    (int)indio_dev->masklength - 1)
-				indio_dev->masklength
-					= channels[i].scan_index + 1;
-
 			ret = iio_buffer_add_channel_sysfs(indio_dev,
 							 &channels[i]);
 			if (ret < 0)
-- 
2.1.4
