Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	tglx@linutronix.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 14/21] irq: export handle_simple_irq and irq_to_desc to allow for virtual irqs in IIO
Date: Thu, 31 Mar 2011 15:54:08 +0100
Message-Id: <1301583255-28468-15-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
References: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

---
 kernel/irq/chip.c    |    1 +
 kernel/irq/irqdesc.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index c9c0601..4647fe9 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -431,6 +431,7 @@ handle_simple_irq(unsigned int irq, struct irq_desc *desc)
 out_unlock:
 	raw_spin_unlock(&desc->lock);
 }
+EXPORT_SYMBOL_GPL(handle_simple_irq);
 
 /**
  *	handle_level_irq - Level type irq handler
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 6fb014f..0403c5a 100644
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
