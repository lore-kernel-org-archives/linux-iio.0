Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:iio-trig-bfin-timer: Fix compile error
Date: Fri, 27 Sep 2013 15:50:38 +0200
Message-Id: <1380289838-27029-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

This patch fixes the following compile errors for the iio-trig-bfin-timer
driver:
	drivers/staging/iio/trigger/iio-trig-bfin-timer.c: In function ‘iio_bfin_tmr_frequency_store’:
	drivers/staging/iio/trigger/iio-trig-bfin-timer.c:121: error: invalid storage class for function ‘iio_bfin_tmr_frequency_show’
	drivers/staging/iio/trigger/iio-trig-bfin-timer.c:118: warning: ISO C90 forbids mixed declarations and code
	drivers/staging/iio/trigger/iio-trig-bfin-timer.c:135: error: initializer element is not constant
	...

The issue was introduced in commit e5e26dd5 ("staging: iio: replace
strict_strto*() with kstrto*()") by leaving an excess opening bracket.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index ebb189c..26e1ca0 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -91,7 +91,7 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	if (val > 100000) {
+	if (val > 100000)
 		return -EINVAL;
 
 	enabled = get_enabled_gptimers() & st->t->bit;
-- 
1.8.0
