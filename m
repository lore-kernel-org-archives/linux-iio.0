Return-Path: <SRS0=uIhB=UV=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A1DC43613
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A882084E
	for <linux-iio@archiver.kernel.org>; Sat, 22 Jun 2019 14:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561215471;
	bh=z3PkCbmJUGyQMykrtqUtVR09dSPR8wkjoEJVhmqRtgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=U7UDdEWnGBHdWuSO3Gk2WF5UHpC8CU6ytKTcKM5scHzgX9jTyYu6x3NF2FlWKi5Ym
	 iHJ6RFZQJoZ4YtJTa4y+7kAWjXeN2QNu87mBRwF6Go8PTBtw+mUMQRdvyAEQVRBDeD
	 wTYp/mLqEFLlSrqSIDDpOOWgabubZCc8igGPG/3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfFVO5v (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 22 Jun 2019 10:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:58172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbfFVO5v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Jun 2019 10:57:51 -0400
Received: from localhost.localdomain (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBE7F20820;
        Sat, 22 Jun 2019 14:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561215470;
        bh=z3PkCbmJUGyQMykrtqUtVR09dSPR8wkjoEJVhmqRtgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yI22VW/t8fW+NH+SsP7pvgg2NuQ34r1nuB0s9lQk/+bCMhGSTwwZs0Cv6Rja8fPpZ
         nRAI1LRC6ZLobod+I2dKjqid1eUNb+G1WQvInStWyGfv4zhcbXhfAs76UICw3U4qbZ
         1bp+wvuLYHrmqqPT/XzXIJOUTy3vbz/UT7S2iO/g=
From:   jic23@kernel.org
To:     linux-iio@vger.kernel.org
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 03/14] iio: sw-device: SPDX headers
Date:   Sat, 22 Jun 2019 15:55:05 +0100
Message-Id: <20190622145516.3231-4-jic23@kernel.org>
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

Simple GPLv2.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/industrialio-sw-device.c | 5 +----
 include/linux/iio/sw_device.h        | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/industrialio-sw-device.c b/drivers/iio/industrialio-sw-device.c
index 90df97c542f6..cefa6ce4555a 100644
--- a/drivers/iio/industrialio-sw-device.c
+++ b/drivers/iio/industrialio-sw-device.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * The Industrial I/O core, software IIO devices functions
  *
  * Copyright (c) 2016 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/module.h>
diff --git a/include/linux/iio/sw_device.h b/include/linux/iio/sw_device.h
index 8642b91a7577..253ae5fce3d0 100644
--- a/include/linux/iio/sw_device.h
+++ b/include/linux/iio/sw_device.h
@@ -1,11 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * Industrial I/O software device interface
  *
  * Copyright (c) 2016 Intel Corporation
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #ifndef __IIO_SW_DEVICE
-- 
2.22.0

