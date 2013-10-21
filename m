Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:46115 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753074Ab3JUJ2b (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Oct 2013 05:28:31 -0400
Received: by mail-pa0-f54.google.com with SMTP id kx10so7732460pab.13
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2013 02:28:28 -0700 (PDT)
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, sachin.kamat@linaro.org,
	Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 1/2] iio: adc: nau7802: Remove redundant of_match_ptr
Date: Mon, 21 Oct 2013 14:57:28 +0530
Message-Id: <1382347649-3382-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

nau7802_dt_ids is always compiled in. Hence of_match_ptr is not
needed.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/iio/adc/nau7802.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
index adff9cb..54c5bab 100644
--- a/drivers/iio/adc/nau7802.c
+++ b/drivers/iio/adc/nau7802.c
@@ -570,7 +570,7 @@ static struct i2c_driver nau7802_driver = {
 	.id_table = nau7802_i2c_id,
 	.driver = {
 		   .name = "nau7802",
-		   .of_match_table = of_match_ptr(nau7802_dt_ids),
+		   .of_match_table = nau7802_dt_ids,
 	},
 };
 
-- 
1.7.9.5

