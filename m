Return-Path: <SRS0=LAfQ=HA=analog.com=StefanSerban.Popa@kernel.org>
From: Stefan Popa <stefan.popa@analog.com>
To: <jic23@kernel.org>, <Michael.Hennerich@analog.com>, <lars@metafoo.de>
CC: <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH v3 2/7] iio:dac:ad5686: Change license description
Date: Wed, 11 Apr 2018 14:52:12 +0300
Message-ID: <1523447532-13170-1-git-send-email-stefan.popa@analog.com>
In-Reply-To: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
References: <1523375929-29830-1-git-send-email-stefan.popa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add GPLv2+ SPDX identifier and remove license notice to keep the whole
purpose of using an SPDx id.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
Changes in v3:
	- Created a new patch to use the SPDx identifier

 drivers/iio/dac/ad5686.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index f7f975c..e328513 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -1,9 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * AD5686R, AD5685R, AD5684R Digital to analog converters  driver
  *
  * Copyright 2011 Analog Devices Inc.
- *
- * Licensed under the GPL-2.
  */
 
 #include <linux/interrupt.h>
-- 
2.7.4
