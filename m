Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-175.synserver.de ([212.40.185.175]:1085 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934648AbaGQP7t (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Jul 2014 11:59:49 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] iio: buffer: Use roundup() instead of open-coding it
Date: Thu, 17 Jul 2014 17:59:48 +0200
Message-Id: <1405612789-27964-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1405612789-27964-1-git-send-email-lars@metafoo.de>
References: <1405612789-27964-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Makes the code slightly shorter and a bit easier to understand.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 6da5272..5063703 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -979,9 +979,7 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 			else
 				length = ch->scan_type.storagebits / 8;
 			/* Make sure we are aligned */
-			in_loc += length;
-			if (in_loc % length)
-				in_loc += length - in_loc % length;
+			in_loc = roundup(in_loc, length) + length;
 		}
 		p = kmalloc(sizeof(*p), GFP_KERNEL);
 		if (p == NULL) {
@@ -994,10 +992,8 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 				ch->scan_type.repeat;
 		else
 			length = ch->scan_type.storagebits / 8;
-		if (out_loc % length)
-			out_loc += length - out_loc % length;
-		if (in_loc % length)
-			in_loc += length - in_loc % length;
+		out_loc = roundup(out_loc, length);
+		in_loc = roundup(in_loc, length);
 		p->from = in_loc;
 		p->to = out_loc;
 		p->length = length;
@@ -1019,10 +1015,8 @@ static int iio_buffer_update_demux(struct iio_dev *indio_dev,
 				ch->scan_type.repeat;
 		else
 			length = ch->scan_type.storagebits / 8;
-		if (out_loc % length)
-			out_loc += length - out_loc % length;
-		if (in_loc % length)
-			in_loc += length - in_loc % length;
+		out_loc = roundup(out_loc, length);
+		in_loc = roundup(in_loc, length);
 		p->from = in_loc;
 		p->to = out_loc;
 		p->length = length;
-- 
1.8.0

