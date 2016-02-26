Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53357 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932751AbcBZPo1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 26 Feb 2016 10:44:27 -0500
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
	Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/7] rtc: tps80031: Drop IRQF_EARLY_RESUME flag
Date: Fri, 26 Feb 2016 17:42:55 +0200
Message-ID: <1456501377-16871-6-git-send-email-grygorii.strashko@ti.com>
In-Reply-To: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
References: <1456501377-16871-1-git-send-email-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tps80031 RTC IRQ is nested threaded and wired to the tps80031
inerrupt controller. So, this flag is not required for nested irqs
anymore, since commit 3c646f2c6aa9 ("genirq: Don't suspend
nested_thread irqs over system suspend") was merged.

Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/rtc/rtc-tps80031.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-tps80031.c b/drivers/rtc/rtc-tps80031.c
index 27e254c..737f26e 100644
--- a/drivers/rtc/rtc-tps80031.c
+++ b/drivers/rtc/rtc-tps80031.c
@@ -287,7 +287,7 @@ static int tps80031_rtc_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
 			tps80031_rtc_irq,
-			IRQF_ONESHOT | IRQF_EARLY_RESUME,
+			IRQF_ONESHOT,
 			dev_name(&pdev->dev), rtc);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request IRQ:%d failed, err = %d\n",
-- 
2.7.2

