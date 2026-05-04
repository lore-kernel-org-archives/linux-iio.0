Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE901E1024
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931176; cv=none; b=utE9HCsBK6X7y35d12+5HdC/kvBCfXg3GUKQs/AJkBDQnXd3Iug7kJUf7kYFXZQr7WvfIlpsVqLo8Ix3WI260DyA2x3sRNBUOBtma4IJpGDSm96pvBWK++iNAbfc2mwfndB6JFiUQ+yY3UIjL7EJUGoWCdTgkGOmO7gdz71uUq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931176; c=relaxed/simple;
	bh=7eXjb+FFIC2RsLP+zS+W30CRETMB2hU2C0+NvqiesAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jlTHalq+fav51zu3UaAb+mzxI8ZnELrRFTUcqSKBZIkQwBeLaseMjdEFPtkiwmkw5VU9aGwusz4x+XYH7wgOhW3DX9g7A5R1BqEsJHcmd8QYGnYedLkkj/tB6oHRrPZpVx1vjHXRUMfptWBrT77VmixyyEabOKYmd/k5ic3CXR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nXZS5wGN; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXZS5wGN"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-47c6f914617so1837596b6e.1
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 14:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777931174; x=1778535974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eUD9DeuD9wPNQm64sgjZ1QoOElmrAVGf/IwiBojeS0s=;
        b=nXZS5wGN7MYdC6U+pMakmF1sjmFw4TZ/jprSut2vj+nTZeVSB3LyA2dZxv/QnHnX1B
         4SxYXNmKxCcRAK2S1WAqYYk8DT9lpF+ytXSQV+4bIP2gL8HzTcGhJ5cQEvVB3HryxQBd
         /EmmySBNUTn1fJAGmUwvTr0v/ZLHVixO2aQ63It0dT7w6mkWyPHNZ5b9ZRKvRQMHTOrh
         nQcKrGFGmsnqC9s29BkmtZPrIapsWNez0WqSdaAUrSfvzhrB8bY6iAWmpc0aUm5nMpn9
         ROzmyy2V8SMQrzliTsDUPPPSJ+HKvB96QjSTRLaiXj6WXGXeCsKLzuia8kzh8GQiOpzA
         1A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777931174; x=1778535974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUD9DeuD9wPNQm64sgjZ1QoOElmrAVGf/IwiBojeS0s=;
        b=d851ORj5nip4pXw31ugvjLRuiyVmPbCXN62/rWnmuaE21k4z44TkRkenfDxk4qTz7m
         Z4jJWrzoM3vNu5U9v5OrtC4ERcRoBwudhVoTwQqo1ZjH+eAe6Nnr/kPkuGoMJ97RsgXB
         xMak+vOF61INz9fEMTSMTztM5kGO3sKFvgJS0OH7tPNiAR/WiO9+Lxx80Ko25OxcJZoU
         GA0Guw8YcgmBbHuBxIwNoW6ARS6okItq0/VNt9h9/fVu53i9pFYSHkon0+ifXRrOJEZL
         1QkeISmC1X6HVMVScL108Z3qxEAUMsyaOsG8/bkHzBOOnDVzL19SwPXblaNuWLjZKDpB
         DkYw==
X-Forwarded-Encrypted: i=1; AFNElJ8Ddocoq54EmcrroPAaQpzw7QdKnJCevRwXuWu4rAs1r1BDLMJxafaQjp6skV9jsRhMuwoJy1danQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkcwmY8VJGnIvglX2r7TCrFoOirheJa24NH2M4EcCd/ZLhscgU
	lUjAPwxX2kxRhZi5xUqwvMUrAZ+5A0LMpOJRw8PIXTy6UDXl4o6M2cTP
X-Gm-Gg: AeBDiet++RaOC9YDY2ka70WjzuFiOrZblYlARdIbcOoPgreJWIsYjFYeC2PEQYdE8Fn
	AV/Ogx+14ozItp4XD8NLNgUIdGruu4au2R6BQfio/Dbl/CBzYMyGk82lApkMpP2UmIM77qMsYCE
	bNvLXigFudTjPDmeoGrcyS4upToJQoJbkc8K1ONkkVYrqgUDeMZmC2uDBOyIj6A1A9TXV08PFFB
	k/xdeTirSUfyb5bLlx4M/7//qJ5/XUjUBk2EBf0nAk0Rz26FdkQbunNMgh4XYNBuXV28tVf5QMJ
	fYqzi/93yw5dmG/hLneqJ2ID+u9HNuWwsQFdBRWpq0OLFKkikp64p9wspQjntw8UYc296VM2cJs
	+ChzUGiy6K5pchZ8lQYWXhWhi0N6v1VMtMAwAmXg9tbjtbbL1SE5xOMgF/0lOd4PQusn3A/EflJ
	hArM72/or5BKkMIpZ2rbNUW0Bs+MopBQx3IlQ46wzZPqZUGob1U4uSMpPtR9mlTJigavqJe5JBF
	T89kDM=
X-Received: by 2002:a05:6808:199f:b0:479:ac7d:6d91 with SMTP id 5614622812f47-47c892a6a6amr5268710b6e.39.1777931174448;
        Mon, 04 May 2026 14:46:14 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c763b33c1sm7439845b6e.1.2026.05.04.14.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 14:46:14 -0700 (PDT)
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
Subject: [PATCH] iio: adc: xilinx-ams: Replace spin_lock() and unlock() calls with guard(spinlock*)()
Date: Mon,  4 May 2026 16:46:12 -0500
Message-ID: <20260504214613.121283-1-m32285159@gmail.com>
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
counterparts. This will help modernize the code and increase readability.

Remove "flags" variables where spin_lock_irqsave() has been replaced
with guard(spinlock_irqsave)()

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/adc/xilinx-ams.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 124470c92529..2b98f94d90bc 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -10,6 +10,7 @@
 
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/devm-helpers.h>
@@ -414,18 +415,15 @@ static void ams_unmask(struct ams *ams)
 
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
 	ams_update_intrmask(ams, AMS_ISR0_ALARM_MASK, ~alarm_mask);
 	ams_unmask(ams);
-	spin_unlock_irqrestore(&ams->intr_lock, flags);
 }
 
 static void ams_enable_channel_sequence(struct iio_dev *indio_dev)
@@ -1060,9 +1058,8 @@ static void ams_unmask_worker(struct work_struct *work)
 {
 	struct ams *ams = container_of(work, struct ams, ams_unmask_work.work);
 
-	spin_lock_irq(&ams->intr_lock);
+	guard(spinlock_irq)(&ams->intr_lock);
 	ams_unmask(ams);
-	spin_unlock_irq(&ams->intr_lock);
 
 	/* If still pending some alarm re-trigger the timer */
 	if (ams->current_masked_alarm)
@@ -1076,16 +1073,14 @@ static irqreturn_t ams_irq(int irq, void *data)
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
@@ -1099,8 +1094,6 @@ static irqreturn_t ams_irq(int irq, void *data)
 	schedule_delayed_work(&ams->ams_unmask_work,
 			      msecs_to_jiffies(AMS_UNMASK_TIMEOUT_MS));
 
-	spin_unlock(&ams->intr_lock);
-
 	return IRQ_HANDLED;
 }
 

base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.54.0

