Return-Path: <SRS0=4zHB=7U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E6AC433E0
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9D0206C3
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591545412;
	bh=jkMvbLw7ydajY5LmRGSihqTbAlFJeMGs1LWyA2Q0XBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IjRSxzQUi7JK4BqEgCF0Hx5uTT/qGKPuB9t18x6qbyuNcQMf+0cO38jh/WJNR/2GO
	 Pkswv+Zjh6RINsAp4Gprt76qc8RxS4bNs3ljQDlpaLEY5MZtA2WK5de6IoCqBqgtaP
	 ttOmta8fmLv3okseVSEfi0BCabh7E8ho+Fd5MnhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgFGP4v (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:51 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB32420774;
        Sun,  7 Jun 2020 15:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545411;
        bh=jkMvbLw7ydajY5LmRGSihqTbAlFJeMGs1LWyA2Q0XBc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugoEO3vUw8G5GJgOC3axr5LglnpHvfE1nVCMFVdKMy1UrILNSAfFfUdL+o3D/AP+r
         oJwS1Ca6uX2JWvBBns46x1v9SNIzrncxCFG00uu3eJ26Pa/NSK2fqm+aEv3EwHOTjs
         sidIPA6iz5SSw9+7e0dTCg5jyHt0v9inaFDzsYWA=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH 27/32] iio:adc:ti-ads124s08 Fix alignment and data leak issues.
Date:   Sun,  7 Jun 2020 16:54:03 +0100
Message-Id: <20200607155408.958437-28-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200607155408.958437-1-jic23@kernel.org>
References: <20200607155408.958437-1-jic23@kernel.org>
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
As Lars also noted this anti pattern can involve a leak of data to
userspace and that indeed can happen here.  We close both issues by
moving to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak apart from previous readings.

Fixes: e717f8c6dfec ("iio: adc: Add the TI ads124s08 ADC code")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-ads124s08.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index dacaa7255a3b..f9731e6a4260 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -99,6 +99,11 @@ struct ads124s_private {
 	struct gpio_desc *reset_gpio;
 	struct spi_device *spi;
 	struct mutex lock;
+	/*
+	 * Used to correctly align data.
+	 * Ensure timestamp is naturally aligned.
+	 */
+	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);
 	u8 data[5] ____cacheline_aligned;
 };
 
@@ -269,7 +274,6 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct ads124s_private *priv = iio_priv(indio_dev);
-	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)];
 	int scan_index, j = 0;
 	int ret;
 
@@ -284,7 +288,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		if (ret)
 			dev_err(&priv->spi->dev, "Start ADC conversions failed\n");
 
-		buffer[j] = ads124s_read(indio_dev, scan_index);
+		priv->buffer[j] = ads124s_read(indio_dev, scan_index);
 		ret = ads124s_write_cmd(indio_dev, ADS124S08_STOP_CONV);
 		if (ret)
 			dev_err(&priv->spi->dev, "Stop ADC conversions failed\n");
@@ -292,7 +296,7 @@ static irqreturn_t ads124s_trigger_handler(int irq, void *p)
 		j++;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer,
 			pf->timestamp);
 
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

