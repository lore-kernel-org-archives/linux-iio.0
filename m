Return-Path: <SRS0=2qef=CW=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC492C43461
	for <linux-iio@archiver.kernel.org>; Sun, 13 Sep 2020 13:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B98DA217BA
	for <linux-iio@archiver.kernel.org>; Sun, 13 Sep 2020 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600003406;
	bh=41WTgoOcWayQaiGm5nUrMD4GkMsxkxjsSsEDujfc/0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0wX98FuvaeQAoRSVKghKjhTgIZvNVk7/Tr8wYftD97hM7U0AW98HtwGY3CzGEzYbC
	 fxCkt2VsJSheF//J2VxAb3EXf53q/YYdoSjADG/JxKbgLvgk+BVjuk7XjQ6+uizIRD
	 gGhtLdG4jPMhJEm7029ZWyhIJmUJX3OjQcJeHrnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgIMNXY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 13 Sep 2020 09:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgIMNXX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 09:23:23 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AC5921D80;
        Sun, 13 Sep 2020 13:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600003402;
        bh=41WTgoOcWayQaiGm5nUrMD4GkMsxkxjsSsEDujfc/0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xZi9vtPjTOXtwl4DDd5iqkc8dfP3BTDf9FiOplhW1Du+mT2r5UMWUq4x+E1xTgKGl
         E41Lb7Kf05CuPpcm2cRry+DvnPoN5DZKxXLxyWSfzWQq718bqG1Ls2YMouzziQTx8b
         rLPiKQTVqQJoDtJn4RzLMXAoxGaxHnxsRhPAixQ0=
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 3/3] iio:core: Tidy up kernel-doc.
Date:   Sun, 13 Sep 2020 14:21:15 +0100
Message-Id: <20200913132115.800131-4-jic23@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913132115.800131-1-jic23@kernel.org>
References: <20200913132115.800131-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

One comment isn't kernel-doc at all, but starts with /** and another
is simply missing a parameter that was introduced recently.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 8ddc6dfc8ed4..6e388293c828 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -170,7 +170,7 @@ static const char * const iio_chan_info_postfix[] = {
 };
 
 #if defined(CONFIG_DEBUG_FS)
-/**
+/*
  * There's also a CONFIG_DEBUG_FS guard in include/linux/iio/iio.h for
  * iio_get_debugfs_dentry() to make it inline if CONFIG_DEBUG_FS is undefined
  */
@@ -1525,6 +1525,7 @@ struct device_type iio_device_type = {
 
 /**
  * iio_device_alloc() - allocate an iio_dev from a driver
+ * @parent:		Parent device.
  * @sizeof_priv:	Space to allocate for private structure.
  **/
 struct iio_dev *iio_device_alloc(struct device *parent, int sizeof_priv)
-- 
2.28.0

