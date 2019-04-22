Return-Path: <SRS0=i5D1=SY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0451DC10F11
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 10:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF6CD20874
	for <linux-iio@archiver.kernel.org>; Mon, 22 Apr 2019 10:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555927355;
	bh=ENgcRb2S3oPn/EmyUnQ4K4/nqUOWI0KzvobKKNq7CJw=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=h7DFSajPI10gqv5U4adItFpbDTuzp3o7Y3nnu7NBv9L2sIpd1R8VuYArnLu56RYUm
	 6dB1abjzZQGV99bA6e3st04aA6rRlyi3giEp7jzuVQvaIhWFbsOBgkOx+yUfl907Bg
	 3EQ0O2VlcE69ifc9TPFlD6E69jkgUIaHxyoqz/Qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfDVKCf (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 22 Apr 2019 06:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbfDVKCf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 22 Apr 2019 06:02:35 -0400
Received: from localhost.localdomain (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68B720811;
        Mon, 22 Apr 2019 10:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555927354;
        bh=ENgcRb2S3oPn/EmyUnQ4K4/nqUOWI0KzvobKKNq7CJw=;
        h=From:To:Cc:Subject:Date:From;
        b=fU9WBk+ygjDFoq/uhoO48Q3n1cXDjvNOjkVjeEO6SA8Hi/khSgMfs4tXYbzf/4Lxe
         qq1BgeHDFJnu/2aW70VTHQOow8cgtsm7V5lAFsfp4TwOuB9ijH5OL5Q2IbjSUU5hO+
         kJhOC/zLZAlvdgGAlVHIuhpPQBuwFnKNtp+tauvY=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio:gyro:mp3050 Suppress 'false' sparse warning about endian assigment.
Date:   Mon, 22 Apr 2019 11:00:30 +0100
Message-Id: <20190422100030.10561-1-jic23@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

In this particular case the value being assigned is 0xAAAA so
is not effected by the endian choice.

It's easy to suppress so we might as well do so to make it easier
to spot real warnings.

Warning is:

CHECK   drivers/iio/gyro/mpu3050-core.c
drivers/iio/gyro/mpu3050-core.c:544:48: warning: incorrect type in assignment (different base types)
drivers/iio/gyro/mpu3050-core.c:544:48:    expected restricted __be16 <noident>
drivers/iio/gyro/mpu3050-core.c:544:48:    got int

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 496ed4c99ce9..9aacaca145e4 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -541,7 +541,7 @@ static irqreturn_t mpu3050_trigger_handler(int irq, void *p)
 				toread = bytes_per_datum;
 				offset = 1;
 				/* Put in some dummy value */
-				fifo_values[0] = 0xAAAA;
+				fifo_values[0] = cpu_to_be16(0xAAAA);
 			}
 
 			ret = regmap_bulk_read(mpu3050->map,
-- 
2.21.0

