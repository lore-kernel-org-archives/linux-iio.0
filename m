Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FDC6FA86
	for <linux-iio@archiver.kernel.org>; Tue, 27 Sep 2022 07:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbiI0HeB (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 27 Sep 2022 03:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiI0HeA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Sep 2022 03:34:00 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB5F7CA9D;
        Tue, 27 Sep 2022 00:33:58 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4McBBF2zY1zpSt9;
        Tue, 27 Sep 2022 15:31:01 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 15:33:56 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 15:33:55 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-doc@vger.kernel.org>, <linux-iio@vger.kernel.org>
CC:     <jic23@kernel.org>, <lars@metafoo.de>,
        <Jonathan.Cameron@huawei.com>, <yangyingliang@huawei.com>
Subject: [PATCH -next] Documentation: devres: add missing IIO helpers
Date:   Tue, 27 Sep 2022 15:40:43 +0800
Message-ID: <20220927074043.942836-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add missing device-managed helpers of iio to devres.rst.

Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 Documentation/driver-api/driver-model/devres.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 2895f9ea00c4..5154844bc222 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -286,12 +286,16 @@ IIO
   devm_iio_device_register()
   devm_iio_dmaengine_buffer_setup()
   devm_iio_kfifo_buffer_setup()
+  devm_iio_kfifo_buffer_setup_ext()
   devm_iio_map_array_register()
   devm_iio_triggered_buffer_setup()
+  devm_iio_triggered_buffer_setup_ext()
   devm_iio_trigger_alloc()
   devm_iio_trigger_register()
   devm_iio_channel_get()
   devm_iio_channel_get_all()
+  devm_iio_hw_consumer_alloc()
+  devm_fwnode_iio_channel_get_by_name()
 
 INPUT
   devm_input_allocate_device()
-- 
2.25.1

