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
Subject: [PATCH 5/9] i2c: acpi: Enumerate several instances out of one device
Date: Sun, 20 May 2018 15:28:53 +0200
Message-Id: <20180520132857.8103-6-hdegoede@redhat.com>
In-Reply-To: <20180520132857.8103-1-hdegoede@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Some broken BIOSes provide one ACPI node for several same I2C devices.
Introduce a quirk to handle this case with a list of such devices.

[hdegoede@redhat.com: Add and use i2c_acpi_device_uevent() and
 i2c_acpi_device_modalias() helpers]
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/i2c/i2c-core-acpi.c | 101 ++++++++++++++++++++++++++++++++++--
 drivers/i2c/i2c-core-base.c |   6 +--
 drivers/i2c/i2c-core.h      |  13 +++++
 3 files changed, 112 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/i2c-core-acpi.c b/drivers/i2c/i2c-core-acpi.c
index 75352b3744e5..f2f9048caffd 100644
--- a/drivers/i2c/i2c-core-acpi.c
+++ b/drivers/i2c/i2c-core-acpi.c
@@ -105,8 +105,10 @@ static int i2c_acpi_do_lookup(struct acpi_device *adev,
 	struct list_head resource_list;
 	int ret;
 
-	if (acpi_bus_get_status(adev) || !adev->status.present ||
-	    acpi_device_enumerated(adev))
+	if (acpi_bus_get_status(adev) || !adev->status.present)
+		return -EINVAL;
+
+	if (lookup->index < 0 && acpi_device_enumerated(adev))
 		return -EINVAL;
 
 	if (acpi_match_device_ids(adev, i2c_acpi_ignored_device_ids) == 0)
@@ -187,6 +189,8 @@ static int i2c_acpi_get_info(struct acpi_device *adev,
 	acpi_set_modalias(adev, dev_name(&adev->dev), info->type,
 			  sizeof(info->type));
 
+	info->fwnode_irq_index = index == -1 ? 0 : index;
+
 	return 0;
 }
 
@@ -205,20 +209,73 @@ static void i2c_acpi_register_device(struct i2c_adapter *adapter,
 	}
 }
 
+static const struct acpi_device_id i2c_acpi_multiple_devices_ids[] = {
+	/*
+	 * Some devices are defined as a single ACPI entry while
+	 * providing more than one instance of the same IP. Try to
+	 * enumerate them all.
+	 */
+	{ "BOSC0200", 0 },
+	{ "INT3515", 0 },
+	{}
+};
+
+static int i2c_acpi_check_resource(struct acpi_resource *ares, void *data)
+{
+	struct acpi_resource_i2c_serialbus *sb;
+	int *count = data;
+
+	if (i2c_acpi_get_i2c_resource(ares, &sb))
+		*count = *count + 1;
+
+	return 1;
+}
+
+static int i2c_acpi_count_resource(struct acpi_device *adev)
+{
+	LIST_HEAD(r);
+	int count = 0;
+	int ret;
+
+	ret = acpi_dev_get_resources(adev, &r, i2c_acpi_check_resource, &count);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&r);
+	return count;
+}
+
 static acpi_status i2c_acpi_add_device(acpi_handle handle, u32 level,
 				       void *data, void **return_value)
 {
 	struct i2c_adapter *adapter = data;
 	struct acpi_device *adev;
 	struct i2c_board_info info;
+	int index, count;
+	char name[16];
 
 	if (acpi_bus_get_device(handle, &adev))
 		return AE_OK;
 
-	if (i2c_acpi_get_info(adev, &info, -1, adapter, NULL))
-		return AE_OK;
+	if (!acpi_match_device_ids(adev, i2c_acpi_multiple_devices_ids)) {
+		count = i2c_acpi_count_resource(adev);
+		if (count < 0)
+			return AE_OK;
+	} else {
+		count = 1;
+	}
+
+	for (index = 0; index < count; index++) {
+		if (i2c_acpi_get_info(adev, &info, index, adapter, NULL))
+			return AE_OK;
+
+		if (count > 1) {
+			sprintf(name, "%s.%d", acpi_dev_name(adev), index);
+			info.dev_name = name;
+		}
 
-	i2c_acpi_register_device(adapter, adev, &info);
+		i2c_acpi_register_device(adapter, adev, &info);
+	}
 
 	return AE_OK;
 }
