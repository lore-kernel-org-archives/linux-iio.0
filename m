Return-Path: <linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9BAC433F5
	for <linux-iio@archiver.kernel.org>; Mon, 23 May 2022 12:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiEWM3g (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 23 May 2022 08:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbiEWM3e (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 May 2022 08:29:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2D24162B;
        Mon, 23 May 2022 05:29:32 -0700 (PDT)
Received: from kwepemi500014.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L6GqF0zsjzDqL2;
        Mon, 23 May 2022 20:29:29 +0800 (CST)
Received: from huawei.com (10.67.174.157) by kwepemi500014.china.huawei.com
 (7.221.188.232) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 23 May
 2022 20:29:30 +0800
From:   Li Zhengyu <lizhengyu3@huawei.com>
To:     <ak@it-klinger.de>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] iio: srf08: Remove redundant if statement
Date:   Mon, 23 May 2022 20:27:55 +0800
Message-ID: <20220523122755.90638-1-lizhengyu3@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.157]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500014.china.huawei.com (7.221.188.232)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

(!val) has been checked outside the loop, remove redundant (val &&)
from loop.

Signed-off-by: Li Zhengyu <lizhengyu3@huawei.com>
---
 drivers/iio/proximity/srf08.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index ac1ab7e89d4e..7ed11339c31e 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -354,7 +354,7 @@ static ssize_t srf08_write_sensitivity(struct srf08_data *data,
 		return -EINVAL;
 
 	for (i = 0; i < data->chip_info->num_sensitivity_avail; i++)
-		if (val && (val == data->chip_info->sensitivity_avail[i])) {
+		if (val == data->chip_info->sensitivity_avail[i]) {
 			regval = i;
 			break;
 		}
-- 
2.17.1

