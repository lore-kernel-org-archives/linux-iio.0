Return-Path: <SRS0=Mhlw=6F=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9879FC54FCC
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 783182072D
	for <linux-iio@archiver.kernel.org>; Tue, 21 Apr 2020 00:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUAbj (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 20 Apr 2020 20:31:39 -0400
Received: from mga05.intel.com ([192.55.52.43]:54519 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726109AbgDUAbi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 20 Apr 2020 20:31:38 -0400
IronPort-SDR: sCjClnDdZSIQS2MaL4EmEj2VVJ37vUETEQLaAGs6DGfXV1FgORntQdyHUhd/zdcy6DLr+27U3y
 r3PqndSD0Y4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 17:31:38 -0700
IronPort-SDR: mo6a4o2LqsorKOHeq2OFr6ANkFkPqzKdp0UvEmW25KLsEcq9TFvXjQvkS8uOoZ0Yv0wT7Hj8je
 N8sOscIvKyCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,408,1580803200"; 
   d="scan'208";a="245528002"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 20 Apr 2020 17:31:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 87162233; Tue, 21 Apr 2020 03:31:36 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/16] iio: adc: ti-ads124s08: Use get_unaligned_be24()
Date:   Tue, 21 Apr 2020 03:31:22 +0300
Message-Id: <20200421003135.23060-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
References: <20200421003135.23060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This makes the driver code slightly easier to read.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads124s08.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
index 552c2be8d87a..2516e42ad00d 100644
--- a/drivers/iio/adc/ti-ads124s08.c
+++ b/drivers/iio/adc/ti-ads124s08.c
@@ -188,7 +188,6 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
 {
 	struct ads124s_private *priv = iio_priv(indio_dev);
 	int ret;
-	u32 tmp;
 	struct spi_transfer t[] = {
 		{
 			.tx_buf = &priv->data[0],
@@ -208,9 +207,7 @@ static int ads124s_read(struct iio_dev *indio_dev, unsigned int chan)
 	if (ret < 0)
 		return ret;
 
-	tmp = priv->data[2] << 16 | priv->data[3] << 8 | priv->data[4];
-
-	return tmp;
+	return get_unaligned_be24(&priv->data[2]);
 }
 
 static int ads124s_read_raw(struct iio_dev *indio_dev,
-- 
2.26.1

