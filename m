Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 31/32] tools:iio: adjust coding style
Date: Sun, 31 May 2015 14:40:37 +0200
Message-Id: <49e12374b071615fd136af8993ca823c2d498cca.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <99c4e55ff043684b4a34888d4a982ac19cba891a.1433072539.git.knaack.h@gmx.de>
References: <99c4e55ff043684b4a34888d4a982ac19cba891a.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <cover.1433072539.git.knaack.h@gmx.de>
References: <cover.1433072539.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Fix various coding style issues, including:
  * have spaces around operators
  * indentation
  * consolidate parameters in same line
  * required braces
  * adjust/drop comments
  * multiline comment style
  * delete unnecessary empty lines
  * add empty lines to visualize logial code blocks
  * typos

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 tools/iio/generic_buffer.c    |  46 +++++++++--------
 tools/iio/iio_event_monitor.c |  13 +++--
 tools/iio/iio_utils.c         | 111 +++++++++++++++++++++++++-----------------
 tools/iio/iio_utils.h         |  15 +++---
 tools/iio/lsiio.c             |  15 +++---
 5 files changed, 118 insertions(+), 82 deletions(-)

diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
index c546852..a4c14d0 100644
--- a/tools/iio/generic_buffer.c
+++ b/tools/iio/generic_buffer.c
@@ -51,11 +51,13 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 		if (bytes % channels[i].bytes == 0)
 			channels[i].location = bytes;
 		else
-			channels[i].location = bytes - bytes%channels[i].bytes
-				+ channels[i].bytes;
+			channels[i].location = bytes - bytes % channels[i].bytes
+					       + channels[i].bytes;
+
 		bytes = channels[i].location + channels[i].bytes;
 		i++;
 	}
+
 	return bytes;
 }
 
@@ -136,9 +138,9 @@ void print8byte(uint64_t input, struct iio_channel_info *info)
 /**
  * process_scan() - print out the values in SI units
  * @data:		pointer to the start of the scan
- * @channels:		information about the channels. Note
- *  size_from_channelarray must have been called first to fill the
- *  location offsets.
+ * @channels:		information about the channels.
+ *			Note: size_from_channelarray must have been called first
+ *			      to fill the location offsets.
  * @num_channels:	number of channels
  **/
 void process_scan(char *data,
@@ -213,6 +215,7 @@ int main(int argc, char **argv)
 			num_loops = strtoul(optarg, &dummy, 10);
 			if (errno)
 				return -errno;
+
 			break;
 		case 'e':
 			noevents = 1;
@@ -225,6 +228,7 @@ int main(int argc, char **argv)
 			buf_len = strtoul(optarg, &dummy, 10);
 			if (errno)
 				return -errno;
+
 			break;
 		case 'n':
 			device_name = optarg;
@@ -257,6 +261,7 @@ int main(int argc, char **argv)
 		printf("Failed to find the %s\n", device_name);
 		return dev_num;
 	}
+
 	printf("iio device number being used is %d\n", dev_num);
 
 	ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
@@ -285,9 +290,11 @@ int main(int argc, char **argv)
 			ret = trig_num;
 			goto error_free_triggername;
 		}
+
 		printf("iio trigger number being used is %d\n", trig_num);
-	} else
+	} else {
 		printf("trigger-less mode selected\n");
+	}
 
 	/*
 	 * Parse the files in scan_elements to identify what channels are
@@ -314,8 +321,10 @@ int main(int argc, char **argv)
 
 	if (!notrigger) {
 		printf("%s %s\n", dev_dir_name, trigger_name);
-		/* Set the device trigger to be the data ready trigger found
-		 * above */
+		/*
+		 * Set the device trigger to be the data ready trigger found
+		 * above
+		 */
 		ret = write_sysfs_string_and_verify("trigger/current_trigger",
 						    dev_dir_name,
 						    trigger_name);
