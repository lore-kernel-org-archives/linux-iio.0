Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-045.synserver.de ([212.40.185.45]:1062 "EHLO
	smtp-out-045.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752915Ab3BOQ4A (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Feb 2013 11:56:00 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org,
	linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/9] hwmon: (adt7410) Clear unwanted bits in the config register
Date: Fri, 15 Feb 2013 17:57:10 +0100
Message-Id: <1360947438-2550-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make sure to clear the mode bits from the config register before setting the new
mode. Otherwise we might end up with a different mode than we want to.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/adt7410.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/adt7410.c b/drivers/hwmon/adt7410.c
index 797c2b8..4ccee4f 100644
--- a/drivers/hwmon/adt7410.c
+++ b/drivers/hwmon/adt7410.c
@@ -364,6 +364,7 @@ static int adt7410_probe(struct i2c_client *client,
 	/*
 	 * Set to 16 bit resolution, continous conversion and comparator mode.
 	 */
+	ret &= ~ADT7410_MODE_MASK;
 	data->config = ret | ADT7410_FULL | ADT7410_RESOLUTION |
 			ADT7410_EVENT_MODE;
 	if (data->config != data->oldconfig) {
-- 
1.8.0

