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
Subject: [PATCH 1/9] ACPI: export __acpi_match_device and __acpi_device[_uevent]_modalias
Date: Sun, 20 May 2018 15:28:49 +0200
Message-Id: <20180520132857.8103-2-hdegoede@redhat.com>
In-Reply-To: <20180520132857.8103-1-hdegoede@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Normally __acpi_match_device and __acpi_device[_uevent]_modalias are only
called through functions calling acpi_companion_match() so that if their
are multiple devices sharing the ACPI firmware node only one matches /
gets the acpi:ACPIHID modalias.

Some DSDTs defines multiple i2c devices in a single apci_device and in
the i2c-core-acpi code we want to instantiate separate devices for these,
with all devices reporting / matching the acpi_devices's modalias.

This commit exports __acpi_match_device and __acpi_device[_uevent]_modalias
for use in the i2c-core-acpi code only, with a comment added that they
should not be used in normal code.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/acpi/bus.c          | 11 ++++++-----
 drivers/acpi/device_sysfs.c |  4 +++-
 include/linux/acpi.h        | 11 +++++++++++
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..29a0e8fa2a13 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -767,11 +767,11 @@ static bool __acpi_match_device_cls(const struct acpi_device_id *id,
 	return true;
 }
 
-static bool __acpi_match_device(struct acpi_device *device,
-				const struct acpi_device_id *acpi_ids,
-				const struct of_device_id *of_ids,
-				const struct acpi_device_id **acpi_id,
-				const struct of_device_id **of_id)
+bool __acpi_match_device(struct acpi_device *device,
+			 const struct acpi_device_id *acpi_ids,
+			 const struct of_device_id *of_ids,
+			 const struct acpi_device_id **acpi_id,
+			 const struct of_device_id **of_id)
 {
 	const struct acpi_device_id *id;
 	struct acpi_hardware_id *hwid;
@@ -808,6 +808,7 @@ static bool __acpi_match_device(struct acpi_device *device,
 		*acpi_id = id;
 	return true;
 }
+EXPORT_SYMBOL_GPL(__acpi_match_device);
 
 /**
  * acpi_match_device - Match a struct device against a given list of ACPI IDs
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 545e91420cde..e6d784ef00da 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -276,6 +276,7 @@ int __acpi_device_uevent_modalias(struct acpi_device *adev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__acpi_device_uevent_modalias);
 
 /**
  * acpi_device_uevent_modalias - uevent modalias for ACPI-enumerated devices.
@@ -291,7 +292,7 @@ int acpi_device_uevent_modalias(struct device *dev, struct kobj_uevent_env *env)
 }
 EXPORT_SYMBOL_GPL(acpi_device_uevent_modalias);
 
-static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
+int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
 {
 	int len, count;
 
@@ -321,6 +322,7 @@ static int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size)
 
 	return len;
 }
+EXPORT_SYMBOL_GPL(__acpi_device_modalias);
 
 /**
  * acpi_device_modalias - modalias sysfs attribute for ACPI-enumerated devices.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15bfb15c2fa5..cf97902792a5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -586,12 +586,23 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
 
 const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
 					       const struct device *dev);
+/* Skips the acpi_companion_match() check, normal code must not use this */
+bool __acpi_match_device(struct acpi_device *device,
+			 const struct acpi_device_id *acpi_ids,
+			 const struct of_device_id *of_ids,
+			 const struct acpi_device_id **acpi_id,
+			 const struct of_device_id **of_id);
 
 const void *acpi_device_get_match_data(const struct device *dev);
 extern bool acpi_driver_match_device(struct device *dev,
 				     const struct device_driver *drv);
 int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
+/* Skips the acpi_companion_match() check, normal code must not use this */
+int __acpi_device_uevent_modalias(struct acpi_device *adev,
+				  struct kobj_uevent_env *env);
 int acpi_device_modalias(struct device *, char *, int);
+/* Skips the acpi_companion_match() check, normal code must not use this */
+int __acpi_device_modalias(struct acpi_device *adev, char *buf, int size);
 void acpi_walk_dep_device_list(acpi_handle handle);
 
 struct platform_device *acpi_create_platform_device(struct acpi_device *,
-- 
2.17.0
