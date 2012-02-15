Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:57841 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751781Ab2BOTtB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 15 Feb 2012 14:49:01 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:iio_core.h make less dependent on other included headers
Date: Wed, 15 Feb 2012 19:49:53 +0000
Message-Id: <1329335393-31127-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There are a lot of pointers to structures used in here that are not
declared unless a particular header is included first.  Deal with
the IIO specific ones by putting in forward declarations and the
other ones by including kernel.h and device.h.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio_core.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/iio_core.h b/drivers/staging/iio/iio_core.h
index c9dfcba..f652e6a 100644
--- a/drivers/staging/iio/iio_core.h
+++ b/drivers/staging/iio/iio_core.h
@@ -12,6 +12,12 @@
 
 #ifndef _IIO_CORE_H_
 #define _IIO_CORE_H_
+#include <linux/kernel.h>
+#include <linux/device.h>
+
+struct iio_chan_spec;
+struct iio_dev;
+
 
 int __iio_add_chan_devattr(const char *postfix,
 			   struct iio_chan_spec const *chan,
-- 
1.7.8.4

