Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mike.atx.name ([185.8.165.10]:36446 "EHLO mike.atx.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754212AbdASTQK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Jan 2017 14:16:10 -0500
Date: Thu, 19 Jan 2017 20:01:35 +0100
From: Josef Gajdusek <atx@atx.name>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maitysanchayan@gmail.com,
        gregor.boirie@parrot.com, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, marxin.liska@gmail.com, marex@denx.de,
        atx@atx.name
Subject: [PATCH v3] iio: light: acpi-als: Properly enable on ASUS Zenbooks
Message-ID: <20170119190134.GA14027@rick.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ASUS Zenbooks need several special ACPI calls to enable the ALS peripheral.
Otherwise, reads just return 0.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
 drivers/iio/light/acpi-als.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
index f0b47c5..43417c9 100644
--- a/drivers/iio/light/acpi-als.c
+++ b/drivers/iio/light/acpi-als.c
@@ -30,6 +30,7 @@
 #include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/dmi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
@@ -39,6 +40,9 @@
 #define ACPI_ALS_DEVICE_NAME		"acpi-als"
 #define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
 
+#define ACPI_ALS_ASUS_TALS		"\\_SB.PCI0.LPCB.EC0.TALS"
+#define ACPI_ALS_ASUS_ALSC		"\\_SB.ATKD.ALSC"
+
 ACPI_MODULE_NAME("acpi-als");
 
 /*
@@ -170,6 +174,46 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
+static int acpi_als_quirk_asus_zenbook_add(struct acpi_als *als)
+{
+	acpi_status status;
+
+	status = acpi_execute_simple_method(NULL, ACPI_ALS_ASUS_TALS, 1);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Error enabling ALS by %s",
+				ACPI_ALS_ASUS_TALS));
+		return -EIO;
+	}
+	status = acpi_execute_simple_method(NULL, ACPI_ALS_ASUS_ALSC, 1);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Error enabling ALS by %s",
+				ACPI_ALS_ASUS_ALSC));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+struct quirk_entry {
+	int (*add)(struct acpi_als *als);
+};
+
+static struct quirk_entry acpi_als_quirk_asus_zenbook = {
+	.add = acpi_als_quirk_asus_zenbook_add
+};
+
+static const struct dmi_system_id acpi_als_quirks[] = {
+	{
+		.ident = "ASUSTeK COMPUTER INC. UX",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "UX"),
+		},
+		.driver_data = &acpi_als_quirk_asus_zenbook,
+	},
+	{},
+};
+
 static const struct iio_info acpi_als_info = {
 	.driver_module		= THIS_MODULE,
 	.read_raw		= acpi_als_read_raw,
@@ -180,6 +224,9 @@ static int acpi_als_add(struct acpi_device *device)
 	struct acpi_als *als;
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
+	const struct dmi_system_id *dmiid;
+	struct quirk_entry *quirk;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
 	if (!indio_dev)
@@ -191,6 +238,19 @@ static int acpi_als_add(struct acpi_device *device)
 	als->device = device;
 	mutex_init(&als->lock);
 
+	dmiid = dmi_first_match(acpi_als_quirks);
+	if (dmiid) {
+		dev_dbg(&device->dev, "Detected quirk for %s\n", dmiid->ident);
+		quirk = dmiid->driver_data;
+		ret = quirk->add(als);
+		if (ret) {
+			dev_err(&device->dev,
+				"Executing quirk for %s failed - %d",
+				dmiid->ident, ret);
+			return ret;
+		}
+	}
+
 	indio_dev->name = ACPI_ALS_DEVICE_NAME;
 	indio_dev->dev.parent = &device->dev;
 	indio_dev->info = &acpi_als_info;
-- 
2.10.2

