Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:53060 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858Ab1HZKLY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Aug 2011 06:11:24 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 16/16] iio: imu: adis16400: Avoid using printk facility
Date: Fri, 26 Aug 2011 11:19:33 +0100
Message-Id: <1314353973-7662-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
References: <1314353973-7662-1-git-send-email-jic23@cam.ac.uk>
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
1.7.3.4

