Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45192 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbdLEO4G (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Dec 2017 09:56:06 -0500
Received: by mail-wr0-f196.google.com with SMTP id h1so565507wre.12
        for <linux-iio@vger.kernel.org>; Tue, 05 Dec 2017 06:56:06 -0800 (PST)
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: jic23@kernel.org, alexandre.torgue@st.com, fabrice.gasnier@st.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH] iio: stm32: Adopt SPDX identifier
Date: Tue,  5 Dec 2017 15:55:59 +0100
Message-Id: <20171205145559.20294-1-benjamin.gaignard@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add SPDX identifier in stm32's files in IIO directory

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
 drivers/iio/adc/stm32-adc-core.c            | 14 +-------------
 drivers/iio/adc/stm32-adc-core.h            | 14 +-------------
 drivers/iio/adc/stm32-adc.c                 | 15 +--------------
 drivers/iio/counter/stm32-lptimer-cnt.c     |  2 +-
 drivers/iio/dac/stm32-dac-core.c            | 14 +-------------
 drivers/iio/dac/stm32-dac-core.h            | 15 +--------------
 drivers/iio/dac/stm32-dac.c                 | 15 +--------------
 drivers/iio/trigger/stm32-lptimer-trigger.c |  3 +--
 drivers/iio/trigger/stm32-timer-trigger.c   |  2 +-
 9 files changed, 9 insertions(+), 85 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 6aefef99f935..40be7d9fadbf 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is part of STM32 ADC driver
  *
@@ -6,19 +7,6 @@
  *
  * Inspired from: fsl-imx25-tsadc
  *
- * License type: GPLv2
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.
- * See the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/iio/adc/stm32-adc-core.h b/drivers/iio/adc/stm32-adc-core.h
index 250ee958a669..8af507b3f32d 100644
--- a/drivers/iio/adc/stm32-adc-core.h
+++ b/drivers/iio/adc/stm32-adc-core.h
@@ -1,22 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This file is part of STM32 ADC driver
  *
  * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
  *
- * License type: GPLv2
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.
- * See the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef __STM32_ADC_H
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index c9d96f935dba..f9ccd705bcbb 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is part of STM32 ADC driver
  *
  * Copyright (C) 2016, STMicroelectronics - All Rights Reserved
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
- *
- * License type: GPLv2
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.
- * See the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/iio/counter/stm32-lptimer-cnt.c b/drivers/iio/counter/stm32-lptimer-cnt.c
index 81ae5f74216d..42fb8ba67090 100644
--- a/drivers/iio/counter/stm32-lptimer-cnt.c
+++ b/drivers/iio/counter/stm32-lptimer-cnt.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * STM32 Low-Power Timer Encoder and Counter driver
  *
@@ -7,7 +8,6 @@
  *
  * Inspired by 104-quad-8 and stm32-timer-trigger drivers.
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/bitfield.h>
diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
index 55026fe1c610..d0fb3124de07 100644
--- a/drivers/iio/dac/stm32-dac-core.c
+++ b/drivers/iio/dac/stm32-dac-core.c
@@ -1,22 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is part of STM32 DAC driver
  *
  * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
  *
- * License type: GPLv2
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.
- * See the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/clk.h>
diff --git a/drivers/iio/dac/stm32-dac-core.h b/drivers/iio/dac/stm32-dac-core.h
index daf09931857c..d3b415fb9575 100644
--- a/drivers/iio/dac/stm32-dac-core.h
+++ b/drivers/iio/dac/stm32-dac-core.h
@@ -1,22 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 /*
  * This file is part of STM32 DAC driver
  *
  * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
- *
- * License type: GPLv2
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.
- * See the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #ifndef __STM32_DAC_CORE_H
diff --git a/drivers/iio/dac/stm32-dac.c b/drivers/iio/dac/stm32-dac.c
index 9ffab02bf9f9..cce26a3a6627 100644
--- a/drivers/iio/dac/stm32-dac.c
+++ b/drivers/iio/dac/stm32-dac.c
@@ -1,23 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * This file is part of STM32 DAC driver
  *
  * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
  * Authors: Amelie Delaunay <amelie.delaunay@st.com>
  *	    Fabrice Gasnier <fabrice.gasnier@st.com>
- *
- * License type: GPLv2
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
- * or FITNESS FOR A PARTICULAR PURPOSE.
- * See the GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program. If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/bitfield.h>
diff --git a/drivers/iio/trigger/stm32-lptimer-trigger.c b/drivers/iio/trigger/stm32-lptimer-trigger.c
index de361d879929..98cdc7e47f3d 100644
--- a/drivers/iio/trigger/stm32-lptimer-trigger.c
+++ b/drivers/iio/trigger/stm32-lptimer-trigger.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * STM32 Low-Power Timer Trigger driver
  *
@@ -5,8 +6,6 @@
  *
  * Author: Fabrice Gasnier <fabrice.gasnier@st.com>.
  *
- * License terms:  GNU General Public License (GPL), version 2
- *
  * Inspired by Benjamin Gaignard's stm32-timer-trigger driver
  */
 
diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
index b542dc484969..ccf1ce653b25 100644
--- a/drivers/iio/trigger/stm32-timer-trigger.c
+++ b/drivers/iio/trigger/stm32-timer-trigger.c
@@ -1,9 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) STMicroelectronics 2016
  *
  * Author: Benjamin Gaignard <benjamin.gaignard@st.com>
  *
- * License terms:  GNU General Public License (GPL), version 2
  */
 
 #include <linux/iio/iio.h>
-- 
2.15.0

