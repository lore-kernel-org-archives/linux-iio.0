Return-Path: <SRS0=iwlF=HK=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 02/13] staging: iio: tsl2x7x: use GPL-2.0+ SPDX license identifier
Date: Fri, 20 Apr 2018 20:41:42 -0400
Message-Id: <20180421004153.19073-3-masneyb@onstation.org>
In-Reply-To: <20180421004153.19073-1-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

The summary text for the GPL is not needed since the SPDX identifier
is a legally binding shorthand that can be used instead.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 10 +---------
 drivers/staging/iio/light/tsl2x7x.h | 14 +-------------
 2 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index eeccfbb0eb1f..9cdcc8c9e812 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -5,15 +5,7 @@
  * Copyright (c) 2012, TAOS Corporation.
  * Copyright (c) 2017-2018 Brian Masney <masneyb@onstation.org>
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
+ * SPDX-License-Identifier: GPL-2.0+
  */
 
 #include <linux/delay.h>
diff --git a/drivers/staging/iio/light/tsl2x7x.h b/drivers/staging/iio/light/tsl2x7x.h
index d382cdbb976e..992ee2465609 100644
--- a/drivers/staging/iio/light/tsl2x7x.h
+++ b/drivers/staging/iio/light/tsl2x7x.h
@@ -4,19 +4,7 @@
  *
  * Copyright (c) 2012, TAOS Corporation.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin Street, Fifth Floor, Boston, MA	02110-1301, USA.
+ * SPDX-License-Identifier: GPL-2.0+
  */
 
 #ifndef __TSL2X7X_H
-- 
2.14.3
