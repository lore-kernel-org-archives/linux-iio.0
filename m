Return-Path: <SRS0=DYZA=SL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074D4C282DA
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 20:49:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7F5F2084B
	for <linux-iio@archiver.kernel.org>; Tue,  9 Apr 2019 20:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554842959;
	bh=FwDMFmDqewGsVF2FKu5++eNP6qDvIUT+0OjWLS+oYVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n9lvl9NFOOBDa8SNipRrQpUaEXUTey6JiRov4Qf2tBg5cM+ZAATb51rLUK0pz/O+8
	 rTRBfiTZAvYG7LhX0k9pVZqZg7Zql1WLgjRVFq3jHRwRpJNLbaiU4NNqbjhOxvNNTP
	 nDMi2VI9hSIeQljkDPoi9iN58Q+k+Fv03B+nvjug=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfDIUtT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 9 Apr 2019 16:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:57894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbfDIUtT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 9 Apr 2019 16:49:19 -0400
Received: from localhost.localdomain (unknown [151.66.24.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C472A2084B;
        Tue,  9 Apr 2019 20:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554842957;
        bh=FwDMFmDqewGsVF2FKu5++eNP6qDvIUT+0OjWLS+oYVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yCQNYEm5i60izBz4ovc5OVhV4XxD0ONBzh2Ord3ofvg+62neTp2fPeMu24XNNz3G/
         iDd2yWed06h+729Am26waFl9WxVV8m2dLLqK/u/vb4sBlTJNdCRQw+bY5hoiMmTjwE
         cWq2wsHC2eX5T0dOQf0bKBrF0PCLwoavL2x1ccRM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] iio: imu: st_lsm6dsx: inline per-sensor data
Date:   Tue,  9 Apr 2019 22:49:09 +0200
Message-Id: <7a9445dce569870c70e4fabb1a4fcd8fb35a460e.1554842769.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1554842769.git.lorenzo@kernel.org>
References: <cover.1554842769.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

As it has been already done for other st sensors in 'commit 9049531c91b4
("iio: accel: st_accel: inline per-sensor data")', get rid of some
defines and just open code the values into the appropriate struct
elements since the semantic meaning is inherent in the name of the
C99-addressable fields and there is no reason to duplicate the code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 50 +++++++-------------
 1 file changed, 16 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 04124cc277dd..cf82c9049945 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -62,37 +62,19 @@
 #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR	0x13
 #define ST_LSM6DSX_REG_INT2_ON_INT1_MASK	BIT(5)
 
-#define ST_LSM6DSX_REG_ACC_ODR_ADDR		0x10
-#define ST_LSM6DSX_REG_ACC_ODR_MASK		GENMASK(7, 4)
-#define ST_LSM6DSX_REG_ACC_FS_ADDR		0x10
-#define ST_LSM6DSX_REG_ACC_FS_MASK		GENMASK(3, 2)
 #define ST_LSM6DSX_REG_ACC_OUT_X_L_ADDR		0x28
 #define ST_LSM6DSX_REG_ACC_OUT_Y_L_ADDR		0x2a
 #define ST_LSM6DSX_REG_ACC_OUT_Z_L_ADDR		0x2c
 
-#define ST_LSM6DSX_REG_GYRO_ODR_ADDR		0x11
-#define ST_LSM6DSX_REG_GYRO_ODR_MASK		GENMASK(7, 4)
-#define ST_LSM6DSX_REG_GYRO_FS_ADDR		0x11
-#define ST_LSM6DSX_REG_GYRO_FS_MASK		GENMASK(3, 2)
 #define ST_LSM6DSX_REG_GYRO_OUT_X_L_ADDR	0x22
 #define ST_LSM6DSX_REG_GYRO_OUT_Y_L_ADDR	0x24
 #define ST_LSM6DSX_REG_GYRO_OUT_Z_L_ADDR	0x26
 
-#define ST_LSM6DSX_ACC_FS_2G_GAIN		IIO_G_TO_M_S_2(61)
-#define ST_LSM6DSX_ACC_FS_4G_GAIN		IIO_G_TO_M_S_2(122)
-#define ST_LSM6DSX_ACC_FS_8G_GAIN		IIO_G_TO_M_S_2(244)
-#define ST_LSM6DSX_ACC_FS_16G_GAIN		IIO_G_TO_M_S_2(488)
-
-#define ST_LSM6DSX_GYRO_FS_245_GAIN		IIO_DEGREE_TO_RAD(8750)
-#define ST_LSM6DSX_GYRO_FS_500_GAIN		IIO_DEGREE_TO_RAD(17500)
-#define ST_LSM6DSX_GYRO_FS_1000_GAIN		IIO_DEGREE_TO_RAD(35000)
-#define ST_LSM6DSX_GYRO_FS_2000_GAIN		IIO_DEGREE_TO_RAD(70000)
-
 static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
 	[ST_LSM6DSX_ID_ACC] = {
 		.reg = {
-			.addr = ST_LSM6DSX_REG_ACC_ODR_ADDR,
-			.mask = ST_LSM6DSX_REG_ACC_ODR_MASK,
+			.addr = 0x10,
+			.mask = GENMASK(7, 4),
 		},
 		.odr_avl[0] = {  13, 0x01 },
 		.odr_avl[1] = {  26, 0x02 },
@@ -103,8 +85,8 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
 	},
 	[ST_LSM6DSX_ID_GYRO] = {
 		.reg = {
-			.addr = ST_LSM6DSX_REG_GYRO_ODR_ADDR,
-			.mask = ST_LSM6DSX_REG_GYRO_ODR_MASK,
+			.addr = 0x11,
+			.mask = GENMASK(7, 4),
 		},
 		.odr_avl[0] = {  13, 0x01 },
 		.odr_avl[1] = {  26, 0x02 },
@@ -118,23 +100,23 @@ static const struct st_lsm6dsx_odr_table_entry st_lsm6dsx_odr_table[] = {
 static const struct st_lsm6dsx_fs_table_entry st_lsm6dsx_fs_table[] = {
 	[ST_LSM6DSX_ID_ACC] = {
 		.reg = {
-			.addr = ST_LSM6DSX_REG_ACC_FS_ADDR,
-			.mask = ST_LSM6DSX_REG_ACC_FS_MASK,
+			.addr = 0x10,
+			.mask = GENMASK(3, 2),
 		},
-		.fs_avl[0] = {  ST_LSM6DSX_ACC_FS_2G_GAIN, 0x0 },
-		.fs_avl[1] = {  ST_LSM6DSX_ACC_FS_4G_GAIN, 0x2 },
-		.fs_avl[2] = {  ST_LSM6DSX_ACC_FS_8G_GAIN, 0x3 },
-		.fs_avl[3] = { ST_LSM6DSX_ACC_FS_16G_GAIN, 0x1 },
+		.fs_avl[0] = {  IIO_G_TO_M_S_2(61), 0x0 },
+		.fs_avl[1] = { IIO_G_TO_M_S_2(122), 0x2 },
+		.fs_avl[2] = { IIO_G_TO_M_S_2(244), 0x3 },
+		.fs_avl[3] = { IIO_G_TO_M_S_2(488), 0x1 },
 	},
 	[ST_LSM6DSX_ID_GYRO] = {
 		.reg = {
-			.addr = ST_LSM6DSX_REG_GYRO_FS_ADDR,
-			.mask = ST_LSM6DSX_REG_GYRO_FS_MASK,
+			.addr = 0x11,
+			.mask = GENMASK(3, 2),
 		},
-		.fs_avl[0] = {  ST_LSM6DSX_GYRO_FS_245_GAIN, 0x0 },
-		.fs_avl[1] = {  ST_LSM6DSX_GYRO_FS_500_GAIN, 0x1 },
-		.fs_avl[2] = { ST_LSM6DSX_GYRO_FS_1000_GAIN, 0x2 },
-		.fs_avl[3] = { ST_LSM6DSX_GYRO_FS_2000_GAIN, 0x3 },
+		.fs_avl[0] = {  IIO_DEGREE_TO_RAD(8750), 0x0 },
+		.fs_avl[1] = { IIO_DEGREE_TO_RAD(17500), 0x1 },
+		.fs_avl[2] = { IIO_DEGREE_TO_RAD(35000), 0x2 },
+		.fs_avl[3] = { IIO_DEGREE_TO_RAD(70000), 0x3 },
 	}
 };
 
-- 
2.20.1

