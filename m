Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:40997 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022Ab2DRNOC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Apr 2012 09:14:02 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/14] staging:iio:buffer trivial use of strtobool to remove dodgy equivalent.
Date: Wed, 18 Apr 2012 14:13:41 +0100
Message-Id: <1334754834-13622-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1334754834-13622-1-git-send-email-jic23@kernel.org>
References: <1334754834-13622-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/industrialio-buffer.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/industrialio-buffer.c b/drivers/staging/iio/industrialio-buffer.c
index 386ba76..59b0caf 100644
--- a/drivers/staging/iio/industrialio-buffer.c
+++ b/drivers/staging/iio/industrialio-buffer.c
@@ -124,13 +124,15 @@ static ssize_t iio_scan_el_store(struct device *dev,
 				 const char *buf,
 				 size_t len)
 {
-	int ret = 0;
+	int ret;
 	bool state;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct iio_buffer *buffer = indio_dev->buffer;
 	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
 
-	state = !(buf[0] == '0');
+	ret = strtobool(buf, &state);
+	if (ret < 0)
+		return ret;
 	mutex_lock(&indio_dev->mlock);
 	if (iio_buffer_enabled(indio_dev)) {
 		ret = -EBUSY;
@@ -169,11 +171,14 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 				    const char *buf,
 				    size_t len)
 {
-	int ret = 0;
+	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	bool state;
 
-	state = !(buf[0] == '0');
+	ret = strtobool(buf, &state);
+	if (ret < 0)
+		return ret;
+
 	mutex_lock(&indio_dev->mlock);
 	if (iio_buffer_enabled(indio_dev)) {
 		ret = -EBUSY;
-- 
1.7.0.4

