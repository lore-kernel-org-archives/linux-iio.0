Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:36273 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756385Ab2DJULR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Apr 2012 16:11:17 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 3/6] staging:iio fill in some missing docs
Date: Tue, 10 Apr 2012 21:11:06 +0100
Message-Id: <1334088669-21032-4-git-send-email-jic23@kernel.org>
In-Reply-To: <1334088669-21032-1-git-send-email-jic23@kernel.org>
References: <1334088669-21032-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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
1.7.9.4

