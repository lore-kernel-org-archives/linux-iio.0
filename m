Return-Path: <SRS0=7pCU=XW=gmail.com=nizamhaider786@kernel.org>
From: Nizam Haider <nizamhaider786@gmail.com>
To: pmeerw@pmeerw.net
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Nizam Haider <nizamhaider786@gmail.com>,
	Nizam Haider <nijam.h@hcl.com>
Subject: [PATCH] Staging: iio: impedance-analyzer: ad5933: fix wrong comments
Date: Wed,  7 Dec 2016 23:14:47 +0530
Message-Id: <20161207174447.24128-1-nizamhaider786@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

according to datasheet complete control register is of 2 bytes.
http://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf

Signed-off-by: Nizam Haider <nijam.h@hcl.com>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3892a74..f39e03a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -23,8 +23,8 @@
 #include <linux/iio/kfifo_buf.h>
 
 /* AD5933/AD5934 Registers */
-#define AD5933_REG_CONTROL_HB		0x80	/* R/W, 2 bytes */
-#define AD5933_REG_CONTROL_LB		0x81	/* R/W, 2 bytes */
+#define AD5933_REG_CONTROL_HB		0x80	/* R/W, 1 byte */
+#define AD5933_REG_CONTROL_LB		0x81	/* R/W, 1 byte */
 #define AD5933_REG_FREQ_START		0x82	/* R/W, 3 bytes */
 #define AD5933_REG_FREQ_INC		0x85	/* R/W, 3 bytes */
 #define AD5933_REG_INC_NUM		0x88	/* R/W, 2 bytes, 9 bit */
-- 
2.10.1
