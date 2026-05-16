Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8BC2745E
	for <linux-iio@vger.kernel.org>; Sat, 16 May 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778931151; cv=none; b=AO/Y4XgZSDZjnpGbM3qXOtzHDtFurclAGwVVzpShAUhYOu0AZ6F/9tJlKR72M969g/gIRJAgpq2efiEJD3DvwBmG6Bw6cuZPucy8tv4jylEwAwH4GQGoEcbmPL10fHsmFY8YlnVZ07ucs2OUPmKMuN4gizYVV2umwk8w/8AGFBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778931151; c=relaxed/simple;
	bh=g5cFH94NoRqNQcqi0o6uAdCMG2S19mVTTWTUtDQRkUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=szPdFT+S/BSOJdk3y2tZj6Nnlr8MZvzHz1emPf04oA18VqGq0+cH6tBnmVSh69xiZDZeErrrp5eyeUpW3ssguaqaImfQ/cpLPnE5KrObBye4FH1pIH9XL4yMwg53fn2Z3H8bFm/ozdGGLZM6xF4lYbbmgHtizWO4cGlpufQE2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1j/jOK7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1j/jOK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75BAC19425;
	Sat, 16 May 2026 11:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778931151;
	bh=g5cFH94NoRqNQcqi0o6uAdCMG2S19mVTTWTUtDQRkUU=;
	h=From:To:Cc:Subject:Date:From;
	b=P1j/jOK7IjCcGD89zkKWZLPpH+jaKx+7aon3jDgvzfOpJ3ghw3LgWGHx6h8//FwZy
	 Mp9D3IgPfP/iIfyjJQXrKBQG9LcyvnwffwAuIwMHZi1Yg36rmyw5XjacEhcAmrwZUX
	 lh6JMP8KNtDzlfdcyBFZvd4teQqdi6ZY5cwXMgGfGpvVfvSI5vY9tIVrrPJIXp2JXo
	 3c9qS8TDpD5hW99HvzHmheZYaT0rURu4nHhg5JYiuwqSrfuHkXNCb3Myh++GWHGAAt
	 2k5o5cRTiHFKowdW8nMLfpkNGtiffycKb1/w9dIV2iWRNR6Q7tma89DgHCGai5a1yl
	 TLYDUNrUpWnQg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Stepan Ionichev <sozdayvek@gmail.com>,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] iio: trigger: drop generic interrupt trigger.
Date: Sat, 16 May 2026 12:32:19 +0100
Message-ID: <20260516113219.573610-1-jic23@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is no way to bind to this driver from firmware and no explicit
platform device creation calls exist in mainline.

