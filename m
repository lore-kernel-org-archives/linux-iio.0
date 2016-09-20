Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:56806 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932163AbcITJrY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Sep 2016 05:47:24 -0400
From: Brian Masney <masneyb@onstation.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 2/2] staging: iio: isl29018: fix alignment of function arguments
Date: Tue, 20 Sep 2016 05:38:57 -0400
Message-Id: <1474364337-13949-2-git-send-email-masneyb@onstation.org>
In-Reply-To: <1474364337-13949-1-git-send-email-masneyb@onstation.org>
References: <1474364337-13949-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Address warning from checkpatch:

CHECK: Alignment should match open parenthesis

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index ea4d7f1..4401451 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -607,8 +607,8 @@ static int isl29018_chip_init(struct isl29018_chip *chip)
 		return status;
 	}
 
-	status = isl29018_set_integration_time(chip,
-			isl29018_int_utimes[chip->type][chip->int_time]);
+	status = isl29018_set_integration_time(
+			chip, isl29018_int_utimes[chip->type][chip->int_time]);
 	if (status < 0) {
 		dev_err(dev, "Init of isl29018 fails\n");
 		return status;
-- 
2.7.4

