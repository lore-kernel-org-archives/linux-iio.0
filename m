Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE5D7C10F13
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 02:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8AB213F2
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 02:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfDICBS (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 8 Apr 2019 22:01:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37904 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726133AbfDICBS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Apr 2019 22:01:18 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A9421FC89D1C585517E2;
        Tue,  9 Apr 2019 10:01:16 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Tue, 9 Apr 2019 10:01:09 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-iio@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] iio: imu: st_lsm6dsx: remove set but not used variables 'acc_sensor' and 'gyro_sensor'
Date:   Tue, 9 Apr 2019 02:12:17 +0000
Message-ID: <20190409021217.155327-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c: In function 'st_lsm6dsx_read_tagged_fifo':
drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:520:41: warning:
 variable 'gyro_sensor' set but not used [-Wunused-but-set-variable]

drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c:520:28: warning:
 variable 'acc_sensor' set but not used [-Wunused-but-set-variable]

They are not used since commit 14c7c6e1a860 ("iio: imu: st_lsm6dsx: add
st_lsm6dsx_push_tagged_data routine")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 2da8c5ff699a..bd08711d5b75 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -517,7 +517,6 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 {
 	u16 pattern_len = hw->sip * ST_LSM6DSX_TAGGED_SAMPLE_SIZE;
 	u16 fifo_len, fifo_diff_mask;
-	struct st_lsm6dsx_sensor *acc_sensor, *gyro_sensor;
 	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE], tag;
 	bool reset_ts = false;
 	int i, err, read_len;
@@ -539,9 +538,6 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	if (!fifo_len)
 		return 0;
 
-	acc_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
-	gyro_sensor = iio_priv(hw->iio_devs[ST_LSM6DSX_ID_GYRO]);
-
 	for (read_len = 0; read_len < fifo_len; read_len += pattern_len) {
 		err = st_lsm6dsx_read_block(hw,
 					    ST_LSM6DSX_REG_FIFO_OUT_TAG_ADDR,



