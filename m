Return-Path: <linux-iio-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F241C63797
	for <linux-iio@archiver.kernel.org>; Mon, 16 Jan 2023 09:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjAPJw2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Jan 2023 04:52:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjAPJvy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 04:51:54 -0500
Received: from frolo.macqel.be (smtp2.macqel.be [109.135.2.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47D8F193C4
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 01:51:49 -0800 (PST)
Received: by frolo.macqel.be (Postfix, from userid 1000)
        id D234EDF00AB; Mon, 16 Jan 2023 10:51:48 +0100 (CET)
From:   Philippe De Muyter <Philippe.DeMuyter@macq.eu>
To:     lorenzo@kernel.org, linux-iio@vger.kernel.org
Cc:     Philippe De Muyter <phdm@macqel.be>
Subject: [PATCH 2/2] iio: imu: st_lsm6dsx: add 'mount_matrix' sysfs entry to gyro channel.
Date:   Mon, 16 Jan 2023 10:51:25 +0100
Message-Id: <1673862685-29308-3-git-send-email-Philippe.DeMuyter@macq.eu>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1673862685-29308-1-git-send-email-Philippe.DeMuyter@macq.eu>
References: <1673862685-29308-1-git-send-email-Philippe.DeMuyter@macq.eu>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Philippe De Muyter <phdm@macqel.be>

Signed-off-by: Philippe De Muyter <phdm@macqel.be>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index 5b6f195748fc..499fcf8875b4 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -93,7 +93,7 @@ enum st_lsm6dsx_hw_id {
 		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &st_lsm6dsx_event,				\
-	.ext_info = st_lsm6dsx_accel_ext_info,				\
+	.ext_info = st_lsm6dsx_ext_info,				\
 	.num_event_specs = 1,						\
 }
 
@@ -113,6 +113,7 @@ enum st_lsm6dsx_hw_id {
 		.storagebits = 16,					\
 		.endianness = IIO_LE,					\
 	},								\
+	.ext_info = st_lsm6dsx_ext_info,				\
 }
 
 struct st_lsm6dsx_reg {
@@ -528,7 +529,7 @@ st_lsm6dsx_device_set_enable(struct st_lsm6dsx_sensor *sensor, bool enable)
 }
 
 static const
-struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_accel_ext_info[] = {
+struct iio_chan_spec_ext_info __maybe_unused st_lsm6dsx_ext_info[] = {
 	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, st_lsm6dsx_get_mount_matrix),
 	{ }
 };
-- 
2.31.1

