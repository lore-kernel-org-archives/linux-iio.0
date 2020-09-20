Return-Path: <SRS0=gotz=C5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56049C43469
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137FF23119
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600601307;
	bh=JKDqm3oz8WwgGan8wic+HdnAcdKtCjdQZz0V4syC/xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dyBkjxFfAz6JiaNKAoWCR8D3hQfpe38HfK4RKyiJVnwag2cWRNO6OlEp5rQjOJOe5
	 AJYUVDe2qsG6lNRjfMfolDM2CIcQKq3TD/7NhLg0EGU8Z1sHVl7QZx1/cqOcm8selb
	 j4Sf1KD3dhkseViK42i4f/ORGcIY8o6vv4lhMkiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgITL20 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:28:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgITL20 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 07:28:26 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D79EF21D43;
        Sun, 20 Sep 2020 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600601305;
        bh=JKDqm3oz8WwgGan8wic+HdnAcdKtCjdQZz0V4syC/xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQ5bfiwtxubCnCETYxNHS5Y6LPlS48QRSv7Kdaa+NrmwTXe9GYIqLyk0Qffhv+YmV
         qIIvfoHrWKR/7qBsh9PW9E1HXR+UsE+IdmGCWOVIHM2rohq0mqPLsW2+Lce8qFXyce
         XdKncqAKrrCInYGnk/bPRiDl7YjMIB+SVM0VR9vk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH v4 2/8] iio:light:st_uvis25: Fix timestamp alignment and prevent data leak.
Date:   Sun, 20 Sep 2020 12:27:36 +0100
Message-Id: <20200920112742.170751-3-jic23@kernel.org>
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
moving to a suitable structure in the iio_priv()

This data is allocated with kzalloc() so no data can leak apart
from previous readings.

A local unsigned int variable is used for the regmap call so it
is clear there is no potential issue with writing into the padding
of the structure.

Fixes: 3025c8688c1e ("iio: light: add support for UVIS25 sensor")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4: Drop the pointless masking.

 drivers/iio/light/st_uvis25.h      | 5 +++++
 drivers/iio/light/st_uvis25_core.c | 8 +++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/st_uvis25.h b/drivers/iio/light/st_uvis25.h
index 78bc56aad129..283086887caf 100644
--- a/drivers/iio/light/st_uvis25.h
+++ b/drivers/iio/light/st_uvis25.h
@@ -27,6 +27,11 @@ struct st_uvis25_hw {
 	struct iio_trigger *trig;
 	bool enabled;
 	int irq;
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		u8 chan;
+		s64 ts __aligned(8);
+	} scan;
 };
 
 extern const struct dev_pm_ops st_uvis25_pm_ops;
diff --git a/drivers/iio/light/st_uvis25_core.c b/drivers/iio/light/st_uvis25_core.c
index a18a82e6bbf5..1055594b2276 100644
--- a/drivers/iio/light/st_uvis25_core.c
+++ b/drivers/iio/light/st_uvis25_core.c
@@ -232,17 +232,19 @@ static const struct iio_buffer_setup_ops st_uvis25_buffer_ops = {
 
 static irqreturn_t st_uvis25_buffer_handler_thread(int irq, void *p)
 {
-	u8 buffer[ALIGN(sizeof(u8), sizeof(s64)) + sizeof(s64)];
 	struct iio_poll_func *pf = p;
 	struct iio_dev *iio_dev = pf->indio_dev;
 	struct st_uvis25_hw *hw = iio_priv(iio_dev);
+	unsigned int val;
 	int err;
 
-	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, (int *)buffer);
+	err = regmap_read(hw->regmap, ST_UVIS25_REG_OUT_ADDR, &val);
 	if (err < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(iio_dev, buffer,
+	hw->scan.chan = val;
+
+	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan,
 					   iio_get_time_ns(iio_dev));
 
 out:
-- 
2.28.0

