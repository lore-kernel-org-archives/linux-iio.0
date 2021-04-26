Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34DDC433B4
	for <linux-iio@archiver.kernel.org>; Mon, 26 Apr 2021 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C25861026
	for <linux-iio@archiver.kernel.org>; Mon, 26 Apr 2021 17:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhDZRFH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 26 Apr 2021 13:05:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235135AbhDZRFG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Apr 2021 13:05:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C9CE3613AA;
        Mon, 26 Apr 2021 17:04:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619456665;
        bh=um7xTbcfIkZ3pU67vL/jR1erRTfwDGHwZ8NDAi54i18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I2GFUxzGhZV4V8FnHjBR+zB8bfiE4ZNFUPK03L6Cca3jS5ISscQpegI61BS0aj9SL
         ohmi2U4Qus6tlbI57BIxAulbQplPoFY0VEAI0Pq68oHEGnCH5vRJxOP7VkQ2kTmCBg
         B+WT6U0lcf/KUk6aq2ARvz/VpQzhv0KSSRSZshIRy07qxpITBA2nfn4ROT565sZNDk
         7fGifR5ZrN2hapbjlBzUyMeUX1snInhBhHm0rUuTJlTVNC/hXrxPsdIy3dxnQD4dSv
         nXi/bg3nqfoBhYRX/grVq6Ww8nlT79VznW+2XKXpWr8HJdAICo8KWTwLTyM592GkWo
         hpsyK2lnfxD1A==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jyoti Bhayana <jbhayana@google.com>
Subject: [PATCH 8/8] iio: common: scmi_sensors: Drop duplicate setting of iio_dev.dev.parent
Date:   Mon, 26 Apr 2021 18:02:51 +0100
Message-Id: <20210426170251.351957-9-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210426170251.351957-1-jic23@kernel.org>
References: <20210426170251.351957-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This is already set to the same value in devm_iio_device_alloc()

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jyoti Bhayana <jbhayana@google.com>
---
 drivers/iio/common/scmi_sensors/scmi_iio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/common/scmi_sensors/scmi_iio.c b/drivers/iio/common/scmi_sensors/scmi_iio.c
index 63e4cec9de5e..16f0526ff01a 100644
--- a/drivers/iio/common/scmi_sensors/scmi_iio.c
+++ b/drivers/iio/common/scmi_sensors/scmi_iio.c
@@ -544,7 +544,6 @@ static struct iio_dev *scmi_alloc_iiodev(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	iiodev->modes = INDIO_DIRECT_MODE;
-	iiodev->dev.parent = dev;
 	sensor = iio_priv(iiodev);
 	sensor->handle = handle;
 	sensor->sensor_info = sensor_info;
-- 
2.31.1

