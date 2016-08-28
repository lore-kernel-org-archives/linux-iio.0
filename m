Return-Path: <baoyou.xie@linaro.org>
From: Baoyou Xie <baoyou.xie@linaro.org>
To: jic23@kernel.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linus.walleij@linaro.org,
	rob@kernel.org,
	maitysanchayan@gmail.com,
	baoyou.xie@linaro.org,
	leonard.crestez@intel.com,
	gregor.boirie@parrot.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@linaro.org,
	xie.baoyou@zte.com.cn
Subject: [PATCH v2] fix:iio:common:st_sensors:st_sensors_trigger:mark symbols static where possible
Date: Sun, 28 Aug 2016 15:04:11 +0800
Message-Id: <1472367851-14762-1-git-send-email-baoyou.xie@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

We get 2 warnings when biuld kernel with W=1:
drivers/iio/common/st_sensors/st_sensors_trigger.c:69:13: warning: no previous prototype
for 'st_sensors_irq_handler' [-Wmissing-prototypes]
drivers/iio/common/st_sensors/st_sensors_trigger.c:85:13: warning: no previous prototype
for 'st_sensors_irq_thread' [-Wmissing-prototypes]

In fact, these functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
so this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/common/st_sensors/st_sensors_trigger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
index e66f12e..fa73e67 100644
--- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
+++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
@@ -66,7 +66,7 @@ static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
  * @irq: irq number
  * @p: private handler data
  */
-irqreturn_t st_sensors_irq_handler(int irq, void *p)
+static irqreturn_t st_sensors_irq_handler(int irq, void *p)
 {
 	struct iio_trigger *trig = p;
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
@@ -82,7 +82,7 @@ irqreturn_t st_sensors_irq_handler(int irq, void *p)
  * @irq: irq number
  * @p: private handler data
  */
-irqreturn_t st_sensors_irq_thread(int irq, void *p)
+static irqreturn_t st_sensors_irq_thread(int irq, void *p)
 {
 	struct iio_trigger *trig = p;
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
-- 
2.7.4
