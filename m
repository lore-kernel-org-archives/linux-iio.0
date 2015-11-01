Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36981 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbbKAM7Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Nov 2015 07:59:24 -0500
Received: by wmff134 with SMTP id f134so41144624wmf.0
        for <linux-iio@vger.kernel.org>; Sun, 01 Nov 2015 04:59:24 -0800 (PST)
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: linux-iio@vger.kernel.org, jic23@kernel.org
Cc: outreachy-kernel@googlegroups.com,
	Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 2/2] iio: imu: check sscanf return value
Date: Sun,  1 Nov 2015 14:58:45 +0200
Message-Id: <1446382725-11765-2-git-send-email-ciorneiioana@gmail.com>
In-Reply-To: <1446382725-11765-1-git-send-email-ciorneiioana@gmail.com>
References: <1446382725-11765-1-git-send-email-ciorneiioana@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes the following checkpatch warning:
WARNING: unchecked sscanf return value

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---

based on linux-iio testing branch

 drivers/iio/imu/adis16400_core.c | 6 +++++-
 drivers/iio/imu/adis16480.c      | 4 +++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index abc4c50..72bcc24 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -288,7 +288,11 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 		if (ret)
 			goto err_ret;
 
-		sscanf(indio_dev->name, "adis%u\n", &device_id);
+		ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
+		if (ret != 1) {
+			ret = -EINVAL;
+			goto err_ret;
+		}
 
 		if (prod_id != device_id)
 			dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
index b94bfd3..16d4304 100644
--- a/drivers/iio/imu/adis16480.c
+++ b/drivers/iio/imu/adis16480.c
@@ -765,7 +765,9 @@ static int adis16480_initial_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	sscanf(indio_dev->name, "adis%u\n", &device_id);
+	ret = sscanf(indio_dev->name, "adis%u\n", &device_id);
+	if (ret != 1)
+		return -EINVAL;
 
 	if (prod_id != device_id)
 		dev_warn(&indio_dev->dev, "Device ID(%u) and product ID(%u) do not match.",
-- 
2.1.4

