Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929EAC433E6
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 18:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCF864EE3
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 18:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbhCNSSP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Mar 2021 14:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233369AbhCNSRn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 14:17:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C431064EC4;
        Sun, 14 Mar 2021 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615745863;
        bh=QEaaza3BOatkIZQJ9jfysAynQ6mv9r/zhgtGm6LhEHg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=guw/xjtrM2v/oiEad2cm57UtSM0/s0Vt+0otR9+tz/KmwwvOHP22j8MpSYFhKTSVQ
         ql/faaZQdBePXcxwuAgN/FBNXuvPg4YzzqW0WUGOf4PD7f9U2f68FfTDh1rLOtvz1u
         khPvAxeF1TJ1t+yrwuEvlUj2DcXsUhjUi35RoqBpuWKHInweX7Y8oDoT6RzZ49UMNN
         J0YqyCeFjyGDK7LTdVOPQQU7nhhEJ+fbrIMYMrSciGgmMJd46iazKbqStXV4/MFir9
         uVcE43AaVPI/gh1xx54+8zyoOQA2JSmhweBzCcMtsVIhOdldoHWEVyQvx992A2WeaV
         QNVaeG53XrZVg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Ardelean <aardelean@deviqon.com>, Robh+dt@kernel.org,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 10/24] iio:event: Add timeout event info type
Date:   Sun, 14 Mar 2021 18:14:57 +0000
Message-Id: <20210314181511.531414-11-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314181511.531414-1-jic23@kernel.org>
References: <20210314181511.531414-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

For adaptive threshold events, the current value is compared with a
(typically) low pass filtered version of the same signal that slowly
tracks large scale changes.  However, sometimes a step change can
result in a large lag before the low pass filtered version begins
to track the signal again.  Timeouts can be used to made an
instantaneous 'correction'.  Documentation of this attribute
is added in a later patch.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20210207154623.433442-11-jic23@kernel.org
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index a30e289fc362..17420682e308 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -245,6 +245,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_PERIOD] = "period",
 	[IIO_EV_INFO_HIGH_PASS_FILTER_3DB] = "high_pass_filter_3db",
 	[IIO_EV_INFO_LOW_PASS_FILTER_3DB] = "low_pass_filter_3db",
+	[IIO_EV_INFO_TIMEOUT] = "timeout",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 5aa7f66d4345..84b3f8175cc6 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -16,6 +16,7 @@ enum iio_event_info {
 	IIO_EV_INFO_PERIOD,
 	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
 	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
+	IIO_EV_INFO_TIMEOUT,
 };
 
 #define IIO_VAL_INT 1
-- 
2.30.2

