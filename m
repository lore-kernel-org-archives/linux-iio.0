Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F5C433ED
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 17:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC5DC615FF
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 17:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhEARQU (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 May 2021 13:16:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230195AbhEARQU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:16:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 19EBE61494;
        Sat,  1 May 2021 17:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619889330;
        bh=S+7jWLb5LIxVBBvY3tBtVQzAg9iKURjYg0z5EMqXyb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTrGBzggak5R7TkQ8CwiMcFPrtKNHAKFWMpdW7HBQQ/ACGqtZB1u7urWe/zyhLOPk
         ZvHPlB0uTrUSfUzO8e8XfBiW8njw5uVR0cB8hNxBfP+rAkh1LC5MuC/mCLOPGu3j83
         T81myx3E3NIY0NWKqf6kGVTz6zG/9OYzTLKxTz/sy+L31jYx1wK7++gMz95bE7ktDK
         2wDytyh1ql327j38RLizmGGRp25pr/M4hMCnoTMUAnBdxlskgCx1cs8z6GlF3OC2jT
         s9lT0XZjjPbMHmDAmLO0GpOIPXmGeRrSdIsEFW7HCwHhd/QE0Tx7ocOTCvPi+/I8aT
         hKhtF9f9In7jw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/11] iio: adc: ti-ads8688: Fix alignment of buffer in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:13:45 +0100
Message-Id: <20210501171352.512953-5-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501171352.512953-1-jic23@kernel.org>
References: <20210501171352.512953-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __aligned(8) to ensure the buffer passed to
iio_push_to_buffers_with_timestamp() is suitable for the naturally
aligned timestamp that will be inserted.

Fixes: f214ff521fb1 ("iio: ti-ads8688: Update buffer allocation for timestamps")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads8688.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index 16bcb37eebb7..79c803537dc4 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -383,7 +383,8 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
+	/* Ensure naturally aligned timestamp */
+	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
 	int i, j = 0;
 
 	for (i = 0; i < indio_dev->masklength; i++) {
-- 
2.31.1

