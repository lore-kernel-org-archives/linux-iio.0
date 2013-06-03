Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:11089
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753280Ab3FCIIz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 3 Jun 2013 04:08:55 -0400
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>, <linux-iio@vger.kernel.org>
CC: Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio:inkern: Fix typo/bug in convert raw to processed.
Date: Mon, 3 Jun 2013 10:04:16 +0200
Message-ID: <1370246656-15546-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/inkern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 795d100..442d529 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -450,7 +450,7 @@ static int iio_convert_raw_to_processed_unlocked(struct iio_channel *chan,
 	s64 raw64 = raw;
 	int ret;
 
-	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_SCALE);
+	ret = iio_channel_read(chan, &offset, NULL, IIO_CHAN_INFO_OFFSET);
 	if (ret == 0)
 		raw64 += offset;
 
-- 
1.7.9.5


