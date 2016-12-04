Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47176 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752226AbcLDCUW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:22 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 12/19] staging: iio: isl29028: fix comparison between signed and unsigned integers
Date: Sat,  3 Dec 2016 21:19:36 -0500
Message-Id: <1480817983-32359-13-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixed warning found by make W=2 to reduce the amount of build noise:

warning: comparison between signed and unsigned integer expressions
[-Wsign-compare]

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 218d165..23a4db8 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -80,7 +80,7 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
 					unsigned int sampling)
 {
 	static unsigned int prox_period[] = {800, 400, 200, 100, 75, 50, 12, 0};
-	int sel;
+	unsigned int sel;
 	unsigned int period = DIV_ROUND_UP(1000, sampling);
 
 	for (sel = 0; sel < ARRAY_SIZE(prox_period); ++sel) {
-- 
2.7.4

