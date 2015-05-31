Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 21/32] tools:iio:iio_utils: add error handling
Date: Sun, 31 May 2015 14:40:14 +0200
Message-Id: <e655a43af0f41e20a66b798e1d1859afa89dc9ef.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
References: <6915cdc58104e623ad388787b9069337f1950614.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Add error handling to calls which can indicate a major problem by
returning an error code.
This also sets ret to -ENOENT in iioutils_get_type() and
iioutils_get_param_float() to indicate if no matching directory entry was
found.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/iio_utils.c | 265 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 223 insertions(+), 42 deletions(-)

diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index f0896f46..e1828d0 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -50,6 +50,10 @@ int iioutils_break_up_name(const char *full_name,
 		return -ENOMEM;
 
 	working = strtok(current, "_\0");
+	if (!working) {
+		free(current);
+		return -EINVAL;
+	}
 
 	w = working;
 	r = working;
@@ -117,6 +121,7 @@ int iioutils_get_type(unsigned *is_signed,
 		ret = -errno;
 		goto error_free_builtname_generic;
 	}
+	ret = -ENOENT;
 	while (ent = readdir(dp), ent != NULL)
 		/*
 		 * Do we allow devices to override a generic name with
@@ -162,7 +167,12 @@ int iioutils_get_type(unsigned *is_signed,
 				*is_signed = 1;
 			else
 				*is_signed = 0;
-			fclose(sysfsfp);
+			if (fclose(sysfsfp)) {
+				ret = -errno;
+				printf("Failed to close %s\n", filename);
+				goto error_free_filename;
+			}
+
 			free(filename);
 
 			filename = 0;
@@ -170,12 +180,16 @@ int iioutils_get_type(unsigned *is_signed,
 		}
 error_close_sysfsfp:
 	if (sysfsfp)
-		fclose(sysfsfp);
+		if (fclose(sysfsfp))
+			perror("iioutils_get_type(): Failed to close file");
+
 error_free_filename:
 	if (filename)
 		free(filename);
 error_closedir:
-	closedir(dp);
+	if (closedir(dp) == -1)
+		perror("iioutils_get_type(): Failed to close directory");
+
 error_free_builtname_generic:
 	free(builtname_generic);
 error_free_builtname:
@@ -215,6 +229,7 @@ int iioutils_get_param_float(float *output,
 		ret = -errno;
 		goto error_free_builtname_generic;
 	}
+	ret = -ENOENT;
 	while (ent = readdir(dp), ent != NULL)
 		if ((strcmp(builtname, ent->d_name) == 0) ||
 		    (strcmp(builtname_generic, ent->d_name) == 0)) {
@@ -229,14 +244,19 @@ int iioutils_get_param_float(float *output,
 				ret = -errno;
 				goto error_free_filename;
 			}
-			fscanf(sysfsfp, "%f", output);
+			errno = 0;
+			if (fscanf(sysfsfp, "%f", output) != 1)
+				ret = errno ? -errno : -ENODATA;
+
 			break;
 		}
 error_free_filename:
 	if (filename)
 		free(filename);
 error_closedir:
-	closedir(dp);
+	if (closedir(dp) == -1)
+		perror("iioutils_get_param_float(): Failed to close directory");
+
 error_free_builtname_generic:
 	free(builtname_generic);
 error_free_builtname:
@@ -310,10 +330,24 @@ int build_channel_array(const char *device_dir,
 				free(filename);
 				goto error_close_dir;
 			}
-			fscanf(sysfsfp, "%i", &ret);
+			errno = 0;
+			if (fscanf(sysfsfp, "%i", &ret) != 1) {
+				ret = errno ? -errno : -ENODATA;
+				if (fclose(sysfsfp))
+					perror("build_channel_array(): Failed to close file");
+
+				free(filename);
+				goto error_close_dir;
+			}
+
 			if (ret == 1)
 				(*counter)++;
-			fclose(sysfsfp);
+			if (fclose(sysfsfp)) {
+				ret = -errno;
+				free(filename);
+				goto error_close_dir;
+			}
+
 			free(filename);
 		}
 	*ci_array = malloc(sizeof(**ci_array) * (*counter));
@@ -344,8 +378,20 @@ int build_channel_array(const char *device_dir,
 				count--;
 				goto error_cleanup_array;
 			}
-			fscanf(sysfsfp, "%i", &current_enabled);
-			fclose(sysfsfp);
+			errno = 0;
+			if (fscanf(sysfsfp, "%i", &current_enabled) != 1) {
+				ret = errno ? -errno : -ENODATA;
+				free(filename);
+				count--;
+				goto error_cleanup_array;
+			}
+
+			if (fclose(sysfsfp)) {
+				ret = -errno;
+				free(filename);
+				count--;
+				goto error_cleanup_array;
+			}
 
 			if (!current_enabled) {
 				free(filename);
@@ -383,8 +429,29 @@ int build_channel_array(const char *device_dir,
 				goto error_cleanup_array;
 			}
 			sysfsfp = fopen(filename, "r");
-			fscanf(sysfsfp, "%u", &current->index);
-			fclose(sysfsfp);
+			if (sysfsfp == NULL) {
+				ret = -errno;
+				printf("failed to open %s\n", filename);
+				free(filename);
+				goto error_cleanup_array;
+			}
+
+			errno = 0;
+			if (fscanf(sysfsfp, "%u", &current->index) != 1) {
+				ret = errno ? -errno : -ENODATA;
+				if (fclose(sysfsfp))
+					perror("build_channel_array(): Failed to close file");
+
+				free(filename);
+				goto error_cleanup_array;
+			}
+
+			if (fclose(sysfsfp)) {
+				ret = -errno;
+				free(filename);
+				goto error_cleanup_array;
+			}
+
 			free(filename);
 			/* Find the scale */
 			ret = iioutils_get_param_float(&current->scale,
@@ -410,10 +477,16 @@ int build_channel_array(const char *device_dir,
 						device_dir,
 						current->name,
 						current->generic_name);
+			if (ret < 0)
+				goto error_cleanup_array;
 		}
 	}
 
