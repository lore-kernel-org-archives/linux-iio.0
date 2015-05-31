Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 30/32] tools:iio:iio_utils: pass strings as const
Date: Sun, 31 May 2015 14:40:36 +0200
Message-Id: <99c4e55ff043684b4a34888d4a982ac19cba891a.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Mark strings, which are not supposed to be changed (basedir, filename,
value), as const in function parameters.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 22 +++++++++++++---------
 tools/iio/iio_utils.h | 15 +++++++++------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index dfee1a3..ec9ab7f 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -634,7 +634,8 @@ error_close_dir:
 	return ret;
 }
 
-static int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
+static int _write_sysfs_int(const char *filename, const char *basedir, int val,
+			    int verify)
 {
 	int ret = 0;
 	FILE *sysfsfp;
@@ -707,7 +708,7 @@ error_free:
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int write_sysfs_int(char *filename, char *basedir, int val)
+int write_sysfs_int(const char *filename, const char *basedir, int val)
 {
 	return _write_sysfs_int(filename, basedir, val, 0);
 }
@@ -721,13 +722,14 @@ int write_sysfs_int(char *filename, char *basedir, int val)
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int write_sysfs_int_and_verify(char *filename, char *basedir, int val)
+int write_sysfs_int_and_verify(const char *filename, const char *basedir,
+			       int val)
 {
 	return _write_sysfs_int(filename, basedir, val, 1);
 }
 
-static int _write_sysfs_string(char *filename, char *basedir, char *val,
-			       int verify)
+static int _write_sysfs_string(const char *filename, const char *basedir,
+			       const char *val, int verify)
 {
 	int ret = 0;
 	FILE  *sysfsfp;
@@ -805,7 +807,8 @@ error_free:
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int write_sysfs_string_and_verify(char *filename, char *basedir, char *val)
+int write_sysfs_string_and_verify(const char *filename, const char *basedir,
+				  const char *val)
 {
 	return _write_sysfs_string(filename, basedir, val, 1);
 }
@@ -818,7 +821,8 @@ int write_sysfs_string_and_verify(char *filename, char *basedir, char *val)
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int write_sysfs_string(char *filename, char *basedir, char *val)
+int write_sysfs_string(const char *filename, const char *basedir,
+		       const char *val)
 {
 	return _write_sysfs_string(filename, basedir, val, 0);
 }
@@ -831,7 +835,7 @@ int write_sysfs_string(char *filename, char *basedir, char *val)
  * Returns the read integer value >= 0 on success, otherwise a negative error
  * code.
  **/
-int read_sysfs_posint(char *filename, char *basedir)
+int read_sysfs_posint(const char *filename, const char *basedir)
 {
 	int ret;
 	FILE  *sysfsfp;
@@ -875,7 +879,7 @@ error_free:
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int read_sysfs_float(char *filename, char *basedir, float *val)
+int read_sysfs_float(const char *filename, const char *basedir, float *val)
 {
 	int ret = 0;
 	FILE  *sysfsfp;
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index e5eb46a..379eed9 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -63,12 +63,15 @@ void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt);
 int build_channel_array(const char *device_dir,
 						struct iio_channel_info **ci_array, int *counter);
 int find_type_by_name(const char *name, const char *type);
-int write_sysfs_int(char *filename, char *basedir, int val);
-int write_sysfs_int_and_verify(char *filename, char *basedir, int val);
-int write_sysfs_string_and_verify(char *filename, char *basedir, char *val);
-int write_sysfs_string(char *filename, char *basedir, char *val);
-int read_sysfs_posint(char *filename, char *basedir);
-int read_sysfs_float(char *filename, char *basedir, float *val);
+int write_sysfs_int(const char *filename, const char *basedir, int val);
+int write_sysfs_int_and_verify(const char *filename, const char *basedir,
+			       int val);
+int write_sysfs_string_and_verify(const char *filename, const char *basedir,
+				  const char *val);
+int write_sysfs_string(const char *filename, const char *basedir,
+		       const char *val);
+int read_sysfs_posint(const char *filename, const char *basedir);
+int read_sysfs_float(const char *filename, const char *basedir, float *val);
 int read_sysfs_string(const char *filename, const char *basedir, char *str);
 
 #endif /* _IIO_UTILS_H_ */
-- 
2.3.6
