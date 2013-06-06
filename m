Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de,
	kbuild-all@01.org,
	Fengguang Wu <fengguang.wu@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio:trigger:interrupt fix formatting of rsize variable in name
Date: Thu,  6 Jun 2013 19:24:54 +0100
Message-Id: <1370543094-10248-1-git-send-email-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The name includes irq_res->start which of type resource_size_t not integer.
We could in theory use %pa for this but then it would be in hex and also
that causes a warning about incorrect types anyway.  Hence just
use the irq local variable we assigned the line above.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/trigger/iio-trig-interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
index 84bf397..0a6756d 100644
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ b/drivers/iio/trigger/iio-trig-interrupt.c
@@ -50,7 +50,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
 
 	irq = irq_res->start;
 
-	trig = iio_trigger_alloc("irqtrig%d", irq_res->start);
+	trig = iio_trigger_alloc("irqtrig%zu", irq_res->start);
 	if (!trig) {
 		ret = -ENOMEM;
 		goto error_ret;
-- 
1.8.3