@@ -252,12 +309,46 @@ const struct acpi_device_id *
 i2c_acpi_match_device(const struct acpi_device_id *matches,
 		      struct i2c_client *client)
 {
+	const struct acpi_device_id *id = NULL;
+	struct acpi_device *adev;
+
 	if (!(client && matches))
 		return NULL;
 
+	adev = ACPI_COMPANION(&client->dev);
+
+	/* Std acpi_match_device() only works for the first physical device */
+	if (!acpi_match_device_ids(adev, i2c_acpi_multiple_devices_ids)) {
+		__acpi_match_device(adev, matches, NULL, &id, NULL);
+		return id;
+	}
+
 	return acpi_match_device(matches, &client->dev);
 }
 
+int i2c_acpi_device_uevent(struct i2c_client *client,
+			   struct kobj_uevent_env *env)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+
+	/* Std ACPI function only works for the first physical device */
+	if (!acpi_match_device_ids(adev, i2c_acpi_multiple_devices_ids))
+		return __acpi_device_uevent_modalias(adev, env);
+
+	return acpi_device_uevent_modalias(&client->dev, env);
+}
+
+int i2c_acpi_device_modalias(struct i2c_client *client, char *buf, int size)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
+
+	/* Std ACPI function only works for the first physical device */
+	if (!acpi_match_device_ids(adev, i2c_acpi_multiple_devices_ids))
+		return __acpi_device_modalias(adev, buf, size);
+
+	return acpi_device_modalias(&client->dev, buf, size);
+}
+
 static acpi_status i2c_acpi_lookup_speed(acpi_handle handle, u32 level,
 					   void *data, void **return_value)
 {
diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index ae3fda2c96a4..7bf9d8d1f8e7 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -109,7 +109,7 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
 		return 1;
 
 	/* Then ACPI style match */
-	if (acpi_driver_match_device(dev, drv))
+	if (i2c_acpi_match_device(drv->acpi_match_table, client))
 		return 1;
 
 	driver = to_i2c_driver(drv);
@@ -130,7 +130,7 @@ static int i2c_device_uevent(struct device *dev, struct kobj_uevent_env *env)
 	if (rc != -ENODEV)
 		return rc;
 
-	rc = acpi_device_uevent_modalias(dev, env);
+	rc = i2c_acpi_device_uevent(client, env);
 	if (rc != -ENODEV)
 		return rc;
 
@@ -451,7 +451,7 @@ show_modalias(struct device *dev, struct device_attribute *attr, char *buf)
 	if (len != -ENODEV)
 		return len;
 
-	len = acpi_device_modalias(dev, buf, PAGE_SIZE -1);
+	len = i2c_acpi_device_modalias(client, buf, PAGE_SIZE - 1);
 	if (len != -ENODEV)
 		return len;
 
diff --git a/drivers/i2c/i2c-core.h b/drivers/i2c/i2c-core.h
index 37576f50fe20..887353e1d58d 100644
--- a/drivers/i2c/i2c-core.h
+++ b/drivers/i2c/i2c-core.h
@@ -33,6 +33,9 @@ int i2c_check_7bit_addr_validity_strict(unsigned short addr);
 const struct acpi_device_id *
 i2c_acpi_match_device(const struct acpi_device_id *matches,
 		      struct i2c_client *client);
+int i2c_acpi_device_uevent(struct i2c_client *client,
+			   struct kobj_uevent_env *env);
+int i2c_acpi_device_modalias(struct i2c_client *client, char *buf, int size);
 void i2c_acpi_register_devices(struct i2c_adapter *adap);
 #else /* CONFIG_ACPI */
 static inline void i2c_acpi_register_devices(struct i2c_adapter *adap) { }
@@ -42,6 +45,16 @@ i2c_acpi_match_device(const struct acpi_device_id *matches,
 {
 	return NULL;
 }
+static inline int i2c_acpi_device_uevent(struct i2c_client *client,
+					 struct kobj_uevent_env *env)
+{
+	return -ENODEV;
+}
+static inline int i2c_acpi_device_modalias(struct i2c_client *client,
+					   char *buf, int size)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_ACPI */
 extern struct notifier_block i2c_acpi_notifier;
 
-- 
2.17.0
