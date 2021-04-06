Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35962C433ED
	for <linux-iio@archiver.kernel.org>; Tue,  6 Apr 2021 08:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE3A3613BE
	for <linux-iio@archiver.kernel.org>; Tue,  6 Apr 2021 08:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234820AbhDFIes (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:34:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244449AbhDFIek (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Apr 2021 04:34:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6BB0F613BE;
        Tue,  6 Apr 2021 08:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617698072;
        bh=ohUgHPYY5ta/sj6CnXr883AMKYjgmhg26B47fbT8XtM=;
        h=From:To:Cc:Subject:Date:From;
        b=eikiWFDgo6sZ6F6BYA1PmHHLLlS51O9jkDETA8tlu/NFbYTl2IVTPaHiKSu4CyxCo
         CwVEJgcesvJYkzqzrZ+8rx2UO0P/77uw4zJmFPvvyHFzMQEipWnGapqiHBc4S+Gwie
         HQENX0suSVvtqyKTalFcsMKdIMOewKdIRDFYGqxrisRhLvURVlv2sKojC8C4LBomsS
         K/Y9SLCyCNhq+PAHxLSrcHn6tqTZzJx1zqVxI4lGiPtsVxHDQBd8ZiF32eI/21JRHL
         zAJ013lUQO8FioKwldOmcXPya9RtG8z+iTL8NDgOjbfXI6VJP+Kx4T2TLvi2WORecj
         zD185HA8OPUPg==
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] iio:cdc:ad7150: Fix use of uninitialized ret
Date:   Tue,  6 Apr 2021 09:32:44 +0100
Message-Id: <20210406083244.649984-1-jic23@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This doesn't appear to generate a warning on all versions of GCC, but
0-day reported it and the report looks valid.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/iio/cdc/ad7150.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index f9cce1a64586..ebe112b4618b 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -235,7 +235,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 				     enum iio_event_direction dir, int state)
 {
 	struct ad7150_chip_info *chip = iio_priv(indio_dev);
-	int ret;
+	int ret = 0;
 
 	/*
 	 * There is only a single shared control and no on chip
-- 
2.31.1

