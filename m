Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34058 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751973AbeC2JMI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Mar 2018 05:12:08 -0400
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, Michael.Hennerich@analog.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v6 1/6] Staging: iio: adis16209: Indent the field definitions
Date: Thu, 29 Mar 2018 14:42:02 +0530
Message-Id: <508a70d5477067c083408fc81e58023c7e91bc95.1522306893.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Have indentation in field definitions to make them
clearly different from the register addresses.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v5
  -Change some macro names and have indentation in the field
definitions.

Changes in v6
  -Have indentation in the field definitions and do not
change the names of the macros as the patch for changing 
the names has already been applied.

 drivers/staging/iio/accel/adis16209.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index a8453bf..0e6366a 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -71,13 +71,13 @@
 #define ADIS16209_STAT_REG			0x3C
 #define  ADIS16209_STAT_ALARM2			BIT(9)
 #define  ADIS16209_STAT_ALARM1			BIT(8)
-#define ADIS16209_STAT_SELFTEST_FAIL_BIT	5
-#define ADIS16209_STAT_SPI_FAIL_BIT		3
-#define ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
+#define  ADIS16209_STAT_SELFTEST_FAIL_BIT	5
+#define  ADIS16209_STAT_SPI_FAIL_BIT		3
+#define  ADIS16209_STAT_FLASH_UPT_FAIL_BIT	2
 /* Power supply above 3.625 V */
-#define ADIS16209_STAT_POWER_HIGH_BIT		1
+#define  ADIS16209_STAT_POWER_HIGH_BIT		1
 /* Power supply below 3.15 V */
-#define ADIS16209_STAT_POWER_LOW_BIT		0
+#define  ADIS16209_STAT_POWER_LOW_BIT		0
 
 #define ADIS16209_CMD_REG			0x3E
 #define  ADIS16209_CMD_SW_RESET			BIT(7)
-- 
2.7.4

