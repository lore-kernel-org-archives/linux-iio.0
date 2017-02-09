Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:39944 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751026AbdBICEl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 8 Feb 2017 21:04:41 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        ldewangan@nvidia.com
Subject: [PATCH 4/7] staging: iio: isl29028: use the runtime power management for system sleep
Date: Wed,  8 Feb 2017 20:54:28 -0500
Message-Id: <20170209015431.17380-5-masneyb@onstation.org>
In-Reply-To: <20170209015431.17380-1-masneyb@onstation.org>
References: <20170209015431.17380-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

With the introduction of runtime power management in commit 2db5054ac28d
("staging: iio: isl29028: add runtime power management support"), the
system could go to sleep and turn off the device without notifying the
runtime power management code. This patch changes the system suspend
and resume to go through the runtime power management.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index b63fdf70..ddd604d 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -656,7 +656,8 @@ static int __maybe_unused isl29028_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops isl29028_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(isl29028_suspend, isl29028_resume)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
 	SET_RUNTIME_PM_OPS(isl29028_suspend, isl29028_resume, NULL)
 };
 
-- 
2.9.3

