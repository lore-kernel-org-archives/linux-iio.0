Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36900 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdE2PwN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:13 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/38] iio:dummy: drop assignment of iio_info.driver_module
Date: Mon, 29 May 2017 16:51:27 +0100
Message-Id: <20170529155154.22580-12-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent is now done via macro magic when
the relevant register call is made.  The actual structure
element will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
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
2.13.0

