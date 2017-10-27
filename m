Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:45794 "EHLO vps.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752699AbdJ0TaP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 27 Oct 2017 15:30:15 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 05/13] iio: health: max30102: Fix missing newline in dev_err
Date: Fri, 27 Oct 2017 21:29:45 +0200
Message-Id: <1509132593-1815-11-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 58873b7..389a483 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -262,7 +262,7 @@ static int max30102_led_init(struct max30102_data *data)
 
 	ret = max30102_get_current_idx(val, &reg);
 	if (ret) {
-		dev_err(dev, "invalid IR LED current setting %d", val);
+		dev_err(dev, "invalid IR LED current setting %d\n", val);
 		return ret;
 	}
 
-- 
2.7.4