-	closedir(dp);
+	if (closedir(dp) == -1) {
+		ret = -errno;
+		goto error_cleanup_array;
+	}
+
 	free(scan_el_dir);
 	/* reorder so that the array is in index order */
 	bsort_channel_array_by_index(ci_array, *counter);
@@ -427,7 +500,10 @@ error_cleanup_array:
 	}
 	free(*ci_array);
 error_close_dir:
-	closedir(dp);
+	if (dp)
+		if (closedir(dp) == -1)
+			perror("build_channel_array(): Failed to close dir");
+
 error_free_name:
 	free(scan_el_dir);
 error_ret:
@@ -496,29 +572,45 @@ int find_type_by_name(const char *name, const char *type)
 						+ numstrlen
 						+ 6);
 				if (filename == NULL) {
-					closedir(dp);
-					return -ENOMEM;
+					ret = -ENOMEM;
+					goto error_close_dir;
+				}
+
+				ret = sprintf(filename, "%s%s%d/name", iio_dir,
+					      type, number);
+				if (ret < 0) {
+					free(filename);
+					goto error_close_dir;
 				}
-				sprintf(filename, "%s%s%d/name",
-					iio_dir,
-					type,
-					number);
+
 				nameFile = fopen(filename, "r");
 				if (!nameFile) {
 					free(filename);
 					continue;
 				}
 				free(filename);
-				fscanf(nameFile, "%s", thisname);
-				fclose(nameFile);
+				errno = 0;
+				if (fscanf(nameFile, "%s", thisname) != 1) {
+					ret = errno ? -errno : -ENODATA;
+					goto error_close_dir;
+				}
+
+				if (fclose(nameFile)) {
+					ret = -errno;
+					goto error_close_dir;
+				}
+
 				if (strcmp(name, thisname) == 0) {
-					closedir(dp);
+					if (closedir(dp) == -1)
+						return -errno;
 					return number;
 				}
 			}
 		}
 	}
-	closedir(dp);
+	if (closedir(dp) == -1)
+		return -errno;
+
 	return -ENODEV;
 
 error_close_dir:
@@ -536,15 +628,29 @@ static int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
 
 	if (temp == NULL)
 		return -ENOMEM;
-	sprintf(temp, "%s/%s", basedir, filename);
+	ret = sprintf(temp, "%s/%s", basedir, filename);
+	if (ret < 0)
+		goto error_free;
+
 	sysfsfp = fopen(temp, "w");
 	if (sysfsfp == NULL) {
 		ret = -errno;
 		printf("failed to open %s\n", temp);
 		goto error_free;
 	}
-	fprintf(sysfsfp, "%d", val);
-	fclose(sysfsfp);
+	ret = fprintf(sysfsfp, "%d", val);
+	if (ret < 0) {
+		if (fclose(sysfsfp))
+			perror("_write_sysfs_int(): Failed to close dir");
+
+		goto error_free;
+	}
+
+	if (fclose(sysfsfp)) {
+		ret = -errno;
+		goto error_free;
+	}
+
 	if (verify) {
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
@@ -552,8 +658,19 @@ static int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
 			printf("failed to open %s\n", temp);
 			goto error_free;
 		}
