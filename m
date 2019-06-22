Return-Path: <SRS0=uIhB=UV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A11BC43613
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525A720820
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561215488;
	bh=ma521aPziR/549+zD9WcRdRXj15FLs+97juYXQ4D8nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tmoGqY2RzP5+L30539cQ1XlHrzCHgwBLKSZ62fRi4tCxDb9ni63FQ9PUkZdxo1395
	 SHjWZVTuMdWaFqx71nF2KM8cMrg0Idxe7oT/if3oBJM0BF36V261fBBMjCH8Byq0RD
	 jWVMfeGQYbpSN/Chene9YYQV6M1YGzhD4W/WmXUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfFVO6I (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:58:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:58438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO6H (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:58:07 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE1D620449;
        Sat, 22 Jun 2019 14:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215487;
        bh=ma521aPziR/549+zD9WcRdRXj15FLs+97juYXQ4D8nc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uzIiidZv+cjG5mZ6Cad78DFRliEOlFJV5agrWTc6YA8yNIHhQ4BpLmDVq0BPbILRu
         nvbobapHcHDwRQLEaNtb1yS0T+wtzvFErzTbllEY5JL6t4+cue6LJDVOSB/HuiwlEV
         lhCLiAMgMYFOIaE1q0jzr7ANAbvVM5UHrevCKA2Q=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 13/14] iio: trig-loop: SPDX headers GPL-v2
Date:   Sat, 22 Jun 2019 15:55:15 +0100
Message-Id: <20190622145516.3231-14-jic23@kernel.org>
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

Not exactly standard license text, but clear in intent and it's
my copyright anyway.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/trigger/iio-trig-loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/trigger/iio-trig-loop.c b/drivers/iio/trigger/iio-trig-loop.c
index 9258d3cf149b..f0205a9e47d0 100644
--- a/drivers/iio/trigger/iio-trig-loop.c
+++ b/drivers/iio/trigger/iio-trig-loop.c
@@ -1,8 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright 2016 Jonathan Cameron <jic23@kernel.org>
  *
- * Licensed under the GPL-2.
- *
  * Based on a mashup of the hrtimer trigger and continuous sampling proposal of
  * Gregor Boirie <gregor.boirie@parrot.com>
  *
-- 
2.22.0

