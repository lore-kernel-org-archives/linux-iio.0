Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE05C433B4
	for <linux-iio@archiver.kernel.org>; Mon, 12 Apr 2021 08:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62906109E
	for <linux-iio@archiver.kernel.org>; Mon, 12 Apr 2021 08:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbhDLIjQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 12 Apr 2021 04:39:16 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16568 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237277AbhDLIjQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 04:39:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJht21FYYz1BGYh;
        Mon, 12 Apr 2021 16:36:42 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 16:38:48 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jic23@kernel.org>, <tduszyns@gmail.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
CC:     <linux-iio@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH drivers/iio 0/3] convert sysfs sprintf/snprintf/scnprintf to sysfs_emit
Date:   Mon, 12 Apr 2021 16:39:08 +0800
Message-ID: <1618216751-1678-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the generic sysfs_emit() function to take place of
sprintf/snprintf/scnprintf, to avoid buffer overrun.

Tian Tao (3):
  iio:chemical:sps30:  Convert sysfs sprintf/snprintf family to
    sysfs_emit
  iio: light: Convert sysfs sprintf/snprintf family to sysfs_emit
  iio: trigger: stm32-timer: Convert sysfs sprintf/snprintf family to
    sysfs_emit

 drivers/iio/chemical/sps30.c              | 6 +++---
 drivers/iio/light/veml6030.c              | 2 +-
 drivers/iio/trigger/stm32-timer-trigger.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.7.4

