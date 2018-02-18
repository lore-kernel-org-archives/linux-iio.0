Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44288 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750728AbeBRFgu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Feb 2018 00:36:50 -0500
Received: by mail-pf0-f194.google.com with SMTP id 17so920986pfw.11
        for <linux-iio@vger.kernel.org>; Sat, 17 Feb 2018 21:36:50 -0800 (PST)
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
        Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: add SPDX identifier for various drivers
Date: Sat, 17 Feb 2018 21:36:46 -0800
Message-Id: <20180218053646.13471-1-matt.ranostay@konsulko.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add GPLv2+ SPDX identifier and update email for author's drivers.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/adc/ti-adc161s626.c                   | 16 ++++------------
 drivers/iio/chemical/ams-iaq-core.c               | 17 ++++-------------
 drivers/iio/chemical/atlas-ph-sensor.c            | 16 ++++------------
 drivers/iio/chemical/vz89x.c                      | 17 ++++-------------
 drivers/iio/health/max30100.c                     | 16 ++++------------
 drivers/iio/humidity/hdc100x.c                    | 16 ++++------------
 drivers/iio/light/apds9960.c                      | 16 ++++------------
 drivers/iio/potentiometer/tpl0102.c               | 16 ++++------------
 drivers/iio/potentiostat/lmp91000.c               | 16 ++++------------
 drivers/iio/proximity/as3935.c                    | 17 ++++-------------
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 16 ++++------------
 drivers/iio/temperature/maxim_thermocouple.c      | 16 ++++------------
 12 files changed, 48 insertions(+), 147 deletions(-)

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 10fa7677ac4b..3bbc9b9ddbfe 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ti-adc161s626.c - Texas Instruments ADC161S626 1-channel differential ADC
  *
@@ -5,17 +6,8 @@
  *  adc141s626 - 14-bit ADC
  *  adc161s626 - 16-bit ADC
  *
- * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2016-2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  */
 
 #include <linux/module.h>
@@ -275,6 +267,6 @@ static struct spi_driver ti_adc_driver = {
 };
 module_spi_driver(ti_adc_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("Texas Instruments ADC1x1S 1-channel differential ADC");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index d9e5950ad24a..a0646ba2ad88 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * ams-iaq-core.c - Support for AMS iAQ-Core VOC sensors
  *
- * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
+ * Copyright (C) 2015, 2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  */
 
 #include <linux/module.h>
@@ -194,6 +185,6 @@ static struct i2c_driver ams_iaqcore_driver = {
 };
 module_i2c_driver(ams_iaqcore_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("AMS iAQ-Core VOC sensors");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index 8c4e05580091..abfc4bbc4cfc 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * atlas-ph-sensor.c - Support for Atlas Scientific OEM pH-SM sensor
  *
- * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2015-2018 Matt Ranostay
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  */
 
 #include <linux/module.h>
@@ -689,6 +681,6 @@ static struct i2c_driver atlas_driver = {
 };
 module_i2c_driver(atlas_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("Atlas Scientific pH-SM sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index 9c9095ba4227..415b39339d4e 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * vz89x.c - Support for SGX Sensortech MiCS VZ89X VOC sensors
  *
- * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
+ * Copyright (C) 2015-2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  */
 
 #include <linux/module.h>
@@ -419,6 +410,6 @@ static struct i2c_driver vz89x_driver = {
 };
 module_i2c_driver(vz89x_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("SGX Sensortech MiCS VZ89X VOC sensors");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 91aef5df24a1..84010501762d 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * max30100.c - Support for MAX30100 heart rate and pulse oximeter sensor
  *
- * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2015, 2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * TODO: enable pulse length controls via device tree properties
  */
@@ -518,6 +510,6 @@ static struct i2c_driver max30100_driver = {
 };
 module_i2c_driver(max30100_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("MAX30100 heart rate and pulse oximeter sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index d8438310b6d4..066e05f92081 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * hdc100x.c - Support for the TI HDC100x temperature + humidity sensors
  *
- * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2015, 2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * Datasheets:
  * http://www.ti.com/product/HDC1000/datasheet
@@ -449,6 +441,6 @@ static struct i2c_driver hdc100x_driver = {
 };
 module_i2c_driver(hdc100x_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("TI HDC100x humidity and temperature sensor driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index a8fa00e31c39..1f112ae15f3c 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * apds9960.c - Support for Avago APDS9960 gesture/RGB/ALS/proximity sensor
  *
- * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2015, 2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * TODO: gesture + proximity calib offsets
  */
@@ -1141,6 +1133,6 @@ static struct i2c_driver apds9960_driver = {
 };
 module_i2c_driver(apds9960_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("ADPS9960 Gesture/RGB/ALS/Proximity sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index 93f9d4a8c9aa..ca1cce58fe20 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * tpl0102.c - Support for Texas Instruments digital potentiometers
  *
- * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2016, 2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * TODO: enable/disable hi-z output control
  */
@@ -156,6 +148,6 @@ static struct i2c_driver tpl0102_driver = {
 
 module_i2c_driver(tpl0102_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("TPL0102 digital potentiometer");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 007710991f15..85714055cc74 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * lmp91000.c - Support for Texas Instruments digital potentiostats
  *
- * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2016, 2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * TODO: bias voltage + polarity control, and multiple chip support
  */
@@ -440,6 +432,6 @@ static struct i2c_driver lmp91000_driver = {
 };
 module_i2c_driver(lmp91000_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("LMP91000 digital potentiostat");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index b6249af48014..f130388a16a0 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -1,18 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * as3935.c - Support for AS3935 Franklin lightning sensor
  *
- * Copyright (C) 2014 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
+ * Copyright (C) 2014, 2017-2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  */
 
 #include <linux/module.h>
@@ -502,6 +493,6 @@ static struct spi_driver as3935_driver = {
 };
 module_spi_driver(as3935_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("AS3935 lightning sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 4d56f67b24c6..47af54f14756 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * pulsedlight-lidar-lite-v2.c - Support for PulsedLight LIDAR sensor
  *
- * Copyright (C) 2015 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2015, 2017-2018
+ * Author: Matt Ranostay <matt.ranostay@konsulko.com>
  *
  * TODO: interrupt mode, and signal strength reporting
  */
@@ -377,6 +369,6 @@ static struct i2c_driver lidar_driver = {
 };
 module_i2c_driver(lidar_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("PulsedLight LIDAR sensor");
 MODULE_LICENSE("GPL");
diff --git a/drivers/iio/temperature/maxim_thermocouple.c b/drivers/iio/temperature/maxim_thermocouple.c
index e8b7e0b6c8ad..54e383231d1e 100644
--- a/drivers/iio/temperature/maxim_thermocouple.c
+++ b/drivers/iio/temperature/maxim_thermocouple.c
@@ -1,17 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * maxim_thermocouple.c  - Support for Maxim thermocouple chips
  *
- * Copyright (C) 2016 Matt Ranostay <mranostay@gmail.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
+ * Copyright (C) 2016-2018 Matt Ranostay
+ * Author: <matt.ranostay@konsulko.com>
  */
 
 #include <linux/module.h>
@@ -281,6 +273,6 @@ static struct spi_driver maxim_thermocouple_driver = {
 };
 module_spi_driver(maxim_thermocouple_driver);
 
-MODULE_AUTHOR("Matt Ranostay <mranostay@gmail.com>");
+MODULE_AUTHOR("Matt Ranostay <matt.ranostay@konsulko.com>");
 MODULE_DESCRIPTION("Maxim thermocouple sensors");
 MODULE_LICENSE("GPL");
-- 
2.14.1

