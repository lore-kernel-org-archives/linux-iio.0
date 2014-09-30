Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:55999 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750791AbaI3MAc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 30 Sep 2014 08:00:32 -0400
Received: by mail-pd0-f169.google.com with SMTP id p10so7185576pdj.14
        for <linux-iio@vger.kernel.org>; Tue, 30 Sep 2014 05:00:31 -0700 (PDT)
From: Darshana Padmadas <darshanapadmadas@gmail.com>
To: opw-kernel@googlegroups.com
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Darshana Padmadas <darshanapadmadas@gmail.com>
Subject: [PATCH v3 3/4] Staging: iio: light: Added correct vendor-prefix for device isl29028
Date: Tue, 30 Sep 2014 17:29:07 +0530
Message-Id: <1412078348-7646-4-git-send-email-darshanapadmadas@gmail.com>
In-Reply-To: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
References: <1412078348-7646-1-git-send-email-darshanapadmadas@gmail.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds the correct vendor-prefix for device isl29028 and
maintains deprecated vendor-prefix found by checkpatch warning
for older kernel releases.

Signed-off-by: Darshana Padmadas <darshanapadmadas@gmail.com>
---
 drivers/staging/iio/light/isl29028.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 6014625..60b02a8 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -537,7 +537,8 @@ static const struct i2c_device_id isl29028_id[] = {
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
 
 static const struct of_device_id isl29028_of_match[] = {
-	{ .compatible = "isil,isl29028", },
+	{ .compatible = "isl,isl29028", },
+	{ .compatible = "isil,isl29028", }, /* deprecated, don't use */
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
-- 
1.9.1

