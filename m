Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42949 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754218Ab2H0VMs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Aug 2012 17:12:48 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: fix spelling of subsystem
Date: Mon, 27 Aug 2012 23:12:37 +0200
Message-Id: <1346101957-9413-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/Kconfig         |    2 +-
 drivers/staging/iio/Kconfig |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index d4984c8..56825e6 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -1,5 +1,5 @@
 #
-# Industrial I/O subsytem configuration
+# Industrial I/O subsystem configuration
 #
 
 menuconfig IIO
diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 04cd6ec..ca56c75 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -1,5 +1,5 @@
 #
-# Industrial I/O subsytem configuration
+# Industrial I/O subsystem configuration
 #
 menu "IIO staging drivers"
 	depends on IIO
-- 
1.7.9.5

