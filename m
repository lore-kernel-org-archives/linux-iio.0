Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9974CC25B41
	for <linux-iio@archiver.kernel.org>; Mon, 23 Oct 2023 04:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjJWEGW (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 23 Oct 2023 00:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjJWEGV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Oct 2023 00:06:21 -0400
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4FCCBD52;
        Sun, 22 Oct 2023 21:06:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 0C07460106CE6;
        Mon, 23 Oct 2023 12:06:10 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
To:     Jonathan.Cameron@Huawei.com, jic23@kernel.org, lars@metafoo.de
Cc:     Su Hui <suhui@nfschina.com>, jean-baptiste.maneyrol@tdk.com,
        andy.shevchenko@gmail.com, chenhuiz@axis.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] iio: imu: inv_mpu6050: fix an error code problem in inv_mpu6050_read_raw
Date:   Mon, 23 Oct 2023 12:05:52 +0800
Message-Id: <20231023040551.68902-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

inv_mpu6050_sensor_show() can return -EINVAL or IIO_VAL_INT. Return the
true value rather than only return IIO_VAL_INT.

Signed-off-by: Su Hui <suhui@nfschina.com>
---
v2:
 - fix the error of commit title.
v1: 
 - https://lore.kernel.org/all/20231020091413.205743-2-suhui@nfschina.com/
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 29f906c884bd..a9a5fb266ef1 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -749,13 +749,13 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			ret = inv_mpu6050_sensor_show(st, st->reg->gyro_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 		case IIO_ACCEL:
 			mutex_lock(&st->lock);
 			ret = inv_mpu6050_sensor_show(st, st->reg->accl_offset,
 						chan->channel2, val);
 			mutex_unlock(&st->lock);
-			return IIO_VAL_INT;
+			return ret;
 
 		default:
 			return -EINVAL;
-- 
2.30.2

