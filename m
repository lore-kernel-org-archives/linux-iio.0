Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH v2 02/13] iio: health: max30102: Fix missing newline in dev_err
Date: Fri, 27 Oct 2017 21:45:32 +0200
Message-Id: <1509133543-4597-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
References: <1509133543-4597-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/health/max30102.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 147a8c1..62b1b35 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -261,7 +261,7 @@ static int max30102_led_init(struct max30102_data *data)
 
 	ret = max30102_get_current_idx(val, &reg);
 	if (ret) {
-		dev_err(dev, "invalid IR LED current setting %d", val);
+		dev_err(dev, "invalid IR LED current setting %d\n", val);
 		return ret;
 	}
 
-- 
2.7.4
