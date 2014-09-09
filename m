Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57914 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754151AbaIIRTW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Sep 2014 13:19:22 -0400
Message-ID: <1410283148.4077.16.camel@hadess.net>
Subject: [PATCH] iio:kxcjk-1013: Add support for SMO8500 device
From: Bastien Nocera <hadess@hadess.net>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@intel.com>
Date: Tue, 09 Sep 2014 19:19:08 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Onda v975w tablet contains an accelerometer that's advertised over
ACPI as SMO8500. This device is however a KXCJ9 accelerometer as
can be seen in the Windows driver's INF file.

---

I tested the patch, and it works correctly in my testing. However,
there's no GPIO pin for the "data ready" interrupt, and this throws an
error that looks fatal in the logs (could this be downgraded?), and
the name of the device doesn't match the hid-sensor-hub ones, making it
hard for user-space to discover them.
(https://github.com/hadess/iio-sensor-proxy is my attempt at something
 that integrates with user-space and the IIO sensors)

It will also conflict with Daniel's patch here:
http://www.spinics.net/lists/linux-iio/msg14438.html

Cheers
---
 drivers/iio/accel/kxcjk-1013.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 7941cf2..dea5732 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -736,12 +736,14 @@ static SIMPLE_DEV_PM_OPS(kxcjk1013_pm_ops, kxcjk1013_suspend, kxcjk1013_resume);
 
 static const struct acpi_device_id kx_acpi_match[] = {
 	{"KXCJ1013", 0},
+	{"SMO8500", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
 
 static const struct i2c_device_id kxcjk1013_id[] = {
 	{"kxcjk1013", 0},
+	{"SMO8500", 0},
 	{}
 };
 
-- 
2.1.0


