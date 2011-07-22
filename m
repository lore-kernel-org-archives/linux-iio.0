Return-Path: <vivien.didelot@savoirfairelinux.com>
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-iio@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg KH <greg@kroah.com>
Subject: [PATCH] staging: (iio) restore macro IIO_ATTR_2
Date: Fri, 22 Jul 2011 18:26:59 -0400
Message-Id: <1311373619-19188-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-ID: <linux-iio@vger.kernel.org>

For some reason, IIO_ATTR_2 has been deleted by commit
99e5dc45b854b4b661044e807905152911ed3fdb but it is still used by the macro
IIO_DEVICE_ATTR_2. This patch restores it.
Please ignore it if it shouldn't exist anymore. If so, this would need to
remove IIO_DEVICE_ATTR_2 as well. Obviously it seems to be useful as the struct
iio_dev_attr has a val2 member.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/staging/iio/sysfs.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index dd79b58..cfc0965 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -56,6 +56,11 @@ struct iio_const_attr {
 	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
 	  .address = _addr }
 
+#define IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)	\
+	{ .dev_attr = __ATTR(_name, _mode, _show, _store),	\
+	  .address = _addr,					\
+	  .val2 = _val2 }
+
 #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)	\
 	struct iio_dev_attr iio_dev_attr_##_name		\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
-- 
1.7.6
