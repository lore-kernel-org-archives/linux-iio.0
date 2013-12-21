Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:61048 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472Ab3LUKKh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Dec 2013 05:10:37 -0500
Received: by mail-pd0-f181.google.com with SMTP id p10so3487676pdj.40
        for <linux-iio@vger.kernel.org>; Sat, 21 Dec 2013 02:10:37 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 1/1] iio: cm36651: Remove redundant of_match_ptr helper
Date: Sat, 21 Dec 2013 15:37:21 +0530
Message-Id: <1387620441-28694-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'cm36651_of_match' is always compiled in. Hence the
helper macro is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/iio/light/cm36651.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm36651.c b/drivers/iio/light/cm36651.c
index 0922e39b0ea9..328ef3d760c3 100644
--- a/drivers/iio/light/cm36651.c
+++ b/drivers/iio/light/cm36651.c
@@ -693,7 +693,7 @@ static const struct of_device_id cm36651_of_match[] = {
 static struct i2c_driver cm36651_driver = {
 	.driver = {
 		.name	= "cm36651",
-		.of_match_table = of_match_ptr(cm36651_of_match),
+		.of_match_table = cm36651_of_match,
 		.owner	= THIS_MODULE,
 	},
 	.probe		= cm36651_probe,
-- 
1.7.9.5

