Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36891 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdE2PwP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:15 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 19/38] iio:orientation: drop assign iio_info.driver_module
Date: Mon, 29 May 2017 16:51:35 +0100
Message-Id: <20170529155154.22580-20-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 1 -
 drivers/iio/orientation/hid-sensor-rotation.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index fd1b3696ee42..1e5451d1ff88 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -186,7 +186,6 @@ static int incl_3d_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info incl_3d_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &incl_3d_read_raw,
 	.write_raw = &incl_3d_write_raw,
 };
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index e9fa86c87db5..257a06a724a4 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -138,7 +138,6 @@ static int dev_rot_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info dev_rot_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw_multi = &dev_rot_read_raw,
 	.write_raw = &dev_rot_write_raw,
 };
-- 
2.13.0

