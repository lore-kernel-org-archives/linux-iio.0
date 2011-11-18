Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: iio_simple_dummy: Avoid NULL pointer dereference
Date: Fri, 18 Nov 2011 14:30:11 +0100
Message-ID: <1321623011-30323-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Avoid NULL pointer dereference in case CONFIG_IIO_SIMPLE_DUMMY_BUFFER is not set.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/iio_simple_dummy.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index af0c992..8b784b6 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -435,9 +435,12 @@ static int __devinit iio_dummy_probe(int index)
 	 * Register the channels with the buffer, but avoid the output
 	 * channel being registered by reducing the number of channels by 1.
 	 */
-	ret = iio_buffer_register(indio_dev, iio_dummy_channels, 5);
-	if (ret < 0)
-		goto error_unconfigure_buffer;
+	if (indio_dev->buffer) {
+		ret = iio_buffer_register(indio_dev, iio_dummy_channels,
+			indio_dev->num_channels - 1);
+		if (ret < 0)
+			goto error_unconfigure_buffer;
+	}
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-- 
1.7.0.4
