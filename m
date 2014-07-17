Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1079 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934305AbaGQP7t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jul 2014 11:59:49 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/4] iio: buffer: Fix demux table creation
Date: Thu, 17 Jul 2014 17:59:46 +0200
Message-Id: <1405612789-27964-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When creating the demux table we need to iterate over the selected scan mask for
the buffer to get the samples which should be copied to destination buffer.
Right now the code uses the mask which contains all active channels, which means
the demux table contains entries which causes it to copy all the samples from
source to destination buffer one by one without doing any demuxing.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2952ee0..0472ee2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -963,7 +963,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 
 	/* Now we have the two masks, work from least sig and build up sizes */
 	for_each_set_bit(out_ind,
-			 indio_dev->active_scan_mask,
+			 buffer->scan_mask,
 			 indio_dev->masklength) {
 		in_ind = find_next_bit(indio_dev->active_scan_mask,
 				       indio_dev->masklength,
-- 
1.8.0

