Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v3 3/5] staging: iio: isl29018: fixed race condition in in_illuminance_scale_available_show()
Date: Mon, 26 Sep 2016 20:20:18 -0400
Message-Id: <1474935620-13151-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1474935620-13151-1-git-send-email-masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
In-Reply-To: <20160926075935.GA25938@kroah.com>
References: <20160926075935.GA25938@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

in_illuminance_scale_available_show() references the
isl29018_chip->int_time variable in three places inside a for loop.
The value of the int_time variable can be updated by the
isl29018_set_integration_time() function, which is called by the
isl29018_write_raw() function. isl29018_write_raw() locks a
mutex specific to this driver when the integration time variable is
updated.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 19f282c..990c6e5 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -277,10 +277,12 @@ static ssize_t in_illuminance_scale_available_show
 	unsigned int i;
 	int len = 0;
 
+	mutex_lock(&chip->lock);
 	for (i = 0; i < ARRAY_SIZE(isl29018_scales[chip->int_time]); ++i)
 		len += sprintf(buf + len, "%d.%06d ",
 			       isl29018_scales[chip->int_time][i].scale,
 			       isl29018_scales[chip->int_time][i].uscale);
+	mutex_unlock(&chip->lock);
 
 	buf[len - 1] = '\n';
 
-- 
2.7.4
