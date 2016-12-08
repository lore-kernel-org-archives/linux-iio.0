Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp.megiteam.pl ([31.186.83.105]:40829 "EHLO smtp.megiteam.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752016AbcLHO7A (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Dec 2016 09:59:00 -0500
From: Marcin Niestroj <m.niestroj@grinn-global.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org,
        Marcin Niestroj <m.niestroj@grinn-global.com>
Subject: [PATCH v2 2/6] iio: bmi160: Add of device table for spi
Date: Thu,  8 Dec 2016 15:22:55 +0100
Message-Id: <20161208142259.26230-3-m.niestroj@grinn-global.com>
In-Reply-To: <20161208142259.26230-1-m.niestroj@grinn-global.com>
References: <20161208142259.26230-1-m.niestroj@grinn-global.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>From now on we can add bmi160 device to device-tree by specifying
compatible string.

Signed-off-by: Marcin Niestroj <m.niestroj@grinn-global.com>
---
Patch introduced in v2

 drivers/iio/imu/bmi160/bmi160_spi.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
index 1ec8b12..d34dfdf 100644
--- a/drivers/iio/imu/bmi160/bmi160_spi.c
+++ b/drivers/iio/imu/bmi160/bmi160_spi.c
@@ -7,10 +7,11 @@
  * the GNU General Public License.  See the file COPYING in the main
  * directory of this archive for more details.
  */
+#include <linux/acpi.h>
 #include <linux/module.h>
-#include <linux/spi/spi.h>
+#include <linux/of.h>
 #include <linux/regmap.h>
-#include <linux/acpi.h>
+#include <linux/spi/spi.h>
 
 #include "bmi160.h"
 
@@ -47,13 +48,22 @@ static const struct acpi_device_id bmi160_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, bmi160_acpi_match);
 
+#ifdef CONFIG_OF
+static const struct of_device_id bmi160_of_match[] = {
+	{ .compatible = "bosch,bmi160" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bmi160_of_match);
+#endif
+
 static struct spi_driver bmi160_spi_driver = {
 	.probe		= bmi160_spi_probe,
 	.remove		= bmi160_spi_remove,
 	.id_table	= bmi160_spi_id,
 	.driver = {
-		.acpi_match_table = ACPI_PTR(bmi160_acpi_match),
-		.name	= "bmi160_spi",
+		.acpi_match_table	= ACPI_PTR(bmi160_acpi_match),
+		.of_match_table		= of_match_ptr(bmi160_of_match),
+		.name			= "bmi160_spi",
 	},
 };
 module_spi_driver(bmi160_spi_driver);
-- 
2.10.2

