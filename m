Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 32/32] tools:iio: rename variables
Date: Sun, 31 May 2015 14:40:38 +0200
Message-Id: <1dba5c29995b2d2a4728d036de6e8f17a5f56b22.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <99c4e55ff043684b4a34888d4a982ac19cba891a.1433072539.git.knaack.h@gmx.de>
References: <99c4e55ff043684b4a34888d4a982ac19cba891a.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Use more appropriate/common variable names:
  * namepf instead of nameFile in iio_utils.c
  * ret instead of retval in lsiio.c

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 10 +++++-----
 tools/iio/lsiio.c     | 28 ++++++++++++++--------------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index 4eac11a..8fb3214 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -561,7 +561,7 @@ int find_type_by_name(const char *name, const char *type)
 	const struct dirent *ent;
 	int number, numstrlen, ret;
 
-	FILE *nameFile;
+	FILE *namefp;
 	DIR *dp;
 	char thisname[IIO_MAX_NAME_LENGTH];
 	char *filename;
@@ -607,20 +607,20 @@ int find_type_by_name(const char *name, const char *type)
 					goto error_close_dir;
 				}
 
-				nameFile = fopen(filename, "r");
-				if (!nameFile) {
+				namefp = fopen(filename, "r");
+				if (!namefp) {
 					free(filename);
 					continue;
 				}
 
 				free(filename);
 				errno = 0;
-				if (fscanf(nameFile, "%s", thisname) != 1) {
+				if (fscanf(namefp, "%s", thisname) != 1) {
 					ret = errno ? -errno : -ENODATA;
 					goto error_close_dir;
 				}
 
-				if (fclose(nameFile)) {
+				if (fclose(namefp)) {
 					ret = -errno;
 					goto error_close_dir;
 				}
diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index f5b3bd0..7f432a5 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -61,16 +61,16 @@ static int dump_one_device(const char *dev_dir_name)
 {
 	char name[IIO_MAX_NAME_LENGTH];
 	int dev_idx;
-	int retval;
+	int ret;
 
-	retval = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_device),
-			"%i", &dev_idx);
-	if (retval != 1)
+	ret = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_device), "%i",
+		     &dev_idx);
+	if (ret != 1)
 		return -EINVAL;
 
-	retval = read_sysfs_string("name", dev_dir_name, name);
-	if (retval)
-		return retval;
+	ret = read_sysfs_string("name", dev_dir_name, name);
+	if (ret)
+		return ret;
 
 	printf("Device %03d: %s\n", dev_idx, name);
 
@@ -84,16 +84,16 @@ static int dump_one_trigger(const char *dev_dir_name)
 {
 	char name[IIO_MAX_NAME_LENGTH];
 	int dev_idx;
-	int retval;
+	int ret;
 
-	retval = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_trigger),
-			"%i", &dev_idx);
-	if (retval != 1)
+	ret = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_trigger),
+		     "%i", &dev_idx);
+	if (ret != 1)
 		return -EINVAL;
 
-	retval = read_sysfs_string("name", dev_dir_name, name);
-	if (retval)
-		return retval;
+	ret = read_sysfs_string("name", dev_dir_name, name);
+	if (ret)
+		return ret;
 
 	printf("Trigger %03d: %s\n", dev_idx, name);
 
-- 
2.3.6