As such it is dead code. So drop it rather than potentially wasting time
modernizing it (see #1)

Link: https://lore.kernel.org/all/20260511063229.1433-1-sozdayvek@gmail.com/ #1
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---

Long ago this was somewhat useful, but seems no one cares any more!
If anyone has a usecase then shout - if not it will be easy to bring
back anyway if one surfaces.  At that point we can modernize it.

 drivers/iio/trigger/Kconfig              |   9 --
 drivers/iio/trigger/Makefile             |   1 -
 drivers/iio/trigger/iio-trig-interrupt.c | 109 -----------------------
 3 files changed, 119 deletions(-)
 delete mode 100644 drivers/iio/trigger/iio-trig-interrupt.c

diff --git a/drivers/iio/trigger/Kconfig b/drivers/iio/trigger/Kconfig
index 7ecb69725b1d..52899c22d57c 100644
--- a/drivers/iio/trigger/Kconfig
+++ b/drivers/iio/trigger/Kconfig
@@ -16,15 +16,6 @@ config IIO_HRTIMER_TRIGGER
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-trig-hrtimer.
 
-config IIO_INTERRUPT_TRIGGER
-	tristate "Generic interrupt trigger"
-	help
-	  Provides support for using an interrupt of any type as an IIO
-	  trigger.  This may be provided by a gpio driver for example.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called iio-trig-interrupt.
-
 config IIO_STM32_LPTIMER_TRIGGER
 	tristate "STM32 Low-Power Timer Trigger"
 	depends on MFD_STM32_LPTIMER || COMPILE_TEST
diff --git a/drivers/iio/trigger/Makefile b/drivers/iio/trigger/Makefile
index f3d11acb8a0b..fc1fd5661c94 100644
--- a/drivers/iio/trigger/Makefile
+++ b/drivers/iio/trigger/Makefile
@@ -6,7 +6,6 @@
 # When adding new entries keep the list in alphabetical order
 
 obj-$(CONFIG_IIO_HRTIMER_TRIGGER) += iio-trig-hrtimer.o
-obj-$(CONFIG_IIO_INTERRUPT_TRIGGER) += iio-trig-interrupt.o
 obj-$(CONFIG_IIO_STM32_LPTIMER_TRIGGER) += stm32-lptimer-trigger.o
 obj-$(CONFIG_IIO_STM32_TIMER_TRIGGER) += stm32-timer-trigger.o
 obj-$(CONFIG_IIO_SYSFS_TRIGGER) += iio-trig-sysfs.o
diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
deleted file mode 100644
index a100c2e3a0d9..000000000000
--- a/drivers/iio/trigger/iio-trig-interrupt.c
+++ /dev/null
@@ -1,109 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Industrial I/O - generic interrupt based trigger support
- *
- * Copyright (c) 2008-2013 Jonathan Cameron
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/slab.h>
-
-#include <linux/iio/iio.h>
-#include <linux/iio/trigger.h>
-
-
-struct iio_interrupt_trigger_info {
-	unsigned int irq;
-};
-
-static irqreturn_t iio_interrupt_trigger_poll(int irq, void *private)
-{
-	iio_trigger_poll(private);
-	return IRQ_HANDLED;
-}
-
-static int iio_interrupt_trigger_probe(struct platform_device *pdev)
-{
-	struct iio_interrupt_trigger_info *trig_info;
-	struct iio_trigger *trig;
-	unsigned long irqflags;
-	struct resource *irq_res;
-	int irq, ret = 0;
-
-	irq_res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-
-	if (irq_res == NULL)
-		return -ENODEV;
-
-	irqflags = (irq_res->flags & IRQF_TRIGGER_MASK) | IRQF_SHARED;
-
-	irq = irq_res->start;
-
-	trig = iio_trigger_alloc(NULL, "irqtrig%d", irq);
-	if (!trig) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-
-	trig_info = kzalloc_obj(*trig_info);
-	if (!trig_info) {
-		ret = -ENOMEM;
-		goto error_free_trigger;
-	}
-	iio_trigger_set_drvdata(trig, trig_info);
-	trig_info->irq = irq;
-	ret = request_irq(irq, iio_interrupt_trigger_poll,
-			  irqflags, trig->name, trig);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"request IRQ-%d failed", irq);
-		goto error_free_trig_info;
-	}
-
-	ret = iio_trigger_register(trig);
-	if (ret)
-		goto error_release_irq;
-	platform_set_drvdata(pdev, trig);
-
-	return 0;
-
-/* First clean up the partly allocated trigger */
-error_release_irq:
-	free_irq(irq, trig);
-error_free_trig_info:
-	kfree(trig_info);
-error_free_trigger:
-	iio_trigger_free(trig);
-error_ret:
-	return ret;
-}
-
-static void iio_interrupt_trigger_remove(struct platform_device *pdev)
-{
-	struct iio_trigger *trig;
-	struct iio_interrupt_trigger_info *trig_info;
-
-	trig = platform_get_drvdata(pdev);
-	trig_info = iio_trigger_get_drvdata(trig);
-	iio_trigger_unregister(trig);
-	free_irq(trig_info->irq, trig);
-	kfree(trig_info);
-	iio_trigger_free(trig);
-}
-
-static struct platform_driver iio_interrupt_trigger_driver = {
-	.probe = iio_interrupt_trigger_probe,
-	.remove = iio_interrupt_trigger_remove,
-	.driver = {
-		.name = "iio_interrupt_trigger",
-	},
-};
-
-module_platform_driver(iio_interrupt_trigger_driver);
-
-MODULE_AUTHOR("Jonathan Cameron <jic23@kernel.org>");
-MODULE_DESCRIPTION("Interrupt trigger for the iio subsystem");
-MODULE_LICENSE("GPL v2");
-- 
2.54.0

