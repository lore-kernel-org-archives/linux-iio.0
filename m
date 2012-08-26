Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:39259 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567Ab2HZMnu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 26 Aug 2012 08:43:50 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: fix typos
Date: Sun, 26 Aug 2012 14:43:37 +0200
Message-Id: <1345985019-24288-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/industrialio-core.c |    2 +-
 include/linux/iio/iio.h         |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 2ec266e..47c1ffa 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -729,7 +729,7 @@ static int iio_device_register_sysfs(struct iio_dev *indio_dev)
 	attrcount = attrcount_orig;
 	/*
 	 * New channel registration method - relies on the fact a group does
-	 * not need to be initialized if it is name is NULL.
+	 * not need to be initialized if its name is NULL.
 	 */
 	if (indio_dev->channels)
 		for (i = 0; i < indio_dev->num_channels; i++) {
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index be82936..f323e7b 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -164,7 +164,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  * IIO_ENUM() - Initialize enum extended channel attribute
  * @_name:	Attribute name
  * @_shared:	Whether the attribute is shared between all channels
- * @_e:		Pointer to a iio_enum struct
+ * @_e:		Pointer to an iio_enum struct
  *
  * This should usually be used together with IIO_ENUM_AVAILABLE()
  */
@@ -180,9 +180,9 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
 /**
  * IIO_ENUM_AVAILABLE() - Initialize enum available extended channel attribute
  * @_name:	Attribute name ("_available" will be appended to the name)
- * @_e:		Pointer to a iio_enum struct
+ * @_e:		Pointer to an iio_enum struct
  *
- * Creates a read only attribute which list all the available enum items in a
+ * Creates a read only attribute which lists all the available enum items in a
  * space separated list. This should usually be used together with IIO_ENUM()
  */
 #define IIO_ENUM_AVAILABLE(_name, _e) \
-- 
1.7.9.5

