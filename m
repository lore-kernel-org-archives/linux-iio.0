Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mike.atx.name ([185.8.165.10]:53276 "EHLO mike.atx.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbdARQvO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 18 Jan 2017 11:51:14 -0500
Date: Wed, 18 Jan 2017 17:39:53 +0100
From: Josef Gajdusek <atx@atx.name>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maitysanchayan@gmail.com,
        gregor.boirie@parrot.com, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, marxin.liska@gmail.com, marex@denx.de,
        atx@atx.name
Subject: [PATCH] iio: light: acpi-als: Properly enable on ASUS Zenbooks
Message-ID: <20170118161254.GA17344@rick.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ASUS Zenbooks need several special ACPI calls to enable the ALS peripheral.
Otherwise, reads just return 0.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
 drivers/iio/light/acpi-als.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index f0b47c5..1fe2cd8 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -39,6 +39,9 @@
 #define ACPI_ALS_DEVICE_NAME		"acpi-als"
 #define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
 
+#define ACPI_ALS_ASUS_TALS		"\\_SB.PCI0.LPCB.EC0.TALS"
+#define ACPI_ALS_ASUS_ALSC		"\\_SB.ATKD.ALSC"
+
 ACPI_MODULE_NAME("acpi-als");
 
 /*
@@ -180,6 +183,8 @@ static int acpi_als_add(struct acpi_device *device)
 	struct acpi_als *als;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
+	acpi_handle handle_tals, handle_alsc;
+	acpi_status status_tals, status_alsc;
 
 	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
 	if (!indio_dev)
@@ -191,6 +196,18 @@ static int acpi_als_add(struct acpi_device *device)
 	als->device = device;
 	mutex_init(&als->lock);
 
+	/* ASUS Zenbooks need this to enable ALS */
+	status_tals = acpi_get_handle(NULL, ACPI_ALS_ASUS_TALS, &handle_tals);
+	status_alsc = acpi_get_handle(NULL, ACPI_ALS_ASUS_ALSC, &handle_alsc);
+	/* So far only devices with both have been observed */
+	if (ACPI_SUCCESS(status_tals) ^ ACPI_SUCCESS(status_alsc))
+		dev_warn(&device->dev, "Attempting to enable ACPI ALS, but found only one of \""
+			 ACPI_ALS_ASUS_TALS "\" and \"" ACPI_ALS_ASUS_ALSC "\"");
+	if (ACPI_SUCCESS(status_tals))
+		acpi_execute_simple_method(handle_tals, NULL, 1);
+	if (ACPI_SUCCESS(status_alsc))
+		acpi_execute_simple_method(handle_alsc, NULL, 1);
+
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
 	indio_dev->dev.parent = &device->dev;
 	indio_dev->info = &acpi_als_info;
-- 
2.10.2

