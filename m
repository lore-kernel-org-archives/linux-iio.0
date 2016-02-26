Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45705 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932880AbcBZPo2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 26 Feb 2016 10:44:28 -0500
From: Grygorii Strashko <grygorii.strashko@ti.com>
To: Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: <rtc-linux@googlegroups.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
	<linux-omap@vger.kernel.org>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
	Laxman Dewangan <ldewangan@nvidia.com>
Subject: [PATCH 4/7] rtc: tps65910: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:54 +0200
Message-ID: <1456501377-16871-5-git-send-email-grygorii.strashko@ti.com>
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tps65910 RTC IRQ is nested threaded and wired to the tps65910 inerrupt
controller. So, this flag is not required for nested irqs anymore,
since commit 3c646f2c6aa9 ("genirq: Don't suspend nested_thread irqs
over system suspend") was merged.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/rtc/rtc-tps65910.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index f42aa2b..5a3d53c 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -268,7 +268,7 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
-		tps65910_rtc_interrupt, IRQF_TRIGGER_LOW | IRQF_EARLY_RESUME,
+		tps65910_rtc_interrupt, IRQF_TRIGGER_LOW,
 		dev_name(&pdev->dev), &pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "IRQ is not free.\n");
-- 
2.7.2

