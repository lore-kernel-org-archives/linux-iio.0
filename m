Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33422 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeIBAIA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 Sep 2018 20:08:00 -0400
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: pressure: ms5611: switch to SPDX identifier
Date: Sat,  1 Sep 2018 21:52:14 +0200
Message-Id: <20180901195214.11485-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Drop boilerplate license text and use SPDX identifier instead.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/pressure/ms5611.h      | 5 +----
 drivers/iio/pressure/ms5611_core.c | 5 +----
 drivers/iio/pressure/ms5611_i2c.c  | 5 +----
 drivers/iio/pressure/ms5611_spi.c  | 5 +----
 4 files changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/pressure/ms5611.h b/drivers/iio/pressure/ms5611.h
index ead9e9f85894..c9dd86de3ade 100644
--- a/drivers/iio/pressure/ms5611.h
+++ b/drivers/iio/pressure/ms5611.h
@@ -1,12 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * MS5611 pressure and temperature sensor driver
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */

 #ifndef _MS5611_H
diff --git a/drivers/iio/pressure/ms5611_core.c b/drivers/iio/pressure/ms5611_core.c
index f950cfde5db9..2f598ad91621 100644
--- a/drivers/iio/pressure/ms5611_core.c
+++ b/drivers/iio/pressure/ms5611_core.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MS5611 pressure and temperature sensor driver
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * Data sheet:
  *  http://www.meas-spec.com/downloads/MS5611-01BA03.pdf
  *  http://www.meas-spec.com/downloads/MS5607-02BA03.pdf
diff --git a/drivers/iio/pressure/ms5611_i2c.c b/drivers/iio/pressure/ms5611_i2c.c
index 0469c8ae1134..8089c59adce5 100644
--- a/drivers/iio/pressure/ms5611_i2c.c
+++ b/drivers/iio/pressure/ms5611_i2c.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MS5611 pressure and temperature sensor driver (I2C bus)
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  * 7-bit I2C slave addresses:
  *
  * 0x77 (CSB pin low)
diff --git a/drivers/iio/pressure/ms5611_spi.c b/drivers/iio/pressure/ms5611_spi.c
index cd11d022208e..b463eaa799ab 100644
--- a/drivers/iio/pressure/ms5611_spi.c
+++ b/drivers/iio/pressure/ms5611_spi.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * MS5611 pressure and temperature sensor driver (SPI bus)
  *
  * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
  */

 #include <linux/delay.h>
--
2.18.0
