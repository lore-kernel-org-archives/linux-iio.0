Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [RFC 6/7] iio: Refuse to register triggers with duplicate names
Date: Mon, 23 May 2016 21:40:01 +0300
Message-Id: <643ac0601a74fadc842ccb83c8f3741293ef7299.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
In-Reply-To: <cover.1464027859.git.leonard.crestez@intel.com>
References: <cover.1464027859.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The trigger name is documented as unique but drivers are currently
allowed to register triggers with duplicate names. This should be
considered a bug since it makes the 'current_trigger' interface
unusable.

Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
---
 drivers/iio/industrialio-trigger.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index e79c64c..e77503c 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -64,6 +64,8 @@ static struct attribute *iio_trig_dev_attrs[] = {
 };
 ATTRIBUTE_GROUPS(iio_trig_dev);
 
+static struct iio_trigger *__iio_trigger_find_by_name(const char *name);
+
 int iio_trigger_register(struct iio_trigger *trig_info)
 {
 	int ret;
@@ -82,11 +84,18 @@ int iio_trigger_register(struct iio_trigger *trig_info)
 
 	/* Add to list of available triggers held by the IIO core */
 	mutex_lock(&iio_trigger_list_lock);
+	if (__iio_trigger_find_by_name(trig_info->name)) {
+		pr_err("Duplicate trigger name '%s'\n", trig_info->name);
+		ret = -EEXIST;
+		goto error_device_del;
+	}
 	list_add_tail(&trig_info->list, &iio_trigger_list);
 	mutex_unlock(&iio_trigger_list_lock);
 
 	return 0;
 
+error_device_del:
+	device_del(&trig_info->dev);
 error_unregister_id:
 	ida_simple_remove(&iio_trigger_ida, trig_info->id);
 	return ret;
@@ -105,6 +114,18 @@ void iio_trigger_unregister(struct iio_trigger *trig_info)
 }
 EXPORT_SYMBOL(iio_trigger_unregister);
 
+/* Search for trigger by name, assuming iio_trigger_list_lock held */
+static struct iio_trigger *__iio_trigger_find_by_name(const char *name)
+{
+	struct iio_trigger *iter;
+
+	list_for_each_entry(iter, &iio_trigger_list, list)
+		if (!strcmp(iter->name, name))
+			return iter;
+
+	return NULL;
+}
+
 static struct iio_trigger *iio_trigger_find_by_name(const char *name,
 						    size_t len)
 {
-- 
2.5.5
