Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	<linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] staging:iio: Disallow changing scan elements in all buffered modes
Date: Fri, 16 Dec 2011 11:19:45 +0100
Message-ID: <1324030791-17983-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1324030791-17983-1-git-send-email-lars@metafoo.de>
References: <1324030791-17983-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Currently we only disallow changing the scan elements, while the buffer is
enabled, in triggered buffer mode. This patch changes it to disallow it for all
buffered modes. Disabling or enabling scan elements while the buffer is enabled
will cause undefined behavior since the reader will not be able to tell samples
with the new and old scan element set apart and thus wont be able to extract
any meaningful data from the buffer.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-buffer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 5fe7f83..91cb37a 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -153,7 +153,7 @@ static ssize_t iio_scan_el_store(struct device *dev,
 
 	state = !(buf[0] == '0');
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_buffer_enabled(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
@@ -196,7 +196,7 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 
 	state = !(buf[0] == '0');
 	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
+	if (iio_buffer_enabled(indio_dev)) {
 		ret = -EBUSY;
 		goto error_ret;
 	}
-- 
1.7.7.3
