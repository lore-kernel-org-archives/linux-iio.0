Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46516 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752048Ab1GYNi4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Jul 2011 09:38:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 3/4] staging:iio: sysfs.h remove unused val2 and dead macro.
Date: Mon, 25 Jul 2011 14:38:59 +0100
Message-Id: <1311601140-20660-4-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
References: <1311601140-20660-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Vivien pointed out that 99e5dc45b854b4b661044e807905152911ed3fdb
removed the IIO_DEVICE_ATTR_2 macro but didn't clean up the other
macros that used it.

As it turns out, no one is using val2 in tree, so lets scrap that
until it is needed.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Reported-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/staging/iio/sysfs.h |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 6bd5928..b01fe94 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -18,13 +18,11 @@
  * struct iio_dev_attr - iio specific device attribute
  * @dev_attr:	underlying device attribute
  * @address:	associated register address
- * @val2:	secondary attribute value
  * @l:		list head for maintaining list of dynamically created attrs.
  */
 struct iio_dev_attr {
 	struct device_attribute dev_attr;
 	int address;
-	int val2;
 	struct list_head l;
 	struct iio_chan_spec const *c;
 };
@@ -64,10 +62,6 @@ struct iio_const_attr {
 	struct iio_dev_attr iio_dev_attr_##_vname			\
 	= IIO_ATTR(_name, _mode, _show, _store, _addr)
 
-#define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr, _val2)	\
-	struct iio_dev_attr iio_dev_attr_##_name			\
-	= IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)
-
 #define IIO_CONST_ATTR(_name, _string)					\
 	struct iio_const_attr iio_const_attr_##_name			\
 	= { .string = _string,						\
-- 
1.7.3.4

