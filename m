Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:55574 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752117AbaG1LT3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 28 Jul 2014 07:19:29 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: linux-iio@vger.kernel.org
Cc: Teodora Baluta <teodora.baluta@intel.com>
Subject: [PATCH 4/5] staging: iio: isl29018: fix sparse warning regarding incorrect type (different signedness)
Date: Mon, 28 Jul 2014 14:18:32 +0300
Message-Id: <1406546313-23031-5-git-send-email-teodora.baluta@intel.com>
In-Reply-To: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
References: <1406546313-23031-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the following sparse warning:

drivers/staging/iio/light/isl29018.c:508:50: warning: incorrect type in
argument 3 (different signedness)
drivers/staging/iio/light/isl29018.c:508:50:    expected unsigned int
*conf_adc_bit
drivers/staging/iio/light/isl29018.c:508:50:    got int *<noident>

Signed-off-by: Teodora Baluta <teodora.baluta@intel.com>
---
 drivers/staging/iio/light/isl29018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 3660a43..86cc8f9 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -454,7 +454,7 @@ static const struct attribute_group isl29108_group = {
 static int isl29018_chip_init(struct isl29018_chip *chip)
 {
 	int status;
-	int new_adc_bit;
+	unsigned int new_adc_bit;
 	unsigned int new_range;
 
 	/* Code added per Intersil Application Note 1534:
-- 
1.9.1

