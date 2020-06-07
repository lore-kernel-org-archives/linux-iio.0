Return-Path: <SRS0=4zHB=7U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3ADCC433E1
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE3820748
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591545378;
	bh=rjkMoZ+extP8HeW0stl/HFc3GphsLQokQhYBIPctZwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Q8PcjxgueCYrZmAP9vbwFm1aRW7mJPokw1iQ792Va5j6zsdPCBn6t/SCLBqP2RSUa
	 ij6koN4eicdJJvUceDKSm+l+/XFWJsjoJhhAE++jU7ZYySfS5ktSh1T4nqyhSZsvYJ
	 wAiPGFv24c8qQ5zZ1sHs2ecXHKuN3+ow3xXiu9Oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgFGP4S (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:56:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:57214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgFGP4R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:17 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75431206F6;
        Sun,  7 Jun 2020 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545377;
        bh=rjkMoZ+extP8HeW0stl/HFc3GphsLQokQhYBIPctZwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vNn4Oj4vlCHoKlElHFf7stKqE3MbCIzQoCiTEGw7KCYAe19GR37rGf1V8lq1rQ8Wc
         YZ1wuK/1tO1i1iecKwLvufxUuHKvIrcqN/0O3f53bEe0oRnwUWeZ78eRN+4g3lzQnY
         bFRStZsBBY0cMUR+76o+SdlJG6P0sBIHV6bW6zDs=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 02/32] iio:accel:mma8452: Fix timestamp alignment and prevent data leak.
Date:   Sun,  7 Jun 2020 16:53:38 +0100
Message-Id: <20200607155408.958437-3-jic23@kernel.org>
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
this driver which uses a 16 byte u8 array on the stack.  As Lars also noted
this anti pattern can involve a leak of data to userspace and that
indeed can happen here.  We close both issues by moving to
a suitable structure in the iio_priv() data with alignment
ensured by use of an explicit c structure.  This data is allocated
with kzalloc so no data can leak appart from previous readings.

The additional forcing of the 8 byte alignment of the timestamp
is not strictly necessary but makes the code less fragile by
making this explicit.

Fixes: c7eeea93ac60 ("iio: Add Freescale MMA8452Q 3-axis accelerometer driver")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/mma8452.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index ef3df402fc3c..e58fcc3741c4 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -110,6 +110,12 @@ struct mma8452_data {
 	int sleep_val;
 	struct regulator *vdd_reg;
 	struct regulator *vddio_reg;
+
+	/* Ensure correct alignment of time stamp when present */
+	struct {
+		__be16 channels[3];
+		s64 ts __aligned(8);
+	} buffer;
 };
 
  /**
@@ -1091,14 +1097,13 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mma8452_data *data = iio_priv(indio_dev);
-	u8 buffer[16]; /* 3 16-bit channels + padding + ts */
 	int ret;
 
-	ret = mma8452_read(data, (__be16 *)buffer);
+	ret = mma8452_read(data, data->buffer.channels);
 	if (ret < 0)
 		goto done;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->buffer,
 					   iio_get_time_ns(indio_dev));
 
 done:
-- 
2.26.2

