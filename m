Return-Path: <SRS0=pB1S=QD=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB0C282CA
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:40:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B824E21721
	for <linux-iio@archiver.kernel.org>; Sun, 27 Jan 2019 20:40:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="XE02BRbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfA0Ukj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 27 Jan 2019 15:40:39 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42428 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727133AbfA0Ukj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Jan 2019 15:40:39 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so7039857pfr.9
        for <linux-iio@vger.kernel.org>; Sun, 27 Jan 2019 12:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TtrkNJaC1CsUynrxEJE4lhjXyuJShRlDOow8RSN/bhk=;
        b=XE02BRbmVUUFxt5kerqISSrqG/cacZfPf+1sCRmglqoxOtOiZW1l+8ojkRhx4WTLoa
         tY7ZbyOasCo2UohNjnhpukco0BBk5RX9JPKuFqzYoo8odXm/AT/m9myYMuF6F5lIHmx5
         SWQfqdJD2y4DjWXna+RkcBzyUOv5y6dztBzPlVQ6i7qeaH6B1zJyrRuNDsuOLVc/4Y3T
         mAb5GPe6KVaEPyRam5LNIVHe4aO7RqdC8akY9g7teKLRErnI6uI6mIydyoEmSD+hNmMp
         jrBIYoyszEVFYj4u2Atg1tjPdAXujP5TQwiM5oe3IXS3U7bIHkrluIs1/CRk9pgXSLqy
         G5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TtrkNJaC1CsUynrxEJE4lhjXyuJShRlDOow8RSN/bhk=;
        b=Sg3/5G9uDeXRrrcdosxn3yYOnuvRwx1m5+eDx9puwhNHfGVW8Zbicu+qAxYHm81zT+
         ff3ebaVh2yhgAsMhT24j1fIrdLlcuQjW9hGL0gwBN+6qdvt6s8cb1ktTcVNZFjGBi79q
         0M6kQClPCBUCkCrfru1A9d6GCdLAHzU9y9H4jCTFVvTgHlfhEyquS1icVKfEAyQ8Q85j
         VYj08LiPPw6XhBG/iFcVMe5nFJNYGPRKSfRlBDo2Q3ahLgImoQZCHrEXFTx7tmAnMuq2
         4HvX29ZhunU/H/ej5nKzF4B2vUXJKuaO85BsK8uRul1NyDfUziaTLv8NAgKIDTyUh+CZ
         jCHQ==
X-Gm-Message-State: AJcUukc9ewwTJIfefp6LC2Qx78puzrCHjHjde1oItAn7XvojNKg6Kd5T
        yK8BBlIY57euJ2VS6DCu/rArtPntw4Op8g==
X-Google-Smtp-Source: AHgI3IaPSyuSlh5b/wt/XWKXoP7d7g7IGZO4Uv3teT4a2EDaszFvH6OQM19bgJDOFj1yFf8Ekt42OA==
X-Received: by 2002:a62:5007:: with SMTP id e7mr7084021pfb.92.1548621637642;
        Sun, 27 Jan 2019 12:40:37 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id a4sm33049912pgv.70.2019.01.27.12.40.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 12:40:37 -0800 (PST)
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
Subject: [PATCH v3 5/6] iio:bmi160: use iio_pollfunc_store_time
Date:   Sun, 27 Jan 2019 12:39:10 -0800
Message-Id: <20190127203911.8696-6-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190127203911.8696-1-martin@martingkelly.com>
References: <20190127203911.8696-1-martin@martingkelly.com>
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
index 70739e3920af..de36fe20e023 100644
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

