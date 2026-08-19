Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B9E3446A6
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 20:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171866; cv=none; b=bqnJeU1re05Gc8BYpX8YGpxDOimqPiHta+6p8hl4PIe7bq8hCSsFLnV9ag/xEJM153r2F2m4AN1lUcopyrDSjAhALsnGclGcVQDNQRFZVO198tk0vyMg/WGGl8c6cH02xi4MXPwUUYZP0fdM5hpMHAj3sX8uHKDaIM81wduHvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171866; c=relaxed/simple;
	bh=uToOyf/ES533DOfgWtk4VhwEH90KHBccxnpEcS/Chrw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uf8Z6blUj4LAObg/zjXSL+JmAjoRmAe+f4WzT7RMCOim/ZnuE3wWV1/R49KmnwHfaRlYm/RsJuvY8ENNoa36gMoVPcTQapuXP9Ro+Ahjxkw72ezKCgqMcgqyUGBw+P7e/Fm5XUwBjS2+Wz6i0V2fnTNita60qIzTIyrsVFw3EIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnP1s7/J; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnP1s7/J"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a3819e8be8so814396a12.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 13:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787171863; x=1787776663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PcyBHwH+6uHNvA8WjjMW8g7Vm+W/8j/2VjtnxxOdiR0=;
        b=MnP1s7/JGbTgJEU3LCbQoK6HgT3D36lD9SwICvMUIekBE8W4R6chI6oijmIFwBor0e
         jBwEy0y65VvujjlGkHos6BNdy8fco7lfzFybYZSqdNDBDcJrx6kuTa6xffQVt5TsC2Ac
         l3N7E9Q6AdlCJqLujgbPC7EXC5lHGfRuULuVeAkoB9Qdo5ixkho0+pi2SQEDbEXHEMGb
         iZVkyUdfsBRVMuckaUZs7+xJMHeoDsNDGywHayaqGDv8eIQi41nQoxOOHaZHcSejElLo
         gScc6SWUymwj3bsfJeCfCEUoOHHe4Ez/MXzRwM4jNGuUOSw5DBeRXkVmYM0xkkxDEJPR
         jaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171863; x=1787776663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PcyBHwH+6uHNvA8WjjMW8g7Vm+W/8j/2VjtnxxOdiR0=;
        b=ocBPL9gZj2NHmqGpeRq0EDwzAq4dAWkcy5D4C1MlmmzCnE/hrCbeplpChuFKu5TMV2
         7DZQq/jqC+KD4QUMK3WAnwtAXxfmLZt6J+QgPfwJ8CtRKDpwckVAHDBnizxdmqWezQ47
         rT5CaWHXjqGv8TnXMihlNeEsx71Qe6WyUUrQBehO93LW8lx1NTRO7qHb6aPDjVQ/jhwL
         aLjGF2BXYdrZTMsblLOU1Y/E3+8jmun5jIjNXhwuUO+VtzO3LY6VWZMNg8qhElh/k1rs
         8cvhvNEy7ye4kybITBB8fbwgBuDCOB32M5A++C9cAR6WX3skyyKO/2lITAIlosjWsVSr
         QdhA==
X-Gm-Message-State: AFuF++nOOyiM7gdnDr7AuarGO/4E/KVwy6I7Zi0M8dotakm8zPnY2BZh
	OaiT07QvuBVyg7G2SRUEG3RGtWYYITOdw+9L11SaFalyUqYp9u9oSGE+
X-Gm-Gg: AR+sD13egTd+zi5+pONqZlqp+ZHG5eRztOoDmaXvZUtcgIy9BdwZgPP/YkBqkqPMr5R
	KuTT15af6nnePHAsjlIZ0+OclDNhBPLrLMPqMSC25atIf0N/3eyTTBnn3Sojk3RSDIiC42BwB/t
	giDWdCIPA3/ZnJmlTHrA+AgyC5//zh5XGNXGWfFNZ3QcDmA9VmgjclZjWSYR8PDFJnvcGwpooM0
	0KwwYr8JMawluwbTdhsGVfftdlliTv/v3LL+dzvbA2SjhnrdrrZpDwGYJmT+8pHFX73cSgqB1Fn
	XdnfC8tIi0hBEeNSiB0z8Bh+Z0hKgJ9zyhQK2WSlicCVgMY8nRqm+p8qHBg0DCs0HzQD87HU5i5
	ngGN9Jg4EQ/ZpaJUj3jWzVIwIAcrCecHKNL76wsYxGRTI1odvB97elJp0giC5AvusMXPFGNcdVJ
	X1U3l0xh5qXbefL8PrcQPiYL9ue0YgRCDwASOkWvL6ZiPO0AOfaGO/7q12Yb+n7j8TAFovWbsk1
	vo=
X-Received: by 2002:a05:6402:8c4:b0:695:4916:b97c with SMTP id 4fb4d7f45d1cf-6a41133589dmr840635a12.8.1787171863213;
        Wed, 19 Aug 2026 13:37:43 -0700 (PDT)
Received: from localhost.localdomain ([196.235.194.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff158e82sm1408070a12.16.2026.08.19.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:37:42 -0700 (PDT)
From: Salah Triki <salah.triki@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: [PATCH] iio: proximity: vcnl3020: fix ISR bitmask check in IRQ handler
Date: Wed, 19 Aug 2026 21:37:33 +0100
Message-ID: <20260819203733.12730-1-salah.triki@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In vcnl3020_handle_irq_thread(), the status register (VCNL_ISR) was
incorrectly checked against VCNL_ICR_THRES_EN (BIT(1)), which is a bit
mask intended for the Interrupt Control Register (VCNL_PS_ICR).

Because BIT(1) in the ISR register corresponds only to VCNL_INT_TH_LOW,
any high-threshold interrupt (VCNL_INT_TH_HI, BIT(0)) occurring on its own
resulted in the handler returning IRQ_NONE and ignoring the event.

Fix this by checking the ISR value against both valid status bits:
VCNL_INT_TH_HI and VCNL_INT_TH_LOW.

Fixes: 3363fbbe19e5 ("iio: proximity: vcnl3020: add periodic mode")
Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/iio/proximity/vcnl3020.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vcnl3020.c b/drivers/iio/proximity/vcnl3020.c
index 7f417372566a..d4ad06f8f366 100644
--- a/drivers/iio/proximity/vcnl3020.c
+++ b/drivers/iio/proximity/vcnl3020.c
@@ -584,7 +584,7 @@ static irqreturn_t vcnl3020_handle_irq_thread(int irq, void *p)
 		return IRQ_HANDLED;
 	}
 
-	if (!(isr & VCNL_ICR_THRES_EN))
+	if (!(isr & (VCNL_INT_TH_HI | VCNL_INT_TH_LOW)))
 		return IRQ_NONE;
 
 	iio_push_event(indio_dev,
-- 
2.43.0

