Return-Path: <cristina.opriceana@gmail.com>
Date: Tue, 11 Aug 2015 13:18:18 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 1/2] Staging: iio: trigger: Alignment should match open
 parenthesis
Message-ID: <0146dc807925c66b3098993e4cc2f3a0a0a4f746.1439286814.git.cristina.opriceana@gmail.com>
References: <cover.1439286814.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1439286814.git.cristina.opriceana@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fix alignment for function parameters as suggested by checkpatch.pl.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c   | 7 ++++---
 drivers/staging/iio/trigger/iio-trig-periodic-rtc.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 3c1c8c6..9fe48ef 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -79,7 +79,8 @@ static int iio_bfin_tmr_set_state(struct iio_trigger *trig, bool state)
 }
 
 static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t count)
+					    struct device_attribute *attr,
+					    const char *buf, size_t count)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
@@ -116,8 +117,8 @@ static ssize_t iio_bfin_tmr_frequency_store(struct device *dev,
 }
 
 static ssize_t iio_bfin_tmr_frequency_show(struct device *dev,
-				 struct device_attribute *attr,
-				 char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	struct iio_trigger *trig = to_iio_trigger(dev);
 	struct bfin_tmr_state *st = iio_trigger_get_drvdata(trig);
diff --git a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
index 0c1976d..a2a42c2 100644
--- a/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
+++ b/drivers/staging/iio/trigger/iio-trig-periodic-rtc.c
@@ -37,7 +37,7 @@ static int iio_trig_periodic_rtc_set_state(struct iio_trigger *trig, bool state)
 	if (trig_info->frequency == 0 && state)
 		return -EINVAL;
 	dev_dbg(&trig_info->rtc->dev, "trigger frequency is %u\n",
-			trig_info->frequency);
+		trig_info->frequency);
 	ret = rtc_irq_set_state(trig_info->rtc, &trig_info->task, state);
 	if (ret == 0)
 		trig_info->state = state;
-- 
1.9.1
