Return-Path: <SRS0=4zHB=7U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D27FC433E0
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D9DD20748
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591545416;
	bh=VZXpzmPODQV0DwSJJDIe2LQy8VO+w/2CkuzP3X6CKa8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0617sJ3D2QAQxCvOWNoroiqfBnR1E5aTGjiG4eq1QMebOURvbYtvhY6qYGHqpvq2i
	 Kc7aezwlQ+MFTSNh3wmeQSLUn1fOEiRdsiV+jO6VuGsZcBSehKq+3e0RjM9l0CWr7k
	 suKXAEOKF+q3Oa1vc4N8Fja4tRvpjSrjJ0rgTqh8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgFGP4z (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:56:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:57682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:55 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 225A720723;
        Sun,  7 Jun 2020 15:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545415;
        bh=VZXpzmPODQV0DwSJJDIe2LQy8VO+w/2CkuzP3X6CKa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BHdMa+sjkmdTQrXzrsBSDJfeClMkpBoaAHgGTTRGHbY2gF0TDVjSw2gJqJlSh5Jy0
         IA25hm7LYcwatWON42l4xeQYGNYnjJpHKOeefWAHFWDg4ChprrO2fKrwuJh0h5YsMc
         fTbkwq3ElUEL2Z0W3FPLFaw2eHlP8L0XV24fsS6A=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Akinobu Mita <akinobu.mita@gmail.com>
Subject: [PATCH 30/32] iio:adc:ti-adc12138 Fix alignment issue with timestamp
Date:   Sun,  7 Jun 2020 16:54:06 +0100
Message-Id: <20200607155408.958437-31-jic23@kernel.org>
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

We move to a suitable structure in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak apart from previous readings. Note that previously
no leak at all could occur, but previous readings should never
be a problem.

Fixes: 50a6edb1b6e0 ("iio: adc: add ADC12130/ADC12132/ADC12138 ADC driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc12138.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-adc12138.c b/drivers/iio/adc/ti-adc12138.c
index e485719cd2c4..16f4fd7a04d9 100644
--- a/drivers/iio/adc/ti-adc12138.c
+++ b/drivers/iio/adc/ti-adc12138.c
@@ -47,6 +47,8 @@ struct adc12138 {
 	struct completion complete;
 	/* The number of cclk periods for the S/H's acquisition time */
 	unsigned int acquisition_time;
+	 /* 16x 2 bytes ADC data + 8 bytes timestamp */
+	__be16 data[20] __aligned(8);
 
 	u8 tx_buf[2] ____cacheline_aligned;
 	u8 rx_buf[2];
@@ -329,7 +331,6 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adc12138 *adc = iio_priv(indio_dev);
-	__be16 data[20] = { }; /* 16x 2 bytes ADC data + 8 bytes timestamp */
 	__be16 trash;
 	int ret;
 	int scan_index;
@@ -345,7 +346,7 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 		reinit_completion(&adc->complete);
 
 		ret = adc12138_start_and_read_conv(adc, scan_chan,
-						   i ? &data[i - 1] : &trash);
+					i ? &adc->data[i - 1] : &trash);
 		if (ret) {
 			dev_warn(&adc->spi->dev,
 				 "failed to start conversion\n");
@@ -362,7 +363,7 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 	}
 
 	if (i) {
-		ret = adc12138_read_conv_data(adc, &data[i - 1]);
+		ret = adc12138_read_conv_data(adc, &adc->data[i - 1]);
 		if (ret) {
 			dev_warn(&adc->spi->dev,
 				 "failed to get conversion data\n");
@@ -370,7 +371,7 @@ static irqreturn_t adc12138_trigger_handler(int irq, void *p)
 		}
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data,
+	iio_push_to_buffers_with_timestamp(indio_dev, adc->data,
 					   iio_get_time_ns(indio_dev));
 out:
 	mutex_unlock(&adc->lock);
-- 
2.26.2

