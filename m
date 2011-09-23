Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/16] staging:iio:adc:ad7606 trivial code style fix.
Date: Fri, 23 Sep 2011 13:01:37 +0100
Message-Id: <1316779302-12357-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7606_core.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 7ea5232..02b0a5b 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -329,9 +329,8 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 	}
 
 	ret = gpio_request_array(gpio_array, ARRAY_SIZE(gpio_array));
-	if (!ret) {
+	if (!ret)
 		st->have_os = true;
-	}
 
 	ret = gpio_request_one(st->pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
 			       "AD7606_RESET");
-- 
1.7.3.4
