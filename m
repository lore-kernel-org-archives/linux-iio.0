Return-Path: <SRS0=uIhB=UV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83418C48BE7
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E75E2075E
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561215490;
	bh=B7gaKBtXY6xesDpsBvhwAip7oC9hcecNUNu2zUCzMA4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mi4P2J9K0CudsCxjr+ZKjkarb83sEFdZsSOIppj+Yq3AZIkJMeo2Z6xAHFbz1IYI5
	 ORU5lDAXT5vkvxeYK5MAaF/+DVz4s2H5x05c8hPmBh5LXNgf2diAYWu0xTLNsJ4b+5
	 MPcTlsjqfLaVRqtQJ9pPRq/9f54uF3/v2MEEL+50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfFVO6K (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:58:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:58470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO6J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:58:09 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7402D20679;
        Sat, 22 Jun 2019 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215488;
        bh=B7gaKBtXY6xesDpsBvhwAip7oC9hcecNUNu2zUCzMA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C54mVsj0Iqx9O+h0veJknbmIju1mTeDDk0LhXGZN8O3pS/iwYed6PHAgUiAGx2StM
         oRwaLa8sSZPgvin9PaHDak3JQtwoyZcmFCukxVrs9JgsXLW8yxaQ4M2iX1Aj1zYhCI
         vbJmJzv6WMY6QUViL6+SOT297Nh9SgWGAjjaCQqk=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 14/14] iio: trig-sysfs: SPDX headers GPLv2.
Date:   Sat, 22 Jun 2019 15:55:16 +0100
Message-Id: <20190622145516.3231-15-jic23@kernel.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190622145516.3231-1-jic23@kernel.org>
References: <20190622145516.3231-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Non standard but clear statement of intent.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/iio/trigger/iio-trig-sysfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-sysfs.c b/drivers/iio/trigger/iio-trig-sysfs.c
index 45c4897295d6..c86a78baeba4 100644
--- a/drivers/iio/trigger/iio-trig-sysfs.c
+++ b/drivers/iio/trigger/iio-trig-sysfs.c
@@ -1,8 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
- *
  */
 
 #include <linux/kernel.h>
-- 
2.22.0

