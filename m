Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B82C433FE
	for <linux-iio@archiver.kernel.org>; Sun, 13 Nov 2022 05:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233760AbiKMF3Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Nov 2022 00:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbiKMF3P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2022 00:29:15 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDE9EE1B;
        Sat, 12 Nov 2022 21:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668317305; bh=EeFml0IaVh7+u5qnzQtagdJSc1KAvZBsWOHbyeOYNx4=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=KOZBBF8ZzyP8+Adcy+qOLOZzOlkxrcXlV/1gn5tau/R9wVfOoUJwBjMBw4dgrF8Xy
         FNBEvwDrkBjBBI5ROCWMnrzzG0hUM/5ObBfQIBD1sRz7bUIX+qmBm+77nacecf3XSG
         s5xjE/VaNHnLq42LOGys6eFaIvs9F6g+emXjAzkc=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sun, 13 Nov 2022 06:28:25 +0100 (CET)
X-EA-Auth: V2uAWhgOqEgUOklpFT9QYQ6PeJWA+huKz/8ufkfSmKApy7VUb1qN+/MMT5P9VdXiAkkpb7O+rZRnkB5ETyQ03u9943HdS/7G
Date:   Sun, 13 Nov 2022 10:58:20 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: iio: meter: replace ternary operator by if
 condition
Message-ID: <Y3CAdCa17WdWDYUa@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace ternary operator by simple if based evaluation of the return
value. Issue identified using coccicheck.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v2:
   1. Use if based evaluation instead of using min macro
      suggested by Joe Perches.


 drivers/staging/iio/meter/ade7854-i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index a9a06e8dda51..71b67dd3c8e9 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -61,7 +61,10 @@ static int ade7854_i2c_write_reg(struct device *dev,
 unlock:
 	mutex_unlock(&st->buf_lock);

-	return ret < 0 ? ret : 0;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }

 static int ade7854_i2c_read_reg(struct device *dev,
--
2.34.1



