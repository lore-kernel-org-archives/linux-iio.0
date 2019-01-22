Return-Path: <SRS0=dXrR=P6=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3706DC37122
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062C8217D4
	for <linux-iio@archiver.kernel.org>; Tue, 22 Jan 2019 02:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="FwoyFzPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfAVCEv (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:04:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35740 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfAVCEv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Jan 2019 21:04:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so10970478pfi.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Jan 2019 18:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9zzj010WZSA0DL8/MImmeoLSgz4mP+VjZ9gv0MeoU+w=;
        b=FwoyFzPEhEtPFTClZPJ13OV5As4/KezduvnhQ3x7h5Pxm6UEIr0Lf5Z4/6vhBIdtsv
         dJvrhAv08XMPqL6ICpVmfxtIiDPuLi3XUGpesetQZ9INs0tkn24IhZzzHbWfu2JDXZiB
         OQViCwe+4RkWaZjN5EahkjltOQxBKZbAG2MiR4zJwI7fxKcgf3M5hjS2Rczaf63bLLup
         /2MmJK+xwUWRYtEWbhYoyz45NfHohTth6tZjYzkr/VSU5xqzzJA/aDsu1rS+kF5m7epu
         N/WRIcU/+S62att/5ZBupIZ/EqLHP786+EGN3rcIbeLUzCGrU0LREHAga1NlrC0KkFuv
         oI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9zzj010WZSA0DL8/MImmeoLSgz4mP+VjZ9gv0MeoU+w=;
        b=fvOsb8GBe0E5nFfiubqfNEFgaPc1OSQE+MzY+lBk1j5iwOj0L7g43wfNlXDdf4cSI6
         7Inghae3JO5VEqECU29nXsu1qpluY/8MnRLcJnP3wECH1JGU3d+CfcxD57oF3nYd2QSH
         slHT8WhBcAqKxNQiQ2mjD3QQ50lE2boQIw92Xjej7hz9qOcxAmPQQK6aW7RyIauaq9d9
         ndjyIeBfufZt3c/p7Y3DOwB5eXx1TbZaLS1uZtNeq+UrlA7URnlgyIuwY6LN88yJQEzt
         UhC9C7EgDeqBYR5pWDtjFslT9v4fg4dlEhzZRg4kmW+Cz8iCkScVteRAazlOR/OoFcpK
         VCiw==
X-Gm-Message-State: AJcUukcVeRe+faPd2ylYJlvN61EquPP9JCp+8NmAk96UY3ZCoQ/f88dz
        h1FnRopUSe+LN8McB3TY9TEtqyThRZ8=
X-Google-Smtp-Source: ALg8bN4lDgDhoTiVS67Oa2Aojw4NI+Dy8/9KDcGwoomlJV7jmZ0N6zhh4irdb0uj+gjtL8rh78I/5w==
X-Received: by 2002:a62:26c7:: with SMTP id m190mr32277206pfm.79.1548122689923;
        Mon, 21 Jan 2019 18:04:49 -0800 (PST)
Received: from cascade.Home (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id n21sm19759404pfg.84.2019.01.21.18.04.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 18:04:49 -0800 (PST)
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
Subject: [PATCH v2 5/6] iio:bmi160: use iio_pollfunc_store_time
Date:   Mon, 21 Jan 2019 18:04:30 -0800
Message-Id: <20190122020431.5338-5-martin@martingkelly.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190122020431.5338-1-martin@martingkelly.com>
References: <20190122020431.5338-1-martin@martingkelly.com>
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
v2:
- Use iio_pollfunc_store_time.

 drivers/iio/imu/bmi160/bmi160_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index c848fc1bce61..dca53be066e1 100644
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
@@ -854,7 +853,8 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
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

