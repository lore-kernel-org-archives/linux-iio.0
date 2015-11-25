Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from m50-138.163.com ([123.125.50.138]:42143 "EHLO m50-138.163.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753635AbbKYNNC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 25 Nov 2015 08:13:02 -0500
From: Geliang Tang <geliangtang@163.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: Geliang Tang <geliangtang@163.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] iio: fix a problematic usage of WARN_ON()
Date: Wed, 25 Nov 2015 21:12:16 +0800
Message-Id: <582529c23f77af64373f59fa92e29186df700d79.1448456395.git.geliangtang@163.com>
In-Reply-To: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com>
In-Reply-To: <8bb789c0803579a01e1ee977ed67408c422acd79.1448456395.git.geliangtang@163.com>
References: <86c73f180d3054c1bf17bdac8c89026209167c9b.1448456395.git.geliangtang@163.com> <8bb789c0803579a01e1ee977ed67408c422acd79.1448456395.git.geliangtang@163.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

WARN_ON() takes a condition rather than a format string. This patch
converted WARN_ON() to WARN() instead.

Signed-off-by: Geliang Tang <geliangtang@163.com>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 drivers/iio/industrialio-core.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index d7e908a..0f6f63b 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -302,7 +302,7 @@ static int iio_scan_mask_set(struct iio_dev *indio_dev,
 	if (trialmask == NULL)
 		return -ENOMEM;
 	if (!indio_dev->masklength) {
-		WARN_ON("Trying to set scanmask prior to registering buffer\n");
+		WARN(1, "Trying to set scanmask prior to registering buffer\n");
 		goto err_invalid_mask;
 	}
 	bitmap_copy(trialmask, buffer->scan_mask, indio_dev->masklength);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 37697d5..fe80366 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -654,7 +654,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
 			break;
 		case IIO_SEPARATE:
 			if (!chan->indexed) {
-				WARN_ON("Differential channels must be indexed\n");
+				WARN(1, "Differential channels must be indexed\n");
 				ret = -EINVAL;
 				goto error_free_full_postfix;
 			}
-- 
2.5.0


