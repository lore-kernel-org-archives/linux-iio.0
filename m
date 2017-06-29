Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f46.google.com ([209.85.215.46]:35738 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752150AbdF2L5N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Jun 2017 07:57:13 -0400
Received: by mail-lf0-f46.google.com with SMTP id b207so51288326lfg.2
        for <linux-iio@vger.kernel.org>; Thu, 29 Jun 2017 04:57:12 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] iio: gyro: mpu3050: Allow open drain with anything
Date: Thu, 29 Jun 2017 13:57:04 +0200
Message-Id: <20170629115704.20717-1-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Open drain should work fine with rising or high level IRQs,
this code was due to some misunderstanding on my part.

Reported-by: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/gyro/mpu3050-core.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 2be2a5d287e6..e0d241a9aa30 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1063,11 +1063,6 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 	case IRQF_TRIGGER_RISING:
 		dev_info(&indio_dev->dev,
 			 "pulse interrupts on the rising edge\n");
-		if (mpu3050->irq_opendrain) {
-			dev_info(&indio_dev->dev,
-				 "rising edge incompatible with open drain\n");
-			mpu3050->irq_opendrain = false;
-		}
 		break;
 	case IRQF_TRIGGER_FALLING:
 		mpu3050->irq_actl = true;
@@ -1078,11 +1073,6 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 		mpu3050->irq_latch = true;
 		dev_info(&indio_dev->dev,
 			 "interrupts active high level\n");
-		if (mpu3050->irq_opendrain) {
-			dev_info(&indio_dev->dev,
-				 "active high incompatible with open drain\n");
-			mpu3050->irq_opendrain = false;
-		}
 		/*
 		 * With level IRQs, we mask the IRQ until it is processed,
 		 * but with edge IRQs (pulses) we can queue several interrupts
-- 
2.9.4

