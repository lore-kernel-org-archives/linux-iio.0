Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from va3ehsobe001.messaging.microsoft.com ([216.32.180.11]:58269
	"EHLO VA3EHSOBE008.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751243Ab1HYPid (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 25 Aug 2011 11:38:33 -0400
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>,
	<device-drivers-devel@blackfin.uclinux.org>, <drivers@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: imu: adis16400: Avoid using printk facility
Date: Thu, 25 Aug 2011 17:23:52 +0200
Message-ID: <1314285832-26879-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

use dev_info() instead.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/imu/adis16400_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
index c1ed832..2f0d221 100644
--- a/drivers/staging/iio/imu/adis16400_core.c
+++ b/drivers/staging/iio/imu/adis16400_core.c
@@ -392,7 +392,7 @@ static int adis16400_initial_setup(struct iio_dev *indio_dev)
 		if ((prod_id & 0xF000) != st->variant->product_id)
 			dev_warn(&indio_dev->dev, "incorrect id");
 
-		printk(KERN_INFO "%s: prod_id 0x%04x at CS%d (irq %d)\n",
+		dev_info(&indio_dev->dev, "%s: prod_id 0x%04x at CS%d (irq %d)\n",
 		       indio_dev->name, prod_id,
 		       st->us->chip_select, st->us->irq);
 	}
-- 
1.7.0.4


