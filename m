Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:36402 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbcD1MCt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2016 08:02:49 -0400
Received: by mail-lf0-f48.google.com with SMTP id u64so81402045lff.3
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2016 05:02:48 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] iio: light: bh1780: return after write
Date: Thu, 28 Apr 2016 14:02:41 +0200
Message-Id: <1461844961-28558-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When writing a value using direct reg access from debugfs
we need to return and not fall through to reading the
value, lest we'll dereference a NULL pointer.

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/light/bh1780.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/bh1780.c b/drivers/iio/light/bh1780.c
index 72b364e4aa72..f83595334ff1 100644
--- a/drivers/iio/light/bh1780.c
+++ b/drivers/iio/light/bh1780.c
@@ -84,7 +84,7 @@ static int bh1780_debugfs_reg_access(struct iio_dev *indio_dev,
 	int ret;
 
 	if (!readval)
-		bh1780_write(bh1780, (u8)reg, (u8)writeval);
+		return bh1780_write(bh1780, (u8)reg, (u8)writeval);
 
 	ret = bh1780_read(bh1780, (u8)reg);
 	if (ret < 0)
-- 
2.4.11

