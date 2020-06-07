Return-Path: <SRS0=4zHB=7U=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A50CC433DF
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D2B620723
	for <linux-iio@archiver.kernel.org>; Sun,  7 Jun 2020 15:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591545377;
	bh=gz5kZNLwrLpN0degyhBiEQQPZnWilh2D4G1LHb3gwX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xaxzRxfK92+X/jTfnlPqhAMppZ0wzo4GtSf4iVg3Ma1GRHGRrHaux5okSclTuxcqK
	 RAvq5R11kzsZWFb93kZ16S8IkLVG/xveko0N6b9/ldSOHxIgUJBM0aAncnMmsiaZw/
	 YVemsMGTLYTFxxJUbrUIQyaCMbKVr+bs/ag7BMFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgFGP4Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgFGP4Q (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jun 2020 11:56:16 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39353206C3;
        Sun,  7 Jun 2020 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591545376;
        bh=gz5kZNLwrLpN0degyhBiEQQPZnWilh2D4G1LHb3gwX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y5zuM/TcZfkwfaJlsdU9cmUWPHk+3U7Juvggftv7Dim7t/q5kohWB9oyWbKS5lV7v
         tsexgbTExdUo+YvwXMaNuK5Z3oOfWC4uqT7psrBlw5fFXyfx+26c02sYMjSYKbIBBZ
         qMYC3chxMYUt4Ev5uQJRoKQ5mHsYvsi73CT0SI9Y=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 01/32] iio: accel: kxsd9: Fix alignment of local buffer.
Date:   Sun,  7 Jun 2020 16:53:37 +0100
Message-Id: <20200607155408.958437-2-jic23@kernel.org>
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

iio_push_to_buffers_with_timestamp assumes 8 byte alignment which
is not guaranteed by an array of smaller elements.

Note that whilst in this particular case the alignment forcing
of the ts element is not strictly necessary it acts as good
documentation.

Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/kxsd9.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 63b1d8ee6c6f..85e3c46494d3 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -209,14 +209,20 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 	const struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct kxsd9_state *st = iio_priv(indio_dev);
+	/*
+	 * Ensure correct positioning and alignment of timestamp.
+	 * No need to zero initialize as all elements written.
+	 */
+	struct {
+		__be16 chan[4];
+		s64 ts __aligned(8);
+	} hw_values;
 	int ret;
-	/* 4 * 16bit values AND timestamp */
-	__be16 hw_values[8];
 
 	ret = regmap_bulk_read(st->map,
 			       KXSD9_REG_X,
-			       &hw_values,
-			       8);
+			       hw_values.chan,
+			       sizeof(hw_values.chan));
 	if (ret) {
 		dev_err(st->dev,
 			"error reading data\n");
@@ -224,7 +230,7 @@ static irqreturn_t kxsd9_trigger_handler(int irq, void *p)
 	}
 
 	iio_push_to_buffers_with_timestamp(indio_dev,
-					   hw_values,
+					   &hw_values,
 					   iio_get_time_ns(indio_dev));
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
2.26.2

