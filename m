Return-Path: <SRS0=4zHB=7U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEB2C433E0
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 252E92078C
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591545407;
	bh=GCmZkmjy0OcVhpEfdQZSCkwWib7UM+f/q0mWXYVqYKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=axkBDBlCjrvt0AFtKmILbJDIz919Xj1rBuq+7jnfy/bls57cl9A3ugmdCTk9p8f7H
	 E6ROIj1G2mhLhB+BIa1oftYNIg6r+eZAPH17DdcMx3J9dVQKfszvVdT+wvAjVXAQe6
	 G/udDbWfmZl/OUUznv/Y91rRMQ4jm7kJ8NK3Uz3w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgFGP4q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:56:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbgFGP4q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:46 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EBC5020748;
        Sun,  7 Jun 2020 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545405;
        bh=GCmZkmjy0OcVhpEfdQZSCkwWib7UM+f/q0mWXYVqYKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lyBviUq4XcPcCfJ9fhVPJCs95eGvVAPvUPvEgYteSFNoDAPZra5jQv3iNdY7CIvr7
         hNzb+iqJ70Gjoy2qOhodFuRs8NnfcO1k0kygZ1GTwL5t03B6sK1RgY+cGb6gZgC2hK
         xiUwJj25LTJ0HU7InE6KLp/vpm/Ebf6K7jDoYOds=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 23/32] iio:adc:ti-adc081c Fix alignment and data leak issues
Date:   Sun,  7 Jun 2020 16:53:59 +0100
Message-Id: <20200607155408.958437-24-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv().

This data is allocated with kzalloc so no data can leak apart
from previous readings.

The eplicit alignment of ts is necessary to ensure correct padding
on x86_32 where s64 is only aligned to 4 bytes.

Fixes: 08e05d1fce5c (" ti-adc081c: Initial triggered buffer support")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/ti-adc081c.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
index e44e7a40a36b..12b47dffeb3b 100644
--- a/drivers/iio/adc/ti-adc081c.c
+++ b/drivers/iio/adc/ti-adc081c.c
@@ -33,6 +33,12 @@ struct adc081c {
 
 	/* 8, 10 or 12 */
 	int bits;
+
+	/* Ensure natural alignment of buffer elements */
+	struct {
+		u16 channel;
+		s64 ts __aligned(8);
+	} scan;
 };
 
 #define REG_CONV_RES 0x00
@@ -128,14 +134,13 @@ static irqreturn_t adc081c_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adc081c *data = iio_priv(indio_dev);
-	u16 buf[8]; /* 2 bytes data + 6 bytes padding + 8 bytes timestamp */
 	int ret;
 
 	ret = i2c_smbus_read_word_swapped(data->i2c, REG_CONV_RES);
 	if (ret < 0)
 		goto out;
-	buf[0] = ret;
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
+	data->scan.channel = ret;
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.26.2

