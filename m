Return-Path: <SRS0=Wwjn=OY=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18808C43387
	for <linux-iio@archiver.kernel.org>; Sat, 15 Dec 2018 06:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F40992080F
	for <linux-iio@archiver.kernel.org>; Sat, 15 Dec 2018 06:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbeLOGXr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 15 Dec 2018 01:23:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:16570 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727757AbeLOGXr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 15 Dec 2018 01:23:47 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 542E1424C8786;
        Sat, 15 Dec 2018 14:23:43 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Sat, 15 Dec 2018 14:23:38 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-iio@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] iio: imu: st_lsm6dsx: remove set but not used variable ''
Date:   Sat, 15 Dec 2018 06:31:24 +0000
Message-ID: <1544855484-154231-1-git-send-email-yuehaibing@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c: In function 'st_lsm6dsx_shub_read_reg':
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c:108:41: warning:
 variable 'hub_settings' set but not used [-Wunused-but-set-variable]

It never used since introduction in commit c91c1c844ebd ("iio: imu: st_lsm6dsx:
add i2c embedded controller support")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 8e47dcc..66fbcd9 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -105,12 +105,10 @@ static void st_lsm6dsx_shub_wait_complete(struct st_lsm6dsx_hw *hw)
 static int st_lsm6dsx_shub_read_reg(struct st_lsm6dsx_hw *hw, u8 addr,
 				    u8 *data, int len)
 {
-	const struct st_lsm6dsx_shub_settings *hub_settings;
 	int err;
 
 	mutex_lock(&hw->page_lock);
 
-	hub_settings = &hw->settings->shub_settings;
 	err = st_lsm6dsx_set_page(hw, true);
 	if (err < 0)
 		goto out;



