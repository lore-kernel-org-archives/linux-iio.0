Return-Path: <SRS0=976T=2E=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9F8CC43603
	for <linux-iio@archiver.kernel.org>; Sat, 14 Dec 2019 16:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E352465E
	for <linux-iio@archiver.kernel.org>; Sat, 14 Dec 2019 16:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576342405;
	bh=N5I1SUuL0XWN6tthuT/xbZw9JOM2pjnGuqrKBhPGv9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xTFLGAsAFCLBTGcsyvYVG7myvJCbRVbbFb/Fx22khdzz7eHCt6VriRJZOsWHri16T
	 UjXiDFu7diUTr9b3cTC0Jf1uuOedn86x/HGtrP7zr6P+/Z6U/b617y+5C3qCsCCkqK
	 lHbHiQC4yJb/38hfBHVNq9huViKgA34/ZA1tdfss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725975AbfLNQxZ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 14 Dec 2019 11:53:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:54574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfLNQxZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Dec 2019 11:53:25 -0500
Received: from localhost.localdomain (209-213-91-242.bos.ma.meganet.net [209.213.91.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 623A824671;
        Sat, 14 Dec 2019 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576342404;
        bh=N5I1SUuL0XWN6tthuT/xbZw9JOM2pjnGuqrKBhPGv9U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q1o8pw0IalPacE34RLYAhg8JnMzVIWfRPqmYsVY0Cr3g0kR/PxYN+XXtFUaMHwCVE
         luHIU0G69t8Cs9hyry2VUzomulo9X42iia12ciWlXi9eDtTtBTFWLGo2eBg3A0/AVL
         J7D9fLsVRO5HSuMslnQOdyNgDSJ/MzZO773Fd2R4=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     jic23@kernel.org
Cc:     linux-iio@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH 2/6] iio: imu: st_lsm6dsx: check if master_enable is located in primary page
Date:   Sat, 14 Dec 2019 17:52:55 +0100
Message-Id: <9301949c51a78df2c818619c3be634274f13a790.1576341963.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1576341963.git.lorenzo@kernel.org>
References: <cover.1576341963.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Check if the master enable register is located in the primary or in the
secondary memory page. This is a preliminary patch to support i2c master
controller on lsm6dsm devices

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  6 +++++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c |  2 ++
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c | 11 +++++++----
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
index fb76e0d6770d..0f8f3fbde67a 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
@@ -184,7 +184,11 @@ struct st_lsm6dsx_hw_ts_settings {
  */
 struct st_lsm6dsx_shub_settings {
 	struct st_lsm6dsx_reg page_mux;
-	struct st_lsm6dsx_reg master_en;
+	struct {
+		bool sec_page;
+		u8 addr;
+		u8 mask;
+	} master_en;
 	struct st_lsm6dsx_reg pullup_en;
 	struct st_lsm6dsx_reg aux_sens;
 	struct st_lsm6dsx_reg wr_once;
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index bf995b58c333..fe1aaaf68a9b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -867,6 +867,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = BIT(6),
 			},
 			.master_en = {
+				.sec_page = true,
 				.addr = 0x14,
 				.mask = BIT(2),
 			},
@@ -1242,6 +1243,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
 				.mask = BIT(6),
 			},
 			.master_en = {
+				.sec_page = true,
 				.addr = 0x14,
 				.mask = BIT(2),
 			},
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
index 5684e663d0aa..767482e61a1e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
@@ -185,15 +185,18 @@ static int st_lsm6dsx_shub_master_enable(struct st_lsm6dsx_sensor *sensor,
 	mutex_lock(&hw->page_lock);
 
 	hub_settings = &hw->settings->shub_settings;
-	err = st_lsm6dsx_set_page(hw, true);
-	if (err < 0)
-		goto out;
+	if (hub_settings->master_en.sec_page) {
+		err = st_lsm6dsx_set_page(hw, true);
+		if (err < 0)
+			goto out;
+	}
 
 	data = ST_LSM6DSX_SHIFT_VAL(enable, hub_settings->master_en.mask);
 	err = regmap_update_bits(hw->regmap, hub_settings->master_en.addr,
 				 hub_settings->master_en.mask, data);
 
-	st_lsm6dsx_set_page(hw, false);
+	if (hub_settings->master_en.sec_page)
+		st_lsm6dsx_set_page(hw, false);
 out:
 	mutex_unlock(&hw->page_lock);
 
-- 
2.21.0

