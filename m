Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626AAC433F5
	for <linux-iio@archiver.kernel.org>; Fri, 18 Mar 2022 02:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231936AbiCRCu6 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 17 Mar 2022 22:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCRCu5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 17 Mar 2022 22:50:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC37B715F;
        Thu, 17 Mar 2022 19:49:40 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KKT2x0vHNzfYrQ;
        Fri, 18 Mar 2022 10:48:09 +0800 (CST)
Received: from dggpemm500015.china.huawei.com (7.185.36.181) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 10:49:38 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500015.china.huawei.com
 (7.185.36.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:49:38 +0800
From:   Wang ShaoBo <bobo.shaobowang@huawei.com>
CC:     <cj.chengjian@huawei.com>, <liwei391@huawei.com>,
        <bobo.shaobowang@huawei.com>, <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jic23@kernel.org>, <Jonathan.Cameron@huawei.com>
Subject: [PATCH 0/2] admv8818 driver fixes
Date:   Fri, 18 Mar 2022 10:59:12 +0800
Message-ID: <20220318025914.2614812-1-bobo.shaobowang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
 dggpemm500015.china.huawei.com (7.185.36.181)
X-CFilter-Loop: Reflected
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

admv8818 driver fixes

Wang ShaoBo (2):
  iio:filter:admv8818: Add depends on REGMAP
  iio:filter:admv8818: Fix missing clk_disable_unprepare() in
    admv8818_clk_setup

 drivers/iio/filter/Kconfig    |  2 +-
 drivers/iio/filter/admv8818.c | 14 +++++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

-- 
2.25.1

