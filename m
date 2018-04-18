Return-Path: <SRS0=zfs8=HH=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: st_accel: Add support for the SMO8840 ACPI id
Date: Wed, 18 Apr 2018 14:33:18 +0200
Message-Id: <20180418123318.10948-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

The Lenovo Ideapad Miix 320 uses an st accelerometer with an ACPI id
of SMO8840, add support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/st_accel_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 6bdec8c451e0..056dddb27236 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -107,6 +107,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
 
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id st_accel_acpi_match[] = {
+	{"SMO8840", LNG2DM},
 	{"SMO8A90", LNG2DM},
 	{ },
 };
-- 
2.17.0
