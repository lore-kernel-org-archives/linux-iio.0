Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 13.mo3.mail-out.ovh.net ([188.165.33.202]:48494 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752430Ab3FKTMr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2013 15:12:47 -0400
Received: from mail96.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id BB8AEFF9D40
	for <linux-iio@vger.kernel.org>; Tue, 11 Jun 2013 16:58:28 +0200 (CEST)
From: Alexandre Relange <alexandre@relange.org>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Alexandre Relange <alexandre@relange.org>
Subject: [PATCH 5/5] iio: mechanical: switch sensor: add ID table
Date: Tue, 11 Jun 2013 16:52:16 +0200
Message-Id: <1370962336-20739-5-git-send-email-alexandre@relange.org>
In-Reply-To: <1370962336-20739-1-git-send-email-alexandre@relange.org>
References: <1370962336-20739-1-git-send-email-alexandre@relange.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

auto-probes module when device is detected and prepare module extension
to other hid mechanical sensors.

Signed-off-by: Alexandre Relange <alexandre@relange.org>
---
 drivers/iio/mechanical/hid-sensor-switch.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/mechanical/hid-sensor-switch.c b/drivers/iio/mechanical/hid-sensor-switch.c
index 7027305..1556ee5 100644
--- a/drivers/iio/mechanical/hid-sensor-switch.c
+++ b/drivers/iio/mechanical/hid-sensor-switch.c
@@ -344,11 +344,18 @@ static int hid_switch_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id switch_id_table[] = {
+        { "HID-SENSOR-200061", 0 },
+        {  } /* Terminating Entry */
+};
+MODULE_DEVICE_TABLE(platform, switch_id_table);
+
 static struct platform_driver hid_switch_platform_driver = {
 	.driver = {
 		.name	= DRIVER_NAME,
 		.owner	= THIS_MODULE,
 	},
+	.id_table	= switch_id_table,
 	.probe		= hid_switch_probe,
 	.remove		= hid_switch_remove,
 };
-- 
1.8.3

