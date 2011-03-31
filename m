Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: arnd@arndb.de,
	tglx@linutronix.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 13/21] arm: irq: export set flags
Date: Thu, 31 Mar 2011 15:54:07 +0100
Message-Id: <1301583255-28468-14-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
References: <1301583255-28468-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

---
 arch/arm/kernel/irq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/irq.c b/arch/arm/kernel/irq.c
index 3535d37..e4fd9e4 100644
--- a/arch/arm/kernel/irq.c
+++ b/arch/arm/kernel/irq.c
@@ -163,6 +163,7 @@ void set_irq_flags(unsigned int irq, unsigned int iflags)
 		desc->status &= ~IRQ_NOAUTOEN;
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 }
+EXPORT_SYMBOL(set_irq_flags);
 
 void __init init_IRQ(void)
 {
-- 
1.7.3.4
