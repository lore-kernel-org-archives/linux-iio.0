Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13297C64E7B
	for <linux-iio@archiver.kernel.org>; Mon, 30 Nov 2020 13:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C6E207BC
	for <linux-iio@archiver.kernel.org>; Mon, 30 Nov 2020 13:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UkYd4P8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726038AbgK3NAK (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgK3NAJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 30 Nov 2020 08:00:09 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A766FC0617A6
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 04:59:22 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id d8so21470940lfa.1
        for <linux-iio@vger.kernel.org>; Mon, 30 Nov 2020 04:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xJeOVTG5F26MdxiNKUbGPzQrznC/foMB5ulLxGtVms=;
        b=UkYd4P8ZNMnjejELWQKDVzWklvGlpBBBXZ/nMr0RBX6Rg1fIb/52c9MyksrJ7Oj/wN
         oBiohZ0Y4/9adc2GuexM/nvwJIzHQwKbo1pVCxo6W6S5tBaRhDGvcNEgyFShPw7lQXZ7
         kuRpOrsnudwJR1YMMcA3Tq/aegy33FGAkSlPTmwVZbXYZm4NCX562v8LQGopN1QRoLrW
         2btnOrJYgtQLXqnm7kMWBzZZzTNpIccoEI5jIkfUaXin+cES/NAg8CcYSK0/XMhj6wDK
         tPJ/451Pv4gXwR1Nmix22r6wNWGjDmEF23js9jqP5CPm3IjbPCBJfTqGQK8FTQpWqZNd
         piMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xJeOVTG5F26MdxiNKUbGPzQrznC/foMB5ulLxGtVms=;
        b=j0eZPQM6PT1M1UCP5+gLCBabljIM4oFU5JXljcRF8gm9Ef/RkF3tHMSCVkWqvZPavv
         viWYDtiLW/pu3UYvQfQFMm3V/ZLU33jfEMVG4phDaUo3XFfpatSiEWlZ/WBnVzgWZHGo
         JDPTM/n1fBkeRPiM8R4zGHOqZl725Ar3yQAI2ZFE5HtZ2ybHgRbkMgpJ6iazDTH0TkNM
         TUHjt3Pi28zO010jazFCjJ434C4JM1knZv1oBBgOuZjW1WcOo9K0yNs1K2H9f+qv2IMG
         ebPORi649SXy0TWsRqZ3KCkvTy9OkHIKORMxMzn+8jDTrgFwr+J0PYCqiyF1KWjAEodP
         dleQ==
X-Gm-Message-State: AOAM531Rrt6XM1MKQIQ0XZrSzzE+IDNikvp9xjofVczfmLclGGwvvRC2
        gtDOLN/lBdSbqpXDxdiDA7pqoQ==
X-Google-Smtp-Source: ABdhPJxI8eKQCUSePsjlPc+MMUOSP8Rm5dDcGeP1FNo16TLsrNlVIG8cZNqRRZxRwWbt1/SmGJRaqg==
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr8565559lff.174.1606741161190;
        Mon, 30 Nov 2020 04:59:21 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id y28sm2949671ljn.18.2020.11.30.04.59.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 04:59:20 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] iio: gyro: mpu3050: Store timestamp in poll function
Date:   Mon, 30 Nov 2020 13:59:15 +0100
Message-Id: <20201130125915.1315667-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201130125915.1315667-1-linus.walleij@linaro.org>
References: <20201130125915.1315667-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

If something other than the MPU3050 itself is using this
trigger, the timestamp needs to be stored in the poll
function.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 0d0850945d3a..b892487394ea 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -457,7 +457,7 @@ static int mpu3050_write_raw(struct iio_dev *indio_dev,
 
 static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 {
-	const struct iio_poll_func *pf = p;
+	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 	int ret;
@@ -482,6 +482,9 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 	else
 		timestamp = iio_get_time_ns(indio_dev);
 
+	/* Someone else may be using us as trigger */
+	pf->timestamp = timestamp;
+
 	mutex_lock(&mpu3050->lock);
 
 	/* Using the hardware IRQ trigger? Check the buffer then. */
-- 
2.26.2

