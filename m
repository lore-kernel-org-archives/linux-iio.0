Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28116 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754503AbaFPTFT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 16 Jun 2014 15:05:19 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] iio: AK09911 : Remove duplicate indio_dev->name assignment
Date: Mon, 16 Jun 2014 12:01:17 -0700
Message-Id: <1402945277-12721-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Need to remove indio_dev->name assignment for id->name as id can
be NULL. Copy paste bug from ak8975.c where it was fixed later.

kbuild test robot errors:
error: we previously assumed 'id' could be null (see line 288)

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/ak09911.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak09911.c b/drivers/iio/magnetometer/ak09911.c
index 62f980c..b2bc942 100644
--- a/drivers/iio/magnetometer/ak09911.c
+++ b/drivers/iio/magnetometer/ak09911.c
@@ -298,7 +298,6 @@ static int ak09911_probe(struct i2c_client *client,
 	indio_dev->channels = ak09911_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak09911_channels);
 	indio_dev->info = &ak09911_info;
-	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
-- 
1.7.11.7

