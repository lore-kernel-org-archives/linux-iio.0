Return-Path: <SRS0=mPBy=TH=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680EEC004C9
	for <linux-iio@archiver.kernel.org>; Tue,  7 May 2019 08:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A72420989
	for <linux-iio@archiver.kernel.org>; Tue,  7 May 2019 08:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Z2vlBpYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbfEGIXT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 7 May 2019 04:23:19 -0400
Received: from first.geanix.com ([116.203.34.67]:42562 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726063AbfEGIXT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 7 May 2019 04:23:19 -0400
Received: from zen.localdomain (unknown [85.184.147.232])
        by first.geanix.com (Postfix) with ESMTPSA id F36169A4;
        Tue,  7 May 2019 08:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1557217359; bh=KUEy8lkDyGgm1Jf2E9ADSE8XlfO1mY2FOQ1/BZwwZpM=;
        h=From:To:Cc:Subject:Date;
        b=Z2vlBpYPyltF5ve/XRcfjSBBsdK4cM6nhFV/Y4lcB8sKF/riXNCiwRC3JvaT9b6Sx
         fUGzAZG539oo8WylE5BCVSYnPLAsGI7+HH3Kt6lpafOdCTEBHWXT6U30iRBZYd0ELs
         Jm82uLkPb2TekkvJEo/cBvf8Kt9wx7xnNfrvPlBqswgwLEBDWXdxZaqaBLD0Tcqqx3
         jhg6dHp6Jw/wuQ3g6lNaVGSNaOIDSiPb+0yTnoRNawYl8zDUHWkprVwfjne5tCB8ON
         hvDGhZSkM7bLvQxw1x0MgFQTvO34G5AYUe7rAj0EZprEPhccF4050iLyTZC8j8pw6Z
         nbFUk/TcTH6vA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org
Cc:     Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 1/2] iio: adc: ti-ads8688: save values correct in buffer
Date:   Tue,  7 May 2019 10:23:03 +0200
Message-Id: <20190507082304.11692-1-sean@geanix.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fill the read values in the buffer so we comply
with the given index values.

Fixes: 2a86487786b5c ("iio: adc: ti-ads8688: add trigger and buffer support")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/adc/ti-ads8688.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
index f9461070a74a..d9c354dbd7e4 100644
--- a/drivers/iio/adc/ti-ads8688.c
+++ b/drivers/iio/adc/ti-ads8688.c
@@ -387,13 +387,12 @@ static irqreturn_t ads8688_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	u16 buffer[ADS8688_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
-	int i, j = 0;
+	int bit;
 
-	for (i = 0; i < indio_dev->masklength; i++) {
-		if (!test_bit(i, indio_dev->active_scan_mask))
-			continue;
-		buffer[j] = ads8688_read(indio_dev, i);
-		j++;
+	memset(buffer, 0, sizeof(buffer));
+
+	for_each_set_bit(bit, indio_dev->active_scan_mask, indio_dev->masklength) {
+		buffer[bit] = ads8688_read(indio_dev, bit);
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
-- 
2.21.0

