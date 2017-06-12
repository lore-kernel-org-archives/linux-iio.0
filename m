Return-Path: <SRS0=HePV=5R=ti.com=m-stecklein@kernel.org>
From: Michael Stecklein <m-stecklein@ti.com>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>,
        Michael Stecklein
	<m-stecklein@ti.com>
Subject: [PATCH 2/3] iio: humidity: hdc100x: document compatible HDC10xx devices
Date: Mon, 12 Jun 2017 09:49:09 -0500
Message-ID: <1497278950-12973-2-git-send-email-m-stecklein@ti.com>
In-Reply-To: <1497278950-12973-1-git-send-email-m-stecklein@ti.com>
References: <1497278950-12973-1-git-send-email-m-stecklein@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Include datasheet links, add i2c_device_id entries, and update
kconfig help for compatible HDC10xx devices: HDC1000, HDC1008,
HDC1010, HDC1050, and HDC1080.

Signed-off-by: Michael Stecklein <m-stecklein@ti.com>
---
 drivers/iio/humidity/Kconfig   | 3 ++-
 drivers/iio/humidity/hdc100x.c | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
index 14b9ce4..2c0fc9a 100644
--- a/drivers/iio/humidity/Kconfig
+++ b/drivers/iio/humidity/Kconfig
@@ -31,7 +31,8 @@ config HDC100X
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for the Texas Instruments
-	  HDC1000 and HDC1008 relative humidity and temperature sensors.
+	  HDC1000, HDC1008, HDC1010, HDC1050, and HDC1080 relative
+	  humidity and temperature sensors.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called hdc100x.
diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index aa17115..0e5962f 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -13,6 +13,12 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  * GNU General Public License for more details.
  *
+ * Datasheets:
+ * http://www.ti.com/product/HDC1000/datasheet
+ * http://www.ti.com/product/HDC1008/datasheet
+ * http://www.ti.com/product/HDC1010/datasheet
+ * http://www.ti.com/product/HDC1050/datasheet
+ * http://www.ti.com/product/HDC1080/datasheet
  */
 
 #include <linux/delay.h>
@@ -414,6 +420,9 @@ static int hdc100x_remove(struct i2c_client *client)
 
 static const struct i2c_device_id hdc100x_id[] = {
 	{ "hdc100x", 0 },
+	{ "hdc1010", 0 },
+	{ "hdc1050", 0 },
+	{ "hdc1080", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, hdc100x_id);
-- 
2.7.4
