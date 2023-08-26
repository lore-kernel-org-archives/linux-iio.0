Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5721EC83F01
	for <linux-iio@archiver.kernel.org>; Sat, 26 Aug 2023 06:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjHZG1r (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Aug 2023 02:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjHZG1q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Aug 2023 02:27:46 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238471FC3
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 23:27:44 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RXmzh6Nd9z1L9L2;
        Sat, 26 Aug 2023 14:26:08 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 14:27:41 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next v2 0/2] iio: adc: spear_adc: Simplify with device managed function
Date:   Sat, 26 Aug 2023 14:27:30 +0800
Message-ID: <20230826062733.3714169-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Commit 7ef9651e9792 ("clk: Provide new devm_clk helpers for prepared
and enabled clocks") provides a new helper function to prepare and
enable a clock which keeps prepared (or enabled) during the whole
lifetime of the driver.

Switch to devm_iio_device_register() and drop the remove function.

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless
error is printed.

Changes in v2:
- Switch to devm_iio_device_register() and drop the remove function.
- Use the dev_err_probe() helper to simplify code.

Jinjie Ruan (2):
  iio: adc: spear_adc: Use device managed function
  iio: adc: spear_adc: Use dev_err_probe()

 drivers/iio/adc/spear_adc.c | 61 ++++++++-----------------------------
 1 file changed, 13 insertions(+), 48 deletions(-)

-- 
2.34.1

