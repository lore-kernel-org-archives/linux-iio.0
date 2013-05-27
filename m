Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48431 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TNH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2013 15:13:07 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 18/19] mfd/ti_am335x_tscadc: add a module alias for modprobe
Date: Mon, 27 May 2013 21:12:05 +0200
Message-Id: <1369681926-22185-19-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This ensures that the module is loaded on demand once hardware is found.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mfd/ti_am335x_tscadc.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
index 014df14..5e4076f 100644
--- a/drivers/mfd/ti_am335x_tscadc.c
+++ b/drivers/mfd/ti_am335x_tscadc.c
@@ -272,6 +272,7 @@ static const struct of_device_id ti_tscadc_dt_ids[] = {
 	{ .compatible = "ti,ti-tscadc", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
 
 static struct platform_driver ti_tscadc_driver = {
 	.driver = {
-- 
1.7.10.4

