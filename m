Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 45/45] staging:iio:docs: drop setting of THIS_MODULE from staging docs.
Date: Sun, 23 Jul 2017 17:26:27 +0100
Message-Id: <20170723162627.22534-46-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

These docs need to be cleaned up properly, but for now lets drop
this entry as it is definitely no longer true.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/Documentation/device.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/iio/Documentation/device.txt b/drivers/staging/iio/Documentation/device.txt
index 54ef0deed28f..ec42544a46aa 100644
--- a/drivers/staging/iio/Documentation/device.txt
+++ b/drivers/staging/iio/Documentation/device.txt
@@ -26,9 +26,6 @@ Then fill in the following:
 	pointer to a structure with elements that tend to be fixed for
 	large sets of different parts supported by a given driver.
 	This contains:
-	* info->driver_module:
-		Set to THIS_MODULE. Used to ensure correct ownership
-		of various resources allocate by the core.
 	* info->event_attrs:
 		Attributes used to enable / disable hardware events.
 	* info->attrs:
-- 
2.13.3
