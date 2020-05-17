Return-Path: <SRS0=lwR9=67=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F33C433E3
	for <linux-iio@archiver.kernel.org>; Sun, 17 May 2020 17:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C31F2081A
	for <linux-iio@archiver.kernel.org>; Sun, 17 May 2020 17:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589736732;
	bh=ncSOtpH0DdCs1lxPhvgnk159v8K/cbijvzKLrvrbtP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QuBH4LoExUbs2Tzu1U+SB6BD6Yfmp5mEP82TaGNIkLj4Kc8KXT5QvS66f5xgbLphk
	 Raz9o5MIX/pk6ox4wnYrPC9GfYghWvg0V+EFK99hHz+0tizx9KZMzqcfUUU4cyJK9B
	 zTpHiuNdxzmudj3gDLcePdIrOwS6mcL7nXzPVbnM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgEQRcM (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 17 May 2020 13:32:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgEQRcL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 May 2020 13:32:11 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8480C20801;
        Sun, 17 May 2020 17:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589736731;
        bh=ncSOtpH0DdCs1lxPhvgnk159v8K/cbijvzKLrvrbtP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bPMW/RC/RTtQgiUcxtoccCKKSZWClPmDPkf1N2FHWw32cTOPwpqhynnj/d6fygxuI
         TfxCdvSr/ZYm1TU+EsVBR/a6xrZwZ/EAtsSSh6I6W2PDrkWfANq7aNblw+4Jy22rUk
         t8oswAgb80qLrHUeWy/klkBrN2o0uMRKlCfs8f0Y=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/11] iio:gyro:itg3200: Fix timestamp alignment and prevent data leak.
Date:   Sun, 17 May 2020 18:29:54 +0100
Message-Id: <20200517173000.220819-6-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200517173000.220819-1-jic23@kernel.org>
References: <20200517173000.220819-1-jic23@kernel.org>
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
this driver which uses a 16 byte array of smaller elements on the stack.
This is fixed by using an explicit c structure. As there are no
holes in the structure, there is no possiblity of data leakage
in this case.

Fixes: 36e0371e7764 ("iio:itg3200: Use iio_push_to_buffers_with_timestamp()")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/gyro/itg3200_buffer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index d3fbe9d86467..cd405801e61e 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -46,13 +46,20 @@ static irqreturn_t itg3200_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct itg3200 *st = iio_priv(indio_dev);
-	__be16 buf[ITG3200_SCAN_ELEMENTS + sizeof(s64)/sizeof(u16)];
-
-	int ret = itg3200_read_all_channels(st->i2c, buf);
+	/*
+	 * Ensure correct alignment and padding including for the
+	 * timestamp that may be inserted.
+	 */
+	struct {
+		__be16 buf[ITG3200_SCAN_ELEMENTS];
+		s64 ts;
+	} scan;
+
+	int ret = itg3200_read_all_channels(st->i2c, scan.buf);
 	if (ret < 0)
 		goto error_ret;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.26.2

