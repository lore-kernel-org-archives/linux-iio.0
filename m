Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3580DC48BCF
	for <linux-iio@archiver.kernel.org>; Sun, 13 Jun 2021 15:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D9C6120E
	for <linux-iio@archiver.kernel.org>; Sun, 13 Jun 2021 15:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbhFMPX0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Jun 2021 11:23:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:32798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231844AbhFMPX0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Jun 2021 11:23:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BE63E61358;
        Sun, 13 Jun 2021 15:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623597685;
        bh=OsP7Jyl45mX+TaPWmlosk3K0gqYWkdCUU08UScKj36s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O+Ekdxn0PVUVWVWnbUNxc1++APw0a+dVOoogrN/H392WFqXceAdC5BA2BX6QnHSvy
         G4MIFx7nJ7I0ST5spjEkohFzOdIRemPO78NlgtrHopcGWpSmeWZFGZj1eqEUU3hs4W
         64Zb1NS4flStvvpHmuLttQRlC+cVm7wynIhiw6BW9eshuBbtqIcXDqilHnrud3zQUQ
         FLfetqsP4KgP3IjamEvyNeaKL3CVedIbJ3UUhW0RVBj0BAdSkBAUWjdNg6/rLfb1HX
         iBRWXfqMOArkhsyGYv8z2aubaMar3qffjSTSftMS89QPrKVKaYDjaODnvD/8Hhc8IK
         qHH7ARXsN5YcA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH RESEND 8/8] iio: prox: isl29501: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sun, 13 Jun 2021 16:23:01 +0100
Message-Id: <20210613152301.571002-9-jic23@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210613152301.571002-1-jic23@kernel.org>
References: <20210613152301.571002-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add __aligned(8) to ensure the buffer passed to
iio_push_to_buffers_with_timestamp() is suitable for the naturally
aligned timestamp that will be inserted.

Here an explicit structure is not used, because the holes would
necessitate the addition of an explict memset(), to avoid a kernel
data leak, making for a less minimal fix.

Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/iio/proximity/isl29501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index 90e76451c972..5b6ea783795d 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -938,7 +938,7 @@ static irqreturn_t isl29501_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct isl29501_private *isl29501 = iio_priv(indio_dev);
 	const unsigned long *active_mask = indio_dev->active_scan_mask;
-	u32 buffer[4] = {}; /* 1x16-bit + ts */
+	u32 buffer[4] __aligned(8) = {}; /* 1x16-bit + naturally aligned ts */
 
 	if (test_bit(ISL29501_DISTANCE_SCAN_INDEX, active_mask))
 		isl29501_register_read(isl29501, REG_DISTANCE, buffer);
-- 
2.32.0

