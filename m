Return-Path: <SRS0=BsLG=PW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75140C43387
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46276206B7
	for <linux-iio@archiver.kernel.org>; Mon, 14 Jan 2019 03:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="LnkpAssK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfAND4s (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:56:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37394 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbfAND4s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Jan 2019 22:56:48 -0500
Received: by mail-pl1-f195.google.com with SMTP id b5so9502592plr.4
        for <linux-iio@vger.kernel.org>; Sun, 13 Jan 2019 19:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sY6D3nJrPNk6hjxFulqaRdI0rgmo/bhPApL6m8Dg1pQ=;
        b=LnkpAssKZnPgRh5pQnixanacbQ2eHfRVM2AOqjqf1Pj4B76zZyEwh+NpG7GbO1NBwq
         Cqf3+0nGlKdxv0G2aDFd4Alkt2YskCBalQB+Q3yx3mQx6I0Z6CebKZpBveDMla+Rfmw7
         JU8eiC9WRlKEVzOTPbI4CMJHFg2xQKHj71hEJHArtGBfPQxhIotoZopVgTuOhOwN2rLz
         AqBvigI3C7/gk+6CbbLeE/gKilVsQFk4IausPzfBTW4ukfd2w2WIog1pk5eU3VV7umyX
         ixxl97TarZGwWzweB032Cyg2ZW0nwwxuTTvC/znIYvyizmfYzF0PWtcZVzmGqdS814Zb
         NZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sY6D3nJrPNk6hjxFulqaRdI0rgmo/bhPApL6m8Dg1pQ=;
        b=CiGsriPx5Ze4wB2l4cqFjpSl7NS7l+TgVtRCc9lA0XqBdAkCU4ir0GrPiFvnA9XGxS
         iAJ9NGB4fjrMFVFaRxjBRNOHL7r+Xjfr13O5jSG8gRON2cMSutePSqoIQCg2LqtTcdk0
         vp3sHptB+HtZc/gLkIcavUcop6ARfiInF0BbRCIfs+9ff3RzSiYd2BIRkW3OjYStCnJu
         fOrlumlAXfPXl70NkiNocRSYK03Hn/EKgAfZbT7cYj3xz5F3ybuYkLCSh67j4swr15mJ
         NdK119LAtb5clDMAWvheAzZ+e55S52y+yXYpcrlY/8ej+Ng05Ub8mscKXnvaGSmx+kgF
         PpuA==
X-Gm-Message-State: AJcUukdj56DjqmOytG4dDQWZgCwEXmZL4q7kTEYgrmvP0l92VS30E806
        WwQu5ADSFivCG0I1U/G+7jC89aQGKXQ=
X-Google-Smtp-Source: ALg8bN7dJBzxjN6JXMy/UpRgq0ZSTNFIKHCAF9TzA91WqCdm+9MEJBysNMQVLH7eDLbher13kCxoKw==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr23997924plo.112.1547438207232;
        Sun, 13 Jan 2019 19:56:47 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id l70sm93582741pgd.20.2019.01.13.19.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 19:56:46 -0800 (PST)
From:   Martin Kelly <martin@martingkelly.com>
X-Google-Original-From: Martin Kelly <martin@martingkelly.com
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Martin Kelly <martin@martingkelly.com>
Subject: [PATCH 5/5] iio:bmi160:snap timestamp closer to event
Date:   Sun, 13 Jan 2019 19:56:21 -0800
Message-Id: <20190114035621.5252-6-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190114035621.5252-1-martin@martingkelly.com>
References: <20190114035621.5252-1-martin@martingkelly.com>
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

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index e119965e64a3..4b4456af0971 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -408,6 +408,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
+	s64 ts = iio_get_time_ns(indio_dev);
 	struct bmi160_data *data = iio_priv(indio_dev);
 	__le16 buf[16];
 	/* 3 sens x 3 axis x __le16 + 3 x __le16 pad + 4 x __le16 tstamp */
@@ -423,8 +424,7 @@ static irqreturn_t bmi160_trigger_handler(int irq, void *p)
 		buf[j++] = sample;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev, buf,
-					   iio_get_time_ns(indio_dev));
+	iio_push_to_buffers_with_timestamp(indio_dev, buf, ts);
 done:
 	iio_trigger_notify_done(indio_dev->trig);
 	return IRQ_HANDLED;
-- 
2.11.0

