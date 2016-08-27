Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f170.google.com ([209.85.192.170]:33152 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbcH0G1B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Aug 2016 02:27:01 -0400
Received: by mail-pf0-f170.google.com with SMTP id y134so35158698pfg.0
        for <linux-iio@vger.kernel.org>; Fri, 26 Aug 2016 23:27:01 -0700 (PDT)
From: Baoyou Xie <baoyou.xie@linaro.org>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Cc: linus.walleij@linaro.org, rob@kernel.org, maitysanchayan@gmail.com,
        baoyou.xie@linaro.org, leonard.crestez@intel.com,
        gregor.boirie@parrot.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@linaro.org,
        xie.baoyou@zte.com.cn
Subject: [PATCH] fix:iio:common:st_sensors:st_sensors_trigger:mark symbols static where possible
Date: Sat, 27 Aug 2016 14:26:30 +0800
Message-Id: <1472279190-23169-1-git-send-email-baoyou.xie@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We get 2 warnings when biuld kernel with W=1:
drivers/iio/common/st_sensors/st_sensors_trigger.c:69:13: warning: no previous prototype
for 'st_sensors_irq_handler' [-Wmissing-prototypes]
drivers/iio/common/st_sensors/st_sensors_trigger.c:85:13: warning: no previous prototype
for 'st_sensors_irq_thread' [-Wmissing-prototypes]

In fact, these functions are only used in the file in which they are
declared and don't need a declaration, but can be made static.
so this patch marks these functions with 'static'.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
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

