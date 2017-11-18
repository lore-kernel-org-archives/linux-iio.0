Return-Path: <SRS0=mp7F=CQ=posteo.de=martink@kernel.org>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	harinath922@gmail.com
Cc: pmeerw@pmeerw.net,
	lars@metafoo.de,
	knaack.h@gmx.de,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH v2] iio: mma8452: replace license description with SPDX specifier
Date: Sat, 18 Nov 2017 10:10:11 +0100
Message-Id: <20171118091011.9061-1-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

This replaces the custom license information text with the appropriate
SPDX identifier. While the information here stays the same, it is easier
to read.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
Acked-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---

Sorry I had forgotten to add the mailing lists and got Peter's Ack
privately. -.-  But thanks Peter for the quick response!

Again, an Acked-by from Harinath would be good here too.

thanks

                             martin

revision history
----------------
v2: adds Peter's Acked-by and adds all mailing lists to CC


 drivers/iio/accel/mma8452.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index bfd4bc806fc2..62c0d4646c16 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * mma8452.c - Support for following Freescale / NXP 3-axis accelerometers:
  *
@@ -13,9 +14,6 @@
  * Copyright 2015 Martin Kepplinger <martink@posteo.de>
  * Copyright 2014 Peter Meerwald <pmeerw@pmeerw.net>
  *
- * This file is subject to the terms and conditions of version 2 of
- * the GNU General Public License.  See the file COPYING in the main
- * directory of this archive for more details.
  *
  * TODO: orientation events
  */
-- 
2.11.0
