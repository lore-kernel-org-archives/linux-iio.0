Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16B7C4332F
	for <linux-iio@archiver.kernel.org>; Thu, 20 Oct 2022 12:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbiJTMgW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 Oct 2022 08:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbiJTMgV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2022 08:36:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AB417EF02
        for <linux-iio@vger.kernel.org>; Thu, 20 Oct 2022 05:35:49 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MtRln2P0czmVDK;
        Thu, 20 Oct 2022 20:31:01 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 20:35:39 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 20:35:39 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <samuel@sholland.org>
CC:     <linux-iio@vger.kernel.org>, <linux-sunxi@lists.linux.dev>
Subject: [PATCH v2 0/2] iio: adc: sun4i-gpadc-iio: Fix error handle in sun4i_gpadc_probe()
Date:   Thu, 20 Oct 2022 20:40:43 +0800
Message-ID: <20221020124045.77678-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This patch set fix three bugfixs include:

1) If thermal_zone_of_sensor_register() failed, PM disable
   depth will be imbalanced and iio_map_array may have been
   called. The first patch fixed them.

2) If devm_iio_device_register() failed, we don't revert
   thermal_zone registration. The second patch fix it.

Zhang Qilong (2):
  iio: adc: sun4i-gpadc-iio: Fix PM disable depth imbalance in
    sun4i_gpadc_probe()
  iio: adc: sun4i-gpadc-iio: Fix error handle when
    devm_iio_device_register() failed in sun4i_gpadc_probe()

 drivers/iio/adc/sun4i-gpadc-iio.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.25.1

