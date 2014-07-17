Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1080 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934257AbaGQP7t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jul 2014 11:59:49 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/4] iio: buffer: Use roundup() instead of ALIGN()
Date: Thu, 17 Jul 2014 17:59:47 +0200
Message-Id: <1405612789-27964-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1405612789-27964-1-git-send-email-lars@metafoo.de>
References: <1405612789-27964-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ALIGN() only works correctly if the alignment is a power of two. Some drivers
use 3 bytes for the storage size of the word in which case ALIGN() will cause
incorrect results. Use the more generic roundup() instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
This at least makes the rules for alignment predictable and consistent. But
mixing 3 bytes words with other word sizes will still result in strange layouts.
E.g. 4-byte word, 3-byte word will result in 4-byte word, 2-byte alignment gap,
3-byte word.
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 0472ee2..6da5272 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -486,7 +486,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 				ch->scan_type.repeat;
 		else
 			length = ch->scan_type.storagebits / 8;
-		bytes = ALIGN(bytes, length);
+		bytes = roundup(bytes, length);
 		bytes += length;
 	}
 	if (timestamp) {
@@ -497,7 +497,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 				ch->scan_type.repeat;
 		else
 			length = ch->scan_type.storagebits / 8;
-		bytes = ALIGN(bytes, length);
+		bytes = roundup(bytes, length);
 		bytes += length;
 	}
 	return bytes;
-- 
1.8.0

