Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 1/5] staging:iio fill in some missing docs
Date: Sat,  3 Mar 2012 11:39:11 +0000
Message-Id: <1330774755-18031-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1330774755-18031-1-git-send-email-jic23@kernel.org>
References: <1330774755-18031-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/iio.h b/drivers/staging/iio/iio.h
index b9cd454..833a849 100644
--- a/drivers/staging/iio/iio.h
+++ b/drivers/staging/iio/iio.h
@@ -331,6 +331,8 @@ struct iio_buffer_setup_ops {
  * @name:		[DRIVER] name of the device.
  * @info:		[DRIVER] callbacks and constant info from driver
  * @info_exist_lock:	[INTERN] lock to prevent use during removal
+ * @setup_ops:		[DRIVER] callbacks to call before and after buffer
+ *			enable/disable
  * @chrdev:		[INTERN] associated character device
  * @groups:		[INTERN] attribute groups
  * @groupcounter:	[INTERN] index of next attribute group
-- 
1.7.9.2
