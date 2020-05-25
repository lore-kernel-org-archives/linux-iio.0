Return-Path: <SRS0=I6G3=7H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9957CC433E1
	for <linux-iio@archiver.kernel.org>; Mon, 25 May 2020 17:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 716B3208B3
	for <linux-iio@archiver.kernel.org>; Mon, 25 May 2020 17:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590426560;
	bh=rVZ8obXG9Z449L0E2sVrhNZGsbFafinP9wKcqaPwfjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Wal4JMy7RgoqMPgYKgJzhEoDVXddb3V8f19AP5hAzRxY++ykznZiadEYB51MWNccE
	 Ujkv21IS0NQQgygOardxOWD4tV14L/KnqR4Y0fHopc2rox6s0nQxrPZZcFIlr35VFp
	 a0gGZtqwLaUAjm2GdO8FSfJGCW3lds/GUMOeBdYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391278AbgEYRJS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 25 May 2020 13:09:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391298AbgEYRJS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:18 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6492207DA;
        Mon, 25 May 2020 17:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426557;
        bh=rVZ8obXG9Z449L0E2sVrhNZGsbFafinP9wKcqaPwfjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cyWJ6lv6uHTqWc+CJ/HQeQl7zccY/GGIZLMMOrjnsU/JLqoqpMoK4oRd7bjY/82lI
         /SkQB0jYETfFuZPDy3FstYcZPpzetdDV6bKxCZ0cV3ErB1XAm/hzlBRsD5/0esC81s
         GWbigP4wRl80F2GenQ+3KTEW5cpIDYwEuP4EUFdo=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 14/25] iio:pressure:ms5611 Fix buffer element alignment
Date:   Mon, 25 May 2020 18:06:17 +0100
Message-Id: <20200525170628.503283-15-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
Here there is no data leak possibility so use an explicit structure
on the stack to ensure alignment and nice readable fashion.

Fixes: 713bbb4efb9dc ("iio: pressure: ms5611: Add triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/pressure/ms5611_core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index 2f598ad91621..ba9cf9d77a4a 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -212,16 +212,21 @@ static irqreturn_t ms5611_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ms5611_state *st = iio_priv(indio_dev);
-	s32 buf[4]; /* s32 (pressure) + s32 (temp) + 2 * s32 (timestamp) */
+	/* Ensure buffer elements are naturally aligned */
+	struct {
+		s32 channels[2];
+		s64 ts;
+	} scan;
 	int ret;
 
 	mutex_lock(&st->lock);
-	ret = ms5611_read_temp_and_pressure(indio_dev, &buf[1], &buf[0]);
+	ret = ms5611_read_temp_and_pressure(indio_dev, &scan.channels[1],
+					    &scan.channels[0]);
 	mutex_unlock(&st->lock);
 	if (ret < 0)
 		goto err;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan,
 					   iio_get_time_ns(indio_dev));
 
 err:
-- 
2.26.2

