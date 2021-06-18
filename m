Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743C0C48BDF
	for <linux-iio@archiver.kernel.org>; Fri, 18 Jun 2021 12:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A96161222
	for <linux-iio@archiver.kernel.org>; Fri, 18 Jun 2021 12:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhFRMdY (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 18 Jun 2021 08:33:24 -0400
Received: from aposti.net ([89.234.176.197]:41148 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230438AbhFRMdF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 18 Jun 2021 08:33:05 -0400
From:   Paul Cercueil <paul@crapouillou.net>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/2] iio: core: Forbid use of both labels and extended names
Date:   Fri, 18 Jun 2021 13:30:04 +0100
Message-Id: <20210618123005.49867-2-paul@crapouillou.net>
In-Reply-To: <20210618123005.49867-1-paul@crapouillou.net>
References: <20210618123005.49867-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Extended names are a problem for user-space as they make the filenames
in sysfs sometimes not parsable. They are now deprecated in favor of
labels.

This change makes sure that a device driver won't provide both labels
and extended names for its channels. It has never been the case and we
don't want it to happen.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>
---
 drivers/iio/industrialio-core.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 59efb36db2c7..81f40dab778a 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -1836,6 +1836,24 @@ static int iio_check_unique_scan_index(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int iio_check_extended_name(const struct iio_dev *indio_dev)
+{
+	unsigned int i;
+
+	if (!indio_dev->info->read_label)
+		return 0;
+
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		if (indio_dev->channels[i].extend_name) {
+			dev_err(&indio_dev->dev,
+				"Cannot use labels and extend_name at the same time\n");
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static const struct iio_buffer_setup_ops noop_ring_setup_ops;
 
 int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
@@ -1860,6 +1878,10 @@ int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod)
 	if (ret < 0)
 		return ret;
 
+	ret = iio_check_extended_name(indio_dev);
+	if (ret < 0)
+		return ret;
+
 	iio_device_register_debugfs(indio_dev);
 
 	ret = iio_buffers_alloc_sysfs_and_mask(indio_dev);
-- 
2.30.2

