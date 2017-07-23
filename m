Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55664 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbdGWQ0m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:42 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 12/45] iio:dummy: drop assignment of iio_info.driver_module
Date: Sun, 23 Jul 2017 17:25:54 +0100
Message-Id: <20170723162627.22534-13-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent is now done via macro magic when
the relevant register call is made.  The actual structure
element will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/dummy/iio_simple_dummy.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_simple_dummy.c b/drivers/iio/dummy/iio_simple_dummy.c
index ad3410e528b6..a45d01e9b8e8 100644
--- a/drivers/iio/dummy/iio_simple_dummy.c
+++ b/drivers/iio/dummy/iio_simple_dummy.c
@@ -519,7 +519,6 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
  * Device type specific information.
  */
 static const struct iio_info iio_dummy_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &iio_dummy_read_raw,
 	.write_raw = &iio_dummy_write_raw,
 #ifdef CONFIG_IIO_SIMPLE_DUMMY_EVENTS
-- 
2.13.3

