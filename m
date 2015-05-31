Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 24/32] tools:iio: return values directly
Date: Sun, 31 May 2015 14:40:17 +0200
Message-Id: <82581f631ab07a233d24f07f7e706de34ed6ecbd.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Return directly, if no common cleanup is required.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c    |  5 ++---
 tools/iio/iio_event_monitor.c |  5 ++---
 tools/iio/iio_utils.c         | 27 ++++++++++++---------------
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index 2f48843..f17b168 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -238,8 +238,7 @@ int main(int argc, char **argv)
 	dev_num = find_type_by_name(device_name, "iio:device");
 	if (dev_num < 0) {
 		printf("Failed to find the %s\n", device_name);
-		ret = dev_num;
-		goto error_ret;
+		return dev_num;
 	}
 	printf("iio device number being used is %d\n", dev_num);
 
@@ -410,6 +409,6 @@ error_free_triggername:
 		free(trigger_name);
 error_free_dev_dir_name:
 	free(dev_dir_name);
-error_ret:
+
 	return ret;
 }
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index ecee8ac..17c27bf 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -258,8 +258,7 @@ int main(int argc, char **argv)
 			device_name, dev_num);
 		ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
 		if (ret < 0) {
-			ret = -ENOMEM;
-			goto error_ret;
+			return -ENOMEM;
 		}
 	} else {
 		/* If we can't find a IIO device by name assume device_name is a
@@ -317,6 +316,6 @@ int main(int argc, char **argv)
 
 error_free_chrdev_name:
 	free(chrdev_name);
-error_ret:
+
 	return ret;
 }
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 5d5831d..0524725 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -107,10 +107,9 @@ int iioutils_get_type(unsigned *is_signed,
 	const struct dirent *ent;
 
 	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (ret < 0)
+		return -ENOMEM;
+
 	ret = asprintf(&builtname, FORMAT_TYPE_FILE, name);
 	if (ret < 0) {
 		ret = -ENOMEM;
@@ -202,7 +201,7 @@ error_free_builtname:
 	free(builtname);
 error_free_scan_el_dir:
 	free(scan_el_dir);
-error_ret:
+
 	return ret;
 }
 
@@ -230,10 +229,9 @@ int iioutils_get_param_float(float *output,
 	const struct dirent *ent;
 
 	ret = asprintf(&builtname, "%s_%s", name, param_name);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (ret < 0)
+		return -ENOMEM;
+
 	ret = asprintf(&builtname_generic,
 		       "%s_%s", generic_name, param_name);
 	if (ret < 0) {
@@ -277,7 +275,7 @@ error_free_builtname_generic:
 	free(builtname_generic);
 error_free_builtname:
 	free(builtname);
-error_ret:
+
 	return ret;
 }
 
@@ -326,10 +324,9 @@ int build_channel_array(const char *device_dir,
 
 	*counter = 0;
 	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
+	if (ret < 0)
+		return -ENOMEM;
+
 	dp = opendir(scan_el_dir);
 	if (dp == NULL) {
 		ret = -errno;
@@ -526,7 +523,7 @@ error_close_dir:
 
 error_free_name:
 	free(scan_el_dir);
-error_ret:
+
 	return ret;
 }
 
-- 
2.3.6
