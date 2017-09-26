Return-Path: <SRS0=GbmP=A3=bgdev.pl=brgl@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] iio: dummy: evgen: use irq_sim
Date: Tue, 26 Sep 2017 18:49:10 +0200
Message-Id: <20170926164910.31137-1-brgl@bgdev.pl>
List-ID: <linux-iio@vger.kernel.org>

Switch to using the recently added interrupt simulator for dummy irqs.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
bloat-o-meter output:
add/remove: 0/3 grow/shrink: 1/5 up/down: 12/-540 (-528)
function                                     old     new   delta
iio_dummy_evgen_get_irq                      136     148     +12
iio_evgen_release                             40      36      -4
iio_dummy_evgen_get_regs                      32      28      -4
iio_dummy_work_handler                        20       -     -20
iio_dummy_event_irqunmask                     32       -     -32
iio_dummy_event_irqmask                       32       -     -32
iio_evgen_poke                               140     100     -40
init_module                                  376     172    -204
iio_dummy_evgen_init                         376     172    -204
Total: Before=2804, After=2276, chg -18.83%

 drivers/iio/dummy/Kconfig           |  2 +-
 drivers/iio/dummy/iio_dummy_evgen.c | 91 ++++++++-----------------------------
 2 files changed, 20 insertions(+), 73 deletions(-)

diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index aa5824d96a43..5a29fbd3c531 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -5,7 +5,7 @@ menu "IIO dummy driver"
 	depends on IIO
 
 config IIO_DUMMY_EVGEN
-	select IRQ_WORK
+	select IRQ_SIM
 	tristate
 
 config IIO_SIMPLE_DUMMY
diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index 9e83f348df51..29e1e402388e 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -24,97 +24,44 @@
 #include "iio_dummy_evgen.h"
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/irq_work.h>
+#include <linux/irq_sim.h>
 
 /* Fiddly bit of faking and irq without hardware */
 #define IIO_EVENTGEN_NO 10
 
 /**
- * struct iio_dummy_handle_irq - helper struct to simulate interrupt generation
- * @work: irq_work used to run handlers from hardirq context
- * @irq: fake irq line number to trigger an interrupt
- */
-struct iio_dummy_handle_irq {
-	struct irq_work work;
-	int irq;
-};
-
-/**
- * struct iio_dummy_evgen - evgen state
- * @chip: irq chip we are faking
- * @base: base of irq range
- * @enabled: mask of which irqs are enabled
- * @inuse: mask of which irqs are connected
  * @regs: irq regs we are faking
  * @lock: protect the evgen state
- * @handler: helper for a 'hardware-like' interrupt simulation
+ * @inuse: mask of which irqs are connected
+ * @irq_sim: interrupt simulator
+ * @base: base of irq range
  */
 struct iio_dummy_eventgen {
-	struct irq_chip chip;
-	int base;
-	bool enabled[IIO_EVENTGEN_NO];
-	bool inuse[IIO_EVENTGEN_NO];
 	struct iio_dummy_regs regs[IIO_EVENTGEN_NO];
 	struct mutex lock;
-	struct iio_dummy_handle_irq handler;
+	bool inuse[IIO_EVENTGEN_NO];
+	struct irq_sim irq_sim;
+	int base;
 };
 
 /* We can only ever have one instance of this 'device' */
 static struct iio_dummy_eventgen *iio_evgen;
-static const char *iio_evgen_name = "iio_dummy_evgen";
-
-static void iio_dummy_event_irqmask(struct irq_data *d)
-{
-	struct irq_chip *chip = irq_data_get_irq_chip(d);
-	struct iio_dummy_eventgen *evgen =
-		container_of(chip, struct iio_dummy_eventgen, chip);
-
-	evgen->enabled[d->irq - evgen->base] = false;
-}
-
-static void iio_dummy_event_irqunmask(struct irq_data *d)
-{
-	struct irq_chip *chip = irq_data_get_irq_chip(d);
-	struct iio_dummy_eventgen *evgen =
-		container_of(chip, struct iio_dummy_eventgen, chip);
-
-	evgen->enabled[d->irq - evgen->base] = true;
-}
-
-static void iio_dummy_work_handler(struct irq_work *work)
-{
-	struct iio_dummy_handle_irq *irq_handler;
-
-	irq_handler = container_of(work, struct iio_dummy_handle_irq, work);
-	handle_simple_irq(irq_to_desc(irq_handler->irq));
-}
 
 static int iio_dummy_evgen_create(void)
 {
-	int ret, i;
+	int ret;
 
 	iio_evgen = kzalloc(sizeof(*iio_evgen), GFP_KERNEL);
 	if (!iio_evgen)
 		return -ENOMEM;
 
-	iio_evgen->base = irq_alloc_descs(-1, 0, IIO_EVENTGEN_NO, 0);
-	if (iio_evgen->base < 0) {
-		ret = iio_evgen->base;
-		kfree(iio_evgen);
+	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
+	if (ret)
 		return ret;
-	}
-	iio_evgen->chip.name = iio_evgen_name;
-	iio_evgen->chip.irq_mask = &iio_dummy_event_irqmask;
-	iio_evgen->chip.irq_unmask = &iio_dummy_event_irqunmask;
-	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
-		irq_set_chip(iio_evgen->base + i, &iio_evgen->chip);
-		irq_set_handler(iio_evgen->base + i, &handle_simple_irq);
-		irq_modify_status(iio_evgen->base + i,
-				  IRQ_NOREQUEST | IRQ_NOAUTOEN,
-				  IRQ_NOPROBE);
-	}
-	init_irq_work(&iio_evgen->handler.work, iio_dummy_work_handler);
+
+	iio_evgen->base = irq_sim_irqnum(&iio_evgen->irq_sim, 0);
 	mutex_init(&iio_evgen->lock);
+
 	return 0;
 }
 
@@ -132,15 +79,17 @@ int iio_dummy_evgen_get_irq(void)
 		return -ENODEV;
 
 	mutex_lock(&iio_evgen->lock);
-	for (i = 0; i < IIO_EVENTGEN_NO; i++)
+	for (i = 0; i < IIO_EVENTGEN_NO; i++) {
 		if (!iio_evgen->inuse[i]) {
-			ret = iio_evgen->base + i;
+			ret = irq_sim_irqnum(&iio_evgen->irq_sim, i);
 			iio_evgen->inuse[i] = true;
 			break;
 		}
+	}
 	mutex_unlock(&iio_evgen->lock);
 	if (i == IIO_EVENTGEN_NO)
 		return -ENOMEM;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_irq);
@@ -167,7 +116,7 @@ EXPORT_SYMBOL_GPL(iio_dummy_evgen_get_regs);
 
 static void iio_dummy_evgen_free(void)
 {
-	irq_free_descs(iio_evgen->base, IIO_EVENTGEN_NO);
+	irq_sim_fini(&iio_evgen->irq_sim);
 	kfree(iio_evgen);
 }
 
@@ -192,9 +141,7 @@ static ssize_t iio_evgen_poke(struct device *dev,
 	iio_evgen->regs[this_attr->address].reg_id   = this_attr->address;
 	iio_evgen->regs[this_attr->address].reg_data = event;
 
-	iio_evgen->handler.irq = iio_evgen->base + this_attr->address;
-	if (iio_evgen->enabled[this_attr->address])
-		irq_work_queue(&iio_evgen->handler.work);
+	irq_sim_fire(&iio_evgen->irq_sim, this_attr->address);
 
 	return len;
 }
-- 
2.13.2
