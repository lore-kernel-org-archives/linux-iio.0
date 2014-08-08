Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44377 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752258AbaHHInY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 Aug 2014 04:43:24 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:buffer: Wrong sized allocation of demux table elements.
Date: Fri,  8 Aug 2014 09:43:12 +0100
Message-Id: <1407487392-1671-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The size of the allocation is currently set to the size of the pointer
rather than the structure we should actually be allocating.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: kbuild@01.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/industrialio-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 84a952931f9f..ec82cb0bea38 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -951,7 +951,7 @@ static int iio_buffer_add_demux(struct iio_buffer *buffer,
 		(*p)->to + (*p)->length == out_loc) {
 		(*p)->length += length;
 	} else {
-		*p = kmalloc(sizeof(*p), GFP_KERNEL);
+		*p = kmalloc(sizeof(**p), GFP_KERNEL);
 		if (*p == NULL)
 			return -ENOMEM;
 		(*p)->from = in_loc;
-- 
2.0.3

