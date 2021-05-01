Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02665C433ED
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D79C161481
	for <linux-iio@archiver.kernel.org>; Sat,  1 May 2021 17:03:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhEAREB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 1 May 2021 13:04:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231342AbhEAREA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 May 2021 13:04:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BABBD61494;
        Sat,  1 May 2021 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619888590;
        bh=cb947MlRix6Um6ZRErrxBvHMTuY5yhO85ZzuE7sEDDQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZNpWVsdt0uIatgkR//67Uvv4JCislNCDZi8IYWnFCQUytc+DvIxjl+EY+pjFLdyW
         +i9qJzYitjG/eyXPv3vfwMUqUhrcSvS7px3fpW0QW8TtFpk7+eHXv6HxK9UzdxrNpF
         1kEg7TXr//Pa3U1vs7VEZvpxSaFQ0LXNVuyf5iHXSsspgSeHvR6xGjTggpxaW7N0Oi
         TieefYxzUNRKIY851VRMhIdRAi3WLfXikOPeLl1NFm8pg9vBWeVR0ROLIOOtjxkHsf
         9mh5Nvo2Nxe9TFhXDO3vf5vdCPvLDN1ZRqkmxHR7LyrQJnM6RYRFasep7qlIoTEenu
         DRlvAoYypYTPQ==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andreas Klinger <ak@it-klinger.de>
Subject: [PATCH 12/19] iio: prox: srf08: Fix buffer alignment in iio_push_to_buffers_with_timestamp()
Date:   Sat,  1 May 2021 18:01:14 +0100
Message-Id: <20210501170121.512209-13-jic23@kernel.org>
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

Found during an audit of all calls of uses of
iio_push_to_buffers_with_timestamp()

Fixes: 78f839029e1d ("iio: distance: srf08: add IIO driver for us ranger")
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andreas Klinger <ak@it-klinger.de>
---
 drivers/iio/proximity/srf08.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 70beac5c9c1d..9b0886760f76 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -63,11 +63,11 @@ struct srf08_data {
 	int			range_mm;
 	struct mutex		lock;
 
-	/*
-	 * triggered buffer
-	 * 1x16-bit channel + 3x16 padding + 4x16 timestamp
-	 */
-	s16			buffer[8];
+	/* Ensure timestamp is naturally aligned */
+	struct {
+		s16 chan;
+		s64 timestamp __aligned(8);
+	} scan;
 
 	/* Sensor-Type */
 	enum srf08_sensor_type	sensor_type;
@@ -190,9 +190,9 @@ static irqreturn_t srf08_trigger_handler(int irq, void *p)
 
 	mutex_lock(&data->lock);
 
-	data->buffer[0] = sensor_data;
+	data->scan.chan = sensor_data;
 	iio_push_to_buffers_with_timestamp(indio_dev,
-						data->buffer, pf->timestamp);
+					   &data->scan, pf->timestamp);
 
 	mutex_unlock(&data->lock);
 err:
-- 
2.31.1

