Return-Path: <SRS0=9d48=W7=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F083C3A5A9
	for <linux-iio@archiver.kernel.org>; Wed,  4 Sep 2019 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7708B23401
	for <linux-iio@archiver.kernel.org>; Wed,  4 Sep 2019 09:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="VW8475oZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfIDJRr (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 4 Sep 2019 05:17:47 -0400
Received: from first.geanix.com ([116.203.34.67]:60372 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbfIDJRq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 4 Sep 2019 05:17:46 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id DB57B62F94;
        Wed,  4 Sep 2019 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1567588659; bh=HN2Hl3Yt62nQY3y7v8ExydQMEijFr3Hsz7kZ8cPtmRM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VW8475oZx/bY0JfuGqSBcwT6OmF0/d72jFVUPd4+fcqsX/biNLdz4G4FJqN2GWnKb
         wzMmonWy7B+Pt09aGF3k9b5mrC4uR4vZa+CoZpRz6zhiSMDhktrUvHXcDVR3CYWYIe
         ac9QE3jhRO+6xtPCOuzMUFMLzy/OjsicakQkhfrI7yw+blk8ZyDWjpM/s9IJL8ASJF
         dkMu0/3mIT+low+WavQWJxyX896sF+8dQgQI7NqyC9Jp5Wj3RE0MJWz5SKANr8FXRG
         bThsvhNvYdZ5le8Bza50PVOdwgLSygmPhD84eAmaD48pBmV5CbJQjeCbf0dta1wUPP
         +hfQ787bBXZLQ==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v3 3/6] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Wed,  4 Sep 2019 11:17:29 +0200
Message-Id: <20190904091732.112281-3-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904091732.112281-1-sean@geanix.com>
References: <20190904091732.112281-1-sean@geanix.com>
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
Changes since v1:
 * none, as the call to st_lsm6dsx_flush_fifo will put the fifo in
   bypass mode.

Changes since v2:
 * Removed unnecessary brackets
 * Move enable_irq to after the enable mask

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index d4d6ba934b6d..bb72800bf99b 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1754,6 +1754,10 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (dev->of_node)
+		if (of_property_read_bool(dev->of_node, "wakeup-source"))
+			device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -1772,6 +1776,12 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
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
@@ -1804,6 +1814,11 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
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

