Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A126FC4332F
	for <linux-iio@archiver.kernel.org>; Mon,  7 Nov 2022 04:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiKGEKd (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 6 Nov 2022 23:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKGEKc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 23:10:32 -0500
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3FEC742;
        Sun,  6 Nov 2022 20:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667794206; bh=4vpubAxBJPLICHSVHvPCZgQDNFOK73r6037oLcqxRNw=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=C9iFnW7RbBKdhCtxtXzOLa3JlnRrnJ7VcaqFqQVVR90dK9DJVByEiltrZ1pYEHdXW
         HaZ8FnufHYDVsG2dFR2FWw551lYOjE8LaT6/W7ah0A/HFTvl89M+WhaAXckJee0i1y
         ThqaZvQWeOJGzQDG1BwXvTM7OKTLYLbeKpByI7oE=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Mon,  7 Nov 2022 05:10:06 +0100 (CET)
X-EA-Auth: xmv0Uzdl1lJntsxK/BrE7s8F1LLtHp58aHBwFEduoB5F/pQe89jIg2LygmBdI/VKxLWHU6Cnupv4LfA4oPG2e08H69d/mTW0
Date:   Mon, 7 Nov 2022 09:40:00 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: meter: use min() for comparison and assignment
Message-ID: <Y2iFGA3A1w+XMlYU@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Simplify code by using recommended min helper macro for logical
evaluation and value assignment. This issue is identified by
coccicheck using the minmax.cocci file.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index a9a06e8dda51..a6ce7b24cc8f 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -61,7 +61,7 @@ static int ade7854_i2c_write_reg(struct device *dev,
 unlock:
 	mutex_unlock(&st->buf_lock);

-	return ret < 0 ? ret : 0;
+	return min(ret, 0);
 }

 static int ade7854_i2c_read_reg(struct device *dev,
--
2.34.1



