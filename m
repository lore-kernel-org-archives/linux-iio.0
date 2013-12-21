Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:48618 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668Ab3LUKFw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Dec 2013 05:05:52 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so3504227pde.13
        for <linux-iio@vger.kernel.org>; Sat, 21 Dec 2013 02:05:51 -0800 (PST)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org
Subject: [PATCH 1/1] staging: iio: hmc5843: Remove redundant of_match_ptr helper
Date: Sat, 21 Dec 2013 15:32:28 +0530
Message-Id: <1387620148-27989-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

'hmc5843_of_match' is always compiled in. Hence the helper
macro is not needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 8802f72bedde..d4f4dd90c699 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -639,7 +639,7 @@ static struct i2c_driver hmc5843_driver = {
 	.driver = {
 		.name	= "hmc5843",
 		.pm	= HMC5843_PM_OPS,
-		.of_match_table = of_match_ptr(hmc5843_of_match),
+		.of_match_table = hmc5843_of_match,
 	},
 	.id_table	= hmc5843_id,
 	.probe		= hmc5843_probe,
-- 
1.7.9.5

