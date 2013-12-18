Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46197 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755055Ab3LRQxW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 Dec 2013 11:53:22 -0500
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Lee Jones <lee.jones@linaro.org>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/5] iio: ti_am335x_adc: adjust the closing bracket in tiadc_read_raw()
Date: Wed, 18 Dec 2013 17:52:53 +0100
Message-Id: <1387385577-24447-2-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
References: <1387385577-24447-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

It somehow looks like the ending bracket belongs to the if statement but
it does belong to the while loop. This patch moves the bracket where it
belongs.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index d4d7482..e948454 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -341,7 +341,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
 	while (tiadc_readl(adc_dev, REG_ADCFSM) & SEQ_STATUS) {
 		if (time_after(jiffies, timeout))
 			return -EAGAIN;
-		}
+	}
 	map_val = chan->channel + TOTAL_CHANNELS;
 
 	/*
-- 
1.8.5.1

