Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D3FC433B4
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 17:03:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E767161477
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 17:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhEARDv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 May 2021 13:03:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231517AbhEARDu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:03:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB2F360FEB;
        Sat,  1 May 2021 17:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888580;
        bh=wnCZx9gNN9yoEAKP8Ko4hFMcSK3q0KZ1Tlg6Zl16aAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dch4v/rZ3hvYquOhq/FT+1IF28PPYVwSvIaMJzDuMyImpad/48oZJuyNBleefHPeG
         5IWKilerIWi7MLY2YFQYFesLD9iH+MPRPwzv8LJPAyZOBPcyZ5hvvwRDkADhvWIbow
         49wNQ45hueu9xogjyrfSayGDZExSJgpDScUr/YhO1BRdoW5fvrfv65qJ2htfiyDew3
         J7Dd7eAUQaEfG9C3pOw39zKkCV+FvYz/B6L+VzrsiokRd6k8I2hfccYughUpo4OYWM
         LzOmYazMhVQhWTdgdoCQ7sMAcbLHyykxQCgBMYJ45qUmVaVxjwfdzIs2BmKe1fvsD4
         XG2PrlxTqdxlA==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 06/19] iio: accel: stk8312: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:08 +0100
Message-Id: <20210501170121.512209-7-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210501170121.512209-1-jic23@kernel.org>
References: <20210501170121.512209-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

To make code more readable, use a structure to express the channel
layout and ensure the timestamp is 8 byte aligned.

Found during an audit of all calls of this function.

Fixes: 95c12bba51c3 ("iio: accel: Add buffer mode for Sensortek STK8312")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/accel/stk8312.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/stk8312.c b/drivers/iio/accel/stk8312.c
index 157d8faefb9e..c8b6915a757c 100644
--- a/drivers/iio/accel/stk8312.c
+++ b/drivers/iio/accel/stk8312.c
@@ -103,7 +103,11 @@ struct stk8312_data {
 	u8 mode;
 	struct iio_trigger *dready_trig;
 	bool dready_trigger_on;
-	s8 buffer[16]; /* 3x8-bit channels + 5x8 padding + 64-bit timestamp */
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		s8 chans[3];
+		s64 timestamp;
+	} scan;
 };
 
 static IIO_CONST_ATTR(in_accel_scale_available, STK8312_SCALE_AVAIL);
@@ -438,7 +442,7 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 		ret = i2c_smbus_read_i2c_block_data(data->client,
 						    STK8312_REG_XOUT,
 						    STK8312_ALL_CHANNEL_SIZE,
-						    data->buffer);
+						    data->scan.chans);
 		if (ret < STK8312_ALL_CHANNEL_SIZE) {
 			dev_err(&data->client->dev, "register read failed\n");
 			mutex_unlock(&data->lock);
@@ -452,12 +456,12 @@ static irqreturn_t stk8312_trigger_handler(int irq, void *p)
 				mutex_unlock(&data->lock);
 				goto err;
 			}
-			data->buffer[i++] = ret;
+			data->scan.chans[i++] = ret;
 		}
 	}
 	mutex_unlock(&data->lock);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
+	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
 					   pf->timestamp);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
-- 
2.31.1

