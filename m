Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Azael Avalos <coproscefalo@gmail.com>,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 37/38] platform/x86: toshiba_acpi: drop assignment of iio_info.driver_module
Date: Mon, 29 May 2017 16:51:53 +0100
Message-Id: <20170529155154.22580-38-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This is now handled by use of a macro for device registration.  The field
in iio_info will be going away shortly as it is no longer used.

Cc: Azael Avalos <coproscefalo@gmail.com>
Cc: <platform-driver-x86@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/platform/x86/toshiba_acpi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
index d0daf75cbed1..ef4301f41727 100644
--- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -2515,7 +2515,6 @@ static const struct iio_chan_spec toshiba_iio_accel_channels[] = {
 };
 
 static const struct iio_info toshiba_iio_accel_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = &toshiba_iio_accel_read_raw,
 };
 
-- 
2.13.0
