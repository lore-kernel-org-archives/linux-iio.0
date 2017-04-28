Return-Path: <SRS0=f6FN=4E=collabora.co.uk=sebastian.reichel@kernel.org>
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Sebastian Reichel <sre@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Brian Masney <masneyb@onstation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: [PATCH] staging: iio: isl29028: add isl29030 support
Date: Fri, 28 Apr 2017 17:55:58 +0200
Message-Id: <20170428155558.17723-1-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

isl29030 is basically the same chip. The only difference
is the chip's first pin. For isl29028 its named ADDR0 and
can be used to change the chip's i2c address. For isl29030
on the other hand that pin is named Ials and is an analog
current output proportional to ALS/IR. This change is
irrelevant for the Linux driver.

This has been tested on Motorola Droid 4.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
---
 Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
 drivers/staging/iio/light/isl29028.c                      | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
index ad10fbe61562..010e2ac43f62 100644
--- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
@@ -55,6 +55,7 @@ gmt,g751		G751: Digital Temperature Sensor and Thermal Watchdog with Two-Wire In
 infineon,slb9635tt	Infineon SLB9635 (Soft-) I2C TPM (old protocol, max 100khz)
 infineon,slb9645tt	Infineon SLB9645 I2C TPM (new protocol, max 400khz)
 isil,isl29028		Intersil ISL29028 Ambient Light and Proximity Sensor
+isil,isl29030		Intersil ISL29030 Ambient Light and Proximity Sensor
 maxim,ds1050		5 Bit Programmable, Pulse-Width Modulator
 maxim,max1237		Low-Power, 4-/12-Channel, 2-Wire Serial, 12-Bit ADCs
 maxim,max6625		9-Bit/12-Bit Temperature Sensors with I²C-Compatible Serial Interface
diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 6bb6d37cc7d1..564a62e54b05 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -15,6 +15,10 @@
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Datasheets:
+ *  - http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29028.pdf
+ *  - http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29030.pdf
  */
 
 #include <linux/module.h>
@@ -651,6 +655,7 @@ static const struct dev_pm_ops isl29028_pm_ops = {
 
 static const struct i2c_device_id isl29028_id[] = {
 	{"isl29028", 0},
+	{"isl29030", 0},
 	{}
 };
 MODULE_DEVICE_TABLE(i2c, isl29028_id);
@@ -658,6 +663,7 @@ MODULE_DEVICE_TABLE(i2c, isl29028_id);
 static const struct of_device_id isl29028_of_match[] = {
 	{ .compatible = "isl,isl29028", }, /* for backward compat., don't use */
 	{ .compatible = "isil,isl29028", },
+	{ .compatible = "isil,isl29030", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, isl29028_of_match);
-- 
2.11.0
