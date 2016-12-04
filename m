Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47168 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751950AbcLDCUX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:23 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: [PATCH 19/19] staging: iio: isl29028: remove legacy device tree binding
Date: Sat,  3 Dec 2016 21:19:43 -0500
Message-Id: <1480817983-32359-20-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The isl29028 staging driver contains a legacy binding of "isl,isl29028"
that is marked as legacy and to not use. There are no in tree references
to that binding. This patch removes the legacy binding in preparation
for moving the driver out of staging. Otherwise, we will have to support
this binding indefinitely.

Signed-off-by: Brian Masney <masneyb@onstation.org>
Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>
---
 drivers/staging/iio/light/isl29028.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index ae6896f..6be9aa7 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -611,7 +611,6 @@ static const struct i2c_device_id isl29028_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
 static const struct of_device_id isl29028_of_match[] = {
-	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
 	{ .compatible = "isil,isl29028", },
 	{ },
 };
-- 
2.7.4

