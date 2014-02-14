Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/2] iio: Don't include extended name in shared attributes
Date: Fri, 14 Feb 2014 15:19:24 +0100
Message-Id: <1392387566-8411-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The extended name is channel specific and should not be included in shared
attributes.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
It's a fix, but there are no drivers yet, which have channels with extended
names and shared attributes, so no need to apply it to the fixes branch.
---
 drivers/iio/industrialio-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index acc911a..fd96e8b 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -558,7 +558,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 								    ->channel2],
 						 postfix);
 	} else {
-		if (chan->extend_name == NULL)
+		if (chan->extend_name == NULL || shared_by != IIO_SEPARATE)
 			full_postfix = kstrdup(postfix, GFP_KERNEL);
 		else
 			full_postfix = kasprintf(GFP_KERNEL,
-- 
1.8.0
