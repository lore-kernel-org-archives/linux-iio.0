Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] iio:prox:sx9500 trivial simplification of return path in init function.
Date: Sat,  2 May 2015 11:29:42 +0100
Message-Id: <1430562582-27932-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index f1e9d734b6b6..323de9510ba5 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -860,10 +860,8 @@ static int sx9500_init_device(struct iio_dev *indio_dev)
 	}
 
 	ret = sx9500_init_compensation(indio_dev);
-	if (ret < 0)
-		return ret;
 
-	return 0;
+	return ret;
 }
 
 static void sx9500_gpio_probe(struct i2c_client *client,
-- 
2.3.5
