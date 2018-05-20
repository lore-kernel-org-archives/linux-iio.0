Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751372AbeETN3I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 May 2018 09:29:08 -0400
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Subject: [PATCH 3/9] i2c: acpi: Introduce i2c_acpi_get_i2c_resource() helper
Date: Sun, 20 May 2018 15:28:51 +0200
Message-Id: <20180520132857.8103-4-hdegoede@redhat.com>
In-Reply-To: <20180520132857.8103-1-hdegoede@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Besides current two users one more is coming. Definitely makes sense to
introduce a helper.

No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-acpi.c | 31 +++++++++++++++++++------------
 include/linux/acpi.h        | 11 +++++++++++
 2 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 7c3b4740b94b..7b1b0aeced36 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -45,6 +45,23 @@ struct i2c_acpi_lookup {
 	u32 min_speed;
 };
 
+bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
+			       struct acpi_resource_i2c_serialbus **i2c)
+{
+	struct acpi_resource_i2c_serialbus *sb;
+
+	if (ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
+		return false;
+
+	sb = &ares->data.i2c_serial_bus;
+	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
+		return false;
+
+	*i2c = sb;
+	return true;
+}
+EXPORT_SYMBOL_GPL(i2c_acpi_get_i2c_resource);
+
 static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 {
 	struct i2c_acpi_lookup *lookup = data;
@@ -52,11 +69,7 @@ static int i2c_acpi_fill_info(struct acpi_resource *ares, void *data)
 	struct acpi_resource_i2c_serialbus *sb;
 	acpi_status status;
 
-	if (info->addr || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS)
-		return 1;
-
-	sb = &ares->data.i2c_serial_bus;
-	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C)
+	if (info->addr || !i2c_acpi_get_i2c_resource(ares, &sb))
 		return 1;
 
 	if (lookup->index != -1 && lookup->n++ != lookup->index)
@@ -516,13 +529,7 @@ i2c_acpi_space_handler(u32 function, acpi_physical_address command,
 		goto err;
 	}
 
-	if (!value64 || ares->type != ACPI_RESOURCE_TYPE_SERIAL_BUS) {
-		ret = AE_BAD_PARAMETER;
-		goto err;
-	}
-
-	sb = &ares->data.i2c_serial_bus;
-	if (sb->type != ACPI_RESOURCE_SERIAL_TYPE_I2C) {
+	if (!value64 || !i2c_acpi_get_i2c_resource(ares, &sb)) {
 		ret = AE_BAD_PARAMETER;
 		goto err;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index cf97902792a5..f97c70f8ba4b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1062,6 +1062,17 @@ static inline int acpi_dev_gpio_irq_get(struct acpi_device *adev, int index)
 }
 #endif
 
+#if defined(CONFIG_ACPI) && IS_ENABLED(CONFIG_I2C)
+bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
+			       struct acpi_resource_i2c_serialbus **i2c);
+#else
+static inline bool i2c_acpi_get_i2c_resource(struct acpi_resource *ares,
+			       struct acpi_resource_i2c_serialbus **i2c)
+{
+	return false;
+}
+#endif
+
 /* Device properties */
 
 #define MAX_ACPI_REFERENCE_ARGS	8
-- 
2.17.0

