Return-Path: <SRS0=8cOJ=XE=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3622C49ED5
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 09:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB22B21D6C
	for <linux-iio@archiver.kernel.org>; Mon,  9 Sep 2019 09:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ev7YsAFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389108AbfIIJpQ (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:45:16 -0400
Received: from first.geanix.com ([116.203.34.67]:49140 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389015AbfIIJpP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 9 Sep 2019 05:45:15 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 41C1664179;
        Mon,  9 Sep 2019 09:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568022286; bh=MQYUVwjI4z/V7yXIG6B2PH4Wdvne4TtlKE/u4zhVdiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ev7YsAFXNGOQ+wxIm0AukNxIVtuFx+obDJHGPwSSWlKdq6NFIcR3MGMAYViBMzHx3
         F4M+j8ecgSUgQaaJ0GTSwvqXsfUrq0UURQkb2c+/7GC9vl7qQCvDaVI9vJpU5bCN/k
         k+ChZZE6wYF2CtZte0Cf0gjkLV6DLlzmRgFPz5q3oKUNGCf2S3LK2+acavapIreICi
         nPq+1nTQp32h61ikq6wFdANHlcVDIZlAOTIgcMvgLBcc5fBriSa+4jsshCAjwfSKrc
         JiWf5qX2EBUa4xrx0DPwWMhiMZDuLwFFkNjpKL8dM7gb6Mtkw1UhPoygCEjdDc72fH
         sfN1W4KsA9ktA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v5 3/6] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Mon,  9 Sep 2019 11:45:03 +0200
Message-Id: <20190909094506.51792-3-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190909094506.51792-1-sean@geanix.com>
References: <20190909094506.51792-1-sean@geanix.com>
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
Changes since v4:
 * More devices supports wakeup

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index fb83076d8f17..68df2a8d628b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1822,6 +1822,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -1840,6 +1843,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev)) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
@@ -1872,6 +1881,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev)) {
+			disable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
-- 
2.23.0

