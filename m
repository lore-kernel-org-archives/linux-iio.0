Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47281 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751878Ab2FRSdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jun 2012 14:33:09 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: correct documentation for IIO_CONST_ATTR_SAMP_FREQ_AVAIL, match name of #define
Date: Mon, 18 Jun 2012 20:33:02 +0200
Message-Id: <1340044387-2725-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 include/linux/iio/sysfs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/sysfs.h b/include/linux/iio/sysfs.h
index bfedb73..b7a934b 100644
--- a/include/linux/iio/sysfs.h
+++ b/include/linux/iio/sysfs.h
@@ -97,7 +97,7 @@ struct iio_const_attr {
 #define IIO_DEV_ATTR_SAMP_FREQ_AVAIL(_show)				\
 	IIO_DEVICE_ATTR(sampling_frequency_available, S_IRUGO, _show, NULL, 0)
 /**
- * IIO_CONST_ATTR_AVAIL_SAMP_FREQ - list available sampling frequencies
+ * IIO_CONST_ATTR_SAMP_FREQ_AVAIL - list available sampling frequencies
  * @_string: frequency string for the attribute
  *
  * Constant version
-- 
1.7.9.5

