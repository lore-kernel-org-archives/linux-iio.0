Return-Path: <SRS0=sUvW=IH=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH 6/9] i2c: acpi: Add BSG1160 to i2c_acpi_multiple_devices_ids
Date: Sun, 20 May 2018 15:28:54 +0200
Message-Id: <20180520132857.8103-7-hdegoede@redhat.com>
In-Reply-To: <20180520132857.8103-1-hdegoede@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

The BSG1160 ACPI HID is a HID describing a sensor complex consisting of
3 sensors:

Accel: BMC150A at addr 0x11
Gyro: BMG160 at addr 0x68
Magneto: BMC150B at addr 0x13

The ACPI resources table contains I2cSerialBusV2 resources for each,
add the BSG1160 id to the i2c_acpi_multiple_devices_ids list, so that
an i2c_client gets instantiated for each sensor.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index f2f9048caffd..7fb622b269db 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -216,6 +216,7 @@ static const struct acpi_device_id i2c_acpi_multiple_devices_ids[] = {
 	 * enumerate them all.
 	 */
 	{ "BOSC0200", 0 },
+	{ "BSG1160", 0 },
 	{ "INT3515", 0 },
 	{}
 };
-- 
2.17.0