-		fscanf(sysfsfp, "%d", &test);
-		fclose(sysfsfp);
+		if (fscanf(sysfsfp, "%d", &test) != 1) {
+			ret = errno ? -errno : -ENODATA;
+			if (fclose(sysfsfp))
+				perror("_write_sysfs_int(): Failed to close dir");
+
+			goto error_free;
+		}
+
+		if (fclose(sysfsfp)) {
+			ret = -errno;
+			goto error_free;
+		}
+
 		if (test != val) {
 			printf("Possible failure in int write %d to %s%s\n",
 				val,
@@ -588,15 +705,29 @@ static int _write_sysfs_string(char *filename, char *basedir, char *val,
 		printf("Memory allocation failed\n");
 		return -ENOMEM;
 	}
-	sprintf(temp, "%s/%s", basedir, filename);
+	ret = sprintf(temp, "%s/%s", basedir, filename);
+	if (ret < 0)
+		goto error_free;
+
 	sysfsfp = fopen(temp, "w");
 	if (sysfsfp == NULL) {
 		ret = -errno;
 		printf("Could not open %s\n", temp);
 		goto error_free;
 	}
-	fprintf(sysfsfp, "%s", val);
-	fclose(sysfsfp);
+	ret = fprintf(sysfsfp, "%s", val);
+	if (ret < 0) {
+		if (fclose(sysfsfp))
+			perror("_write_sysfs_string(): Failed to close dir");
+
+		goto error_free;
+	}
+
+	if (fclose(sysfsfp)) {
+		ret = -errno;
+		goto error_free;
+	}
+
 	if (verify) {
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
@@ -604,8 +735,19 @@ static int _write_sysfs_string(char *filename, char *basedir, char *val,
 			printf("could not open file to verify\n");
 			goto error_free;
 		}
-		fscanf(sysfsfp, "%s", temp);
-		fclose(sysfsfp);
+		if (fscanf(sysfsfp, "%s", temp) != 1) {
+			ret = errno ? -errno : -ENODATA;
+			if (fclose(sysfsfp))
+				perror("_write_sysfs_string(): Failed to close dir");
+
+			goto error_free;
+		}
+
+		if (fclose(sysfsfp)) {
+			ret = -errno;
+			goto error_free;
+		}
+
 		if (strcmp(temp, val) != 0) {
 			printf("Possible failure in string write of %s "
 				"Should be %s "
@@ -649,14 +791,27 @@ int read_sysfs_posint(char *filename, char *basedir)
 		printf("Memory allocation failed");
 		return -ENOMEM;
 	}
-	sprintf(temp, "%s/%s", basedir, filename);
+	ret = sprintf(temp, "%s/%s", basedir, filename);
+	if (ret < 0)
+		goto error_free;
+
 	sysfsfp = fopen(temp, "r");
 	if (sysfsfp == NULL) {
 		ret = -errno;
 		goto error_free;
 	}
-	fscanf(sysfsfp, "%d\n", &ret);
-	fclose(sysfsfp);
+	errno = 0;
+	if (fscanf(sysfsfp, "%d\n", &ret) != 1) {
+		ret = errno ? -errno : -ENODATA;
+		if (fclose(sysfsfp))
+			perror("read_sysfs_posint(): Failed to close dir");
+
+		goto error_free;
+	}
+
+	if (fclose(sysfsfp))
+		ret = -errno;
+
 error_free:
 	free(temp);
 	return ret;
@@ -672,14 +827,27 @@ int read_sysfs_float(char *filename, char *basedir, float *val)
 		printf("Memory allocation failed");
 		return -ENOMEM;
 	}
-	sprintf(temp, "%s/%s", basedir, filename);
+	ret = sprintf(temp, "%s/%s", basedir, filename);
+	if (ret < 0)
+		goto error_free;
+
 	sysfsfp = fopen(temp, "r");
 	if (sysfsfp == NULL) {
 		ret = -errno;
 		goto error_free;
 	}
-	fscanf(sysfsfp, "%f\n", val);
-	fclose(sysfsfp);
+	errno = 0;
+	if (fscanf(sysfsfp, "%f\n", val) != 1) {
+		ret = errno ? -errno : -ENODATA;
+		if (fclose(sysfsfp))
+			perror("read_sysfs_float(): Failed to close dir");
+
+		goto error_free;
+	}
+
+	if (fclose(sysfsfp))
+		ret = -errno;
+
 error_free:
 	free(temp);
 	return ret;
@@ -695,14 +863,27 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
 		printf("Memory allocation failed");
 		return -ENOMEM;
 	}
-	sprintf(temp, "%s/%s", basedir, filename);
+	ret = sprintf(temp, "%s/%s", basedir, filename);
+	if (ret < 0)
+		goto error_free;
+
 	sysfsfp = fopen(temp, "r");
 	if (sysfsfp == NULL) {
 		ret = -errno;
 		goto error_free;
 	}
-	fscanf(sysfsfp, "%s\n", str);
-	fclose(sysfsfp);
+	errno = 0;
+	if (fscanf(sysfsfp, "%s\n", str) != 1) {
+		ret = errno ? -errno : -ENODATA;
+		if (fclose(sysfsfp))
+			perror("read_sysfs_string(): Failed to close dir");
+
+		goto error_free;
+	}
+
+	if (fclose(sysfsfp))
+		ret = -errno;
+
 error_free:
 	free(temp);
 	return ret;
-- 
2.3.6
