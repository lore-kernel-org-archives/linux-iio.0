Return-Path: <SRS0=gotz=C5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59BEC43466
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 11:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D58235F9
	for <linux-iio@archiver.kernel.org>; Sun, 20 Sep 2020 11:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600601311;
	bh=fm7sgvvsHrieUik4TkM1qthsRkZi6ZzJbpsGAr/QaxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CKnL4UmZgPOECP08BQuxLdZjqswx5fB4s3L+aug7qoUs165AF4Cvo3mgPQ4D+EFLP
	 2BECMgbruWD7zotHYALGdAEChevNSlE+4nS7TriyEmLiZyD3advvWiqTr9zdDfkS6a
	 9Dbx0TtAqyBcH1pkviccfFy0Tqr094fsh1lp4ruM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgITL2a (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 20 Sep 2020 07:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgITL23 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Sep 2020 07:28:29 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B53C1221EC;
        Sun, 20 Sep 2020 11:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600601308;
        bh=fm7sgvvsHrieUik4TkM1qthsRkZi6ZzJbpsGAr/QaxI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A2taVisEOEWaeYEiAbNQCEOtXVPivmsTYGy2FhU5ItM8+mlRdqQSuFeXS9qrHZGP5
         c0vR05JLobfQaSpwS2D2Li7rNKLemTXcufh5IYrLQaxwYK90JkUdCM+2hRm0mlBfnq
         IteUBwHPvjtHoYTa8RAG0muxNzl8iDbJbR0jxjnc=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Daniel Baluta <daniel.baluta@oss.nxp.com>
Subject: [PATCH v4 4/8] iio:imu:bmi160: Fix too large a buffer.
Date:   Sun, 20 Sep 2020 12:27:38 +0100
Message-Id: <20200920112742.170751-5-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200920112742.170751-1-jic23@kernel.org>
References: <20200920112742.170751-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

The comment implies this device has 3 sensor types, but it only
has an accelerometer and a gyroscope (both 3D).  As such the
buffer does not need to be as long as stated.

Note I've separated this from the following patch which fixes
the alignment for passing to iio_push_to_buffers_with_timestamp()
as they are different issues even if they affect the same line
of code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta <daniel.baluta@oss.nxp.com>
---
 v4: New patch
 drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 222ebb26f013..39fea58dd308 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -427,8 +427,8 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi160_data *data = iio_priv(indio_dev);
-	__le16 buf[16];
-	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
+	__le16 buf[12];
+	/* 2 sens x 3 axis x __le16 + 2 x __le16 pad + 4 x __le16 tstamp */
 	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
 	__le16 sample;
 
-- 
2.28.0

