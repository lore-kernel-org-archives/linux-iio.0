Return-Path: <SRS0=m8fg=XB=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16683C00307
	for <linux-iio@archiver.kernel.org>; Fri,  6 Sep 2019 12:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA58C2173B
	for <linux-iio@archiver.kernel.org>; Fri,  6 Sep 2019 12:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="GTmbFYU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391964AbfIFMR0 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:17:26 -0400
Received: from first.geanix.com ([116.203.34.67]:41578 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391959AbfIFMR0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 6 Sep 2019 08:17:26 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 7A46063946;
        Fri,  6 Sep 2019 12:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567772229; bh=A0M1+YjzHnG0X4/QpttQ3haH+usEQms/zA/N5Sg0pWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GTmbFYU88vvFuPdMBrwHQdsCf//AtCoSXg1o7mCOzliERrvpCYNm4J0u9D1fYGno0
         Bhv0nzv9gR7wLmxeeqwsdjlUFMDstQ05fdDQc4JA/4T7/qymFWkqPzoyCKuMxtAMAP
         usHpf1A3/OnSJtP2rg3QHAxkGncGWBRDdnxVFGCiwg3fLeFRxA/6VP7ccbsaqoDlWF
         dMLcxgqO8v57YH54YSlvu2Nx+7kTEQD4ygZol+Wfm5jps2geYxt43zZSCoRYVN0lbC
         q1XS6SJiwWeIKSCeJ/+kl0bOYRvuhiUJ21G7SB0L7Wg5DmWHyLBCY2w0/KDw5yZbCg
         MxtL3Odxiq8hw==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v4 3/6] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Fri,  6 Sep 2019 14:17:13 +0200
Message-Id: <20190906121716.66194-3-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190906121716.66194-1-sean@geanix.com>
References: <20190906121716.66194-1-sean@geanix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This add ways for the SoC to wake from accelerometer wake events.

In the suspend function we skip disabling the sensor if wakeup-source
and events are activated.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 7761ee5b1ec7..2dda0f90a816 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1755,6 +1755,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -1773,6 +1776,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
@@ -1805,6 +1814,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev) && i == ST_LSM6DSX_ID_ACC) {
+			disable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
-- 
2.23.0

