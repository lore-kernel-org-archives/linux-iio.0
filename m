Return-Path: <gabriele.mzt@gmail.com>
From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	marxin.liska@gmail.com,
	marex@denx.de,
	rui.zhang@intel.com,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	daniel.baluta@gmail.com,
	Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] iio: acpi-als: Fix Kconfig and remove unneeded pointer casting
Date: Sat,  9 May 2015 21:30:58 +0200
Message-Id: <1431199858-8066-1-git-send-email-gabriele.mzt@gmail.com>
In-Reply-To: <1430569857-31386-1-git-send-email-gabriele.mzt@gmail.com>
References: <1430569857-31386-1-git-send-email-gabriele.mzt@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
This patch fixes the issues of:
[PATCH v9] iio: acpi: Add support for ACPI0008 Ambient Light Sensor

Link: http://lkml.kernel.org/g/1430569857-31386-1-git-send-email-gabriele.mzt@gmail.com

 drivers/iio/light/Kconfig    | 1 +
 drivers/iio/light/acpi-als.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 898b2b5..fecd743 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -8,6 +8,7 @@ menu "Light sensors"
 config ACPI_ALS
 	tristate "ACPI Ambient Light Sensor"
 	depends on ACPI
+	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	select IIO_KFIFO_BUF
 	help
diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index 9839c9a..1dafa07 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -138,8 +138,7 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
 		goto out;
 	}
 
-	iio_push_to_buffers_with_timestamp(indio_dev,
-					   (u8 *)als->evt_buffer, time_ns);
+	iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
 
 out:
 	mutex_unlock(&als->lock);
-- 
2.1.4
