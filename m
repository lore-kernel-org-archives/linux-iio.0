Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:33375 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeJ3Xk5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 30 Oct 2018 19:40:57 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        linux-iio@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Javier Martinez Canillas <javierm@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Presser <steve@pressers.name>
Subject: [RFC][PATCH v1] ACPI / scan: Create platform device for BOSC0200 ACPI nodes
Date: Tue, 30 Oct 2018 16:47:06 +0200
Message-Id: <20181030144706.6737-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On some laptops the ACPI device with BOSC0200 _HID is representing
two accelerometers under one node.

We add an ID to the I2C multi instantiate list to enumerate
all I2C slaves correctly.

For reference here is the relevant DSDT blurb from the Yoga 11e:

Device (ACC)
{
	Name (_ADR, Zero)  // _ADR: Address
	Name (_HID, "BOSC0200")  // _HID: Hardware ID
	Name (_CID, "BOSC0200")  // _CID: Compatible ID
	Name (_DDN, "Accelerometer")  // _DDN: DOS Device Name
	Name (_UID, One)  // _UID: Unique ID
	Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
	{
		Name (RBUF, ResourceTemplate ()
		{
			I2cSerialBusV2 (0x0019, ControllerInitiated, 0x00061A80,
				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
				0x00, ResourceConsumer, , Exclusive,
			)
			I2cSerialBusV2 (0x0018, ControllerInitiated, 0x00061A80,
				AddressingMode7Bit, "\\_SB.PCI0.I2C3",
				0x00, ResourceConsumer, , Exclusive,
			)
		})
		Return (RBUF) /* \_SB_.PCI0.I2C3.ACC_._CRS.RBUF */
	}

Reported-by: Jeremy Cline <jeremy@jcline.org>
Cc: Steven Presser <steve@pressers.name>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

The previous approach had been discussed at
https://lore.kernel.org/lkml/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com/

This has an obvious regression as per commit 1911f48de0d9 ("iio: accel: bmc150:
Add support for BOSC0200 ACPI device id") there are tables where under same ID
we have different sets of the devices (luckily some of that is possible to
autodetect):

- one accellerometer  (250e)
- one accellerometer  (222e)
- two accellerometers (???)

The proper enabling of the last case w/o a regression sounds like a DMI based
data for I2C multi instantiate driver along with automatic selection of the latter
whenever user selects bmc150-accel-i2c.c.

 drivers/acpi/scan.c                          | 1 +
 drivers/iio/accel/bmc150-accel-i2c.c         | 1 -
 drivers/platform/x86/i2c-multi-instantiate.c | 7 +++++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index bd1c59fb0e17..a8cdae057a47 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1539,6 +1539,7 @@ static bool acpi_device_enumeration_by_parent(struct acpi_device *device)
 	 * which i2c_device_id to use for each resource.
 	 */
 	static const struct acpi_device_id i2c_multi_instantiate_ids[] = {
+		{"BOSC0200", },
 		{"BSG1160", },
 		{"INT33FE", },
 		{}
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 8ffc308d5fd0..9d22a4d9d568 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -64,7 +64,6 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMA250E",	bma250e},
 	{"BMA222E",	bma222e},
 	{"BMA0280",	bma280},
-	{"BOSC0200"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
diff --git a/drivers/platform/x86/i2c-multi-instantiate.c b/drivers/platform/x86/i2c-multi-instantiate.c
index 5456581b473c..8e763765a05e 100644
--- a/drivers/platform/x86/i2c-multi-instantiate.c
+++ b/drivers/platform/x86/i2c-multi-instantiate.c
@@ -100,6 +100,12 @@ static int i2c_multi_inst_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct i2c_inst_data bosc0200_data[]  = {
+	{ "bmc150_accel", -1 },
+	{ "bmc150_accel", -1 },
+	{}
+};
+
 static const struct i2c_inst_data bsg1160_data[]  = {
 	{ "bmc150_accel", 0 },
 	{ "bmc150_magn", -1 },
@@ -112,6 +118,7 @@ static const struct i2c_inst_data bsg1160_data[]  = {
  * drivers/acpi/scan.c: acpi_device_enumeration_by_parent().
  */
 static const struct acpi_device_id i2c_multi_inst_acpi_ids[] = {
+	{ "BOSC0200", (unsigned long)bosc0200_data },
 	{ "BSG1160", (unsigned long)bsg1160_data },
 	{ }
 };
-- 
2.19.1
