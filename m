Return-Path: <SRS0=41xl=5Y=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: bmc150: Add support for BOSC0200 ACPI device id
Date: Mon, 19 Jun 2017 08:22:25 +0200
Message-Id: <20170619062225.3402-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Add support for the BOSC0200 ACPI device id used on some x86 tablets.
note driver_data is not set to a specific model, driver_data is not
used anyways (instead detection is done on the chip_id reg) and the
2 tablets with a BOSC0200 ACPI device id I've have 2 different chips,
one has a BMA250E, the other a BMA222E.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 8ca8041267ef..f85014fbaa12 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -64,6 +64,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMA250E",	bma250e},
 	{"BMA222E",	bma222e},
 	{"BMA0280",	bma280},
+	{"BOSC0200"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
-- 
2.13.0
