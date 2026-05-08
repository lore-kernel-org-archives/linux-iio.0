Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB5D3DCDB0
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244318; cv=none; b=HuVSpamT2YECVZn4G1SRJXIjcgZKqOQN+iAUf8kxpNUb6F6zUPkh6LeqB6vQx7+nr/atEtjV2Y8SCZplG585NjCcniunqe86jDqH94sD/lWZuv8SU5FtwEpmf4aHBbH+pUuzofu6la8N+WNJJRbn+qf92WDl9pI2Dm22fjyPHZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244318; c=relaxed/simple;
	bh=jYK6el2X48+S4w88qDbDd6Y/tDrlmJ83S6sFrdAv+8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cp0+2v7YrZxVXcsLgkpF7aCCZJNs7Y73+ysh4YQODSghTJupGEAGF24U5nx/cyncWLeLIUXUN21GlNUZa+pdx6+DO1eDwFLXhNIjOp6nDQylQ6BK70e5HcAhhN/BExHMIxp4uiIO+ejPCtsxEXLUGQUrVJMWT9Bn9NXubpXjqeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VfrhyKK2; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VfrhyKK2"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-42fdab683b7so1044940fac.3
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 05:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778244316; x=1778849116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7NaUZ8NzgConcLQlWK2tCRyH0zU4s9BkLK3EWuec7V0=;
        b=VfrhyKK2qfhRjQEA7Hu6lcR3+gdoFnq1qg6gH+2NKWPe6zFe0NGTnwRf7oMWWXJCoz
         xDGknZN42a/jVSn2yTkvbCEuZcfbcJWgyIuAKfBkfHeoJbPwAIoORIiSqZTpExvkslZo
         RKwYeqlh+13XkCT87/3mvaC5vzU/YLUGVIax05V7eslnY5qCK4Qyfz/1C4KsP82B381f
         6hdGwh/3SXGrN5Evul9ynEceo2TWxfNIh9e1ZPXOMK4slJh33n6uV24kcZhS9/V5gC9W
         voRf8lukIRFYageDkW29hbyxyrKgsGtcHjjHt+yU8jmra1X0SlPJy4mMNB9ZCONKYquc
         y4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778244316; x=1778849116;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7NaUZ8NzgConcLQlWK2tCRyH0zU4s9BkLK3EWuec7V0=;
        b=pTkG7AbNdaQBe2WECGdfQxBTTe3hUPVCGqq9kaCZVJtgj9Vv1W6Z5QZqsQctcUmd6o
         A1qR2XnkHl1khqNq2Yi/IRwE1JEklWWu6FDPou8wEotUbwT+MXS7dHpHHHez2ccnWzRp
         sX5GceTQB/4eSJBRJNQgBZNetXlGCnh85Bwfu+2gwk8kZ/+zOIziYpAIxGusvcgk7J84
         EiKeDemDU/wXOh3tNt2H/02faE7jj2Xsjcf1h7XLuTbVTrXJdqJsIDWlvHHToS8ZVvob
         qeVyamhrXWJD9s/Hz9uc2HjDqpruKnPOC2oPAGyQxwdw/8qu6njEDLQBhw1tJXEaek0T
         H1xw==
X-Forwarded-Encrypted: i=1; AFNElJ8xlrybxM+/X+xiEehPKkoaloRtZ9cVvkreM8nAmkQ9tT71WsXH+3R5/7MpgONQkie2Hc/lruhiB4c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5QY4vuei7wgwEjyc6AMxKyB9KlqGKC58WEThI7zroWGq34PBb
	sxJYwpZ4vqs0dQosi6b4zuSWNs1EW/gHtBaun9KyEWg53PGYcgTXkVZq
