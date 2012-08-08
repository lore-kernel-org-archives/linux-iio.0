Return-Path: <khoroshilov@ispras.ru>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ldv-project@ispras.ru
Subject: [PATCH] iio/adjd_s311: Fix potential memory leak in adjd_s311_update_scan_mode()
Date: Wed,  8 Aug 2012 10:36:56 +0400
Message-Id: <1344407816-13480-1-git-send-email-khoroshilov@ispras.ru>
List-ID: <linux-iio@vger.kernel.org>

Do not leak memory by updating pointer with potentially
NULL realloc return value.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/iio/light/adjd_s311.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
index 1cbb449..0adda5b 100644
--- a/drivers/iio/light/adjd_s311.c
+++ b/drivers/iio/light/adjd_s311.c
@@ -271,12 +271,18 @@ static int adjd_s311_update_scan_mode(struct iio_dev *indio_dev,
 	const unsigned long *scan_mask)
 {
 	struct adjd_s311_data *data = iio_priv(indio_dev);
-	data->buffer = krealloc(data->buffer, indio_dev->scan_bytes,
+	u16 *new_buffer;
+	int ret = 0;
+
+	new_buffer = krealloc(data->buffer, indio_dev->scan_bytes,
 				GFP_KERNEL);
-	if (!data->buffer)
-		return -ENOMEM;
+	if (new_buffer == NULL) {
+		kfree(data->buffer);
+		ret = -ENOMEM;
+	}
+	data->buffer = new_buffer;
 
-	return 0;
+	return ret;
 }
 
 static const struct iio_info adjd_s311_info = {
-- 
1.7.9.5
