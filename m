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
Subject: [PATCH 4/9] i2c: acpi: Allow get info by index in i2c_acpi_get_info()
Date: Sun, 20 May 2018 15:28:52 +0200
Message-Id: <20180520132857.8103-5-hdegoede@redhat.com>
In-Reply-To: <20180520132857.8103-1-hdegoede@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For some devices we need to get info based on index. As a preparation of
support such, slightly modify i2c_acpi_get_info() helper.

While here, assume that interrupt resources are provided in the same amount
with 1:1 mapping to serial bus resources. This will not affect existing
behaviour because only first resource of each type is considered.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-acpi.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 7b1b0aeced36..75352b3744e5 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -129,17 +129,19 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 
 static int i2c_acpi_get_info(struct acpi_device *adev,
 			     struct i2c_board_info *info,
+			     int index,
 			     struct i2c_adapter *adapter,
 			     acpi_handle *adapter_handle)
 {
 	struct list_head resource_list;
 	struct resource_entry *entry;
 	struct i2c_acpi_lookup lookup;
+	unsigned int n;
 	int ret;
 
 	memset(&lookup, 0, sizeof(lookup));
 	lookup.info = info;
-	lookup.index = -1;
+	lookup.index = index;
 
 	ret = i2c_acpi_do_lookup(adev, &lookup);
 	if (ret)
@@ -170,10 +172,13 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 	if (ret < 0)
 		return -EINVAL;
 
+	n = 0;
 	resource_list_for_each_entry(entry, &resource_list) {
 		if (resource_type(entry->res) == IORESOURCE_IRQ) {
-			info->irq = entry->res->start;
-			break;
+			if (index == -1 || n++ == index) {
+				info->irq = entry->res->start;
+				break;
+			}
 		}
 	}
 
@@ -210,7 +215,7 @@ static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 	if (acpi_bus_get_device(handle, &adev))
 		return AE_OK;
 
-	if (i2c_acpi_get_info(adev, &info, adapter, NULL))
+	if (i2c_acpi_get_info(adev, &info, -1, adapter, NULL))
 		return AE_OK;
 
 	i2c_acpi_register_device(adapter, adev, &info);
@@ -356,7 +361,7 @@ static int i2c_acpi_notify(struct notifier_block *nb, unsigned long value,
 
 	switch (value) {
 	case ACPI_RECONFIG_DEVICE_ADD:
-		if (i2c_acpi_get_info(adev, &info, NULL, &adapter_handle))
+		if (i2c_acpi_get_info(adev, &info, -1, NULL, &adapter_handle))
 			break;
 
 		adapter = i2c_acpi_find_adapter_by_handle(adapter_handle);
-- 
2.17.0
