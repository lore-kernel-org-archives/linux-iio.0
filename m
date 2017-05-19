Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34621 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755022AbdESULk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 19 May 2017 16:11:40 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so3845956wrb.1
        for <linux-iio@vger.kernel.org>; Fri, 19 May 2017 13:11:39 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH] iio: imu: st_lsm6dsx: substitute ifdef CONFIG_PM with __maybe_unused macro
Date: Fri, 19 May 2017 22:11:36 +0200
Message-Id: <20170519201136.11658-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Get rid of #ifdef CONFIG_PM by adding __maybe_unused macro to
st_lsm6dsx_suspend and st_lsm6dsx_resume function declarations

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
index 1b53848cdfd8..b485540da89e 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
@@ -732,8 +732,7 @@ int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id, const char *name,
 }
 EXPORT_SYMBOL(st_lsm6dsx_probe);
 
-#ifdef CONFIG_PM
-static int st_lsm6dsx_suspend(struct device *dev)
+static int __maybe_unused st_lsm6dsx_suspend(struct device *dev)
 {
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
@@ -757,7 +756,7 @@ static int st_lsm6dsx_suspend(struct device *dev)
 	return err;
 }
 
-static int st_lsm6dsx_resume(struct device *dev)
+static int __maybe_unused st_lsm6dsx_resume(struct device *dev)
 {
 	struct st_lsm6dsx_hw *hw = dev_get_drvdata(dev);
 	struct st_lsm6dsx_sensor *sensor;
@@ -778,7 +777,6 @@ static int st_lsm6dsx_resume(struct device *dev)
 
 	return err;
 }
-#endif /* CONFIG_PM */
 
 const struct dev_pm_ops st_lsm6dsx_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(st_lsm6dsx_suspend, st_lsm6dsx_resume)
-- 
2.12.2

