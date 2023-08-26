Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F89AC83F01
	for <linux-iio@archiver.kernel.org>; Sat, 26 Aug 2023 03:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjHZDyx (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 25 Aug 2023 23:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231767AbjHZDyY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Aug 2023 23:54:24 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17E62698
        for <linux-iio@vger.kernel.org>; Fri, 25 Aug 2023 20:54:20 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RXjXK6yFPzNmsP;
        Sat, 26 Aug 2023 11:50:41 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 26 Aug
 2023 11:54:17 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next 0/2] iio: adc: mt6577_auxadc: Cleanup with the helpers
Date:   Sat, 26 Aug 2023 11:54:00 +0800
Message-ID: <20230826035402.3512033-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use the dev_err_probe() helper to simplify error handling during probe.
This also handle scenario, when EDEFER is returned and useless
error is printed.

And use devm_add_action_or_reset() and devm_iio_device_register()
to simplify the code.

Jinjie Ruan (2):
  iio: adc: mt6577_auxadc: Simplify with dev_err_probe()
  iio: adc: mt6577_auxadc: Simplify with device managed function

 drivers/iio/adc/mt6577_auxadc.c | 60 +++++++++++++--------------------
 1 file changed, 23 insertions(+), 37 deletions(-)

-- 
2.34.1

