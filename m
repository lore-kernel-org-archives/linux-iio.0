Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 07/10] staging:iio:core shared attrs do not work with modifier.
Date: Wed, 26 Oct 2011 17:27:42 +0100
Message-Id: <1319646465-2788-8-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
References: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The logic building the name had a small bug where
it did not verify if it was generic before applying the
modifier.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/industrialio-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
index 326e967..555877d 100644
--- a/drivers/staging/iio/industrialio-core.c
+++ b/drivers/staging/iio/industrialio-core.c
@@ -408,7 +408,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 	sysfs_attr_init(&dev_attr->attr);
 
 	/* Build up postfix of <extend_name>_<modifier>_postfix */
-	if (chan->modified) {
+	if (chan->modified && !generic) {
 		if (chan->extend_name)
 			full_postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
 						 iio_modifier_names[chan
-- 
1.7.7
