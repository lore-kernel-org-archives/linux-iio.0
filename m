Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 5/5] staging:iio:iio_core.h make less dependent on other included headers
Date: Sat,  3 Mar 2012 11:39:15 +0000
Message-Id: <1330774755-18031-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1330774755-18031-1-git-send-email-jic23@kernel.org>
References: <1330774755-18031-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

There are a lot of pointers to structures used in here that are not
declared unless a particular header is included first.  Deal with
the IIO specific ones by putting in forward declarations and the
other ones by including kernel.h and device.h.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/iio_core.h |    6 ++++++
 1 file changed, 6 insertions(+)

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
1.7.9.2