@@ -334,8 +343,9 @@ int main(int argc, char **argv)
 	ret = write_sysfs_int("enable", buf_dir_name, 1);
 	if (ret < 0)
 		goto error_free_buf_dir_name;
+
 	scan_size = size_from_channelarray(channels, num_channels);
-	data = malloc(scan_size*buf_len);
+	data = malloc(scan_size * buf_len);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error_free_buf_dir_name;
@@ -349,13 +359,12 @@ int main(int argc, char **argv)
 
 	/* Attempt to open non blocking the access dev */
 	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
-	if (fp == -1) { /* If it isn't there make the node */
+	if (fp == -1) { /* TODO: If it isn't there make the node */
 		ret = -errno;
 		printf("Failed to open %s\n", buffer_access);
 		goto error_free_buffer_access;
 	}
 
-	/* Wait for events 10 times */
 	for (j = 0; j < num_loops; j++) {
 		if (!noevents) {
 			struct pollfd pfd = {
@@ -372,25 +381,22 @@ int main(int argc, char **argv)
 			}
 
 			toread = buf_len;
-
 		} else {
 			usleep(timedelay);
 			toread = 64;
 		}
 
-		read_size = read(fp,
-				 data,
-				 toread*scan_size);
+		read_size = read(fp, data, toread * scan_size);
 		if (read_size < 0) {
 			if (errno == EAGAIN) {
 				printf("nothing available\n");
 				continue;
-			} else
+			} else {
 				break;
+			}
 		}
-		for (i = 0; i < read_size/scan_size; i++)
-			process_scan(data + scan_size*i,
-				     channels,
+		for (i = 0; i < read_size / scan_size; i++)
+			process_scan(data + scan_size * i, channels,
 				     num_channels);
 	}
 
@@ -409,6 +415,7 @@ int main(int argc, char **argv)
 error_close_buffer_access:
 	if (close(fp) == -1)
 		perror("Failed to close buffer");
+
 error_free_buffer_access:
 	free(buffer_access);
 error_free_data:
@@ -424,6 +431,7 @@ error_free_channels:
 error_free_triggername:
 	if (datardytrigger && !notrigger)
 		free(trigger_name);
+
 error_free_dev_dir_name:
 	free(dev_dir_name);
 
diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
index 8e682a7..c36f314 100644
--- a/tools/iio/iio_event_monitor.c
+++ b/tools/iio/iio_event_monitor.c
@@ -13,7 +13,6 @@
  *
  * Usage:
  *	iio_event_monitor <device_name>
- *
  */
 
 #include <unistd.h>
@@ -209,7 +208,8 @@ static void print_event(struct iio_event_data *event)
 
 	if (!event_is_known(event)) {
 		printf("Unknown event: time: %lld, id: %llx\n",
-				event->timestamp, event->id);
+		       event->timestamp, event->id);
+
 		return;
 	}
 
@@ -229,6 +229,7 @@ static void print_event(struct iio_event_data *event)
 
 	if (dir != IIO_EV_DIR_NONE)
 		printf(", direction: %s", iio_ev_dir_text[dir]);
+
 	printf("\n");
 }
 
