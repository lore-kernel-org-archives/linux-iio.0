Return-Path: <SRS0=/6pp=LD=axentia.se=peda@kernel.org>
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/5] iio: potentiometer: mcp4531: switch to SPDX license identifier
Date: Mon, 20 Aug 2018 12:01:11 +0200
Message-Id: <20180820100114.22966-3-peda@axentia.se>
In-Reply-To: <20180820100114.22966-1-peda@axentia.se>
References: <20180820100114.22966-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Drop the boilerplate license text and use the correct MODULE_LICENSE.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4531.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index df894af6cccb..831ad3e7871c 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Industrial I/O driver for Microchip digital potentiometers
  * Copyright (c) 2015  Axentia Technologies AB
@@ -22,10 +23,6 @@
  * mcp4652	2	257		5, 10, 50, 100          01011xx
  * mcp4661	2	257		5, 10, 50, 100          0101xxx
  * mcp4662	2	257		5, 10, 50, 100          01011xx
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
  */
 
 #include <linux/module.h>
@@ -403,4 +400,4 @@ module_i2c_driver(mcp4531_driver);
 
 MODULE_AUTHOR("Peter Rosin <peda@axentia.se>");
 MODULE_DESCRIPTION("MCP4531 digital potentiometer");
-MODULE_LICENSE("GPL");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
