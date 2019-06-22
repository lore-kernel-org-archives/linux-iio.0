Return-Path: <SRS0=uIhB=UV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855C9C48BE8
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503022087F
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561215473;
	bh=cYTEBA7xPXaK++o6snHCzupTB8Um9C2K3H3M4Wopdtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1Zi1/N1Ass51SBKd20/suluBIGNvVGOyD45EtdTYYfRPtmEzGWG33FhdvqfvxzUzh
	 qvlSMPMLUlS2jo1CVdXfpBOlwU8EKNkNQQa5JN00L+vkySxBExgrEKqUP+QEYBMIzT
	 cirdzjNw4YEEnRdyuK+9dqHWxbGq7WlG9dz54VwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfFVO5x (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:57:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO5w (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:52 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EAFF2075E;
        Sat, 22 Jun 2019 14:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215471;
        bh=cYTEBA7xPXaK++o6snHCzupTB8Um9C2K3H3M4Wopdtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rm3F3NGNDoU8A/btvZp/urKtexqBZJdd/XWgdW0cauBn9DczrAAIF5fPBiCFS8GYU
         fIwy97OckSXzEsC9PpcFKvRwOEMs8MQaxyEUPhR1y3ky+XHrXXGrmnBEtYSK3xOCfV
         ECJ70ANWPHKG0EbKsL0matTusQxgtJKse21WoNS4=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 04/14] iio: sw-trigger: SPDX headers.
Date:   Sat, 22 Jun 2019 15:55:06 +0100
Message-Id: <20190622145516.3231-5-jic23@kernel.org>
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

GPLv2, add SPDX headers and remove boilerplate.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/industrialio-sw-trigger.c | 5 +----
 include/linux/iio/sw_trigger.h        | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-sw-trigger.c b/drivers/iio/industrialio-sw-trigger.c
index bc6b7fb43e3a..b8fcb4cd06f1 100644
--- a/drivers/iio/industrialio-sw-trigger.c
+++ b/drivers/iio/industrialio-sw-trigger.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * The Industrial I/O core, software trigger functions
  *
  * Copyright (c) 2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/module.h>
diff --git a/include/linux/iio/sw_trigger.h b/include/linux/iio/sw_trigger.h
index 0c43738a9e24..c8b9868b5e62 100644
--- a/include/linux/iio/sw_trigger.h
+++ b/include/linux/iio/sw_trigger.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Industrial I/O software trigger interface
  *
  * Copyright (c) 2015 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef __IIO_SW_TRIGGER
-- 
2.22.0

