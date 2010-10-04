Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: manuel.stahl@iis.fraunhofer.de,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 16/16] staging:iio: update example application.
Date: Mon,  4 Oct 2010 16:58:05 +0100
Message-Id: <1286207885-26689-17-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
References: <1286207885-26689-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

The application is now considerably more generic and should cope
with all devices in tree.  The process function will need to be
extended to handle other type values as needed.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/Documentation/generic_buffer.c |  318 ++++++++++++++++
 drivers/staging/iio/Documentation/iio_utils.h      |  396 +++++++++++++++++++-
 .../iio/Documentation/lis3l02dqbuffersimple.c      |  238 ------------
 3 files changed, 709 insertions(+), 243 deletions(-)

diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
new file mode 100644
index 0000000..df23aeb
--- /dev/null
+++ b/drivers/staging/iio/Documentation/generic_buffer.c
@@ -0,0 +1,318 @@
+/* Industrialio buffer test code.
+ *
+ * Copyright (c) 2008 Jonathan Cameron
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * This program is primarily intended as an example application.
+ * Reads the current buffer setup from sysfs and starts a short capture
+ * from the specified device, pretty printing the result after appropriate
+ * conversion.
+ *
+ * Command line parameters
+ * generic_buffer -n <device_name> -t <trigger_name>
+ * If trigger name is not specified the program assumes you want a dataready
+ * trigger associated with the device and goes looking for it.
+ *
+ */
+
+#include <unistd.h>
+#include <dirent.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sys/stat.h>
+#include <sys/dir.h>
+#include <linux/types.h>
+#include "iio_utils.h"
+
+const int buf_len = 128;
+const int num_loops = 2;
+
+/**
+ * size_from_channelarray() - calculate the storage size of a scan
+ * @channels: the channel info array
+ * @num_channels: size of the channel info array
+ *
+ * Has the side effect of filling the channels[i].location values used
+ * in processing the buffer output.
+ **/
+int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+{
+	int bytes = 0;
+	int i = 0;
+	while (i < num_channels) {
+		if (bytes % channels[i].bytes == 0)
+			channels[i].location = bytes;
+		else
+			channels[i].location = bytes - bytes%channels[i].bytes
+				+ channels[i].bytes;
+		bytes = channels[i].location + channels[i].bytes;
+		i++;
+	}
+	return bytes;
+}
+
+/**
+ * process_scan() - print out the values in SI units
+ * @data:		pointer to the start of the scan
+ * @infoarray:		information about the channels. Note
+ *  size_from_channelarray must have been called first to fill the
+ *  location offsets.
+ * @num_channels:	the number of active channels
+ **/
+void process_scan(char *data,
+		  struct iio_channel_info *infoarray,
+		  int num_channels)
+{
+	int k;
+	for (k = 0; k < num_channels; k++)
+		switch (infoarray[k].bytes) {
+			/* only a few cases implemented so far */
+		case 2:
+			if (infoarray[k].is_signed) {
+				int16_t val = *(int16_t *)
+					(data
+					 + infoarray[k].location);
+				if ((val >> infoarray[k].bits_used) & 1)
+					val = (val & infoarray[k].mask) |
+						~infoarray[k].mask;
+				printf("%05f ", ((float)val +
+						 infoarray[k].offset)*
+				       infoarray[k].scale);
+			} else {
+				uint16_t val = *(uint16_t *)
+					(data +
+					 infoarray[k].location);
+				val = (val & infoarray[k].mask);
+				printf("%05f ", ((float)val +
+						 infoarray[k].offset)*
+				       infoarray[k].scale);
+			}
+			break;
+		case 8:
+			if (infoarray[k].is_signed) {
+				int64_t val = *(int64_t *)
+					(data +
+					 infoarray[k].location);
+				if ((val >> infoarray[k].bits_used) & 1)
+					val = (val & infoarray[k].mask) |
+						~infoarray[k].mask;
+				/* special case for timestamp */
+				if (infoarray[k].scale == 1.0f &&
+				    infoarray[k].offset == 0.0f)
+					printf(" %lld", val);
+				else
+					printf("%05f ", ((float)val +
+							 infoarray[k].offset)*
+					       infoarray[k].scale);
+			}
+			break;
+		default:
+			break;
+		}
+	printf("\n");
+}
+
+int main(int argc, char **argv)
+{
+	int ret, c, i, j, toread;
+
+	FILE *fp_ev;
+	int fp;
+
+	int num_channels;
+	char *trigger_name = NULL, *device_name = NULL;
+	char *dev_dir_name, *buf_dir_name;
+
+	int datardytrigger = 1;
+	char *data;
+	size_t read_size;
+	struct iio_event_data dat;
+	int dev_num, trig_num;
+	char *buffer_access, *buffer_event;
+	int scan_size;
+
+	struct iio_channel_info *infoarray;
+
+	while ((c = getopt(argc, argv, "t:n:")) != -1) {
+		switch (c) {
+		case 'n':
+			device_name = optarg;
+			break;
+		case 't':
+			trigger_name = optarg;
+			datardytrigger = 0;
+			break;
+		case '?':
+			return -1;
+		}
+	}
+
+	/* Find the device requested */
+	dev_num = find_type_by_name(device_name, "device");
+	if (dev_num < 0) {
+		printf("Failed to find the %s\n", device_name);
+		ret = -ENODEV;
+		goto error_ret;
+	}
+	printf("iio device number being used is %d\n", dev_num);
+
+	asprintf(&dev_dir_name, "%sdevice%d", iio_dir, dev_num);
+	if (trigger_name == NULL) {
+		/*
+		 * Build the trigger name. If it is device associated it's
+		 * name is <device_name>_dev[n] where n matches the device
+		 * number found above
+		 */
+		ret = asprintf(&trigger_name,
+			       "%s-dev%d", device_name, dev_num);
+		if (ret < 0) {
+			ret = -ENOMEM;
+			goto error_ret;
+		}
+	}
+
+	/* Verify the trigger exists */
+	trig_num = find_type_by_name(trigger_name, "trigger");
+	if (trig_num < 0) {
+		printf("Failed to find the trigger %s\n", trigger_name);
+		ret = -ENODEV;
+		goto error_free_triggername;
+	}
+	printf("iio trigger number being used is %d\n", trig_num);
+
+	/*
+	 * Parse the files in scan_elements to identify what channels are
+	 * present
+	 */
+	ret = build_channel_array(dev_dir_name, &infoarray, &num_channels);
+	if (ret) {
+		printf("Problem reading scan element information \n");
+		goto error_free_triggername;
+	}
+
+	/*
+	 * Construct the directory name for the associated buffer.
+	 * As we know that the lis3l02dq has only one buffer this may
+	 * be built rather than found.
+	 */
+	ret = asprintf(&buf_dir_name, "%sdevice%d:buffer0", iio_dir, dev_num);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_free_triggername;
+	}
+	printf("%s %s\n", dev_dir_name, trigger_name);
+	/* Set the device trigger to be the data rdy trigger found above */
+	ret = write_sysfs_string_and_verify("trigger/current_trigger",
+					dev_dir_name,
+					trigger_name);
+	if (ret < 0) {
+		printf("Failed to write current_trigger file\n");
+		goto error_free_buf_dir_name;
+	}
+
+	/* Setup ring buffer parameters */
+	ret = write_sysfs_int("length", buf_dir_name, buf_len);
+	if (ret < 0)
+		goto error_free_buf_dir_name;
+
+	/* Enable the buffer */
+	ret = write_sysfs_int("enable", buf_dir_name, 1);
+	if (ret < 0)
+		goto error_free_buf_dir_name;
+	scan_size = size_from_channelarray(infoarray, num_channels);
+	data = malloc(scan_size*buf_len);
+	if (!data) {
+		ret = -ENOMEM;
+		goto error_free_buf_dir_name;
+	}
+
+	ret = asprintf(&buffer_access,
+		       "/dev/device%d:buffer0:access0",
+		       dev_num);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_free_data;
+	}
+
+	ret = asprintf(&buffer_event, "/dev/device%d:buffer0:event0", dev_num);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_free_buffer_access;
+	}
+	/* Attempt to open non blocking the access dev */
+	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
+	if (fp == -1) { /*If it isn't there make the node */
+		printf("Failed to open %s\n", buffer_access);
+		ret = -errno;
+		goto error_free_buffer_event;
+	}
+	/* Attempt to open the event access dev (blocking this time) */
+	fp_ev = fopen(buffer_event, "rb");
+	if (fp_ev == NULL) {
+		printf("Failed to open %s\n", buffer_event);
+		ret = -errno;
+		goto error_close_buffer_access;
+	}
+
+	/* Wait for events 10 times */
+	for (j = 0; j < num_loops; j++) {
+		read_size = fread(&dat, 1, sizeof(struct iio_event_data),
+				  fp_ev);
+		switch (dat.id) {
+		case IIO_EVENT_CODE_RING_100_FULL:
+			toread = buf_len;
+			break;
+		case IIO_EVENT_CODE_RING_75_FULL:
+			toread = buf_len*3/4;
+			break;
+		case IIO_EVENT_CODE_RING_50_FULL:
+			toread = buf_len/2;
+			break;
+		default:
+			printf("Unexpecteded event code\n");
+			continue;
+		}
+		read_size = read(fp,
+				 data,
+				 toread*scan_size);
+		if (read_size == -EAGAIN) {
+			printf("nothing available\n");
+			continue;
+		}
+		for (i = 0; i < read_size/scan_size; i++)
+			process_scan(data + scan_size*i,
+				     infoarray,
+				     num_channels);
+	}
+
+	/* Stop the ring buffer */
+	ret = write_sysfs_int("enable", buf_dir_name, 0);
+	if (ret < 0)
+		goto error_close_buffer_event;
+
+	/* Disconnect from the trigger - just write a dummy name.*/
+	write_sysfs_string("trigger/current_trigger",
+			dev_dir_name, "NULL");
+
+error_close_buffer_event:
+	fclose(fp_ev);
+error_close_buffer_access:
+	close(fp);
+error_free_data:
+	free(data);
+error_free_buffer_access:
+	free(buffer_access);
+error_free_buffer_event:
+	free(buffer_event);
+error_free_buf_dir_name:
+	free(buf_dir_name);
+error_free_triggername:
+	if (datardytrigger)
+		free(trigger_name);
+error_ret:
+	return ret;
+}
diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
index 014f668..0372424 100644
--- a/drivers/staging/iio/Documentation/iio_utils.h
+++ b/drivers/staging/iio/Documentation/iio_utils.h
@@ -10,12 +10,23 @@
 /* Made up value to limit allocation sizes */
 #include <string.h>
 #include <stdlib.h>
