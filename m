Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:53906 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756112AbcEQQ0T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 17 May 2016 12:26:19 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Kieran Bingham <kieran@ksquared.org.uk>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Ranostay <mranostay@gmail.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Export I2C module alias information
Date: Tue, 17 May 2016 12:25:37 -0400
Message-Id: <1463502337-13199-1-git-send-email-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The I2C drivers have an i2c_device_id array but that information isn't
exported to the modules using the MODULE_DEVICE_TABLE() macro. So the
modules autoloading won't work if the I2C device is registered using
OF or legacy board files due missing alias information in the modules.

The issue was found using Kieran Bingham's coccinelle semantic patch:
https://lkml.org/lkml/2016/5/10/520

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/iio/humidity/am2315.c     | 1 +
 drivers/iio/humidity/htu21.c      | 1 +
 drivers/iio/pressure/hp206c.c     | 1 +
 drivers/iio/pressure/ms5637.c     | 1 +
 drivers/iio/temperature/tsys02d.c | 1 +
 5 files changed, 5 insertions(+)

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 3be6d209a159..8de39bd349f9 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -278,6 +278,7 @@ static const struct i2c_device_id am2315_i2c_id[] = {
 	{"am2315", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, am2315_i2c_id);
 
 static const struct acpi_device_id am2315_acpi_id[] = {
 	{"AOS2315", 0},
diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
index 11cbc38b450f..0fbbd8c40894 100644
--- a/drivers/iio/humidity/htu21.c
+++ b/drivers/iio/humidity/htu21.c
@@ -236,6 +236,7 @@ static const struct i2c_device_id htu21_id[] = {
 	{"ms8607-humidity", MS8607},
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, htu21_id);
 
 static struct i2c_driver htu21_driver = {
 	.probe = htu21_probe,
diff --git a/drivers/iio/pressure/hp206c.c b/drivers/iio/pressure/hp206c.c
index 90f2b6e4a920..12f769e86355 100644
--- a/drivers/iio/pressure/hp206c.c
+++ b/drivers/iio/pressure/hp206c.c
@@ -401,6 +401,7 @@ static const struct i2c_device_id hp206c_id[] = {
 	{"hp206c"},
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, hp206c_id);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id hp206c_acpi_match[] = {
diff --git a/drivers/iio/pressure/ms5637.c b/drivers/iio/pressure/ms5637.c
index e68052c118e6..8fb6f7ab97e4 100644
--- a/drivers/iio/pressure/ms5637.c
+++ b/drivers/iio/pressure/ms5637.c
@@ -173,6 +173,7 @@ static const struct i2c_device_id ms5637_id[] = {
 	{"ms8607-temppressure", 1},
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, ms5637_id);
 
 static struct i2c_driver ms5637_driver = {
 	.probe = ms5637_probe,
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index ab6fe8f6f2d1..c0a19a000387 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -174,6 +174,7 @@ static const struct i2c_device_id tsys02d_id[] = {
 	{"tsys02d", 0},
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, tsys02d_id);
 
 static struct i2c_driver tsys02d_driver = {
 	.probe = tsys02d_probe,
-- 
2.5.5

