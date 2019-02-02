Return-Path: <SRS0=e/h2=QJ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC3C282D7
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D2E2084A
	for <linux-iio@archiver.kernel.org>; Sat,  2 Feb 2019 21:56:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="PpFpUjQ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfBBV41 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 2 Feb 2019 16:56:27 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44853 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbfBBV41 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2019 16:56:27 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so4990660pfh.11
        for <linux-iio@vger.kernel.org>; Sat, 02 Feb 2019 13:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1boX/x+e8zIPyMRDJMyViHJFELThRLCZN0kTeGhnnB8=;
        b=PpFpUjQ0zrjYqTg53RgiyUDLI574JQwIqJE5RPAgMXa6ya7RELJxzTzqzaaHLieenZ
         TSiyFWSDJIjAYTEP20XSBYAw/To588n8LxMTOwQvOYMd9yz1uzPOYAtgUHWN75Ti2qPh
         nDgCYg/chjjplKdKoqmGykzS0BtOy0IE7sS0ksjNFLzPyQEs8crrWvvd03nJ7677tW5k
         2O78vflNuu2L/h5laUj9SWmxtaquPBaAzDWmguucDhHhF7BxHpeBF/bfoPV68pEThPsE
         OZ1ubb/dSkcIi37WHzz2iXffS6gP/kIyo5WekRMYvx9dHj2QIgKSsyzWwWOz0GcX4g68
         XwyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1boX/x+e8zIPyMRDJMyViHJFELThRLCZN0kTeGhnnB8=;
        b=YsWhhIBhIKFNj9ZieHGh6eKbSwZrul05IFN9M1MiqO735R3dmKrEmxPHczGUxrrg0R
         EYC4KiL8IrZE438wXzZe83Ynyv+Ml50nqMhzYOtyzyjJ+hCkQc+uddEn+Cbh4utoC7cu
         iLr48DJuMwgjhS6nTlu1w7NIl8MMifV6Ex7heKgZd95hWBQHTIGYb/emW2daKAZvoW6v
         QsiLvRaRFTmmTPD0Px9867CxmSSj7CcPFG2Ib7FRiBDBAeaTor0iUMbDVxdP6itsZUMm
         eXPwtDAYTj0g07xf2x9/JgrjJxaOEydoLcziiAHxmAQ5Fym7gZiPP+279F+1DxuFR2zW
         xjRg==
X-Gm-Message-State: AHQUAuZ4BA0+dvaofa4idQQ1tCq3kl1dsG2g8MsOG+bIww2GMzjh3rJI
        +TWAZAa16+miJj94Tr0F+hkfc4+bF+o=
X-Google-Smtp-Source: AHgI3IYTbwlcdsjvng9l5XoPJWq2doU4juZAeASUxScc5PXGtHFZfc/J5j99GleXCd3J95yPrwe7lg==
X-Received: by 2002:a63:b34f:: with SMTP id x15mr7551849pgt.243.1549144586454;
        Sat, 02 Feb 2019 13:56:26 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id z127sm20082025pfb.80.2019.02.02.13.56.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 13:56:25 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org, Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v4 5/6] iio:bmi160: use iio_pollfunc_store_time
Date:   Sat,  2 Feb 2019 13:56:00 -0800
Message-Id: <20190202215601.20275-6-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190202215601.20275-1-martin@martingkelly.com>
References: <20190202215601.20275-1-martin@martingkelly.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Martin Kelly <martin@martingkelly.com>

Currently, we snap the timestamp after reading from the buffer and
processing the event. When the IIO poll function is triggered by an
interrupt,  we can get a slightly more accurate timestamp by snapping it
prior to reading the data, since the data was already generated prior to
entering the trigger handler. This is not going to make a huge difference,
but we might as well improve slightly.

Do this by using iio_pollfunc_store_time as other drivers do.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index 007f7c532ac4..f3c5b86a281e 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -425,8 +425,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 		buf[j++] = sample;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, pf->timestamp);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
@@ -834,7 +833,8 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &bmi160_info;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+					      iio_pollfunc_store_time,
 					      bmi160_trigger_handler, NULL);
 	if (ret < 0)
 		return ret;
-- 
2.11.0

