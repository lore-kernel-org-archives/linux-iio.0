Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:36279 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751051AbdAUE41 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Jan 2017 23:56:27 -0500
Date: Sat, 21 Jan 2017 07:55:58 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: trigger: clean up viio_trigger_alloc()
Message-ID: <20170121045557.GE15269@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

1) Reverse the test for kmalloc() failure so we can pull everything
   back one tab.
2) Use gotos for unwinding.
3) Some of the extra line breaks for the 80 character limit are no
   longer needed so we can remove them.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 978729f..372faef 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -513,46 +513,45 @@ static void iio_trig_subirqunmask(struct irq_data *d)
 static struct iio_trigger *viio_trigger_alloc(const char *fmt, va_list vargs)
 {
 	struct iio_trigger *trig;
+	int i;
+
 	trig = kzalloc(sizeof *trig, GFP_KERNEL);
-	if (trig) {
-		int i;
-		trig->dev.type = &iio_trig_type;
-		trig->dev.bus = &iio_bus_type;
-		device_initialize(&trig->dev);
-
-		mutex_init(&trig->pool_lock);
-		trig->subirq_base
-			= irq_alloc_descs(-1, 0,
-					  CONFIG_IIO_CONSUMERS_PER_TRIGGER,
-					  0);
-		if (trig->subirq_base < 0) {
-			kfree(trig);
-			return NULL;
-		}
+	if (!trig)
+		return NULL;
 
-		trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
-		if (trig->name == NULL) {
-			irq_free_descs(trig->subirq_base,
-				       CONFIG_IIO_CONSUMERS_PER_TRIGGER);
-			kfree(trig);
-			return NULL;
-		}
-		trig->subirq_chip.name = trig->name;
-		trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
-		trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
-		for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
-			irq_set_chip(trig->subirq_base + i,
-				     &trig->subirq_chip);
-			irq_set_handler(trig->subirq_base + i,
-					&handle_simple_irq);
-			irq_modify_status(trig->subirq_base + i,
-					  IRQ_NOREQUEST | IRQ_NOAUTOEN,
-					  IRQ_NOPROBE);
-		}
-		get_device(&trig->dev);
+	trig->dev.type = &iio_trig_type;
+	trig->dev.bus = &iio_bus_type;
+	device_initialize(&trig->dev);
+
+	mutex_init(&trig->pool_lock);
+	trig->subirq_base = irq_alloc_descs(-1, 0,
+					    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
+					    0);
+	if (trig->subirq_base < 0)
+		goto free_trig;
+
+	trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
+	if (trig->name == NULL)
+		goto free_descs;
+
+	trig->subirq_chip.name = trig->name;
+	trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
+	trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
+	for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
+		irq_set_chip(trig->subirq_base + i, &trig->subirq_chip);
+		irq_set_handler(trig->subirq_base + i, &handle_simple_irq);
+		irq_modify_status(trig->subirq_base + i,
+				  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
 	}
+	get_device(&trig->dev);
 
 	return trig;
+
+free_descs:
+	irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
+free_trig:
+	kfree(trig);
+	return NULL;
 }
 
 struct iio_trigger *iio_trigger_alloc(const char *fmt, ...)
