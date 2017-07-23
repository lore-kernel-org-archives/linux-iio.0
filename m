Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 44/45] staging:iio:docs: drop reference to setting trig_ops->owner
Date: Sun, 23 Jul 2017 17:26:26 +0100
Message-Id: <20170723162627.22534-45-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

Whilst these docs have lots of other flaws, this element is definitely
no longer true.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/Documentation/trigger.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/Documentation/trigger.txt b/drivers/staging/iio/Documentation/trigger.txt
index 7c0e505e4f04..299a1add98bf 100644
--- a/drivers/staging/iio/Documentation/trigger.txt
+++ b/drivers/staging/iio/Documentation/trigger.txt
@@ -10,10 +10,6 @@ struct iio_trig *trig = iio_trigger_alloc("<trigger format string>", ...);
 allocates a trigger structure.  The key elements to then fill in within
 a driver are:
 
-trig->owner
-	Typically set to THIS_MODULE. Used to ensure correct
-	ownership of core allocated resources.
-
 trig->set_trigger_state:
 	Function that enables / disables the underlying source of the trigger.
 
-- 
2.13.3
