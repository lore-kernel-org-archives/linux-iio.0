Return-Path: <SRS0=iV6u=XL=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCD9C4CECD
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 12:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65EE21848
	for <linux-iio@archiver.kernel.org>; Mon, 16 Sep 2019 12:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="cBQrgLEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732656AbfIPMfH (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 16 Sep 2019 08:35:07 -0400
Received: from first.geanix.com ([116.203.34.67]:58050 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732604AbfIPMfH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 16 Sep 2019 08:35:07 -0400
Received: from zen.localdomain (unknown [85.184.140.241])
        by first.geanix.com (Postfix) with ESMTPSA id 6341765755;
        Mon, 16 Sep 2019 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1568637246; bh=3QEP5Q7V7Lb/3oEETVdkhhzkOmODUyiUssMv6rhoglk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=cBQrgLEnuHIOZ4K0RG3QTJ2OXhuHc2ne+57zZka8qpeQY9DnBTf/QzHwLnl6Y0Fm4
         VNh0+HtSUbTSDwQYJKXF3Ze24XYOGDv1UXwZwSxhGniGjiR4+b3y2uJdQOaPW0awxZ
         c+8fO6J5Ca/GKv7BPdZ1UQNVcHvVK5L9jWmEWzmZ6VhKTT41c6cDijt57hFDZfr5uS
         txluEJ3oNXDZHQbsMxj5uJfd8OB64Z2vo+Z/mqOvbxdQeW8JV/IbLDmDkW0Qrn054U
         StKmyOSXNsO+L8358meDukw5NNcdeXw94yxQ4b6xNN6YxUF/91zYsfVZydwWxXTHPL
         kX5tbxF3uMzDA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     linux-iio@vger.kernel.org, jic23@kernel.org,
        lorenzo.bianconi83@gmail.com
Cc:     Sean Nyekjaer <sean@geanix.com>, denis.ciocca@st.com,
        mario.tesi@st.com, armando.visconti@st.com, martin@geanix.com
Subject: [PATCH v9 3/6] iio: imu: st_lsm6dsx: add wakeup-source option
Date:   Mon, 16 Sep 2019 14:34:53 +0200
Message-Id: <20190916123456.1742253-3-sean@geanix.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916123456.1742253-1-sean@geanix.com>
References: <20190916123456.1742253-1-sean@geanix.com>
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

Changes since v5:
 * None

Changes since v6:
 * None

Changes since v7:
 * Add check for hw->enable_event
 * Moved disable_irq_wake section so it's called
 * Removed not neeeded continue from disable_irq_wake section

Changes since v8:
 * Using sensor->id instead of i in suspend/resume loops

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 4198ba263d03..a7f12cf57f11 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -1858,6 +1858,9 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
 			return err;
 	}
 
+	if (dev->of_node && of_property_read_bool(dev->of_node, "wakeup-source"))
+		device_init_wakeup(dev, true);
+
 	return 0;
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
@@ -1876,6 +1879,13 @@ static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 		if (!(hw->enable_mask & BIT(sensor->id)))
 			continue;
 
+		if (device_may_wakeup(dev) &&
+		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event) {
+			/* Enable wake from IRQ */
+			enable_irq_wake(hw->irq);
+			continue;
+		}
+
 		if (sensor->id == ST_LSM6DSX_ID_EXT0 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT1 ||
 		    sensor->id == ST_LSM6DSX_ID_EXT2)
@@ -1905,6 +1915,10 @@ static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 			continue;
 
 		sensor = iio_priv(hw->iio_devs[i]);
+		if (device_may_wakeup(dev) &&
+		    sensor->id == ST_LSM6DSX_ID_ACC && hw->enable_event)
+			disable_irq_wake(hw->irq);
+
 		if (!(hw->suspend_mask & BIT(sensor->id)))
 			continue;
 
-- 
2.23.0

