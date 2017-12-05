Return-Path: <SRS0=aaeU=DB=gmail.com=pravin.shedge4linux@kernel.org>
From: Pravin Shedge <pravin.shedge4linux@gmail.com>
To: 
Cc: pravin.shedge4linux@gmail.com,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/45] drivers: iio: gyro: remove duplicate includes
Date: Tue,  5 Dec 2017 07:30:19 +0530
Message-Id: <1512439222-15714-1-git-send-email-pravin.shedge4linux@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

These duplicate includes have been found with scripts/checkincludes.pl but
they have been removed manually to avoid removing false positives.

Signed-off-by: Pravin Shedge <pravin.shedge4linux@gmail.com>
---
 drivers/iio/gyro/bmg160_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 1504617..63ca316 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -27,7 +27,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/regmap.h>
-#include <linux/delay.h>
 #include "bmg160.h"
 
 #define BMG160_IRQ_NAME		"bmg160_event"
-- 
2.7.4
