Return-Path: <SRS0=R3xd=C6=axtens.net=dja@kernel.org>
From: Daniel Axtens <dja@axtens.net>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org
Cc: trivial@kernel.org,
	Daniel Axtens <dja@axtens.net>
Subject: [PATCH] iio: adc: add MODULE_LICENSE to qcom-vadc-common.c
Date: Sat,  2 Dec 2017 23:22:09 +1100
Message-Id: <20171202122209.14720-1-dja@axtens.net>
List-ID: <linux-iio@vger.kernel.org>

This fixes the following warning during an allmodconfig build:
WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o

This matches the header at the top of the file.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 drivers/iio/adc/qcom-vadc-common.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 47d24ae5462f..3b2c48ab44ff 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -5,6 +5,7 @@
 #include <linux/math64.h>
 #include <linux/log2.h>
 #include <linux/err.h>
+#include <linux/module.h>
 
 #include "qcom-vadc-common.h"
 
@@ -229,3 +230,5 @@ int qcom_vadc_decimation_from_dt(u32 value)
 	return __ffs64(value / VADC_DECIMATION_MIN);
 }
 EXPORT_SYMBOL(qcom_vadc_decimation_from_dt);
+
+MODULE_LICENSE("GPL v2");
-- 
2.11.0