+#include <ctype.h>
+#include <stdio.h>
+#include <stdint.h>
 
 #define IIO_MAX_NAME_LENGTH 30
 
-#define IIO_EVENT_CODE_RING_50_FULL 200
-#define IIO_EVENT_CODE_RING_75_FULL 201
-#define IIO_EVENT_CODE_RING_100_FULL 202
+#define IIO_EV_CLASS_BUFFER		0
+#define IIO_BUFFER_EVENT_CODE(code)		\
+	(IIO_EV_CLASS_BUFFER | (code << 8))
+
+#define IIO_EVENT_CODE_RING_50_FULL	IIO_BUFFER_EVENT_CODE(0)
+#define IIO_EVENT_CODE_RING_75_FULL	IIO_BUFFER_EVENT_CODE(1)
+#define IIO_EVENT_CODE_RING_100_FULL	IIO_BUFFER_EVENT_CODE(2)
+
+
+#define FORMAT_SCAN_ELEMENTS_DIR "%s:buffer0/scan_elements"
+#define FORMAT_TYPE_FILE "%s_type"
 
 const char *iio_dir = "/sys/bus/iio/devices/";
 
@@ -25,6 +36,380 @@ struct iio_event_data {
 };
 
 /**
+ * iioutils_break_up_name() - extract generic name from full channel name
+ * @full_name: the full channel name
+ * @generic_name: the output generic channel name
+ **/
+static int iioutils_break_up_name(const char *full_name,
+				  char **generic_name)
+{
+	char *current;
+	char *w, *r;
+	char *working;
+	current = strdup(full_name);
+	working = strtok(current, "_\0");
+	w = working;
+	r = working;
+
+	while(*r != '\0') {
+		if (!isdigit(*r)) {
+			*w = *r;
+			w++;
+		}
+		r++;
+	}
+	*w = '\0';
+	*generic_name = strdup(working);
+	free(current);
+
+	return 0;
+}
+
+/**
+ * struct iio_channel_info - information about a given channel
+ * @name: channel name
+ * @generic_name: general name for channel type
+ * @scale: scale factor to be applied for conversion to si units
+ * @offset: offset to be applied for conversion to si units
+ * @index: the channel index in the buffer output
+ * @bytes: number of bytes occupied in buffer output
+ * @mask: a bit mask for the raw output
+ * @is_signed: is the raw value stored signed
+ * @enabled: is this channel enabled
+ **/
+struct iio_channel_info {
+	char *name;
+	char *generic_name;
+	float scale;
+	float offset;
+	unsigned index;
+	unsigned bytes;
+	unsigned bits_used;
+	uint64_t mask;
+	unsigned is_signed;
+	unsigned enabled;
+	unsigned location;
+};
+
+/**
+ * iioutils_get_type() - find and process _type attribute data
+ * @is_signed: output whether channel is signed
+ * @bytes: output how many bytes the channel storage occupies
+ * @mask: output a bit mask for the raw data
+ * @device_dir: the iio device directory
+ * @name: the channel name
+ * @generic_name: the channel type name
+ **/
+inline int iioutils_get_type(unsigned *is_signed,
+			     unsigned *bytes,
+			     unsigned *bits_used,
+			     uint64_t *mask,
+			     const char *device_dir,
+			     const char *name,
+			     const char *generic_name)
+{
+	FILE *sysfsfp;
+	int ret;
+	DIR *dp;
+	char *scan_el_dir, *builtname, *builtname_generic, *filename = 0;
+	char signchar;
+	unsigned sizeint, padint;
+	const struct dirent *ent;
+
+	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	ret = asprintf(&builtname, FORMAT_TYPE_FILE, name);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_free_scan_el_dir;
+	}
+	ret = asprintf(&builtname_generic, FORMAT_TYPE_FILE, generic_name);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_free_builtname;
+	}
+
+	dp = opendir(scan_el_dir);
+	if (dp == NULL) {
+		ret = -errno;
+		goto error_free_builtname_generic;
+	}
+	while (ent = readdir(dp), ent != NULL)
+		/*
+		 * Do we allow devices to override a generic name with
+		 * a specific one?
+		 */
+		if ((strcmp(builtname, ent->d_name) == 0) ||
+		    (strcmp(builtname_generic, ent->d_name) == 0)) {
+			ret = asprintf(&filename,
+				       "%s/%s", scan_el_dir, ent->d_name);
+			if (ret < 0) {
+				ret = -ENOMEM;
+				goto error_closedir;
+			}
+			sysfsfp = fopen(filename, "r");
+			if (sysfsfp == NULL) {
+				printf("failed to open %s\n", filename);
+				ret = -errno;
+				goto error_free_filename;
+			}
+			fscanf(sysfsfp,
+			       "%c%u/%u", &signchar, bits_used, &padint);
+			*bytes = padint / 8;
+			if (sizeint == 64)
+				*mask = ~0;
+			else
+				*mask = (1 << *bits_used) - 1;
+			if (signchar == 's')
+				*is_signed = 1;
+			else
+				*is_signed = 0;
+		}
+error_free_filename:
+	if (filename)
+		free(filename);
+error_closedir:
+	closedir(dp);
+error_free_builtname_generic:
+	free(builtname_generic);
+error_free_builtname:
+	free(builtname);
+error_free_scan_el_dir:
+	free(scan_el_dir);
+error_ret:
+	return ret;
+}
+
+inline int iioutils_get_param_float(float *output,
+				    const char *param_name,
+				    const char *device_dir,
+				    const char *name,
+				    const char *generic_name)
+{
+	FILE *sysfsfp;
+	int ret;
+	DIR *dp;
+	char *builtname, *builtname_generic;
+	char *filename = NULL;
+	const struct dirent *ent;
+
+	ret = asprintf(&builtname, "%s_%s", name, param_name);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	ret = asprintf(&builtname_generic,
+		       "%s_%s", generic_name, param_name);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_free_builtname;
+	}
+	dp = opendir(device_dir);
+	if (dp == NULL) {
+		ret = -errno;
+		goto error_free_builtname_generic;
+	}
+	while (ent = readdir(dp), ent != NULL)
+		if ((strcmp(builtname, ent->d_name) == 0) ||
+		    (strcmp(builtname_generic, ent->d_name) == 0)) {
+			ret = asprintf(&filename,
+				       "%s/%s", device_dir, ent->d_name);
+			if (ret < 0) {
+				ret = -ENOMEM;
+				goto error_closedir;
+			}
+			sysfsfp = fopen(filename, "r");
+			if (!sysfsfp) {
+				ret = -errno;
+				goto error_free_filename;
+			}
+			fscanf(sysfsfp, "%f", output);
+			break;
+		}
+error_free_filename:
+	if (filename)
+		free(filename);
+error_closedir:
+	closedir(dp);
+error_free_builtname_generic:
+	free(builtname_generic);
+error_free_builtname:
+	free(builtname);
+error_ret:
+	return ret;
+}
+
+
+/**
+ * build_channel_array() - function to figure out what channels are present
+ * @device_dir: the IIO device directory in sysfs
+ * @
+ **/
+inline int build_channel_array(const char *device_dir,
+			      struct iio_channel_info **ci_array,
+			      int *counter)
+{
+	DIR *dp;
+	FILE *sysfsfp;
+	int count = 0, temp, i;
+	struct iio_channel_info *current;
+	int ret;
+	const struct dirent *ent;
+	char *scan_el_dir;
+	char *filename;
+
+	*counter = 0;
+	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
+	if (ret < 0) {
+		ret = -ENOMEM;
+		goto error_ret;
+	}
+	dp = opendir(scan_el_dir);
+	if (dp == NULL) {
+		ret = -errno;
+		goto error_free_name;
+	}
+	while (ent = readdir(dp), ent != NULL)
+		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
+			   "_en") == 0) {
+			ret = asprintf(&filename,
+				       "%s/%s", scan_el_dir, ent->d_name);
+			if (ret < 0) {
+				ret = -ENOMEM;
+				goto error_close_dir;
+			}
+			sysfsfp = fopen(filename, "r");
+			if (sysfsfp == NULL) {
+				ret = -errno;
+				free(filename);
+				goto error_close_dir;
+			}
+			fscanf(sysfsfp, "%u", &ret);
+			if (ret == 1)
+				(*counter)++;
+			fclose(sysfsfp);
+			free(filename);
+		}
+	*ci_array = malloc(sizeof(**ci_array)*(*counter));
+	if (*ci_array == NULL) {
+		ret = -ENOMEM;
+		goto error_close_dir;
+	}
+	seekdir(dp, 0);
+	while (ent = readdir(dp), ent != NULL) {
+		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
+			   "_en") == 0) {
+			current = &(*ci_array)[count++];
+			ret = asprintf(&filename,
+				       "%s/%s", scan_el_dir, ent->d_name);
+			if (ret < 0) {
+				ret = -ENOMEM;
+				/* decrement count to avoid freeing name */
+				count--;
+				goto error_cleanup_array;
+			}
+			sysfsfp = fopen(filename, "r");
+			if (sysfsfp == NULL) {
+				free(filename);
+				ret = -errno;
+				goto error_cleanup_array;
+			}
+			fscanf(sysfsfp, "%u", &current->enabled);
+			fclose(sysfsfp);
+			free(filename);
+			current->scale = 1.0;
+			current->offset = 0;
+			current->name = strndup(ent->d_name,
+						strlen(ent->d_name) -
+						strlen("_en"));
+			if (current->name == NULL) {
+				free(filename);
+				ret = -ENOMEM;
+				goto error_cleanup_array;
+			}
+			/* Get the generic and specific name elements */
+			ret = iioutils_break_up_name(current->name,
+						     &current->generic_name);
+			if (ret) {
+				free(filename);
+				goto error_cleanup_array;
+			}
+			ret = asprintf(&filename,
+				       "%s/%s_index",
+				       scan_el_dir,
+				       current->name);
+			if (ret < 0) {
+				free(filename);
+				ret = -ENOMEM;
+				goto error_cleanup_array;
+			}
+			sysfsfp = fopen(filename, "r");
+			fscanf(sysfsfp, "%u", &current->index);
+			fclose(sysfsfp);
+			free(filename);
+			/* Find the scale */
+			ret = iioutils_get_param_float(&current->scale,
+						       "scale",
+						       device_dir,
+						       current->name,
+						       current->generic_name);
+			if (ret < 0)
+				goto error_cleanup_array;
+			ret = iioutils_get_param_float(&current->offset,
+						       "offset",
+						       device_dir,
+						       current->name,
+						       current->generic_name);
+			if (ret < 0)
+				goto error_cleanup_array;
+			ret = iioutils_get_type(&current->is_signed,
+						&current->bytes,
+						&current->bits_used,
+						&current->mask,
+						device_dir,
+						current->name,
+						current->generic_name);
+		}
+	}
+	/* reorder so that the array is in index order*/
+	current = malloc(sizeof(**ci_array)**counter);
+	if (current == NULL) {
+		ret = -ENOMEM;
+		goto error_cleanup_array;
+	}
+	closedir(dp);
+	count = 0;
+	temp = 0;
+	while (count < *counter)
+		for (i = 0; i < *counter; i++)
+			if ((*ci_array)[i].index == temp) {
+				memcpy(&current[count++],
+				       &(*ci_array)[i],
+				       sizeof(*current));
+				temp++;
+				break;
+			}
+	free(*ci_array);
+	*ci_array = current;
+
+	return 0;
+
+error_cleanup_array:
+	for (i = count - 1;  i >= 0; i++)
+		free((*ci_array)[i].name);
+	free(*ci_array);
+error_close_dir:
+	closedir(dp);
+error_free_name:
+	free(scan_el_dir);
+error_ret:
+	return ret;
+}
+
+/**
  * find_type_by_name() - function to match top level types by name
  * @name: top level type instance name
  * @type: the type of top level instance being sort
@@ -40,7 +425,6 @@ inline int find_type_by_name(const char *name, const char *type)
 	DIR *dp;
 	char thisname[IIO_MAX_NAME_LENGTH];
 	char *filename;
-	struct stat Stat;
 
 	dp = opendir(iio_dir);
 	if (dp == NULL) {
@@ -134,7 +518,7 @@ int write_sysfs_int_and_verify(char *filename, char *basedir, int val)
 
 int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
 {
-	int ret;
+	int ret = 0;
 	FILE  *sysfsfp;
 	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
 	if (temp == NULL) {
@@ -153,6 +537,7 @@ int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
 	if (verify) {
 		sysfsfp = fopen(temp, "r");
 		if (sysfsfp == NULL) {
+			printf("could not open file to verify\n");
 			ret = -errno;
 			goto error_free;
 		}
@@ -173,6 +558,7 @@ error_free:
 
 	return ret;
 }
+
 /**
  * write_sysfs_string_and_verify() - string write, readback and verify
  * @filename: name of file to write to
diff --git a/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c b/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
deleted file mode 100644
index 2fc3fd8..0000000
--- a/drivers/staging/iio/Documentation/lis3l02dqbuffersimple.c
+++ /dev/null
@@ -1,238 +0,0 @@
-/* Industrialio ring buffer with a lis3l02dq accelerometer
- *
- * Copyright (c) 2008 Jonathan Cameron
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License version 2 as published by
- * the Free Software Foundation.
- *
- * This program is primarily intended as an example application.
- */
-
-#include <dirent.h>
-#include <fcntl.h>
-#include <stdio.h>
-#include <errno.h>
-#include <sys/stat.h>
-#include <sys/dir.h>
-#include <linux/types.h>
-#include "iio_utils.h"
-
-const char *device_name = "lis3l02dq";
-const char *trigger_name_base = "lis3l02dq-dev";
-const int num_vals = 3;
-const int scan_ts = 1;
-const int buf_len = 128;
-const int num_loops = 10;
-
-/*
- * Could get this from ring bps, but only after starting the ring
- * which is a bit late for it to be useful.
- *
- * Todo: replace with much more generic version based on scan_elements
- * directory.
- */
-int size_from_scanmode(int num_vals, int timestamp)
-{
-	if (num_vals && timestamp)
-		return 16;
-	else if (timestamp)
-		return 8;
-	else
-		return num_vals*2;
-}
-
-int main(int argc, char **argv)
-{
-	int ret;
-	int i, j, k, toread;
-	FILE *fp_ev;
-	int fp;
-
-	char *trigger_name, *dev_dir_name, *buf_dir_name;
-	char *data;
-	size_t read_size;
-	struct iio_event_data dat;
-	int dev_num, trig_num;
-
-	char *buffer_access, *buffer_event;
-	const char *iio_dir = "/sys/bus/iio/devices/";
-	int scan_size;
-	float gain = 1;
-
-
-	/* Find out which iio device is the accelerometer. */
-	dev_num = find_type_by_name(device_name, "device");
-	if (dev_num < 0) {
-		printf("Failed to find the %s\n", device_name);
-		ret = -ENODEV;
-		goto error_ret;
-	}
-	printf("iio device number being used is %d\n", dev_num);
-	asprintf(&dev_dir_name, "%sdevice%d", iio_dir, dev_num);
-
-	/*
-	 * Build the trigger name.
-	 * In this case we want the lis3l02dq's data ready trigger
-	 * for this lis3l02dq. The naming is lis3l02dq_dev[n], where
-	 * n matches the device number found above.
-	 */
-	ret = asprintf(&trigger_name, "%s%d", trigger_name_base, dev_num);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_free_dev_dir_name;
-	}
-
-	/*
-	 * Find the trigger by name.
-	 * This is techically unecessary here as we only need to
-	 * refer to the trigger by name and that name is already
-	 * known.
-	 */
-	trig_num = find_type_by_name(trigger_name, "trigger");
-	if (trig_num < 0) {
-		printf("Failed to find the %s\n", trigger_name);
-		ret = -ENODEV;
-		goto error_free_triggername;
-	}
-	printf("iio trigger number being used is %d\n", trig_num);
-
-	/*
-	 * Read in the scale value - in a more generic case, first
-	 * check for accel_scale, then the indivual channel scales
-	 */
-	ret = read_sysfs_float("accel_scale", dev_dir_name, &gain);
-	if (ret)
-		goto error_free_triggername;;
-
-	/*
-	 * Construct the directory name for the associated buffer.
-	 * As we know that the lis3l02dq has only one buffer this may
-	 * be built rather than found.
-	 */
-	ret = asprintf(&buf_dir_name, "%sdevice%d:buffer0", iio_dir, dev_num);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_free_triggername;
-	}
-	/* Set the device trigger to be the data rdy trigger found above */
-	ret = write_sysfs_string_and_verify("trigger/current_trigger",
-					dev_dir_name,
-					trigger_name);
-	if (ret < 0) {
-		printf("Failed to write current_trigger file\n");
-		goto error_free_buf_dir_name;
-	}
-
-	/* Setup ring buffer parameters */
-	ret = write_sysfs_int("length", buf_dir_name, buf_len);
-	if (ret < 0)
-		goto error_free_buf_dir_name;
-
-	/* Enable the buffer */
-	ret = write_sysfs_int("enable", buf_dir_name, 1);
-	if (ret < 0)
-		goto error_free_buf_dir_name;
-
-	data = malloc(size_from_scanmode(num_vals, scan_ts)*buf_len);
-	if (!data) {
-		ret = -ENOMEM;
-		goto error_free_buf_dir_name;
-	}
-
-	ret = asprintf(&buffer_access,
-		       "/dev/device%d:buffer0:access0",
-		       dev_num);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_free_data;
-	}
-
-	ret = asprintf(&buffer_event, "/dev/device%d:buffer0:event0", dev_num);
-	if (ret < 0) {
-		ret = -ENOMEM;
-		goto error_free_data;
-	}
-	/* Attempt to open non blocking the access dev */
-	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
-	if (fp == -1) { /*If it isn't there make the node */
-		printf("Failed to open %s\n", buffer_access);
-		ret = -errno;
-		goto error_free_buffer_event;
-	}
-	/* Attempt to open the event access dev (blocking this time) */
-	fp_ev = fopen(buffer_event, "rb");
-	if (fp_ev == NULL) {
-		printf("Failed to open %s\n", buffer_event);
-		ret = -errno;
-		goto error_close_buffer_access;
-	}
-
-	/* Wait for events 10 times */
-	for (j = 0; j < num_loops; j++) {
-		read_size = fread(&dat, 1, sizeof(struct iio_event_data),
-				  fp_ev);
-		switch (dat.id) {
-		case IIO_EVENT_CODE_RING_100_FULL:
-			toread = buf_len;
-			break;
-		case IIO_EVENT_CODE_RING_75_FULL:
-			toread = buf_len*3/4;
-			break;
-		case IIO_EVENT_CODE_RING_50_FULL:
-			toread = buf_len/2;
-			break;
-		default:
-			printf("Unexpecteded event code\n");
-			continue;
-		}
-		read_size = read(fp,
-				 data,
-				 toread*size_from_scanmode(num_vals, scan_ts));
-		if (read_size == -EAGAIN) {
-			printf("nothing available\n");
-			continue;
-		}
-		scan_size = size_from_scanmode(num_vals, scan_ts);
-		for (i = 0; i < read_size/scan_size; i++) {
-			for (k = 0; k < num_vals; k++) {
-				__s16 val = *(__s16 *)(&data[i*scan_size
-							     + (k)*2]);
-				printf("%05f ", (float)val*gain);
-			}
-			printf(" %lld\n",
-			       *(__s64 *)(&data[(i + 1)
-						*size_from_scanmode(num_vals,
-								    scan_ts)
-						- sizeof(__s64)]));
-		}
-	}
-
-	/* Stop the ring buffer */
-	ret = write_sysfs_int("enable", buf_dir_name, 0);
-	if (ret < 0)
-		goto error_close_buffer_event;
-
-	/* Disconnect from the trigger - just write a dummy name.*/
-	write_sysfs_string("trigger/current_trigger",
-			dev_dir_name, "NULL");
-
-error_close_buffer_event:
-	fclose(fp_ev);
-error_close_buffer_access:
-	close(fp);
-error_free_data:
-	free(data);
-error_free_buffer_access:
-	free(buffer_access);
-error_free_buffer_event:
-	free(buffer_event);
-error_free_buf_dir_name:
-	free(buf_dir_name);
-error_free_triggername:
-	free(trigger_name);
-error_free_dev_dir_name:
-	free(dev_dir_name);
-error_ret:
-	return ret;
-}
-- 
1.7.2.2
