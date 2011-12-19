Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tx2ehsobe002.messaging.microsoft.com ([65.55.88.12]:3420 "EHLO
	TX2EHSOBE003.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369Ab1LSOXd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Dec 2011 09:23:33 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@suse.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	<devel@driverdev.osuosl.org>, <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/8] staging:iio: Disallow changing scan elements in all buffered modes
Date: Mon, 19 Dec 2011 15:23:43 +0100
Message-ID: <1324304629-24720-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1324304629-24720-1-git-send-email-lars@metafoo.de>
References: <1324304629-24720-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently we only disallow changing the scan elements, while the buffer is
enabled, in triggered buffer mode. This patch changes it to disallow it for all
buffered modes. Disabling or enabling scan elements while the buffer is enabled
will cause undefined behavior since the reader will not be able to tell samples
with the new and old scan element set apart and thus wont be able to extract
any meaningful data from the buffer.

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/industrialio-buffer.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 3699303..747b901 100644
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


