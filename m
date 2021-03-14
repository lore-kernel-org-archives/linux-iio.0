Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007FCC433E6
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 16:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB5D764E7C
	for <linux-iio@archiver.kernel.org>; Sun, 14 Mar 2021 16:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhCNQto (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Mar 2021 12:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234680AbhCNQtM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:49:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9635364EE2;
        Sun, 14 Mar 2021 16:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615740552;
        bh=a7xK8Y2Raye1KHoVO5z1emS3vFbx+WA+ec6BgZZrn5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dsDmdiUPVY0REmERwJcZLu46m58mYZTVgXIhz/9MEMpKRKI+NXIYxOO6We+HXvkzB
         jMCaEqAzXFEDEICMAP02duYjn2YmFFGT84pnU+jf2fGzm3mvqs9Y9Gd5Ldf/E5IcJy
         /NT0BlY5FlJXE12byn23w6c8bDq9rYx92iXFyknlLbr8ITuYb8+RAxeY8KqrHB7wsw
         CWMi3dlzZnvs3M08986iDS0Je4yOBvZSyPlvuvTw0oQaWizsx1W3yJEcEGgtuOr/Fk
         +q++vwjURO54UMc41qL6fIaF8OPy7t4P006S3ZpbKE/wG9d2F92jqVO5NM6wck1Dxd
         C5xE7p/xEJZsw==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 6/8] iio: adc: adi-axi-adc: Drop false marking for kernel-doc
Date:   Sun, 14 Mar 2021 16:46:53 +0000
Message-Id: <20210314164655.408461-7-jic23@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210314164655.408461-1-jic23@kernel.org>
References: <20210314164655.408461-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This comment block isn't in kernel-doc format so drop the /** marking.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/adc/adi-axi-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 2e84623f732e..d5f6ffc5b5bc 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -23,7 +23,7 @@
 #include <linux/fpga/adi-axi-common.h>
 #include <linux/iio/adc/adi-axi-adc.h>
 
-/**
+/*
  * Register definitions:
  *   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip#register_map
  */
-- 
2.30.2

