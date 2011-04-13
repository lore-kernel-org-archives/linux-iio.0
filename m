Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH] irq: export handle_simple_irq, irq_modify_status and irq_to_desc
Date: Wed, 13 Apr 2011 17:35:06 +0100
Message-Id: <1302712506-30560-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This is to allow their use in IIO. We have complete control of
both the irq_chip creation and requesting of irqs so would like
to be able to build as a module. That requires these exports.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---

Exports irq_modify_status in addition to those in the
previous version. This is in response to Thomas'
comments on use of set_irq_flags within drivers.
http://marc.info/?l=linux-iio&m=130158653209132&w=2

Exports are now _GPL as requested.

 kernel/irq/chip.c    |    2 ++
 kernel/irq/irqdesc.c |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 616ec1c..d2c78be 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -310,6 +310,7 @@ handle_simple_irq(unsigned int irq, struct irq_desc *desc)
 out_unlock:
 	raw_spin_unlock(&desc->lock);
 }
+EXPORT_SYMBOL_GPL(handle_simple_irq);
 
 /**
  *	handle_level_irq - Level type irq handler
@@ -612,6 +613,7 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 
 	irq_put_desc_unlock(desc, flags);
 }
+EXPORT_SYMBOL_GPL(irq_modify_status);
 
 /**
  *	irq_cpu_online - Invoke all irq_cpu_online functions.
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 2c039c9..e90b3d9 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -110,6 +110,7 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 {
 	return radix_tree_lookup(&irq_desc_tree, irq);
 }
+EXPORT_SYMBOL_GPL(irq_to_desc);
 
 static void delete_irq_desc(unsigned int irq)
 {
-- 
1.7.3.4
