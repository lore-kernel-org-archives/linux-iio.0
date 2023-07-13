Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001ADEB64DD
	for <linux-iio@archiver.kernel.org>; Thu, 13 Jul 2023 10:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjGMKsL (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 13 Jul 2023 06:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbjGMKr4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 13 Jul 2023 06:47:56 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F54F2683;
        Thu, 13 Jul 2023 03:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689245273;
  x=1720781273;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=xM/3mEoxCUQ/wZ0ZwtpBg5cBzRBduFqs5j7ewLkHOEQ=;
  b=Cfj+QTPAjczSEviwfNA4ssljkdrCY9ySj0BN9JpLHCm5NbSC72xjKTmk
   2vQwwUeJjp10+ehYzHLl89aSVjCUFKH1Bsd/9vF4rhhkb9XV828rZ2L+H
   RCnNB0eylM6PJMwMGn9ccmsqQSIbapAwWq1sSx6Ui9ReZGcyinRvXUenn
   BFQ+IQMeXaZ983gr+l8hluUWLhO9544/RzbJbV1lfISigJfMF7wM9HfVx
   PjUZz/NSTc4ITH5Bx7s1DX+UBUfRWTXpAqiDZaNAjv8D5f86CTkBEnpCJ
   mMaOY2njX6tOzAhDw+xUeDQahmKuRA7XvgG+F6UmSaQTLJEiSqb0nURs/
   w==;
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <kernel@axis.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: Fix return value check for set_trigger_state()
Date:   Thu, 13 Jul 2023 12:47:31 +0200
Message-ID: <pndv8eojdey.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In `iio_trigger_detach_poll_func()` the return value from
`trig->ops->set_trigger_state(trig, false)` is checked with `if (ret)`.
However, in `iio_trigger_attach_poll_func()` it is checked with
`if (ret < 0)`. Fix this mismatch by only checking for `if (ret)` in
both places.

Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
---
 drivers/iio/industrialio-trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index f207e36b12cc..18f83158f637 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -313,7 +313,7 @@ int iio_trigger_attach_poll_func(struct iio_trigger *trig,
 	/* Enable trigger in driver */
 	if (trig->ops && trig->ops->set_trigger_state && notinuse) {
 		ret = trig->ops->set_trigger_state(trig, true);
-		if (ret < 0)
+		if (ret)
 			goto out_free_irq;
 	}
 
-- 
2.30.2

