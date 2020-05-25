Return-Path: <SRS0=I6G3=7H=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF22C433E0
	for <linux-iio@archiver.kernel.org>; Mon, 25 May 2020 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71E9C208A7
	for <linux-iio@archiver.kernel.org>; Mon, 25 May 2020 17:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590426558;
	bh=QiHTxdk/MwrRdHI4WdZKznL5IopXuhyAOipatDZDTg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2swOq1gnrrUuwExLSI7nvcwaJMNNn01pgE/UOD6cdAXNs7IIqm0vn3mX2Z8OAPeMi
	 CamPRs57U94LV2LZy29rw52Q5RiWS8Fg6Y7YLbCD+TXIs4f/4KMrfFQm+r4VVy+/nW
	 YPPmQe9EeoXLzsKiJc3jDw8zwR10wIVZoT2Zc6DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391288AbgEYRJP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 25 May 2020 13:09:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391279AbgEYRJO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 25 May 2020 13:09:14 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A1A20723;
        Mon, 25 May 2020 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590426553;
        bh=QiHTxdk/MwrRdHI4WdZKznL5IopXuhyAOipatDZDTg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y6gd+0opL5Dzu0FhCf7tdStObZJddWb76eHboUOjFuBLWoKNSBomE8Pk20CWbrCKj
         sU48rvEpg9iwdkY/y/j7ACTkK1QnPFgGsQiAwl0I21ZM8tGRnySn2WgNAhWwVERkw1
         K83g686WrJUeWChax57BYAOzEIpcDGV7axQdf8Lk=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: [PATCH 11/25] iio:imu:bmi160 Fix alignment and data leak issues
Date:   Mon, 25 May 2020 18:06:14 +0100
Message-Id: <20200525170628.503283-12-jic23@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525170628.503283-1-jic23@kernel.org>
References: <20200525170628.503283-1-jic23@kernel.org>
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
moving to a suitable array in the iio_priv() data with alignment
explicitly requested.  This data is allocated with kzalloc so no
data can leak apart from previous readings.

Fixes: 77c4ad2d6a9b ("iio: imu: Add initial support for Bosch BMI160")
Reported-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta  <daniel.baluta@gmail.com>
---
 drivers/iio/imu/bmi160/bmi160.h      | 2 ++
 drivers/iio/imu/bmi160/bmi160_core.c | 5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 621f5309d735..fa071d9230ec 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -7,6 +7,8 @@
 struct bmi160_data {
 	struct regmap *regmap;
 	struct iio_trigger *trig;
+	/* Ensure natural alignment for timestamp if present */
+	__le16 buf[16] __aligned(8);
 };
 
 extern const struct regmap_config bmi160_regmap_config;
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 6af65d6f1d28..81977d427687 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -411,7 +411,6 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bmi160_data *data = iio_priv(indio_dev);
-	__le16 buf[16];
 	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
 	int i, ret, j = 0, base = BMI160_REG_DATA_MAGN_XOUT_L;
 	__le16 sample;
@@ -422,10 +421,10 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 				       &sample, sizeof(sample));
 		if (ret)
 			goto done;
-		buf[j++] = sample;
+		data->buf[j++] = sample;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
+	iio_push_to_buffers_with_timestamp(indio_dev, data->buf, pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.26.2

