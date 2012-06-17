Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/4] iio: correct documentation for IIO_CONST_ATTR_SAMP_FREQ_AVAIL, match name of #define
Date: Sun, 17 Jun 2012 19:03:17 +0200
Message-Id: <1339952599-22105-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
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
