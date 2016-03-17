Return-Path: <amitoj1606@gmail.com>
Date: Thu, 17 Mar 2016 19:25:11 +0530
From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tj@kernel.org, outreachy-kernel@googlegroups.com
Subject: [PATCH] iio: light: tsl2563: Remove flush_scheduled_work
Message-ID: <20160317135510.GA4831@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

flush_scheduled_work is scheduled for deprecation.
Replace cancel_delayed_work and flush_scheduled_work with
cancel_delayed_work_sync instead to ensure there is no pending or
running work item.

Since there is only one work item, chip->poweroff_work, there are 
no further dependencies of flush_scheduled_work().

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/iio/light/tsl2563.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 12731d6..57b108c 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -806,8 +806,7 @@ static int tsl2563_probe(struct i2c_client *client,
 	return 0;
 
 fail:
-	cancel_delayed_work(&chip->poweroff_work);
-	flush_scheduled_work();
+	cancel_delayed_work_sync(&chip->poweroff_work);
 	return err;
 }
 
-- 
1.9.1
