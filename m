Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:35905 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab2DVMNg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 22 Apr 2012 08:13:36 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 09/14] staging:iio:buffers switch select kconfig elements to depends.
Date: Sun, 22 Apr 2012 13:13:34 +0100
Message-Id: <1335096819-19565-10-git-send-email-jic23@kernel.org>
In-Reply-To: <1335096819-19565-1-git-send-email-jic23@kernel.org>
References: <1335096819-19565-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As we are moving the IIO core out of staging, we need to
stop drivers in staging controlling whether elements of the
core are built.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index fe15867..e644508 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -28,7 +28,7 @@ config IIO_BUFFER
 if IIO_BUFFER
 
 config IIO_SW_RING
-       select IIO_TRIGGER
+        depends on IIO_TRIGGER
 	tristate "Industrial I/O lock free software ring"
 	help
 	  Example software ring buffer implementation.  The design aim
@@ -37,7 +37,7 @@ config IIO_SW_RING
 	  in interrupt context.
 
 config IIO_KFIFO_BUF
-	select IIO_TRIGGER
+	depends on IIO_TRIGGER
 	tristate "Industrial I/O buffering based on kfifo"
 	help
 	  A simple fifo based on kfifo.  Use this if you want a fifo
-- 
1.7.9.4