@@ -251,14 +252,16 @@ int main(int argc, char **argv)
 	dev_num = find_type_by_name(device_name, "iio:device");
 	if (dev_num >= 0) {
 		printf("Found IIO device with name %s with device number %d\n",
-			device_name, dev_num);
+		       device_name, dev_num);
 		ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
 		if (ret < 0) {
 			return -ENOMEM;
 		}
 	} else {
-		/* If we can't find a IIO device by name assume device_name is a
-		   IIO chrdev */
+		/*
+		 * If we can't find an IIO device by name assume device_name is
+		 * an IIO chrdev
+		 */
 		chrdev_name = strdup(device_name);
 		if (!chrdev_name)
 			return -ENOMEM;
diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
index ec9ab7f..4eac11a 100644
--- a/tools/iio/iio_utils.c
+++ b/tools/iio/iio_utils.c
@@ -32,8 +32,7 @@ static char * const iio_direction[] = {
  *
  * Returns 0 on success, or a negative error code if string extraction failed.
  **/
-int iioutils_break_up_name(const char *full_name,
-				  char **generic_name)
+int iioutils_break_up_name(const char *full_name, char **generic_name)
 {
 	char *current;
 	char *w, *r;
@@ -65,6 +64,7 @@ int iioutils_break_up_name(const char *full_name,
 			*w = *r;
 			w++;
 		}
+
 		r++;
 	}
 	*w = '\0';
@@ -88,15 +88,10 @@ int iioutils_break_up_name(const char *full_name,
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int iioutils_get_type(unsigned *is_signed,
-			     unsigned *bytes,
-			     unsigned *bits_used,
-			     unsigned *shift,
-			     uint64_t *mask,
-			     unsigned *be,
-			     const char *device_dir,
-			     const char *name,
-			     const char *generic_name)
+int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
+		      unsigned *shift, uint64_t *mask, unsigned *be,
+		      const char *device_dir, const char *name,
+		      const char *generic_name)
 {
 	FILE *sysfsfp;
 	int ret;
@@ -126,6 +121,7 @@ int iioutils_get_type(unsigned *is_signed,
 		ret = -errno;
 		goto error_free_builtname_generic;
 	}
+
 	ret = -ENOENT;
 	while (ent = readdir(dp), ent != NULL)
 		/*
@@ -140,6 +136,7 @@ int iioutils_get_type(unsigned *is_signed,
 				ret = -ENOMEM;
 				goto error_closedir;
 			}
+
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
 				ret = -errno;
@@ -162,12 +159,14 @@ int iioutils_get_type(unsigned *is_signed,
 				printf("scan type description didn't match\n");
 				goto error_close_sysfsfp;
 			}
+
 			*be = (endianchar == 'b');
 			*bytes = padint / 8;
 			if (*bits_used == 64)
 				*mask = ~0;
 			else
 				*mask = (1 << *bits_used) - 1;
+
 			*is_signed = (signchar == 's');
 			if (fclose(sysfsfp)) {
 				ret = -errno;
@@ -177,9 +176,9 @@ int iioutils_get_type(unsigned *is_signed,
 
 			sysfsfp = 0;
 			free(filename);
-
 			filename = 0;
 		}
+
 error_close_sysfsfp:
 	if (sysfsfp)
 		if (fclose(sysfsfp))
@@ -188,6 +187,7 @@ error_close_sysfsfp:
 error_free_filename:
 	if (filename)
 		free(filename);
+
 error_closedir:
 	if (closedir(dp) == -1)
 		perror("iioutils_get_type(): Failed to close directory");
@@ -212,11 +212,9 @@ error_free_scan_el_dir:
  *
  * Returns a value >= 0 on success, otherwise a negative error code.
  **/
-int iioutils_get_param_float(float *output,
-				    const char *param_name,
-				    const char *device_dir,
-				    const char *name,
-				    const char *generic_name)
+int iioutils_get_param_float(float *output, const char *param_name,
+			     const char *device_dir, const char *name,
+			     const char *generic_name)
 {
 	FILE *sysfsfp;
 	int ret;
@@ -235,11 +233,13 @@ int iioutils_get_param_float(float *output,
 		ret = -ENOMEM;
 		goto error_free_builtname;
 	}
+
 	dp = opendir(device_dir);
 	if (dp == NULL) {
 		ret = -errno;
 		goto error_free_builtname_generic;
 	}
+
 	ret = -ENOENT;
 	while (ent = readdir(dp), ent != NULL)
 		if ((strcmp(builtname, ent->d_name) == 0) ||
@@ -250,11 +250,13 @@ int iioutils_get_param_float(float *output,
 				ret = -ENOMEM;
 				goto error_closedir;
 			}
+
 			sysfsfp = fopen(filename, "r");
 			if (!sysfsfp) {
 				ret = -errno;
 				goto error_free_filename;
 			}
+
 			errno = 0;
 			if (fscanf(sysfsfp, "%f", output) != 1)
 				ret = errno ? -errno : -ENODATA;
@@ -264,6 +266,7 @@ int iioutils_get_param_float(float *output,
 error_free_filename:
 	if (filename)
 		free(filename);
+
 error_closedir:
 	if (closedir(dp) == -1)
 		perror("iioutils_get_param_float(): Failed to close directory");
@@ -282,16 +285,14 @@ error_free_builtname:
  * @cnt: the amount of array elements
  **/
 
-void bsort_channel_array_by_index(struct iio_channel_info **ci_array,
-					 int cnt)
+void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt)
 {
-
 	struct iio_channel_info temp;
 	int x, y;
 
 	for (x = 0; x < cnt; x++)
 		for (y = 0; y < (cnt - 1); y++)
-			if ((*ci_array)[y].index > (*ci_array)[y+1].index) {
+			if ((*ci_array)[y].index > (*ci_array)[y + 1].index) {
 				temp = (*ci_array)[y + 1];
 				(*ci_array)[y + 1] = (*ci_array)[y];
 				(*ci_array)[y] = temp;
@@ -307,8 +308,7 @@ void bsort_channel_array_by_index(struct iio_channel_info **ci_array,
  * Returns 0 on success, otherwise a negative error code.
  **/
 int build_channel_array(const char *device_dir,
-			      struct iio_channel_info **ci_array,
-			      int *counter)
+			struct iio_channel_info **ci_array, int *counter)
 {
 	DIR *dp;
 	FILE *sysfsfp;
@@ -329,6 +329,7 @@ int build_channel_array(const char *device_dir,
 		ret = -errno;
 		goto error_free_name;
 	}
+
 	while (ent = readdir(dp), ent != NULL)
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
 			   "_en") == 0) {
@@ -338,12 +339,14 @@ int build_channel_array(const char *device_dir,
 				ret = -ENOMEM;
 				goto error_close_dir;
 			}
+
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
 				ret = -errno;
 				free(filename);
 				goto error_close_dir;
 			}
+
 			errno = 0;
 			if (fscanf(sysfsfp, "%i", &ret) != 1) {
 				ret = errno ? -errno : -ENODATA;
@@ -353,9 +356,9 @@ int build_channel_array(const char *device_dir,
 				free(filename);
 				goto error_close_dir;
 			}
-
 			if (ret == 1)
 				(*counter)++;
+
 			if (fclose(sysfsfp)) {
 				ret = -errno;
 				free(filename);
@@ -364,11 +367,13 @@ int build_channel_array(const char *device_dir,
 
 			free(filename);
 		}
+
 	*ci_array = malloc(sizeof(**ci_array) * (*counter));
 	if (*ci_array == NULL) {
 		ret = -ENOMEM;
 		goto error_close_dir;
 	}
+
 	seekdir(dp, 0);
 	while (ent = readdir(dp), ent != NULL) {
 		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
@@ -384,6 +389,7 @@ int build_channel_array(const char *device_dir,
 				count--;
 				goto error_cleanup_array;
 			}
+
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
 				ret = -errno;
@@ -391,6 +397,7 @@ int build_channel_array(const char *device_dir,
 				count--;
 				goto error_cleanup_array;
 			}
+
 			errno = 0;
 			if (fscanf(sysfsfp, "%i", &current_enabled) != 1) {
 				ret = errno ? -errno : -ENODATA;
@@ -423,6 +430,7 @@ int build_channel_array(const char *device_dir,
 				count--;
 				goto error_cleanup_array;
 			}
+
 			/* Get the generic and specific name elements */
 			ret = iioutils_break_up_name(current->name,
 						     &current->generic_name);
@@ -432,6 +440,7 @@ int build_channel_array(const char *device_dir,
 				count--;
 				goto error_cleanup_array;
 			}
+
 			ret = asprintf(&filename,
 				       "%s/%s_index",
 				       scan_el_dir,
@@ -441,6 +450,7 @@ int build_channel_array(const char *device_dir,
 				ret = -ENOMEM;
 				goto error_cleanup_array;
 			}
+
 			sysfsfp = fopen(filename, "r");
 			if (sysfsfp == NULL) {
 				ret = -errno;
@@ -474,6 +484,7 @@ int build_channel_array(const char *device_dir,
 						       current->generic_name);
 			if (ret < 0)
 				goto error_cleanup_array;
+
 			ret = iioutils_get_param_float(&current->offset,
 						       "offset",
 						       device_dir,
@@ -481,6 +492,7 @@ int build_channel_array(const char *device_dir,
 						       current->generic_name);
 			if (ret < 0)
 				goto error_cleanup_array;
+
 			ret = iioutils_get_type(&current->is_signed,
 						&current->bytes,
 						&current->bits_used,
@@ -562,9 +574,9 @@ int find_type_by_name(const char *name, const char *type)
 
 	while (ent = readdir(dp), ent != NULL) {
 		if (strcmp(ent->d_name, ".") != 0 &&
-			strcmp(ent->d_name, "..") != 0 &&
-			strlen(ent->d_name) > strlen(type) &&
-			strncmp(ent->d_name, type, strlen(type)) == 0) {
+		    strcmp(ent->d_name, "..") != 0 &&
+		    strlen(ent->d_name) > strlen(type) &&
+		    strncmp(ent->d_name, type, strlen(type)) == 0) {
 			errno = 0;
 			ret = sscanf(ent->d_name + strlen(type), "%d", &number);
 			if (ret < 0) {
@@ -580,12 +592,9 @@ int find_type_by_name(const char *name, const char *type)
 			numstrlen = calc_digits(number);
 			/* verify the next character is not a colon */
 			if (strncmp(ent->d_name + strlen(type) + numstrlen,
-					":",
-					1) != 0) {
-				filename = malloc(strlen(iio_dir)
-						+ strlen(type)
-						+ numstrlen
-						+ 6);
+			    ":", 1) != 0) {
+				filename = malloc(strlen(iio_dir) + strlen(type)
+						  + numstrlen + 6);
 				if (filename == NULL) {
 					ret = -ENOMEM;
 					goto error_close_dir;
@@ -603,6 +612,7 @@ int find_type_by_name(const char *name, const char *type)
 					free(filename);
 					continue;
 				}
+
 				free(filename);
 				errno = 0;
 				if (fscanf(nameFile, "%s", thisname) != 1) {
@@ -618,6 +628,7 @@ int find_type_by_name(const char *name, const char *type)
 				if (strcmp(name, thisname) == 0) {
 					if (closedir(dp) == -1)
 						return -errno;
+
 					return number;
 				}
 			}
@@ -631,6 +642,7 @@ int find_type_by_name(const char *name, const char *type)
 error_close_dir:
 	if (closedir(dp) == -1)
 		perror("find_type_by_name(): Failed to close directory");
+
 	return ret;
 }
 
@@ -644,6 +656,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 
 	if (temp == NULL)
 		return -ENOMEM;
+
 	ret = sprintf(temp, "%s/%s", basedir, filename);
 	if (ret < 0)
 		goto error_free;
@@ -654,6 +667,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 		printf("failed to open %s\n", temp);
 		goto error_free;
 	}
+
 	ret = fprintf(sysfsfp, "%d", val);
 	if (ret < 0) {
 		if (fclose(sysfsfp))
@@ -674,6 +688,7 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 			printf("failed to open %s\n", temp);
 			goto error_free;
 		}
+
 		if (fscanf(sysfsfp, "%d", &test) != 1) {
 			ret = errno ? -errno : -ENODATA;
 			if (fclose(sysfsfp))
@@ -688,13 +703,12 @@ static int _write_sysfs_int(const char *filename, const char *basedir, int val,
 		}
 
 		if (test != val) {
-			printf("Possible failure in int write %d to %s%s\n",
-				val,
-				basedir,
-				filename);
+			printf("Possible failure in int write %d to %s/%s\n",
+			       val, basedir, filename);
 			ret = -1;
 		}
 	}
+
 error_free:
 	free(temp);
 	return ret;
@@ -739,6 +753,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 		printf("Memory allocation failed\n");
 		return -ENOMEM;
 	}
+
 	ret = sprintf(temp, "%s/%s", basedir, filename);
 	if (ret < 0)
 		goto error_free;
@@ -749,6 +764,7 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 		printf("Could not open %s\n", temp);
 		goto error_free;
 	}
+
 	ret = fprintf(sysfsfp, "%s", val);
 	if (ret < 0) {
 		if (fclose(sysfsfp))
@@ -766,9 +782,10 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
 			ret = -errno;
-			printf("could not open file to verify\n");
+			printf("Could not open file to verify\n");
 			goto error_free;
 		}
+
 		if (fscanf(sysfsfp, "%s", temp) != 1) {
 			ret = errno ? -errno : -ENODATA;
 			if (fclose(sysfsfp))
@@ -784,15 +801,12 @@ static int _write_sysfs_string(const char *filename, const char *basedir,
 
 		if (strcmp(temp, val) != 0) {
 			printf("Possible failure in string write of %s "
-				"Should be %s "
-				"written to %s\%s\n",
-				temp,
-				val,
-				basedir,
-				filename);
+			       "Should be %s written to %s/%s\n", temp, val,
+			       basedir, filename);
 			ret = -1;
 		}
 	}
+
 error_free:
 	free(temp);
 
@@ -845,6 +859,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
 		printf("Memory allocation failed");
 		return -ENOMEM;
 	}
+
 	ret = sprintf(temp, "%s/%s", basedir, filename);
 	if (ret < 0)
 		goto error_free;
@@ -854,6 +869,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
 		ret = -errno;
 		goto error_free;
 	}
+
 	errno = 0;
 	if (fscanf(sysfsfp, "%d\n", &ret) != 1) {
 		ret = errno ? -errno : -ENODATA;
@@ -868,6 +884,7 @@ int read_sysfs_posint(const char *filename, const char *basedir)
 
 error_free:
 	free(temp);
+
 	return ret;
 }
 
@@ -889,6 +906,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
 		printf("Memory allocation failed");
 		return -ENOMEM;
 	}
+
 	ret = sprintf(temp, "%s/%s", basedir, filename);
 	if (ret < 0)
 		goto error_free;
@@ -898,6 +916,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
 		ret = -errno;
 		goto error_free;
 	}
+
 	errno = 0;
 	if (fscanf(sysfsfp, "%f\n", val) != 1) {
 		ret = errno ? -errno : -ENODATA;
@@ -912,6 +931,7 @@ int read_sysfs_float(const char *filename, const char *basedir, float *val)
 
 error_free:
 	free(temp);
+
 	return ret;
 }
 
@@ -933,6 +953,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
 		printf("Memory allocation failed");
 		return -ENOMEM;
 	}
+
 	ret = sprintf(temp, "%s/%s", basedir, filename);
 	if (ret < 0)
 		goto error_free;
@@ -942,6 +963,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
 		ret = -errno;
 		goto error_free;
 	}
+
 	errno = 0;
 	if (fscanf(sysfsfp, "%s\n", str) != 1) {
 		ret = errno ? -errno : -ENODATA;
@@ -956,6 +978,7 @@ int read_sysfs_string(const char *filename, const char *basedir, char *str)
 
 error_free:
 	free(temp);
+
 	return ret;
 }
 
diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
index 379eed9..0866101 100644
--- a/tools/iio/iio_utils.h
+++ b/tools/iio/iio_utils.h
@@ -51,17 +51,16 @@ struct iio_channel_info {
 };
 
 int iioutils_break_up_name(const char *full_name, char **generic_name);
-int iioutils_get_type(unsigned *is_signed, unsigned *bytes,
-					  unsigned *bits_used, unsigned *shift,
-					  uint64_t *mask, unsigned *be,
-					  const char *device_dir, const char *name,
-					  const char *generic_name);
+int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
+		      unsigned *shift, uint64_t *mask, unsigned *be,
+		      const char *device_dir, const char *name,
+		      const char *generic_name);
 int iioutils_get_param_float(float *output, const char *param_name,
-							 const char *device_dir, const char *name,
-							 const char *generic_name);
+			     const char *device_dir, const char *name,
+			     const char *generic_name);
 void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt);
 int build_channel_array(const char *device_dir,
-						struct iio_channel_info **ci_array, int *counter);
+			struct iio_channel_info **ci_array, int *counter);
 int find_type_by_name(const char *name, const char *type);
 int write_sysfs_int(const char *filename, const char *basedir, int val);
 int write_sysfs_int_and_verify(const char *filename, const char *basedir,
diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
index b59ee17..f5b3bd0 100644
--- a/tools/iio/lsiio.c
+++ b/tools/iio/lsiio.c
@@ -20,7 +20,6 @@
 #include <sys/dir.h>
 #include "iio_utils.h"
 
-
 static enum verbosity {
 	VERBLEVEL_DEFAULT,	/* 0 gives lspci behaviour */
 	VERBLEVEL_SENSORS,	/* 1 lists sensors */
@@ -29,17 +28,16 @@ static enum verbosity {
 const char *type_device = "iio:device";
 const char *type_trigger = "trigger";
 
-
 static inline int check_prefix(const char *str, const char *prefix)
 {
 	return strlen(str) > strlen(prefix) &&
-		strncmp(str, prefix, strlen(prefix)) == 0;
+	       strncmp(str, prefix, strlen(prefix)) == 0;
 }
 
 static inline int check_postfix(const char *str, const char *postfix)
 {
 	return strlen(str) > strlen(postfix) &&
-		strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
+	       strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
 }
 
 static int dump_channels(const char *dev_dir_name)
@@ -50,11 +48,11 @@ static int dump_channels(const char *dev_dir_name)
 	dp = opendir(dev_dir_name);
 	if (dp == NULL)
 		return -errno;
+
 	while (ent = readdir(dp), ent != NULL)
 		if (check_prefix(ent->d_name, "in_") &&
-		    check_postfix(ent->d_name, "_raw")) {
+		    check_postfix(ent->d_name, "_raw"))
 			printf("   %-10s\n", ent->d_name);
-		}
 
 	return (closedir(dp) == -1) ? -errno : 0;
 }
@@ -69,6 +67,7 @@ static int dump_one_device(const char *dev_dir_name)
 			"%i", &dev_idx);
 	if (retval != 1)
 		return -EINVAL;
+
 	retval = read_sysfs_string("name", dev_dir_name, name);
 	if (retval)
 		return retval;
@@ -77,6 +76,7 @@ static int dump_one_device(const char *dev_dir_name)
 
 	if (verblevel >= VERBLEVEL_SENSORS)
 		return dump_channels(dev_dir_name);
+
 	return 0;
 }
 
@@ -90,11 +90,13 @@ static int dump_one_trigger(const char *dev_dir_name)
 			"%i", &dev_idx);
 	if (retval != 1)
 		return -EINVAL;
+
 	retval = read_sysfs_string("name", dev_dir_name, name);
 	if (retval)
 		return retval;
 
 	printf("Trigger %03d: %s\n", dev_idx, name);
+
 	return 0;
 }
 
@@ -151,6 +153,7 @@ static int dump_devices(void)
 			free(dev_dir_name);
 		}
 	}
+
 	return (closedir(dp) == -1) ? -errno : 0;
 
 error_close_dir:
-- 
2.3.6
