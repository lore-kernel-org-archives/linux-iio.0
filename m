Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:46193 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754818Ab1CSRPP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Mar 2011 13:15:15 -0400
Message-ID: <4D84E4E7.3080108@cam.ac.uk>
Date: Sat, 19 Mar 2011 17:16:23 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Exporting a few bits of irq infrastructure.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Thomas,

Just a quick enquiry.  Is there a reason to not allow
exporting the symbols handle_simple_irq and irq_to_desc?
Or is it simply a case that there is not normally a reason
for having irq chips registered via modules?

My implementation of what I think you were suggesting the other
day for handling our IIO triggers registers a separate irq
chip for each trigger (currently with a compile time number
of irq's per trigger).  These are allocated from a pool set
up in a boards platform init code. The device drivers can then query to
get the next available irq for a given trigger and request
that.  Some trigggers are entirely instantiated based on
a request form userspace (or should be anyway - see Arnd's observations
on iio-trig-sysfs).  This could be done with a layer of indirection, but
that would be annoyingly fiddly!

Anyhow, right now the patch is dependent on (cut out of a larger patch)

iff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index baa5c4a..eb3d53b 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -487,6 +487,7 @@ handle_simple_irq(unsigned int irq, struct irq_desc *desc)
 out_unlock:
 	raw_spin_unlock(&desc->lock);
 }
+EXPORT_SYMBOL_GPL(handle_simple_irq);
 
 /**
  *	handle_level_irq - Level type irq handler
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 282f202..d3765e2 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -109,6 +109,7 @@ struct irq_desc *irq_to_desc(unsigned int irq)
 {
 	return radix_tree_lookup(&irq_desc_tree, irq);
 }
+EXPORT_SYMBOL(irq_to_desc);
 
 static void delete_irq_desc(unsigned int irq)
 {
-- 
1.7.3.4


We also need set_irq_flags in arch/arm/kernel/irq.c I think, but for
that I clearly need to also ask the arm guys so lets sort the two above
first.

Thanks,

Jonathan
