Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:48234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965786AbdIZHFM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 26 Sep 2017 03:05:12 -0400
Date: Tue, 26 Sep 2017 08:05:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] iio:stm32-lp-timer and ep93xx: drop assign
 iio_info.driver_module and iio_trigger_ops.owner
Message-ID: <20170926080508.740a6158@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements have gone away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
Greg, please take this one directly for staging-next.  This should fix
the build failures Stephen is seeing with linux-next.  Thanks!

Sorry about this one. I somehow completely failed to realise that the
two drivers that went into mainline via other trees last cycle, were
not yet in my local branch when I last tested this set.

Hindsight shows I should have done this in two goes with the change
in pull request 1 and the actual removal a while later.

Sorry for the waste of time.  Obviously this will cause bisection issues
but hopefully not that many people will try bisect anything with these two
obscure drivers.

 drivers/iio/adc/ep93xx_adc.c                | 1 -
 drivers/iio/counter/stm32-lptimer-cnt.c     | 1 -
 drivers/iio/trigger/stm32-lptimer-trigger.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/iio/adc/ep93xx_adc.c b/drivers/iio/adc/ep93xx_adc.c
index a179ac476c6d..81c901507ad2 100644
--- a/drivers/iio/adc/ep93xx_adc.c
+++ b/drivers/iio/adc/ep93xx_adc.c
@@ -150,7 +150,6 @@ static int ep93xx_read_raw(struct iio_dev *iiodev,
 }
 
 static const struct iio_info ep93xx_adc_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = ep93xx_read_raw,
 };
 
diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
index 1c5909bb1605..81ae5f74216d 100644
--- a/drivers/iio/counter/stm32-lptimer-cnt.c
+++ b/drivers/iio/counter/stm32-lptimer-cnt.c
@@ -178,7 +178,6 @@ static int stm32_lptim_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info stm32_lptim_cnt_iio_info = {
 	.read_raw = stm32_lptim_read_raw,
 	.write_raw = stm32_lptim_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const char *const stm32_lptim_quadrature_modes[] = {
diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index 241eae6a4306..de361d879929 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -37,7 +37,6 @@ static int stm32_lptim_validate_device(struct iio_trigger *trig,
 }
 
 static const struct iio_trigger_ops stm32_lptim_trigger_ops = {
-	.owner = THIS_MODULE,
 	.validate_device = stm32_lptim_validate_device,
 };
 
-- 
2.14.1

