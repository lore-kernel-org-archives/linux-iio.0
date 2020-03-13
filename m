Return-Path: <SRS0=K2ZU=46=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DB0C10DCE
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 18:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 821B3206EB
	for <linux-iio@archiver.kernel.org>; Fri, 13 Mar 2020 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584122776;
	bh=GgsEsmfySKuoVrDluXcysKJXOhDPRmuJn8pnR9p67Q4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=OXQqm+WemSv+eOtlNG3FTOJDEyFSpkdObb+iX09H9ewdAdOLCW7ImWNeQThnt0xST
	 Dm6FXjQ6DG5fq6Zd5/zHnSbgyGdQPmcVXwBRQTc+m84k/+B5o/OP9Oe4Zx8hLFhTlw
	 5qAypNipxL++10T4u/Hxq5f1P4e4UMh46/xo5f4Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgCMSGQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 13 Mar 2020 14:06:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgCMSGQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 13 Mar 2020 14:06:16 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5190220674;
        Fri, 13 Mar 2020 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584122775;
        bh=GgsEsmfySKuoVrDluXcysKJXOhDPRmuJn8pnR9p67Q4=;
        h=From:To:Cc:Subject:Date:From;
        b=leuysofoNYiSEm86Cu8GjCZmNmzGgi8zd0+ARG7q7fUWvct7qU9Uk5oeYNjgldaan
         jYKKYJBDhWSQqU/PTvTrO3AbobyfU8/DhycEMHmp216mfZkkzp3B8KoNUxZrYZa5OU
         +TLMy0BtnjGsRENxqkI6fR+Xx1AgAzjyDLopO2KQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com,
        mario.tesi@st.com, vitor.soares@synopsys.com
Subject: [PATCH] iio: imu: st_lsm6dsx: flush hw FIFO before resetting the device
Date:   Fri, 13 Mar 2020 19:06:00 +0100
Message-Id: <e9beff6b3a32ddf0de20821e50cf3ed562e36b48.1584122527.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

flush hw FIFO before device reset in order to avoid possible races
on interrupt line 1. If the first interrupt line is asserted during
hw reset the device will work in I3C-only mode (if it is supported)

Fixes: 801a6e0af0c6 ("iio: imu: st_lsm6dsx: add support to LSM6DSO")
Fixes: 43901008fde0 ("iio: imu: st_lsm6dsx: add support to LSM6DSR")
Reported-by: Mario Tesi <mario.tesi@st.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
This is a new version of: "iio: imu: st_lsm6dsx: disable I3C support during
device reset"
https://patchwork.kernel.org/patch/11425389/
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 24 +++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 84d219ae6aee..4426524b59f2 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -2036,11 +2036,21 @@ static int st_lsm6dsx_init_hw_timer(struct st_lsm6dsx_hw *hw)
 	return 0;
 }
 
-static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
+static int st_lsm6dsx_reset_device(struct st_lsm6dsx_hw *hw)
 {
 	const struct st_lsm6dsx_reg *reg;
 	int err;
 
+	/*
+	 * flush hw FIFO before device reset in order to avoid
+	 * possible races on interrupt line 1. If the first interrupt
+	 * line is asserted during hw reset the device will work in
+	 * I3C-only mode (if it is supported)
+	 */
+	err = st_lsm6dsx_flush_fifo(hw);
+	if (err < 0 && err != -ENOTSUPP)
+		return err;
+
 	/* device sw reset */
 	reg = &hw->settings->reset;
 	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
@@ -2059,6 +2069,18 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
 
 	msleep(50);
 
+	return 0;
+}
+
+static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
+{
+	const struct st_lsm6dsx_reg *reg;
+	int err;
+
+	err = st_lsm6dsx_reset_device(hw);
+	if (err < 0)
+		return err;
+
 	/* enable Block Data Update */
 	reg = &hw->settings->bdu;
 	err = regmap_update_bits(hw->regmap, reg->addr, reg->mask,
-- 
2.24.1

