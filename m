Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:52764 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727952AbeGUUbw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Jul 2018 16:31:52 -0400
From: David Lechner <david@lechnology.com>
To: linux-iio@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] iio: adc: ti-ads7950: use SPDX-License-Identifier
Date: Sat, 21 Jul 2018 14:37:33 -0500
Message-Id: <20180721193734.6427-2-david@lechnology.com>
In-Reply-To: <20180721193734.6427-1-david@lechnology.com>
References: <20180721193734.6427-1-david@lechnology.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This updates the ti-ads7950.c file to use SPDX-License-Identifier
instead of more verbose license text.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/iio/adc/ti-ads7950.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 0225c1b333ab..f08c4de2bd10 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Texas Instruments ADS7950 SPI ADC driver
  *
@@ -10,15 +11,6 @@
  * And also on hwmon/ads79xx.c
  * Copyright (C) 2013 Texas Instruments Incorporated - http://www.ti.com/
  *	Nishanth Menon
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation version 2.
- *
- * This program is distributed "as is" WITHOUT ANY WARRANTY of any
- * kind, whether express or implied; without even the implied warranty
- * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/acpi.h>
-- 
2.17.1

