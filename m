Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:50465 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752633Ab3G2VfO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 29 Jul 2013 17:35:14 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH] iio: Fix documentation of devm_iio_device_free()
Date: Mon, 29 Jul 2013 23:35:10 +0200
Message-Id: <1375133710-19453-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 include/linux/iio/iio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index f1d99f6..7ae54a5 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -552,9 +552,9 @@ struct iio_dev *devm_iio_device_alloc(struct device *dev, int sizeof_priv);
  * @dev:		Device this iio_dev belongs to
  * @indio_dev: 		the iio_dev associated with the device
  *
- * Free indio_dev allocated with devm_iio_device_alloc().
+ * Free iio_dev allocated with devm_iio_device_alloc().
  */
-void devm_iio_device_free(struct device *dev, struct iio_dev *iio_dev);
+void devm_iio_device_free(struct device *dev, struct iio_dev *indio_dev);
 
 /**
  * iio_buffer_enabled() - helper function to test if the buffer is enabled
-- 
1.8.3.4

