Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56022 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752530AbeC3Snc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Mar 2018 14:43:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id b127so15960234wmf.5
        for <linux-iio@vger.kernel.org>; Fri, 30 Mar 2018 11:43:31 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: fix FIFO threshold mask for LSM6DSM/LSM6DSL
Date: Fri, 30 Mar 2018 20:43:22 +0200
Message-Id: <20180330184322.5455-1-lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

According to the latest datasheet, LSM6DSM and LSM6DSL imu sensors
export GENMASK(10, 0) for FIFO threshold mask definition. Despite
that is not an actual issue since write on fifo_th register is protected
by max_fifo_size value, fix fifo_th and fifo_diff register definitions

Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 8656d72ef4ee..50d6491df484 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -266,11 +266,11 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 		.fifo_ops = {
 			.fifo_th = {
 				.addr = 0x06,
-				.mask = GENMASK(11, 0),
+				.mask = GENMASK(10, 0),
 			},
 			.fifo_diff = {
 				.addr = 0x3a,
-				.mask = GENMASK(11, 0),
+				.mask = GENMASK(10, 0),
 			},
 			.th_wl = 3, /* 1LSB = 2B */
 		},
-- 
2.16.2