X-Gm-Gg: Acq92OEaWeZnapu2lHyJVERoumR3KIuY9bFFVXNdLuglPGl9BIEE7/VEaENAhVkqh5+
	2HuQAF33QHaiEfGAKT+UvC529aP02q+P23N3bfuWU0NNSv9zTTfu79q0JnP1d9tgAsoCnrhQlRD
	wpEAP9w+bK8WP+Ngwy2tKagWDFXXsP/2dC5kFJVvpZOKNq9Y9+O08ILj/Lik4c7/uSCvegMr63A
	Y4yqi7OdY+pjwaO2fed6ERyvWXasC+m6jCmr7wFCyPATqveZGsLnJ+c8CTM9GbcyC9Hf4gXly0C
	Ngmc+ht/UFandlv7eddchmDndbIpMXGR1li02JxDx3nqokIWjXJ0JSr0652gLhvlHN65PKPBSS+
	Fi4/EhY5lsUY8hOTXEcGBl9OIa9K0gnpEEtHWCJx1KGFEz0ukQefvrAnZAkyP2bPzN3jBAaKTvi
	tBFtriXCvjIiOf9Hf/kVeM3XeqmjUnbw23Zgobu/p4hrsP5yM6FufpKeFsRw==
X-Received: by 2002:a05:6870:312a:b0:42c:ebc:7f53 with SMTP id 586e51a60fabf-434f657b535mr7417665fac.37.1778244316057;
        Fri, 08 May 2026 05:45:16 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435573e7254sm1630055fac.14.2026.05.08.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:45:14 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: salih.erim@amd.com,
	conall.ogriofa@amd.com,
	jic23@kernel.org,
	michal.simek@amd.com
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:XILINX AMS DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: adc: xilinx-ams: Replace spin_lock() and unlock() calls with guard(spinlock*)()
Date: Fri,  8 May 2026 07:45:13 -0500
Message-ID: <20260508124513.17752-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include linux/cleanup.h to take advantage of RAII macros.

Replace spin_lock() and unlock() calls with their RAII macro
counterparts, which modernizes the code and increases readability.

Remove "flags" variables where spin_lock_irqsave() has been replaced
with guard(spinlock_irqsave)().

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 v2:
 - Replace guard(spinlock_irq)() in ams_unmask_worker() with
   scoped_guard() per Jonathan's suggestion.

 drivers/iio/adc/xilinx-ams.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 124470c92529..05bf1444ca7d 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -10,6 +10,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/devm-helpers.h>
@@ -414,18 +415,16 @@ static void ams_unmask(struct ams *ams)
 
 static void ams_update_alarm(struct ams *ams, unsigned long alarm_mask)
 {
-	unsigned long flags;
-
 	if (ams->ps_base)
 		ams_update_ps_alarm(ams, alarm_mask);
 
 	if (ams->pl_base)
 		ams_update_pl_alarm(ams, alarm_mask);
 
-	spin_lock_irqsave(&ams->intr_lock, flags);
+	guard(spinlock_irqsave)(&ams->intr_lock);
+
 	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
 	ams_unmask(ams);
-	spin_unlock_irqrestore(&ams->intr_lock, flags);
 }
 
 static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
@@ -1060,9 +1059,8 @@ static void ams_unmask_worker(struct work_struct *work)
 {
 	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
 
-	spin_lock_irq(&ams->intr_lock);
-	ams_unmask(ams);
-	spin_unlock_irq(&ams->intr_lock);
+	scoped_guard(spinlock_irq, &ams->intr_lock)
+		ams_unmask(ams);
 
 	/* If still pending some alarm re-trigger the timer */
 	if (ams->current_masked_alarm)
@@ -1076,16 +1074,14 @@ static irqreturn_t ams_irq(int irq, void *data)
 	struct ams *ams = iio_priv(indio_dev);
 	u32 isr0;
 
-	spin_lock(&ams->intr_lock);
+	guard(spinlock)(&ams->intr_lock);
 
 	isr0 = readl(ams->base + AMS_ISR_0);
 
 	/* Only process alarms that are not masked */
 	isr0 &= ~((ams->intr_mask & AMS_ISR0_ALARM_MASK) | ams->current_masked_alarm);
-	if (!isr0) {
-		spin_unlock(&ams->intr_lock);
+	if (!isr0)
 		return IRQ_NONE;
-	}
 
 	/* Clear interrupt */
 	writel(isr0, ams->base + AMS_ISR_0);
@@ -1099,8 +1095,6 @@ static irqreturn_t ams_irq(int irq, void *data)
 	schedule_delayed_work(&ams->ams_unmask_work,
 			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
 
-	spin_unlock(&ams->intr_lock);
-
 	return IRQ_HANDLED;
 }
 
-- 
2.54.0

