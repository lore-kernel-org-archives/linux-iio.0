Return-Path: <SRS0=gotz=C5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A372FC43465
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 11:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 688B1235F9
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 11:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600601316;
	bh=1PzJMw9WIg1pCpshAZf3NIZK0fxLMlKYksdnKuROyjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Df+4nx9UxQqupXBy32zBW9DfW6uo/kS2B3einZ3ttaoY2oHZRmCVO/+3BsCllykl8
	 OLOEMBSIC14T/Na/Z346Lf2vAYNdhdIwioIYskkeQahj2kpplM7NHwZvHtkQSm3dKJ
	 fFSBOaCuKiSyx3i+ImkdliXbpBAEHu56ALI7uAdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgITL2g (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgITL2f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 07:28:35 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78D3321BE5;
        Sun, 20 Sep 2020 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600601314;
        bh=1PzJMw9WIg1pCpshAZf3NIZK0fxLMlKYksdnKuROyjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uoaQpjF4N7v2pS0P0any61MMFL6xBID8zfY+5iTcbSw7g2aGCWrk2IaBVJLPx0tKa
         uaQiQB9AnsSQvQEOXRdJyZRg1L/VCzpJqmxUnWUGac8GNds/nkaS9sILM24RZTNT5s
         bAC9I7mgoeN6lx9UMs12SHUdb9tWycLEo2XiAFcc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v4 8/8] iio:adc:ti-ads124s08: Fix alignment and data leak issues.
Date:   Sun, 20 Sep 2020 12:27:42 +0100
Message-Id: <20200920112742.170751-9-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920112742.170751-1-jic23@kernel.org>
References: <20200920112742.170751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One of a class of bugs pointed out by Lars in a recent review.
iio_push_to_buffers_with_timestamp() assumes the buffer used is aligned
to the size of the timestamp (8 bytes).  This is not guaranteed in
this driver which uses an array of smaller elements on the stack.
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc() so no
data can leak apart from previous readings.

In this driver the timestamp can end up in various different locations
depending on what other channels are enabled.  As a result, we don't
use a structure to specify it's position as that would be misleading.

Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 v4: Expand comment to express the buffer length not all needed if
  not all channels are enabled.
  
 drivers/iio/adc/ti-ads124s08.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index eff4f9a9898e..b4a128b19188 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -99,6 +99,14 @@ struct ads124s_private {
 	struct gpio_desc *reset_gpio;
 	struct spi_device *spi;
 	struct mutex lock;
+	/*
+	 * Used to correctly align data.
+	 * Ensure timestamp is naturally aligned.
+	 * Note that the full buffer length may not be needed if not
+	 * all channels are enabled, as long as the alignment of the
+	 * timestamp is maintained.
+	 */
+	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u32)] __aligned(8);
 	u8 data[5] ____cacheline_aligned;
 };
 
@@ -269,7 +277,6 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads124s_private *priv = iio_priv(indio_dev);
-	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u32)];
 	int scan_index, j = 0;
 	int ret;
 
@@ -284,7 +291,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		if (ret)
 			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
 
-		buffer[j] = ads124s_read(indio_dev, scan_index);
+		priv->buffer[j] = ads124s_read(indio_dev, scan_index);
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
 		if (ret)
 			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
@@ -292,7 +299,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
 			pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.28.0

