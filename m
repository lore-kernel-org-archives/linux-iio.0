Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from h1.radempa.de ([176.9.142.194]:54409 "EHLO mail.cosmopool.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751190AbdBWRPW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 23 Feb 2017 12:15:22 -0500
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, Harald Geyer <harald@ccbib.org>
Subject: [PATCH 2/2] [RFC] iio: dht11: Add optional support for supply control via regulator framework
Date: Thu, 23 Feb 2017 17:06:53 +0000
Message-Id: <1487869613-11927-2-git-send-email-harald@ccbib.org>
In-Reply-To: <1487869613-11927-1-git-send-email-harald@ccbib.org>
References: <1487869613-11927-1-git-send-email-harald@ccbib.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If a supply is provided via DT, release the supply whenever we don't read
the sensor. Also use notifications to track the actual status of the
supply to ensure that we meet the timing requirements stated in the
datasheet.

This change is motivated by the hope that these sensors will work more
reliably if power-cycled regularly.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
This is an RFC this time, because I want to run extensive long term tests
with DHT11 and DHT22 before officially proposing this for inclusion. I
have learned my lessons with this quirky bits of HW... :(

However since this will take a lot of time (mostly physical, but also
man hours), I'd like to get review comments now instead of risking a
second iteration of long term tests.

 .../devicetree/bindings/iio/humidity/dht11.txt     | 10 ++++
 drivers/iio/humidity/dht11.c                       | 57 ++++++++++++++++++++--
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11.txt b/Documentation/devicetree/bindings/iio/humidity/dht11.txt
index ecc24c19..ab9ea18 100644
--- a/Documentation/devicetree/bindings/iio/humidity/dht11.txt
+++ b/Documentation/devicetree/bindings/iio/humidity/dht11.txt
@@ -6,9 +6,19 @@ Required properties:
     line, see "gpios property" in
     Documentation/devicetree/bindings/gpio/gpio.txt.
 
+Optional properties:
+  - vdd-supply: phandle to the regulator node, for details see
+    Documentation/devicetree/bindings/regulator/regulator.txt
+    On Linux the driver disables the regulator after 4 seconds of
+    inactivity, to save power and to ensure that the hardware is
+    reset regularly, because it was found to randomly stop responding
+    otherwise. However for this to work all other consumers of the
+    regulator must cooperate (disable the regulator when possible too).
+
 Example:
 
 humidity_sensor {
 	compatible = "dht11";
 	gpios = <&gpio0 6 0>;
+	vdd-supply = <&sensor_supply>;
 }
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index 2a22ad9..5bce712 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -34,12 +34,16 @@
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
 #include <linux/timekeeping.h>
+#include <linux/regulator/consumer.h>
+#include <linux/notifier.h>
 
 #include <linux/iio/iio.h>
 
 #define DRIVER_NAME	"dht11"
 
 #define DHT11_DATA_VALID_TIME	2000000000  /* 2s in ns */
+#define DHT11_POWER_ON_TIME 2000000000 /* must be less the MAX_INT */
+#define DHT11_POWEROFF_DELAY 4000 /* ms */
 
 #define DHT11_EDGES_PREAMBLE 2
 #define DHT11_BITS_PER_READ 40
@@ -84,6 +88,10 @@ struct dht11 {
 	int				gpio;
 	int				irq;
 
+	struct regulator		*supply;
+	struct notifier_block		nb;
+	s64				timestamp_enabled;
+
 	struct completion		completion;
 	/* The iio sysfs interface doesn't prevent concurrent reads: */
 	struct mutex			lock;
@@ -97,6 +105,21 @@ struct dht11 {
 	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
 };
 
+static int dht11_regulator_update(struct notifier_block *nb,
+				  unsigned long event,
+				  void *ignored)
+{
+	struct dht11 *dht11 = container_of(nb, struct dht11, nb);
+
+	if (event & REGULATOR_EVENT_DISABLE)
+		dht11->timestamp_enabled = -1;
+	else if (event & REGULATOR_EVENT_ENABLE)
+		if (dht11->timestamp_enabled == -1)
+			dht11->timestamp_enabled = ktime_get_boot_ns();
+
+	return NOTIFY_OK;
+}
+
 #ifdef CONFIG_DYNAMIC_DEBUG
 /*
  * dht11_edges_print: show the data as actually received by the
@@ -203,9 +226,22 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 {
 	struct dht11 *dht11 = iio_priv(iio_dev);
 	int ret, timeres, offset;
+	s64 time;
 
 	mutex_lock(&dht11->lock);
-	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boot_ns()) {
+	time = ktime_get_boot_ns();
+	if (dht11->timestamp + DHT11_DATA_VALID_TIME < time) {
+		if (dht11->supply) {
+			ret = regulator_enable(dht11->supply);
+			if (ret) {
+				dev_err(dht11->dev, "Can't enable supply\n");
+				goto err_reg;
+			}
+			time -= dht11->timestamp_enabled + DHT11_POWER_ON_TIME;
+			if (time < 0)
+				msleep(((int)(-time)) / 1000000);
+		}
+
 		timeres = ktime_get_resolution_ns();
 		dev_dbg(dht11->dev, "current timeresolution: %dns\n", timeres);
 		if (timeres > DHT11_MIN_TIMERES) {
@@ -266,8 +302,13 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 				break;
 		}
 
+err:
+		if (dht11->supply)
+			regulator_disable_deferred(dht11->supply,
+						   DHT11_POWEROFF_DELAY);
+
 		if (ret)
-			goto err;
+			goto err_reg;
 	}
 
 	ret = IIO_VAL_INT;
@@ -277,7 +318,8 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 		*val = dht11->humidity;
 	else
 		ret = -EINVAL;
-err:
+
+err_reg:
 	dht11->num_edges = -1;
 	mutex_unlock(&dht11->lock);
 	return ret;
@@ -332,6 +374,15 @@ static int dht11_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	dht11->timestamp_enabled = -1;
+	dht11->supply = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(dht11->supply)) {
+		dht11->supply = NULL;
+	} else {
+		dht11->nb.notifier_call = &dht11_regulator_update;
+		devm_regulator_register_notifier(dht11->supply, &dht11->nb);
+	}
+
 	dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
 	dht11->num_edges = -1;
 
-- 
2.1.4

