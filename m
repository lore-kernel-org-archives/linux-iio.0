Return-Path: <SRS0=zqEj=ZU=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AD2C432C0
	for <linux-iio@archiver.kernel.org>; Thu, 28 Nov 2019 19:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880A721781
	for <linux-iio@archiver.kernel.org>; Thu, 28 Nov 2019 19:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574968740;
	bh=6ltMmsrU8skBcPv4GkNQbTeSY/3KzUEw5RRsc8D+Q/k=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ry2FOQGXUm4Ud5TNb5Jea9oLM94tJC2WhRd9yrEXdS3gBfPid5Yqn1YigbPIwAXGP
	 MqZcMXP6c1tUzPXQwHLU04r0bajtEz/YdXsLHhMQiFsbdwAIaQwsTpxejKSOeLODN8
	 MfyXyvGz69Rkmpq1ANaIDOF/t2OOdEhFR1mdopnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfK1TTA (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:19:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:46880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfK1TS7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Nov 2019 14:18:59 -0500
Received: from localhost.localdomain.com (unknown [77.139.212.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC0B520880;
        Thu, 28 Nov 2019 19:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574968739;
        bh=6ltMmsrU8skBcPv4GkNQbTeSY/3KzUEw5RRsc8D+Q/k=;
        h=From:To:Cc:Subject:Date:From;
        b=u7c7Pn3dbBkotArHfizSwxXoNfIKUr0bm+55TTezCNDVg8tlpDf5tGHKbPFmqF66z
         WF9BHKbM8+j7KhQsyUAdskqmAP+XqaVnfmT3AqSbFYmh4jtElCNu9L3N9ogUNa5PeS
         lbzQacR+VUNtaIz2zz57q/FH7K68+rziYCIwMl9I=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        sean@geanix.com
Subject: [RFC/RFT] iio: imu: st_lsm6dsx: do not power-off accel if events are enabled
Date:   Thu, 28 Nov 2019 21:18:39 +0200
Message-Id: <e9782c23425f455da34c5d171013167551beeb37.1574968509.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Do not power-off accel unconditionally if wake-up events are enabled
powering off the hw FIFO. At the same time do not power-off the accel
sensor if it is 'batched' in the hw FIFO disabling sensor events

Fixes: b5969abfa8b8 ("iio: imu: st_lsm6dsx: add motion events")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This patch is based on https://patchwork.kernel.org/patch/11266301/
@Sean: could you please run some tests in your environment?
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 30 +++++++++++++++++---
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 6f628c3cd133..a7d40c02ce6b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1447,8 +1447,9 @@ st_lsm6dsx_set_odr(struct st_lsm6dsx_sensor *sensor, u32 req_odr)
 	return st_lsm6dsx_update_bits_locked(hw, reg->addr, reg->mask, data);
 }
 
-int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
-				 bool enable)
+static int
+__st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
+			       bool enable)
 {
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	u32 odr = enable ? sensor->odr : 0;
@@ -1466,6 +1467,26 @@ int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
 	return 0;
 }
 
+static int
+st_lsm6dsx_check_events(struct st_lsm6dsx_sensor *sensor, bool enable)
+{
+	struct st_lsm6dsx_hw *hw = sensor->hw;
+
+	if (sensor->id == ST_LSM6DSX_ID_GYRO || enable)
+		return 0;
+
+	return hw->enable_event;
+}
+
+int st_lsm6dsx_sensor_set_enable(struct st_lsm6dsx_sensor *sensor,
+				 bool enable)
+{
+	if (st_lsm6dsx_check_events(sensor, enable))
+		return 0;
+
+	return __st_lsm6dsx_sensor_set_enable(sensor, enable);
+}
+
 static int st_lsm6dsx_read_oneshot(struct st_lsm6dsx_sensor *sensor,
 				   u8 addr, int *val)
 {
@@ -1661,7 +1682,7 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 	struct st_lsm6dsx_sensor *sensor = iio_priv(iio_dev);
 	struct st_lsm6dsx_hw *hw = sensor->hw;
 	u8 enable_event;
-	int err = 0;
+	int err;
 
 	if (type != IIO_EV_TYPE_THRESH)
 		return -EINVAL;
@@ -1689,7 +1710,8 @@ st_lsm6dsx_write_event_config(struct iio_dev *iio_dev,
 		return err;
 
 	mutex_lock(&hw->conf_lock);
-	err = st_lsm6dsx_sensor_set_enable(sensor, state);
+	if (enable_event || !(hw->fifo_mask & BIT(sensor->id)))
+		err = __st_lsm6dsx_sensor_set_enable(sensor, state);
 	mutex_unlock(&hw->conf_lock);
 	if (err < 0)
 		return err;
-- 
2.21.0

