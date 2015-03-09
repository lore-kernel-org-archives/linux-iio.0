Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45010 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbbCIRQp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 13:16:45 -0400
Message-ID: <54FDD57A.5050202@kernel.org>
Date: Mon, 09 Mar 2015 17:16:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 3/5] iio: Move iio userspace applications out of staging
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com> <1424940567-24877-4-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-4-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 26/02/15 08:49, Roberta Dobrescu wrote:
> This patch moves iio userspace applications out of staging, to tools/iio/
> and adds a Makefile in order to compile them easily. It also adds tools/iio/
> to MAINTAINERS file.
> 
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
Applied to the togreg branch of iio.git.

Thanks for sorting this out.  Always on the todo list but never
happens. Good to have someone step up and deal with it!

Jonathan
> ---
>  MAINTAINERS                                        |   1 +
>  drivers/staging/iio/Documentation/generic_buffer.c | 361 ------------
>  .../staging/iio/Documentation/iio_event_monitor.c  | 310 ----------
>  drivers/staging/iio/Documentation/iio_utils.c      | 651 ---------------------
>  drivers/staging/iio/Documentation/iio_utils.h      |  71 ---
>  drivers/staging/iio/Documentation/lsiio.c          | 163 ------
>  tools/iio/Makefile                                 |  16 +
>  tools/iio/generic_buffer.c                         | 361 ++++++++++++
>  tools/iio/iio_event_monitor.c                      | 310 ++++++++++
>  tools/iio/iio_utils.c                              | 651 +++++++++++++++++++++
>  tools/iio/iio_utils.h                              |  71 +++
>  tools/iio/lsiio.c                                  | 163 ++++++
>  12 files changed, 1573 insertions(+), 1556 deletions(-)
>  delete mode 100644 drivers/staging/iio/Documentation/generic_buffer.c
>  delete mode 100644 drivers/staging/iio/Documentation/iio_event_monitor.c
>  delete mode 100644 drivers/staging/iio/Documentation/iio_utils.c
>  delete mode 100644 drivers/staging/iio/Documentation/iio_utils.h
>  delete mode 100644 drivers/staging/iio/Documentation/lsiio.c
>  create mode 100644 tools/iio/Makefile
>  create mode 100644 tools/iio/generic_buffer.c
>  create mode 100644 tools/iio/iio_event_monitor.c
>  create mode 100644 tools/iio/iio_utils.c
>  create mode 100644 tools/iio/iio_utils.h
>  create mode 100644 tools/iio/lsiio.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 873f496..6fb6bdc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4871,6 +4871,7 @@ S:	Maintained
>  F:	drivers/iio/
>  F:	drivers/staging/iio/
>  F:	include/linux/iio/
> +F:	tools/iio/
>  
>  IKANOS/ADI EAGLE ADSL USB DRIVER
>  M:	Matthieu Castet <castet.matthieu@free.fr>
> diff --git a/drivers/staging/iio/Documentation/generic_buffer.c b/drivers/staging/iio/Documentation/generic_buffer.c
> deleted file mode 100644
> index 01266c2..0000000
> --- a/drivers/staging/iio/Documentation/generic_buffer.c
> +++ /dev/null
> @@ -1,361 +0,0 @@
> -/* Industrialio buffer test code.
> - *
> - * Copyright (c) 2008 Jonathan Cameron
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - *
> - * This program is primarily intended as an example application.
> - * Reads the current buffer setup from sysfs and starts a short capture
> - * from the specified device, pretty printing the result after appropriate
> - * conversion.
> - *
> - * Command line parameters
> - * generic_buffer -n <device_name> -t <trigger_name>
> - * If trigger name is not specified the program assumes you want a dataready
> - * trigger associated with the device and goes looking for it.
> - *
> - */
> -
> -#define _GNU_SOURCE
> -
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <dirent.h>
> -#include <fcntl.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include <sys/stat.h>
> -#include <sys/dir.h>
> -#include <linux/types.h>
> -#include <string.h>
> -#include <poll.h>
> -#include <endian.h>
> -#include <getopt.h>
> -#include <inttypes.h>
> -#include "iio_utils.h"
> -
> -/**
> - * size_from_channelarray() - calculate the storage size of a scan
> - * @channels:		the channel info array
> - * @num_channels:	number of channels
> - *
> - * Has the side effect of filling the channels[i].location values used
> - * in processing the buffer output.
> - **/
> -int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
> -{
> -	int bytes = 0;
> -	int i = 0;
> -
> -	while (i < num_channels) {
> -		if (bytes % channels[i].bytes == 0)
> -			channels[i].location = bytes;
> -		else
> -			channels[i].location = bytes - bytes%channels[i].bytes
> -				+ channels[i].bytes;
> -		bytes = channels[i].location + channels[i].bytes;
> -		i++;
> -	}
> -	return bytes;
> -}
> -
> -void print2byte(int input, struct iio_channel_info *info)
> -{
> -	/* First swap if incorrect endian */
> -	if (info->be)
> -		input = be16toh((uint16_t)input);
> -	else
> -		input = le16toh((uint16_t)input);
> -
> -	/*
> -	 * Shift before conversion to avoid sign extension
> -	 * of left aligned data
> -	 */
> -	input = input >> info->shift;
> -	if (info->is_signed) {
> -		int16_t val = input;
> -
> -		val &= (1 << info->bits_used) - 1;
> -		val = (int16_t)(val << (16 - info->bits_used)) >>
> -			(16 - info->bits_used);
> -		printf("%05f ", ((float)val + info->offset)*info->scale);
> -	} else {
> -		uint16_t val = input;
> -
> -		val &= (1 << info->bits_used) - 1;
> -		printf("%05f ", ((float)val + info->offset)*info->scale);
> -	}
> -}
> -/**
> - * process_scan() - print out the values in SI units
> - * @data:		pointer to the start of the scan
> - * @channels:		information about the channels. Note
> - *  size_from_channelarray must have been called first to fill the
> - *  location offsets.
> - * @num_channels:	number of channels
> - **/
> -void process_scan(char *data,
> -		  struct iio_channel_info *channels,
> -		  int num_channels)
> -{
> -	int k;
> -
> -	for (k = 0; k < num_channels; k++)
> -		switch (channels[k].bytes) {
> -			/* only a few cases implemented so far */
> -		case 2:
> -			print2byte(*(uint16_t *)(data + channels[k].location),
> -				   &channels[k]);
> -			break;
> -		case 4:
> -			if (!channels[k].is_signed) {
> -				uint32_t val = *(uint32_t *)
> -					(data + channels[k].location);
> -				printf("%05f ", ((float)val +
> -						 channels[k].offset)*
> -				       channels[k].scale);
> -
> -			}
> -			break;
> -		case 8:
> -			if (channels[k].is_signed) {
> -				int64_t val = *(int64_t *)
> -					(data +
> -					 channels[k].location);
> -				if ((val >> channels[k].bits_used) & 1)
> -					val = (val & channels[k].mask) |
> -						~channels[k].mask;
> -				/* special case for timestamp */
> -				if (channels[k].scale == 1.0f &&
> -				    channels[k].offset == 0.0f)
> -					printf("%" PRId64 " ", val);
> -				else
> -					printf("%05f ", ((float)val +
> -							 channels[k].offset)*
> -					       channels[k].scale);
> -			}
> -			break;
> -		default:
> -			break;
> -		}
> -	printf("\n");
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	unsigned long num_loops = 2;
> -	unsigned long timedelay = 1000000;
> -	unsigned long buf_len = 128;
> -
> -	int ret, c, i, j, toread;
> -	int fp;
> -
> -	int num_channels;
> -	char *trigger_name = NULL, *device_name = NULL;
> -	char *dev_dir_name, *buf_dir_name;
> -
> -	int datardytrigger = 1;
> -	char *data;
> -	ssize_t read_size;
> -	int dev_num, trig_num;
> -	char *buffer_access;
> -	int scan_size;
> -	int noevents = 0;
> -	int notrigger = 0;
> -	char *dummy;
> -
> -	struct iio_channel_info *channels;
> -
> -	while ((c = getopt(argc, argv, "l:w:c:et:n:g")) != -1) {
> -		switch (c) {
> -		case 'n':
> -			device_name = optarg;
> -			break;
> -		case 't':
> -			trigger_name = optarg;
> -			datardytrigger = 0;
> -			break;
> -		case 'e':
> -			noevents = 1;
> -			break;
> -		case 'c':
> -			num_loops = strtoul(optarg, &dummy, 10);
> -			break;
> -		case 'w':
> -			timedelay = strtoul(optarg, &dummy, 10);
> -			break;
> -		case 'l':
> -			buf_len = strtoul(optarg, &dummy, 10);
> -			break;
> -		case 'g':
> -			notrigger = 1;
> -			break;
> -		case '?':
> -			return -1;
> -		}
> -	}
> -
> -	if (device_name == NULL)
> -		return -1;
> -
> -	/* Find the device requested */
> -	dev_num = find_type_by_name(device_name, "iio:device");
> -	if (dev_num < 0) {
> -		printf("Failed to find the %s\n", device_name);
> -		ret = -ENODEV;
> -		goto error_ret;
> -	}
> -	printf("iio device number being used is %d\n", dev_num);
> -
> -	asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
> -
> -	if (!notrigger) {
> -		if (trigger_name == NULL) {
> -			/*
> -			 * Build the trigger name. If it is device associated
> -			 * its name is <device_name>_dev[n] where n matches
> -			 * the device number found above.
> -			 */
> -			ret = asprintf(&trigger_name,
> -				       "%s-dev%d", device_name, dev_num);
> -			if (ret < 0) {
> -				ret = -ENOMEM;
> -				goto error_ret;
> -			}
> -		}
> -
> -		/* Verify the trigger exists */
> -		trig_num = find_type_by_name(trigger_name, "trigger");
> -		if (trig_num < 0) {
> -			printf("Failed to find the trigger %s\n", trigger_name);
> -			ret = -ENODEV;
> -			goto error_free_triggername;
> -		}
> -		printf("iio trigger number being used is %d\n", trig_num);
> -	} else
> -		printf("trigger-less mode selected\n");
> -
> -	/*
> -	 * Parse the files in scan_elements to identify what channels are
> -	 * present
> -	 */
> -	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
> -	if (ret) {
> -		printf("Problem reading scan element information\n");
> -		printf("diag %s\n", dev_dir_name);
> -		goto error_free_triggername;
> -	}
> -
> -	/*
> -	 * Construct the directory name for the associated buffer.
> -	 * As we know that the lis3l02dq has only one buffer this may
> -	 * be built rather than found.
> -	 */
> -	ret = asprintf(&buf_dir_name,
> -		       "%siio:device%d/buffer", iio_dir, dev_num);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_free_triggername;
> -	}
> -
> -	if (!notrigger) {
> -		printf("%s %s\n", dev_dir_name, trigger_name);
> -		/* Set the device trigger to be the data ready trigger found
> -		 * above */
> -		ret = write_sysfs_string_and_verify("trigger/current_trigger",
> -						    dev_dir_name,
> -						    trigger_name);
> -		if (ret < 0) {
> -			printf("Failed to write current_trigger file\n");
> -			goto error_free_buf_dir_name;
> -		}
> -	}
> -
> -	/* Setup ring buffer parameters */
> -	ret = write_sysfs_int("length", buf_dir_name, buf_len);
> -	if (ret < 0)
> -		goto error_free_buf_dir_name;
> -
> -	/* Enable the buffer */
> -	ret = write_sysfs_int("enable", buf_dir_name, 1);
> -	if (ret < 0)
> -		goto error_free_buf_dir_name;
> -	scan_size = size_from_channelarray(channels, num_channels);
> -	data = malloc(scan_size*buf_len);
> -	if (!data) {
> -		ret = -ENOMEM;
> -		goto error_free_buf_dir_name;
> -	}
> -
> -	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_free_data;
> -	}
> -
> -	/* Attempt to open non blocking the access dev */
> -	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
> -	if (fp == -1) { /* If it isn't there make the node */
> -		printf("Failed to open %s\n", buffer_access);
> -		ret = -errno;
> -		goto error_free_buffer_access;
> -	}
> -
> -	/* Wait for events 10 times */
> -	for (j = 0; j < num_loops; j++) {
> -		if (!noevents) {
> -			struct pollfd pfd = {
> -				.fd = fp,
> -				.events = POLLIN,
> -			};
> -
> -			poll(&pfd, 1, -1);
> -			toread = buf_len;
> -
> -		} else {
> -			usleep(timedelay);
> -			toread = 64;
> -		}
> -
> -		read_size = read(fp,
> -				 data,
> -				 toread*scan_size);
> -		if (read_size < 0) {
> -			if (errno == -EAGAIN) {
> -				printf("nothing available\n");
> -				continue;
> -			} else
> -				break;
> -		}
> -		for (i = 0; i < read_size/scan_size; i++)
> -			process_scan(data + scan_size*i,
> -				     channels,
> -				     num_channels);
> -	}
> -
> -	/* Stop the buffer */
> -	ret = write_sysfs_int("enable", buf_dir_name, 0);
> -	if (ret < 0)
> -		goto error_close_buffer_access;
> -
> -	if (!notrigger)
> -		/* Disconnect the trigger - just write a dummy name. */
> -		write_sysfs_string("trigger/current_trigger",
> -				   dev_dir_name, "NULL");
> -
> -error_close_buffer_access:
> -	close(fp);
> -error_free_data:
> -	free(data);
> -error_free_buffer_access:
> -	free(buffer_access);
> -error_free_buf_dir_name:
> -	free(buf_dir_name);
> -error_free_triggername:
> -	if (datardytrigger)
> -		free(trigger_name);
> -error_ret:
> -	return ret;
> -}
> diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
> deleted file mode 100644
> index f19cff1..0000000
> --- a/drivers/staging/iio/Documentation/iio_event_monitor.c
> +++ /dev/null
> @@ -1,310 +0,0 @@
> -/* Industrialio event test code.
> - *
> - * Copyright (c) 2011-2012 Lars-Peter Clausen <lars@metafoo.de>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - *
> - * This program is primarily intended as an example application.
> - * Reads the current buffer setup from sysfs and starts a short capture
> - * from the specified device, pretty printing the result after appropriate
> - * conversion.
> - *
> - * Usage:
> - *	iio_event_monitor <device_name>
> - *
> - */
> -
> -#define _GNU_SOURCE
> -
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <stdbool.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include <string.h>
> -#include <poll.h>
> -#include <fcntl.h>
> -#include <sys/ioctl.h>
> -#include "iio_utils.h"
> -#include <linux/iio/events.h>
> -#include <linux/iio/types.h>
> -
> -static const char * const iio_chan_type_name_spec[] = {
> -	[IIO_VOLTAGE] = "voltage",
> -	[IIO_CURRENT] = "current",
> -	[IIO_POWER] = "power",
> -	[IIO_ACCEL] = "accel",
> -	[IIO_ANGL_VEL] = "anglvel",
> -	[IIO_MAGN] = "magn",
> -	[IIO_LIGHT] = "illuminance",
> -	[IIO_INTENSITY] = "intensity",
> -	[IIO_PROXIMITY] = "proximity",
> -	[IIO_TEMP] = "temp",
> -	[IIO_INCLI] = "incli",
> -	[IIO_ROT] = "rot",
> -	[IIO_ANGL] = "angl",
> -	[IIO_TIMESTAMP] = "timestamp",
> -	[IIO_CAPACITANCE] = "capacitance",
> -	[IIO_ALTVOLTAGE] = "altvoltage",
> -	[IIO_CCT] = "cct",
> -	[IIO_PRESSURE] = "pressure",
> -	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
> -	[IIO_ACTIVITY] = "activity",
> -	[IIO_STEPS] = "steps",
> -};
> -
> -static const char * const iio_ev_type_text[] = {
> -	[IIO_EV_TYPE_THRESH] = "thresh",
> -	[IIO_EV_TYPE_MAG] = "mag",
> -	[IIO_EV_TYPE_ROC] = "roc",
> -	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
> -	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
> -	[IIO_EV_TYPE_CHANGE] = "change",
> -};
> -
> -static const char * const iio_ev_dir_text[] = {
> -	[IIO_EV_DIR_EITHER] = "either",
> -	[IIO_EV_DIR_RISING] = "rising",
> -	[IIO_EV_DIR_FALLING] = "falling"
> -};
> -
> -static const char * const iio_modifier_names[] = {
> -	[IIO_MOD_X] = "x",
> -	[IIO_MOD_Y] = "y",
> -	[IIO_MOD_Z] = "z",
> -	[IIO_MOD_X_AND_Y] = "x&y",
> -	[IIO_MOD_X_AND_Z] = "x&z",
> -	[IIO_MOD_Y_AND_Z] = "y&z",
> -	[IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
> -	[IIO_MOD_X_OR_Y] = "x|y",
> -	[IIO_MOD_X_OR_Z] = "x|z",
> -	[IIO_MOD_Y_OR_Z] = "y|z",
> -	[IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",
> -	[IIO_MOD_LIGHT_BOTH] = "both",
> -	[IIO_MOD_LIGHT_IR] = "ir",
> -	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
> -	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
> -	[IIO_MOD_LIGHT_CLEAR] = "clear",
> -	[IIO_MOD_LIGHT_RED] = "red",
> -	[IIO_MOD_LIGHT_GREEN] = "green",
> -	[IIO_MOD_LIGHT_BLUE] = "blue",
> -	[IIO_MOD_QUATERNION] = "quaternion",
> -	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> -	[IIO_MOD_TEMP_OBJECT] = "object",
> -	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
> -	[IIO_MOD_NORTH_TRUE] = "from_north_true",
> -	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
> -	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp",
> -	[IIO_MOD_RUNNING] = "running",
> -	[IIO_MOD_JOGGING] = "jogging",
> -	[IIO_MOD_WALKING] = "walking",
> -	[IIO_MOD_STILL] = "still",
> -};
> -
> -static bool event_is_known(struct iio_event_data *event)
> -{
> -	enum iio_chan_type type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event->id);
> -	enum iio_modifier mod = IIO_EVENT_CODE_EXTRACT_MODIFIER(event->id);
> -	enum iio_event_type ev_type = IIO_EVENT_CODE_EXTRACT_TYPE(event->id);
> -	enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(event->id);
> -
> -	switch (type) {
> -	case IIO_VOLTAGE:
> -	case IIO_CURRENT:
> -	case IIO_POWER:
> -	case IIO_ACCEL:
> -	case IIO_ANGL_VEL:
> -	case IIO_MAGN:
> -	case IIO_LIGHT:
> -	case IIO_INTENSITY:
> -	case IIO_PROXIMITY:
> -	case IIO_TEMP:
> -	case IIO_INCLI:
> -	case IIO_ROT:
> -	case IIO_ANGL:
> -	case IIO_TIMESTAMP:
> -	case IIO_CAPACITANCE:
> -	case IIO_ALTVOLTAGE:
> -	case IIO_CCT:
> -	case IIO_PRESSURE:
> -	case IIO_HUMIDITYRELATIVE:
> -	case IIO_ACTIVITY:
> -	case IIO_STEPS:
> -		break;
> -	default:
> -		return false;
> -	}
> -
> -	switch (mod) {
> -	case IIO_NO_MOD:
> -	case IIO_MOD_X:
> -	case IIO_MOD_Y:
> -	case IIO_MOD_Z:
> -	case IIO_MOD_X_AND_Y:
> -	case IIO_MOD_X_AND_Z:
> -	case IIO_MOD_Y_AND_Z:
> -	case IIO_MOD_X_AND_Y_AND_Z:
> -	case IIO_MOD_X_OR_Y:
> -	case IIO_MOD_X_OR_Z:
> -	case IIO_MOD_Y_OR_Z:
> -	case IIO_MOD_X_OR_Y_OR_Z:
> -	case IIO_MOD_LIGHT_BOTH:
> -	case IIO_MOD_LIGHT_IR:
> -	case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
> -	case IIO_MOD_SUM_SQUARED_X_Y_Z:
> -	case IIO_MOD_LIGHT_CLEAR:
> -	case IIO_MOD_LIGHT_RED:
> -	case IIO_MOD_LIGHT_GREEN:
> -	case IIO_MOD_LIGHT_BLUE:
> -	case IIO_MOD_QUATERNION:
> -	case IIO_MOD_TEMP_AMBIENT:
> -	case IIO_MOD_TEMP_OBJECT:
> -	case IIO_MOD_NORTH_MAGN:
> -	case IIO_MOD_NORTH_TRUE:
> -	case IIO_MOD_NORTH_MAGN_TILT_COMP:
> -	case IIO_MOD_NORTH_TRUE_TILT_COMP:
> -	case IIO_MOD_RUNNING:
> -	case IIO_MOD_JOGGING:
> -	case IIO_MOD_WALKING:
> -	case IIO_MOD_STILL:
> -		break;
> -	default:
> -		return false;
> -	}
> -
> -	switch (ev_type) {
> -	case IIO_EV_TYPE_THRESH:
> -	case IIO_EV_TYPE_MAG:
> -	case IIO_EV_TYPE_ROC:
> -	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> -	case IIO_EV_TYPE_MAG_ADAPTIVE:
> -	case IIO_EV_TYPE_CHANGE:
> -		break;
> -	default:
> -		return false;
> -	}
> -
> -	switch (dir) {
> -	case IIO_EV_DIR_EITHER:
> -	case IIO_EV_DIR_RISING:
> -	case IIO_EV_DIR_FALLING:
> -	case IIO_EV_DIR_NONE:
> -		break;
> -	default:
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
> -static void print_event(struct iio_event_data *event)
> -{
> -	enum iio_chan_type type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event->id);
> -	enum iio_modifier mod = IIO_EVENT_CODE_EXTRACT_MODIFIER(event->id);
> -	enum iio_event_type ev_type = IIO_EVENT_CODE_EXTRACT_TYPE(event->id);
> -	enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(event->id);
> -	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event->id);
> -	int chan2 = IIO_EVENT_CODE_EXTRACT_CHAN2(event->id);
> -	bool diff = IIO_EVENT_CODE_EXTRACT_DIFF(event->id);
> -
> -	if (!event_is_known(event)) {
> -		printf("Unknown event: time: %lld, id: %llx\n",
> -				event->timestamp, event->id);
> -		return;
> -	}
> -
> -	printf("Event: time: %lld, ", event->timestamp);
> -
> -	if (mod != IIO_NO_MOD) {
> -		printf("type: %s(%s), ",
> -			iio_chan_type_name_spec[type],
> -			iio_modifier_names[mod]);
> -	} else {
> -		printf("type: %s, ",
> -			iio_chan_type_name_spec[type]);
> -	}
> -
> -	if (diff && chan >= 0 && chan2 >= 0)
> -		printf("channel: %d-%d, ", chan, chan2);
> -	else if (chan >= 0)
> -		printf("channel: %d, ", chan);
> -
> -	printf("evtype: %s", iio_ev_type_text[ev_type]);
> -
> -	if (dir != IIO_EV_DIR_NONE)
> -		printf(", direction: %s", iio_ev_dir_text[dir]);
> -	printf("\n");
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	struct iio_event_data event;
> -	const char *device_name;
> -	char *chrdev_name;
> -	int ret;
> -	int dev_num;
> -	int fd, event_fd;
> -
> -	if (argc <= 1) {
> -		printf("Usage: %s <device_name>\n", argv[0]);
> -		return -1;
> -	}
> -
> -	device_name = argv[1];
> -
> -	dev_num = find_type_by_name(device_name, "iio:device");
> -	if (dev_num >= 0) {
> -		printf("Found IIO device with name %s with device number %d\n",
> -			device_name, dev_num);
> -		ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
> -		if (ret < 0) {
> -			ret = -ENOMEM;
> -			goto error_ret;
> -		}
> -	} else {
> -		/* If we can't find a IIO device by name assume device_name is a
> -		   IIO chrdev */
> -		chrdev_name = strdup(device_name);
> -	}
> -
> -	fd = open(chrdev_name, 0);
> -	if (fd == -1) {
> -		fprintf(stdout, "Failed to open %s\n", chrdev_name);
> -		ret = -errno;
> -		goto error_free_chrdev_name;
> -	}
> -
> -	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
> -
> -	close(fd);
> -
> -	if (ret == -1 || event_fd == -1) {
> -		fprintf(stdout, "Failed to retrieve event fd\n");
> -		ret = -errno;
> -		goto error_free_chrdev_name;
> -	}
> -
> -	while (true) {
> -		ret = read(event_fd, &event, sizeof(event));
> -		if (ret == -1) {
> -			if (errno == EAGAIN) {
> -				printf("nothing available\n");
> -				continue;
> -			} else {
> -				perror("Failed to read event from device");
> -				ret = -errno;
> -				break;
> -			}
> -		}
> -
> -		print_event(&event);
> -	}
> -
> -	close(event_fd);
> -error_free_chrdev_name:
> -	free(chrdev_name);
> -error_ret:
> -	return ret;
> -}
> diff --git a/drivers/staging/iio/Documentation/iio_utils.c b/drivers/staging/iio/Documentation/iio_utils.c
> deleted file mode 100644
> index aea9282..0000000
> --- a/drivers/staging/iio/Documentation/iio_utils.c
> +++ /dev/null
> @@ -1,651 +0,0 @@
> -/* IIO - useful set of util functionality
> - *
> - * Copyright (c) 2008 Jonathan Cameron
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - */
> -
> -#include <string.h>
> -#include <stdlib.h>
> -#include <stdio.h>
> -#include <stdint.h>
> -#include <dirent.h>
> -#include <errno.h>
> -#include <ctype.h>
> -#include "iio_utils.h"
> -
> -const char *iio_dir = "/sys/bus/iio/devices/";
> -
> -/**
> - * iioutils_break_up_name() - extract generic name from full channel name
> - * @full_name: the full channel name
> - * @generic_name: the output generic channel name
> - **/
> -int iioutils_break_up_name(const char *full_name,
> -				  char **generic_name)
> -{
> -	char *current;
> -	char *w, *r;
> -	char *working;
> -
> -	current = strdup(full_name);
> -	working = strtok(current, "_\0");
> -	w = working;
> -	r = working;
> -
> -	while (*r != '\0') {
> -		if (!isdigit(*r)) {
> -			*w = *r;
> -			w++;
> -		}
> -		r++;
> -	}
> -	*w = '\0';
> -	*generic_name = strdup(working);
> -	free(current);
> -
> -	return 0;
> -}
> -
> -/**
> - * iioutils_get_type() - find and process _type attribute data
> - * @is_signed: output whether channel is signed
> - * @bytes: output how many bytes the channel storage occupies
> - * @mask: output a bit mask for the raw data
> - * @be: big endian
> - * @device_dir: the iio device directory
> - * @name: the channel name
> - * @generic_name: the channel type name
> - **/
> -int iioutils_get_type(unsigned *is_signed,
> -			     unsigned *bytes,
> -			     unsigned *bits_used,
> -			     unsigned *shift,
> -			     uint64_t *mask,
> -			     unsigned *be,
> -			     const char *device_dir,
> -			     const char *name,
> -			     const char *generic_name)
> -{
> -	FILE *sysfsfp;
> -	int ret;
> -	DIR *dp;
> -	char *scan_el_dir, *builtname, *builtname_generic, *filename = 0;
> -	char signchar, endianchar;
> -	unsigned padint;
> -	const struct dirent *ent;
> -
> -	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -	ret = asprintf(&builtname, FORMAT_TYPE_FILE, name);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_free_scan_el_dir;
> -	}
> -	ret = asprintf(&builtname_generic, FORMAT_TYPE_FILE, generic_name);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_free_builtname;
> -	}
> -
> -	dp = opendir(scan_el_dir);
> -	if (dp == NULL) {
> -		ret = -errno;
> -		goto error_free_builtname_generic;
> -	}
> -	while (ent = readdir(dp), ent != NULL)
> -		/*
> -		 * Do we allow devices to override a generic name with
> -		 * a specific one?
> -		 */
> -		if ((strcmp(builtname, ent->d_name) == 0) ||
> -		    (strcmp(builtname_generic, ent->d_name) == 0)) {
> -			ret = asprintf(&filename,
> -				       "%s/%s", scan_el_dir, ent->d_name);
> -			if (ret < 0) {
> -				ret = -ENOMEM;
> -				goto error_closedir;
> -			}
> -			sysfsfp = fopen(filename, "r");
> -			if (sysfsfp == NULL) {
> -				printf("failed to open %s\n", filename);
> -				ret = -errno;
> -				goto error_free_filename;
> -			}
> -
> -			ret = fscanf(sysfsfp,
> -				     "%ce:%c%u/%u>>%u",
> -				     &endianchar,
> -				     &signchar,
> -				     bits_used,
> -				     &padint, shift);
> -			if (ret < 0) {
> -				printf("failed to pass scan type description\n");
> -				ret = -errno;
> -				goto error_close_sysfsfp;
> -			}
> -			*be = (endianchar == 'b');
> -			*bytes = padint / 8;
> -			if (*bits_used == 64)
> -				*mask = ~0;
> -			else
> -				*mask = (1 << *bits_used) - 1;
> -			if (signchar == 's')
> -				*is_signed = 1;
> -			else
> -				*is_signed = 0;
> -			fclose(sysfsfp);
> -			free(filename);
> -
> -			filename = 0;
> -			sysfsfp = 0;
> -		}
> -error_close_sysfsfp:
> -	if (sysfsfp)
> -		fclose(sysfsfp);
> -error_free_filename:
> -	if (filename)
> -		free(filename);
> -error_closedir:
> -	closedir(dp);
> -error_free_builtname_generic:
> -	free(builtname_generic);
> -error_free_builtname:
> -	free(builtname);
> -error_free_scan_el_dir:
> -	free(scan_el_dir);
> -error_ret:
> -	return ret;
> -}
> -
> -int iioutils_get_param_float(float *output,
> -				    const char *param_name,
> -				    const char *device_dir,
> -				    const char *name,
> -				    const char *generic_name)
> -{
> -	FILE *sysfsfp;
> -	int ret;
> -	DIR *dp;
> -	char *builtname, *builtname_generic;
> -	char *filename = NULL;
> -	const struct dirent *ent;
> -
> -	ret = asprintf(&builtname, "%s_%s", name, param_name);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -	ret = asprintf(&builtname_generic,
> -		       "%s_%s", generic_name, param_name);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_free_builtname;
> -	}
> -	dp = opendir(device_dir);
> -	if (dp == NULL) {
> -		ret = -errno;
> -		goto error_free_builtname_generic;
> -	}
> -	while (ent = readdir(dp), ent != NULL)
> -		if ((strcmp(builtname, ent->d_name) == 0) ||
> -		    (strcmp(builtname_generic, ent->d_name) == 0)) {
> -			ret = asprintf(&filename,
> -				       "%s/%s", device_dir, ent->d_name);
> -			if (ret < 0) {
> -				ret = -ENOMEM;
> -				goto error_closedir;
> -			}
> -			sysfsfp = fopen(filename, "r");
> -			if (!sysfsfp) {
> -				ret = -errno;
> -				goto error_free_filename;
> -			}
> -			fscanf(sysfsfp, "%f", output);
> -			break;
> -		}
> -error_free_filename:
> -	if (filename)
> -		free(filename);
> -error_closedir:
> -	closedir(dp);
> -error_free_builtname_generic:
> -	free(builtname_generic);
> -error_free_builtname:
> -	free(builtname);
> -error_ret:
> -	return ret;
> -}
> -
> -/**
> - * bsort_channel_array_by_index() - reorder so that the array is in index order
> - *
> - **/
> -
> -void bsort_channel_array_by_index(struct iio_channel_info **ci_array,
> -					 int cnt)
> -{
> -
> -	struct iio_channel_info temp;
> -	int x, y;
> -
> -	for (x = 0; x < cnt; x++)
> -		for (y = 0; y < (cnt - 1); y++)
> -			if ((*ci_array)[y].index > (*ci_array)[y+1].index) {
> -				temp = (*ci_array)[y + 1];
> -				(*ci_array)[y + 1] = (*ci_array)[y];
> -				(*ci_array)[y] = temp;
> -			}
> -}
> -
> -/**
> - * build_channel_array() - function to figure out what channels are present
> - * @device_dir: the IIO device directory in sysfs
> - * @
> - **/
> -int build_channel_array(const char *device_dir,
> -			      struct iio_channel_info **ci_array,
> -			      int *counter)
> -{
> -	DIR *dp;
> -	FILE *sysfsfp;
> -	int count, i;
> -	struct iio_channel_info *current;
> -	int ret;
> -	const struct dirent *ent;
> -	char *scan_el_dir;
> -	char *filename;
> -
> -	*counter = 0;
> -	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_ret;
> -	}
> -	dp = opendir(scan_el_dir);
> -	if (dp == NULL) {
> -		ret = -errno;
> -		goto error_free_name;
> -	}
> -	while (ent = readdir(dp), ent != NULL)
> -		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
> -			   "_en") == 0) {
> -			ret = asprintf(&filename,
> -				       "%s/%s", scan_el_dir, ent->d_name);
> -			if (ret < 0) {
> -				ret = -ENOMEM;
> -				goto error_close_dir;
> -			}
> -			sysfsfp = fopen(filename, "r");
> -			if (sysfsfp == NULL) {
> -				ret = -errno;
> -				free(filename);
> -				goto error_close_dir;
> -			}
> -			fscanf(sysfsfp, "%i", &ret);
> -			if (ret == 1)
> -				(*counter)++;
> -			fclose(sysfsfp);
> -			free(filename);
> -		}
> -	*ci_array = malloc(sizeof(**ci_array) * (*counter));
> -	if (*ci_array == NULL) {
> -		ret = -ENOMEM;
> -		goto error_close_dir;
> -	}
> -	seekdir(dp, 0);
> -	count = 0;
> -	while (ent = readdir(dp), ent != NULL) {
> -		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
> -			   "_en") == 0) {
> -			int current_enabled = 0;
> -
> -			current = &(*ci_array)[count++];
> -			ret = asprintf(&filename,
> -				       "%s/%s", scan_el_dir, ent->d_name);
> -			if (ret < 0) {
> -				ret = -ENOMEM;
> -				/* decrement count to avoid freeing name */
> -				count--;
> -				goto error_cleanup_array;
> -			}
> -			sysfsfp = fopen(filename, "r");
> -			if (sysfsfp == NULL) {
> -				free(filename);
> -				ret = -errno;
> -				goto error_cleanup_array;
> -			}
> -			fscanf(sysfsfp, "%i", &current_enabled);
> -			fclose(sysfsfp);
> -
> -			if (!current_enabled) {
> -				free(filename);
> -				count--;
> -				continue;
> -			}
> -
> -			current->scale = 1.0;
> -			current->offset = 0;
> -			current->name = strndup(ent->d_name,
> -						strlen(ent->d_name) -
> -						strlen("_en"));
> -			if (current->name == NULL) {
> -				free(filename);
> -				ret = -ENOMEM;
> -				goto error_cleanup_array;
> -			}
> -			/* Get the generic and specific name elements */
> -			ret = iioutils_break_up_name(current->name,
> -						     &current->generic_name);
> -			if (ret) {
> -				free(filename);
> -				goto error_cleanup_array;
> -			}
> -			ret = asprintf(&filename,
> -				       "%s/%s_index",
> -				       scan_el_dir,
> -				       current->name);
> -			if (ret < 0) {
> -				free(filename);
> -				ret = -ENOMEM;
> -				goto error_cleanup_array;
> -			}
> -			sysfsfp = fopen(filename, "r");
> -			fscanf(sysfsfp, "%u", &current->index);
> -			fclose(sysfsfp);
> -			free(filename);
> -			/* Find the scale */
> -			ret = iioutils_get_param_float(&current->scale,
> -						       "scale",
> -						       device_dir,
> -						       current->name,
> -						       current->generic_name);
> -			if (ret < 0)
> -				goto error_cleanup_array;
> -			ret = iioutils_get_param_float(&current->offset,
> -						       "offset",
> -						       device_dir,
> -						       current->name,
> -						       current->generic_name);
> -			if (ret < 0)
> -				goto error_cleanup_array;
> -			ret = iioutils_get_type(&current->is_signed,
> -						&current->bytes,
> -						&current->bits_used,
> -						&current->shift,
> -						&current->mask,
> -						&current->be,
> -						device_dir,
> -						current->name,
> -						current->generic_name);
> -		}
> -	}
> -
> -	closedir(dp);
> -	/* reorder so that the array is in index order */
> -	bsort_channel_array_by_index(ci_array, *counter);
> -
> -	return 0;
> -
> -error_cleanup_array:
> -	for (i = count - 1;  i >= 0; i--)
> -		free((*ci_array)[i].name);
> -	free(*ci_array);
> -error_close_dir:
> -	closedir(dp);
> -error_free_name:
> -	free(scan_el_dir);
> -error_ret:
> -	return ret;
> -}
> -
> -/**
> - * find_type_by_name() - function to match top level types by name
> - * @name: top level type instance name
> - * @type: the type of top level instance being sort
> - *
> - * Typical types this is used for are device and trigger.
> - **/
> -int find_type_by_name(const char *name, const char *type)
> -{
> -	const struct dirent *ent;
> -	int number, numstrlen;
> -
> -	FILE *nameFile;
> -	DIR *dp;
> -	char thisname[IIO_MAX_NAME_LENGTH];
> -	char *filename;
> -
> -	dp = opendir(iio_dir);
> -	if (dp == NULL) {
> -		printf("No industrialio devices available\n");
> -		return -ENODEV;
> -	}
> -
> -	while (ent = readdir(dp), ent != NULL) {
> -		if (strcmp(ent->d_name, ".") != 0 &&
> -			strcmp(ent->d_name, "..") != 0 &&
> -			strlen(ent->d_name) > strlen(type) &&
> -			strncmp(ent->d_name, type, strlen(type)) == 0) {
> -			numstrlen = sscanf(ent->d_name + strlen(type),
> -					   "%d",
> -					   &number);
> -			/* verify the next character is not a colon */
> -			if (strncmp(ent->d_name + strlen(type) + numstrlen,
> -					":",
> -					1) != 0) {
> -				filename = malloc(strlen(iio_dir)
> -						+ strlen(type)
> -						+ numstrlen
> -						+ 6);
> -				if (filename == NULL) {
> -					closedir(dp);
> -					return -ENOMEM;
> -				}
> -				sprintf(filename, "%s%s%d/name",
> -					iio_dir,
> -					type,
> -					number);
> -				nameFile = fopen(filename, "r");
> -				if (!nameFile) {
> -					free(filename);
> -					continue;
> -				}
> -				free(filename);
> -				fscanf(nameFile, "%s", thisname);
> -				fclose(nameFile);
> -				if (strcmp(name, thisname) == 0) {
> -					closedir(dp);
> -					return number;
> -				}
> -			}
> -		}
> -	}
> -	closedir(dp);
> -	return -ENODEV;
> -}
> -
> -int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
> -{
> -	int ret = 0;
> -	FILE *sysfsfp;
> -	int test;
> -	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> -
> -	if (temp == NULL)
> -		return -ENOMEM;
> -	sprintf(temp, "%s/%s", basedir, filename);
> -	sysfsfp = fopen(temp, "w");
> -	if (sysfsfp == NULL) {
> -		printf("failed to open %s\n", temp);
> -		ret = -errno;
> -		goto error_free;
> -	}
> -	fprintf(sysfsfp, "%d", val);
> -	fclose(sysfsfp);
> -	if (verify) {
> -		sysfsfp = fopen(temp, "r");
> -		if (sysfsfp == NULL) {
> -			printf("failed to open %s\n", temp);
> -			ret = -errno;
> -			goto error_free;
> -		}
> -		fscanf(sysfsfp, "%d", &test);
> -		fclose(sysfsfp);
> -		if (test != val) {
> -			printf("Possible failure in int write %d to %s%s\n",
> -				val,
> -				basedir,
> -				filename);
> -			ret = -1;
> -		}
> -	}
> -error_free:
> -	free(temp);
> -	return ret;
> -}
> -
> -int write_sysfs_int(char *filename, char *basedir, int val)
> -{
> -	return _write_sysfs_int(filename, basedir, val, 0);
> -}
> -
> -int write_sysfs_int_and_verify(char *filename, char *basedir, int val)
> -{
> -	return _write_sysfs_int(filename, basedir, val, 1);
> -}
> -
> -int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
> -{
> -	int ret = 0;
> -	FILE  *sysfsfp;
> -	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> -
> -	if (temp == NULL) {
> -		printf("Memory allocation failed\n");
> -		return -ENOMEM;
> -	}
> -	sprintf(temp, "%s/%s", basedir, filename);
> -	sysfsfp = fopen(temp, "w");
> -	if (sysfsfp == NULL) {
> -		printf("Could not open %s\n", temp);
> -		ret = -errno;
> -		goto error_free;
> -	}
> -	fprintf(sysfsfp, "%s", val);
> -	fclose(sysfsfp);
> -	if (verify) {
> -		sysfsfp = fopen(temp, "r");
> -		if (sysfsfp == NULL) {
> -			printf("could not open file to verify\n");
> -			ret = -errno;
> -			goto error_free;
> -		}
> -		fscanf(sysfsfp, "%s", temp);
> -		fclose(sysfsfp);
> -		if (strcmp(temp, val) != 0) {
> -			printf("Possible failure in string write of %s "
> -				"Should be %s "
> -				"written to %s\%s\n",
> -				temp,
> -				val,
> -				basedir,
> -				filename);
> -			ret = -1;
> -		}
> -	}
> -error_free:
> -	free(temp);
> -
> -	return ret;
> -}
> -
> -/**
> - * write_sysfs_string_and_verify() - string write, readback and verify
> - * @filename: name of file to write to
> - * @basedir: the sysfs directory in which the file is to be found
> - * @val: the string to write
> - **/
> -int write_sysfs_string_and_verify(char *filename, char *basedir, char *val)
> -{
> -	return _write_sysfs_string(filename, basedir, val, 1);
> -}
> -
> -int write_sysfs_string(char *filename, char *basedir, char *val)
> -{
> -	return _write_sysfs_string(filename, basedir, val, 0);
> -}
> -
> -int read_sysfs_posint(char *filename, char *basedir)
> -{
> -	int ret;
> -	FILE  *sysfsfp;
> -	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> -
> -	if (temp == NULL) {
> -		printf("Memory allocation failed");
> -		return -ENOMEM;
> -	}
> -	sprintf(temp, "%s/%s", basedir, filename);
> -	sysfsfp = fopen(temp, "r");
> -	if (sysfsfp == NULL) {
> -		ret = -errno;
> -		goto error_free;
> -	}
> -	fscanf(sysfsfp, "%d\n", &ret);
> -	fclose(sysfsfp);
> -error_free:
> -	free(temp);
> -	return ret;
> -}
> -
> -int read_sysfs_float(char *filename, char *basedir, float *val)
> -{
> -	int ret = 0;
> -	FILE  *sysfsfp;
> -	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> -
> -	if (temp == NULL) {
> -		printf("Memory allocation failed");
> -		return -ENOMEM;
> -	}
> -	sprintf(temp, "%s/%s", basedir, filename);
> -	sysfsfp = fopen(temp, "r");
> -	if (sysfsfp == NULL) {
> -		ret = -errno;
> -		goto error_free;
> -	}
> -	fscanf(sysfsfp, "%f\n", val);
> -	fclose(sysfsfp);
> -error_free:
> -	free(temp);
> -	return ret;
> -}
> -
> -int read_sysfs_string(const char *filename, const char *basedir, char *str)
> -{
> -	int ret = 0;
> -	FILE  *sysfsfp;
> -	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> -
> -	if (temp == NULL) {
> -		printf("Memory allocation failed");
> -		return -ENOMEM;
> -	}
> -	sprintf(temp, "%s/%s", basedir, filename);
> -	sysfsfp = fopen(temp, "r");
> -	if (sysfsfp == NULL) {
> -		ret = -errno;
> -		goto error_free;
> -	}
> -	fscanf(sysfsfp, "%s\n", str);
> -	fclose(sysfsfp);
> -error_free:
> -	free(temp);
> -	return ret;
> -}
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> deleted file mode 100644
> index 1bc837b..0000000
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ /dev/null
> @@ -1,71 +0,0 @@
> -#ifndef _IIO_UTILS_H_
> -#define _IIO_UTILS_H_
> -
> -/* IIO - useful set of util functionality
> - *
> - * Copyright (c) 2008 Jonathan Cameron
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - */
> -
> -#include <stdint.h>
> -
> -/* Made up value to limit allocation sizes */
> -#define IIO_MAX_NAME_LENGTH 30
> -
> -#define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
> -#define FORMAT_TYPE_FILE "%s_type"
> -
> -extern const char *iio_dir;
> -
> -/**
> - * struct iio_channel_info - information about a given channel
> - * @name: channel name
> - * @generic_name: general name for channel type
> - * @scale: scale factor to be applied for conversion to si units
> - * @offset: offset to be applied for conversion to si units
> - * @index: the channel index in the buffer output
> - * @bytes: number of bytes occupied in buffer output
> - * @mask: a bit mask for the raw output
> - * @is_signed: is the raw value stored signed
> - * @enabled: is this channel enabled
> - **/
> -struct iio_channel_info {
> -	char *name;
> -	char *generic_name;
> -	float scale;
> -	float offset;
> -	unsigned index;
> -	unsigned bytes;
> -	unsigned bits_used;
> -	unsigned shift;
> -	uint64_t mask;
> -	unsigned be;
> -	unsigned is_signed;
> -	unsigned location;
> -};
> -
> -int iioutils_break_up_name(const char *full_name, char **generic_name);
> -int iioutils_get_type(unsigned *is_signed, unsigned *bytes,
> -					  unsigned *bits_used, unsigned *shift,
> -					  uint64_t *mask, unsigned *be,
> -					  const char *device_dir, const char *name,
> -					  const char *generic_name);
> -int iioutils_get_param_float(float *output, const char *param_name,
> -							 const char *device_dir, const char *name,
> -							 const char *generic_name);
> -void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt);
> -int build_channel_array(const char *device_dir,
> -						struct iio_channel_info **ci_array, int *counter);
> -int find_type_by_name(const char *name, const char *type);
> -int write_sysfs_int(char *filename, char *basedir, int val);
> -int write_sysfs_int_and_verify(char *filename, char *basedir, int val);
> -int write_sysfs_string_and_verify(char *filename, char *basedir, char *val);
> -int write_sysfs_string(char *filename, char *basedir, char *val);
> -int read_sysfs_posint(char *filename, char *basedir);
> -int read_sysfs_float(char *filename, char *basedir, float *val);
> -int read_sysfs_string(const char *filename, const char *basedir, char *str);
> -
> -#endif /* _IIO_UTILS_H_ */
> diff --git a/drivers/staging/iio/Documentation/lsiio.c b/drivers/staging/iio/Documentation/lsiio.c
> deleted file mode 100644
> index 98a0de0..0000000
> --- a/drivers/staging/iio/Documentation/lsiio.c
> +++ /dev/null
> @@ -1,163 +0,0 @@
> -/*
> - * Industrial I/O utilities - lsiio.c
> - *
> - * Copyright (c) 2010 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
> - */
> -
> -#include <string.h>
> -#include <dirent.h>
> -#include <stdio.h>
> -#include <errno.h>
> -#include <stdint.h>
> -#include <stdlib.h>
> -#include <unistd.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <sys/dir.h>
> -#include "iio_utils.h"
> -
> -
> -static enum verbosity {
> -	VERBLEVEL_DEFAULT,	/* 0 gives lspci behaviour */
> -	VERBLEVEL_SENSORS,	/* 1 lists sensors */
> -} verblevel = VERBLEVEL_DEFAULT;
> -
> -const char *type_device = "iio:device";
> -const char *type_trigger = "trigger";
> -
> -
> -static inline int check_prefix(const char *str, const char *prefix)
> -{
> -	return strlen(str) > strlen(prefix) &&
> -		strncmp(str, prefix, strlen(prefix)) == 0;
> -}
> -
> -static inline int check_postfix(const char *str, const char *postfix)
> -{
> -	return strlen(str) > strlen(postfix) &&
> -		strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
> -}
> -
> -static int dump_channels(const char *dev_dir_name)
> -{
> -	DIR *dp;
> -	const struct dirent *ent;
> -
> -	dp = opendir(dev_dir_name);
> -	if (dp == NULL)
> -		return -errno;
> -	while (ent = readdir(dp), ent != NULL)
> -		if (check_prefix(ent->d_name, "in_") &&
> -		    check_postfix(ent->d_name, "_raw")) {
> -			printf("   %-10s\n", ent->d_name);
> -		}
> -
> -	return 0;
> -}
> -
> -static int dump_one_device(const char *dev_dir_name)
> -{
> -	char name[IIO_MAX_NAME_LENGTH];
> -	int dev_idx;
> -	int retval;
> -
> -	retval = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_device),
> -			"%i", &dev_idx);
> -	if (retval != 1)
> -		return -EINVAL;
> -	read_sysfs_string("name", dev_dir_name, name);
> -	printf("Device %03d: %s\n", dev_idx, name);
> -
> -	if (verblevel >= VERBLEVEL_SENSORS)
> -		return dump_channels(dev_dir_name);
> -	return 0;
> -}
> -
> -static int dump_one_trigger(const char *dev_dir_name)
> -{
> -	char name[IIO_MAX_NAME_LENGTH];
> -	int dev_idx;
> -	int retval;
> -
> -	retval = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_trigger),
> -			"%i", &dev_idx);
> -	if (retval != 1)
> -		return -EINVAL;
> -	read_sysfs_string("name", dev_dir_name, name);
> -	printf("Trigger %03d: %s\n", dev_idx, name);
> -	return 0;
> -}
> -
> -static void dump_devices(void)
> -{
> -	const struct dirent *ent;
> -	int number, numstrlen;
> -
> -	FILE *nameFile;
> -	DIR *dp;
> -	char thisname[IIO_MAX_NAME_LENGTH];
> -	char *filename;
> -
> -	dp = opendir(iio_dir);
> -	if (dp == NULL) {
> -		printf("No industrial I/O devices available\n");
> -		return;
> -	}
> -
> -	while (ent = readdir(dp), ent != NULL) {
> -		if (check_prefix(ent->d_name, type_device)) {
> -			char *dev_dir_name;
> -
> -			asprintf(&dev_dir_name, "%s%s", iio_dir, ent->d_name);
> -			dump_one_device(dev_dir_name);
> -			free(dev_dir_name);
> -			if (verblevel >= VERBLEVEL_SENSORS)
> -				printf("\n");
> -		}
> -	}
> -	rewinddir(dp);
> -	while (ent = readdir(dp), ent != NULL) {
> -		if (check_prefix(ent->d_name, type_trigger)) {
> -			char *dev_dir_name;
> -
> -			asprintf(&dev_dir_name, "%s%s", iio_dir, ent->d_name);
> -			dump_one_trigger(dev_dir_name);
> -			free(dev_dir_name);
> -		}
> -	}
> -	closedir(dp);
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	int c, err = 0;
> -
> -	while ((c = getopt(argc, argv, "d:D:v")) != EOF) {
> -		switch (c) {
> -		case 'v':
> -			verblevel++;
> -			break;
> -
> -		case '?':
> -		default:
> -			err++;
> -			break;
> -		}
> -	}
> -	if (err || argc > optind) {
> -		fprintf(stderr, "Usage: lsiio [options]...\n"
> -			"List industrial I/O devices\n"
> -			"  -v, --verbose\n"
> -			"      Increase verbosity (may be given multiple times)\n"
> -			);
> -		exit(1);
> -	}
> -
> -	dump_devices();
> -
> -	return 0;
> -}
> diff --git a/tools/iio/Makefile b/tools/iio/Makefile
> new file mode 100644
> index 0000000..83813ad
> --- /dev/null
> +++ b/tools/iio/Makefile
> @@ -0,0 +1,16 @@
> +CC = gcc
> +CFLAGS = -Wall -g
> +
> +all: iio_event_monitor lsiio generic_buffer
> +
> +iio_event_monitor: iio_event_monitor.o iio_utils.o
> +
> +lsiio: lsiio.o iio_utils.o
> +
> +generic_buffer: generic_buffer.o iio_utils.o
> +
> +%.o: %.c iio_utils.h
> +
> +.PHONY: clean
> +clean:
> +	rm -f *.o iio_event_monitor lsiio generic_buffer
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> new file mode 100644
> index 0000000..01266c2
> --- /dev/null
> +++ b/tools/iio/generic_buffer.c
> @@ -0,0 +1,361 @@
> +/* Industrialio buffer test code.
> + *
> + * Copyright (c) 2008 Jonathan Cameron
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is primarily intended as an example application.
> + * Reads the current buffer setup from sysfs and starts a short capture
> + * from the specified device, pretty printing the result after appropriate
> + * conversion.
> + *
> + * Command line parameters
> + * generic_buffer -n <device_name> -t <trigger_name>
> + * If trigger name is not specified the program assumes you want a dataready
> + * trigger associated with the device and goes looking for it.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <dirent.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <sys/stat.h>
> +#include <sys/dir.h>
> +#include <linux/types.h>
> +#include <string.h>
> +#include <poll.h>
> +#include <endian.h>
> +#include <getopt.h>
> +#include <inttypes.h>
> +#include "iio_utils.h"
> +
> +/**
> + * size_from_channelarray() - calculate the storage size of a scan
> + * @channels:		the channel info array
> + * @num_channels:	number of channels
> + *
> + * Has the side effect of filling the channels[i].location values used
> + * in processing the buffer output.
> + **/
> +int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
> +{
> +	int bytes = 0;
> +	int i = 0;
> +
> +	while (i < num_channels) {
> +		if (bytes % channels[i].bytes == 0)
> +			channels[i].location = bytes;
> +		else
> +			channels[i].location = bytes - bytes%channels[i].bytes
> +				+ channels[i].bytes;
> +		bytes = channels[i].location + channels[i].bytes;
> +		i++;
> +	}
> +	return bytes;
> +}
> +
> +void print2byte(int input, struct iio_channel_info *info)
> +{
> +	/* First swap if incorrect endian */
> +	if (info->be)
> +		input = be16toh((uint16_t)input);
> +	else
> +		input = le16toh((uint16_t)input);
> +
> +	/*
> +	 * Shift before conversion to avoid sign extension
> +	 * of left aligned data
> +	 */
> +	input = input >> info->shift;
> +	if (info->is_signed) {
> +		int16_t val = input;
> +
> +		val &= (1 << info->bits_used) - 1;
> +		val = (int16_t)(val << (16 - info->bits_used)) >>
> +			(16 - info->bits_used);
> +		printf("%05f ", ((float)val + info->offset)*info->scale);
> +	} else {
> +		uint16_t val = input;
> +
> +		val &= (1 << info->bits_used) - 1;
> +		printf("%05f ", ((float)val + info->offset)*info->scale);
> +	}
> +}
> +/**
> + * process_scan() - print out the values in SI units
> + * @data:		pointer to the start of the scan
> + * @channels:		information about the channels. Note
> + *  size_from_channelarray must have been called first to fill the
> + *  location offsets.
> + * @num_channels:	number of channels
> + **/
> +void process_scan(char *data,
> +		  struct iio_channel_info *channels,
> +		  int num_channels)
> +{
> +	int k;
> +
> +	for (k = 0; k < num_channels; k++)
> +		switch (channels[k].bytes) {
> +			/* only a few cases implemented so far */
> +		case 2:
> +			print2byte(*(uint16_t *)(data + channels[k].location),
> +				   &channels[k]);
> +			break;
> +		case 4:
> +			if (!channels[k].is_signed) {
> +				uint32_t val = *(uint32_t *)
> +					(data + channels[k].location);
> +				printf("%05f ", ((float)val +
> +						 channels[k].offset)*
> +				       channels[k].scale);
> +
> +			}
> +			break;
> +		case 8:
> +			if (channels[k].is_signed) {
> +				int64_t val = *(int64_t *)
> +					(data +
> +					 channels[k].location);
> +				if ((val >> channels[k].bits_used) & 1)
> +					val = (val & channels[k].mask) |
> +						~channels[k].mask;
> +				/* special case for timestamp */
> +				if (channels[k].scale == 1.0f &&
> +				    channels[k].offset == 0.0f)
> +					printf("%" PRId64 " ", val);
> +				else
> +					printf("%05f ", ((float)val +
> +							 channels[k].offset)*
> +					       channels[k].scale);
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	printf("\n");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	unsigned long num_loops = 2;
> +	unsigned long timedelay = 1000000;
> +	unsigned long buf_len = 128;
> +
> +	int ret, c, i, j, toread;
> +	int fp;
> +
> +	int num_channels;
> +	char *trigger_name = NULL, *device_name = NULL;
> +	char *dev_dir_name, *buf_dir_name;
> +
> +	int datardytrigger = 1;
> +	char *data;
> +	ssize_t read_size;
> +	int dev_num, trig_num;
> +	char *buffer_access;
> +	int scan_size;
> +	int noevents = 0;
> +	int notrigger = 0;
> +	char *dummy;
> +
> +	struct iio_channel_info *channels;
> +
> +	while ((c = getopt(argc, argv, "l:w:c:et:n:g")) != -1) {
> +		switch (c) {
> +		case 'n':
> +			device_name = optarg;
> +			break;
> +		case 't':
> +			trigger_name = optarg;
> +			datardytrigger = 0;
> +			break;
> +		case 'e':
> +			noevents = 1;
> +			break;
> +		case 'c':
> +			num_loops = strtoul(optarg, &dummy, 10);
> +			break;
> +		case 'w':
> +			timedelay = strtoul(optarg, &dummy, 10);
> +			break;
> +		case 'l':
> +			buf_len = strtoul(optarg, &dummy, 10);
> +			break;
> +		case 'g':
> +			notrigger = 1;
> +			break;
> +		case '?':
> +			return -1;
> +		}
> +	}
> +
> +	if (device_name == NULL)
> +		return -1;
> +
> +	/* Find the device requested */
> +	dev_num = find_type_by_name(device_name, "iio:device");
> +	if (dev_num < 0) {
> +		printf("Failed to find the %s\n", device_name);
> +		ret = -ENODEV;
> +		goto error_ret;
> +	}
> +	printf("iio device number being used is %d\n", dev_num);
> +
> +	asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
> +
> +	if (!notrigger) {
> +		if (trigger_name == NULL) {
> +			/*
> +			 * Build the trigger name. If it is device associated
> +			 * its name is <device_name>_dev[n] where n matches
> +			 * the device number found above.
> +			 */
> +			ret = asprintf(&trigger_name,
> +				       "%s-dev%d", device_name, dev_num);
> +			if (ret < 0) {
> +				ret = -ENOMEM;
> +				goto error_ret;
> +			}
> +		}
> +
> +		/* Verify the trigger exists */
> +		trig_num = find_type_by_name(trigger_name, "trigger");
> +		if (trig_num < 0) {
> +			printf("Failed to find the trigger %s\n", trigger_name);
> +			ret = -ENODEV;
> +			goto error_free_triggername;
> +		}
> +		printf("iio trigger number being used is %d\n", trig_num);
> +	} else
> +		printf("trigger-less mode selected\n");
> +
> +	/*
> +	 * Parse the files in scan_elements to identify what channels are
> +	 * present
> +	 */
> +	ret = build_channel_array(dev_dir_name, &channels, &num_channels);
> +	if (ret) {
> +		printf("Problem reading scan element information\n");
> +		printf("diag %s\n", dev_dir_name);
> +		goto error_free_triggername;
> +	}
> +
> +	/*
> +	 * Construct the directory name for the associated buffer.
> +	 * As we know that the lis3l02dq has only one buffer this may
> +	 * be built rather than found.
> +	 */
> +	ret = asprintf(&buf_dir_name,
> +		       "%siio:device%d/buffer", iio_dir, dev_num);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_free_triggername;
> +	}
> +
> +	if (!notrigger) {
> +		printf("%s %s\n", dev_dir_name, trigger_name);
> +		/* Set the device trigger to be the data ready trigger found
> +		 * above */
> +		ret = write_sysfs_string_and_verify("trigger/current_trigger",
> +						    dev_dir_name,
> +						    trigger_name);
> +		if (ret < 0) {
> +			printf("Failed to write current_trigger file\n");
> +			goto error_free_buf_dir_name;
> +		}
> +	}
> +
> +	/* Setup ring buffer parameters */
> +	ret = write_sysfs_int("length", buf_dir_name, buf_len);
> +	if (ret < 0)
> +		goto error_free_buf_dir_name;
> +
> +	/* Enable the buffer */
> +	ret = write_sysfs_int("enable", buf_dir_name, 1);
> +	if (ret < 0)
> +		goto error_free_buf_dir_name;
> +	scan_size = size_from_channelarray(channels, num_channels);
> +	data = malloc(scan_size*buf_len);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto error_free_buf_dir_name;
> +	}
> +
> +	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_free_data;
> +	}
> +
> +	/* Attempt to open non blocking the access dev */
> +	fp = open(buffer_access, O_RDONLY | O_NONBLOCK);
> +	if (fp == -1) { /* If it isn't there make the node */
> +		printf("Failed to open %s\n", buffer_access);
> +		ret = -errno;
> +		goto error_free_buffer_access;
> +	}
> +
> +	/* Wait for events 10 times */
> +	for (j = 0; j < num_loops; j++) {
> +		if (!noevents) {
> +			struct pollfd pfd = {
> +				.fd = fp,
> +				.events = POLLIN,
> +			};
> +
> +			poll(&pfd, 1, -1);
> +			toread = buf_len;
> +
> +		} else {
> +			usleep(timedelay);
> +			toread = 64;
> +		}
> +
> +		read_size = read(fp,
> +				 data,
> +				 toread*scan_size);
> +		if (read_size < 0) {
> +			if (errno == -EAGAIN) {
> +				printf("nothing available\n");
> +				continue;
> +			} else
> +				break;
> +		}
> +		for (i = 0; i < read_size/scan_size; i++)
> +			process_scan(data + scan_size*i,
> +				     channels,
> +				     num_channels);
> +	}
> +
> +	/* Stop the buffer */
> +	ret = write_sysfs_int("enable", buf_dir_name, 0);
> +	if (ret < 0)
> +		goto error_close_buffer_access;
> +
> +	if (!notrigger)
> +		/* Disconnect the trigger - just write a dummy name. */
> +		write_sysfs_string("trigger/current_trigger",
> +				   dev_dir_name, "NULL");
> +
> +error_close_buffer_access:
> +	close(fp);
> +error_free_data:
> +	free(data);
> +error_free_buffer_access:
> +	free(buffer_access);
> +error_free_buf_dir_name:
> +	free(buf_dir_name);
> +error_free_triggername:
> +	if (datardytrigger)
> +		free(trigger_name);
> +error_ret:
> +	return ret;
> +}
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> new file mode 100644
> index 0000000..f19cff1
> --- /dev/null
> +++ b/tools/iio/iio_event_monitor.c
> @@ -0,0 +1,310 @@
> +/* Industrialio event test code.
> + *
> + * Copyright (c) 2011-2012 Lars-Peter Clausen <lars@metafoo.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + *
> + * This program is primarily intended as an example application.
> + * Reads the current buffer setup from sysfs and starts a short capture
> + * from the specified device, pretty printing the result after appropriate
> + * conversion.
> + *
> + * Usage:
> + *	iio_event_monitor <device_name>
> + *
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <poll.h>
> +#include <fcntl.h>
> +#include <sys/ioctl.h>
> +#include "iio_utils.h"
> +#include <linux/iio/events.h>
> +#include <linux/iio/types.h>
> +
> +static const char * const iio_chan_type_name_spec[] = {
> +	[IIO_VOLTAGE] = "voltage",
> +	[IIO_CURRENT] = "current",
> +	[IIO_POWER] = "power",
> +	[IIO_ACCEL] = "accel",
> +	[IIO_ANGL_VEL] = "anglvel",
> +	[IIO_MAGN] = "magn",
> +	[IIO_LIGHT] = "illuminance",
> +	[IIO_INTENSITY] = "intensity",
> +	[IIO_PROXIMITY] = "proximity",
> +	[IIO_TEMP] = "temp",
> +	[IIO_INCLI] = "incli",
> +	[IIO_ROT] = "rot",
> +	[IIO_ANGL] = "angl",
> +	[IIO_TIMESTAMP] = "timestamp",
> +	[IIO_CAPACITANCE] = "capacitance",
> +	[IIO_ALTVOLTAGE] = "altvoltage",
> +	[IIO_CCT] = "cct",
> +	[IIO_PRESSURE] = "pressure",
> +	[IIO_HUMIDITYRELATIVE] = "humidityrelative",
> +	[IIO_ACTIVITY] = "activity",
> +	[IIO_STEPS] = "steps",
> +};
> +
> +static const char * const iio_ev_type_text[] = {
> +	[IIO_EV_TYPE_THRESH] = "thresh",
> +	[IIO_EV_TYPE_MAG] = "mag",
> +	[IIO_EV_TYPE_ROC] = "roc",
> +	[IIO_EV_TYPE_THRESH_ADAPTIVE] = "thresh_adaptive",
> +	[IIO_EV_TYPE_MAG_ADAPTIVE] = "mag_adaptive",
> +	[IIO_EV_TYPE_CHANGE] = "change",
> +};
> +
> +static const char * const iio_ev_dir_text[] = {
> +	[IIO_EV_DIR_EITHER] = "either",
> +	[IIO_EV_DIR_RISING] = "rising",
> +	[IIO_EV_DIR_FALLING] = "falling"
> +};
> +
> +static const char * const iio_modifier_names[] = {
> +	[IIO_MOD_X] = "x",
> +	[IIO_MOD_Y] = "y",
> +	[IIO_MOD_Z] = "z",
> +	[IIO_MOD_X_AND_Y] = "x&y",
> +	[IIO_MOD_X_AND_Z] = "x&z",
> +	[IIO_MOD_Y_AND_Z] = "y&z",
> +	[IIO_MOD_X_AND_Y_AND_Z] = "x&y&z",
> +	[IIO_MOD_X_OR_Y] = "x|y",
> +	[IIO_MOD_X_OR_Z] = "x|z",
> +	[IIO_MOD_Y_OR_Z] = "y|z",
> +	[IIO_MOD_X_OR_Y_OR_Z] = "x|y|z",
> +	[IIO_MOD_LIGHT_BOTH] = "both",
> +	[IIO_MOD_LIGHT_IR] = "ir",
> +	[IIO_MOD_ROOT_SUM_SQUARED_X_Y] = "sqrt(x^2+y^2)",
> +	[IIO_MOD_SUM_SQUARED_X_Y_Z] = "x^2+y^2+z^2",
> +	[IIO_MOD_LIGHT_CLEAR] = "clear",
> +	[IIO_MOD_LIGHT_RED] = "red",
> +	[IIO_MOD_LIGHT_GREEN] = "green",
> +	[IIO_MOD_LIGHT_BLUE] = "blue",
> +	[IIO_MOD_QUATERNION] = "quaternion",
> +	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> +	[IIO_MOD_TEMP_OBJECT] = "object",
> +	[IIO_MOD_NORTH_MAGN] = "from_north_magnetic",
> +	[IIO_MOD_NORTH_TRUE] = "from_north_true",
> +	[IIO_MOD_NORTH_MAGN_TILT_COMP] = "from_north_magnetic_tilt_comp",
> +	[IIO_MOD_NORTH_TRUE_TILT_COMP] = "from_north_true_tilt_comp",
> +	[IIO_MOD_RUNNING] = "running",
> +	[IIO_MOD_JOGGING] = "jogging",
> +	[IIO_MOD_WALKING] = "walking",
> +	[IIO_MOD_STILL] = "still",
> +};
> +
> +static bool event_is_known(struct iio_event_data *event)
> +{
> +	enum iio_chan_type type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event->id);
> +	enum iio_modifier mod = IIO_EVENT_CODE_EXTRACT_MODIFIER(event->id);
> +	enum iio_event_type ev_type = IIO_EVENT_CODE_EXTRACT_TYPE(event->id);
> +	enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(event->id);
> +
> +	switch (type) {
> +	case IIO_VOLTAGE:
> +	case IIO_CURRENT:
> +	case IIO_POWER:
> +	case IIO_ACCEL:
> +	case IIO_ANGL_VEL:
> +	case IIO_MAGN:
> +	case IIO_LIGHT:
> +	case IIO_INTENSITY:
> +	case IIO_PROXIMITY:
> +	case IIO_TEMP:
> +	case IIO_INCLI:
> +	case IIO_ROT:
> +	case IIO_ANGL:
> +	case IIO_TIMESTAMP:
> +	case IIO_CAPACITANCE:
> +	case IIO_ALTVOLTAGE:
> +	case IIO_CCT:
> +	case IIO_PRESSURE:
> +	case IIO_HUMIDITYRELATIVE:
> +	case IIO_ACTIVITY:
> +	case IIO_STEPS:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	switch (mod) {
> +	case IIO_NO_MOD:
> +	case IIO_MOD_X:
> +	case IIO_MOD_Y:
> +	case IIO_MOD_Z:
> +	case IIO_MOD_X_AND_Y:
> +	case IIO_MOD_X_AND_Z:
> +	case IIO_MOD_Y_AND_Z:
> +	case IIO_MOD_X_AND_Y_AND_Z:
> +	case IIO_MOD_X_OR_Y:
> +	case IIO_MOD_X_OR_Z:
> +	case IIO_MOD_Y_OR_Z:
> +	case IIO_MOD_X_OR_Y_OR_Z:
> +	case IIO_MOD_LIGHT_BOTH:
> +	case IIO_MOD_LIGHT_IR:
> +	case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
> +	case IIO_MOD_SUM_SQUARED_X_Y_Z:
> +	case IIO_MOD_LIGHT_CLEAR:
> +	case IIO_MOD_LIGHT_RED:
> +	case IIO_MOD_LIGHT_GREEN:
> +	case IIO_MOD_LIGHT_BLUE:
> +	case IIO_MOD_QUATERNION:
> +	case IIO_MOD_TEMP_AMBIENT:
> +	case IIO_MOD_TEMP_OBJECT:
> +	case IIO_MOD_NORTH_MAGN:
> +	case IIO_MOD_NORTH_TRUE:
> +	case IIO_MOD_NORTH_MAGN_TILT_COMP:
> +	case IIO_MOD_NORTH_TRUE_TILT_COMP:
> +	case IIO_MOD_RUNNING:
> +	case IIO_MOD_JOGGING:
> +	case IIO_MOD_WALKING:
> +	case IIO_MOD_STILL:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	switch (ev_type) {
> +	case IIO_EV_TYPE_THRESH:
> +	case IIO_EV_TYPE_MAG:
> +	case IIO_EV_TYPE_ROC:
> +	case IIO_EV_TYPE_THRESH_ADAPTIVE:
> +	case IIO_EV_TYPE_MAG_ADAPTIVE:
> +	case IIO_EV_TYPE_CHANGE:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	switch (dir) {
> +	case IIO_EV_DIR_EITHER:
> +	case IIO_EV_DIR_RISING:
> +	case IIO_EV_DIR_FALLING:
> +	case IIO_EV_DIR_NONE:
> +		break;
> +	default:
> +		return false;
> +	}
> +
> +	return true;
> +}
> +
> +static void print_event(struct iio_event_data *event)
> +{
> +	enum iio_chan_type type = IIO_EVENT_CODE_EXTRACT_CHAN_TYPE(event->id);
> +	enum iio_modifier mod = IIO_EVENT_CODE_EXTRACT_MODIFIER(event->id);
> +	enum iio_event_type ev_type = IIO_EVENT_CODE_EXTRACT_TYPE(event->id);
> +	enum iio_event_direction dir = IIO_EVENT_CODE_EXTRACT_DIR(event->id);
> +	int chan = IIO_EVENT_CODE_EXTRACT_CHAN(event->id);
> +	int chan2 = IIO_EVENT_CODE_EXTRACT_CHAN2(event->id);
> +	bool diff = IIO_EVENT_CODE_EXTRACT_DIFF(event->id);
> +
> +	if (!event_is_known(event)) {
> +		printf("Unknown event: time: %lld, id: %llx\n",
> +				event->timestamp, event->id);
> +		return;
> +	}
> +
> +	printf("Event: time: %lld, ", event->timestamp);
> +
> +	if (mod != IIO_NO_MOD) {
> +		printf("type: %s(%s), ",
> +			iio_chan_type_name_spec[type],
> +			iio_modifier_names[mod]);
> +	} else {
> +		printf("type: %s, ",
> +			iio_chan_type_name_spec[type]);
> +	}
> +
> +	if (diff && chan >= 0 && chan2 >= 0)
> +		printf("channel: %d-%d, ", chan, chan2);
> +	else if (chan >= 0)
> +		printf("channel: %d, ", chan);
> +
> +	printf("evtype: %s", iio_ev_type_text[ev_type]);
> +
> +	if (dir != IIO_EV_DIR_NONE)
> +		printf(", direction: %s", iio_ev_dir_text[dir]);
> +	printf("\n");
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct iio_event_data event;
> +	const char *device_name;
> +	char *chrdev_name;
> +	int ret;
> +	int dev_num;
> +	int fd, event_fd;
> +
> +	if (argc <= 1) {
> +		printf("Usage: %s <device_name>\n", argv[0]);
> +		return -1;
> +	}
> +
> +	device_name = argv[1];
> +
> +	dev_num = find_type_by_name(device_name, "iio:device");
> +	if (dev_num >= 0) {
> +		printf("Found IIO device with name %s with device number %d\n",
> +			device_name, dev_num);
> +		ret = asprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
> +		if (ret < 0) {
> +			ret = -ENOMEM;
> +			goto error_ret;
> +		}
> +	} else {
> +		/* If we can't find a IIO device by name assume device_name is a
> +		   IIO chrdev */
> +		chrdev_name = strdup(device_name);
> +	}
> +
> +	fd = open(chrdev_name, 0);
> +	if (fd == -1) {
> +		fprintf(stdout, "Failed to open %s\n", chrdev_name);
> +		ret = -errno;
> +		goto error_free_chrdev_name;
> +	}
> +
> +	ret = ioctl(fd, IIO_GET_EVENT_FD_IOCTL, &event_fd);
> +
> +	close(fd);
> +
> +	if (ret == -1 || event_fd == -1) {
> +		fprintf(stdout, "Failed to retrieve event fd\n");
> +		ret = -errno;
> +		goto error_free_chrdev_name;
> +	}
> +
> +	while (true) {
> +		ret = read(event_fd, &event, sizeof(event));
> +		if (ret == -1) {
> +			if (errno == EAGAIN) {
> +				printf("nothing available\n");
> +				continue;
> +			} else {
> +				perror("Failed to read event from device");
> +				ret = -errno;
> +				break;
> +			}
> +		}
> +
> +		print_event(&event);
> +	}
> +
> +	close(event_fd);
> +error_free_chrdev_name:
> +	free(chrdev_name);
> +error_ret:
> +	return ret;
> +}
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> new file mode 100644
> index 0000000..aea9282
> --- /dev/null
> +++ b/tools/iio/iio_utils.c
> @@ -0,0 +1,651 @@
> +/* IIO - useful set of util functionality
> + *
> + * Copyright (c) 2008 Jonathan Cameron
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <string.h>
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <stdint.h>
> +#include <dirent.h>
> +#include <errno.h>
> +#include <ctype.h>
> +#include "iio_utils.h"
> +
> +const char *iio_dir = "/sys/bus/iio/devices/";
> +
> +/**
> + * iioutils_break_up_name() - extract generic name from full channel name
> + * @full_name: the full channel name
> + * @generic_name: the output generic channel name
> + **/
> +int iioutils_break_up_name(const char *full_name,
> +				  char **generic_name)
> +{
> +	char *current;
> +	char *w, *r;
> +	char *working;
> +
> +	current = strdup(full_name);
> +	working = strtok(current, "_\0");
> +	w = working;
> +	r = working;
> +
> +	while (*r != '\0') {
> +		if (!isdigit(*r)) {
> +			*w = *r;
> +			w++;
> +		}
> +		r++;
> +	}
> +	*w = '\0';
> +	*generic_name = strdup(working);
> +	free(current);
> +
> +	return 0;
> +}
> +
> +/**
> + * iioutils_get_type() - find and process _type attribute data
> + * @is_signed: output whether channel is signed
> + * @bytes: output how many bytes the channel storage occupies
> + * @mask: output a bit mask for the raw data
> + * @be: big endian
> + * @device_dir: the iio device directory
> + * @name: the channel name
> + * @generic_name: the channel type name
> + **/
> +int iioutils_get_type(unsigned *is_signed,
> +			     unsigned *bytes,
> +			     unsigned *bits_used,
> +			     unsigned *shift,
> +			     uint64_t *mask,
> +			     unsigned *be,
> +			     const char *device_dir,
> +			     const char *name,
> +			     const char *generic_name)
> +{
> +	FILE *sysfsfp;
> +	int ret;
> +	DIR *dp;
> +	char *scan_el_dir, *builtname, *builtname_generic, *filename = 0;
> +	char signchar, endianchar;
> +	unsigned padint;
> +	const struct dirent *ent;
> +
> +	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	ret = asprintf(&builtname, FORMAT_TYPE_FILE, name);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_free_scan_el_dir;
> +	}
> +	ret = asprintf(&builtname_generic, FORMAT_TYPE_FILE, generic_name);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_free_builtname;
> +	}
> +
> +	dp = opendir(scan_el_dir);
> +	if (dp == NULL) {
> +		ret = -errno;
> +		goto error_free_builtname_generic;
> +	}
> +	while (ent = readdir(dp), ent != NULL)
> +		/*
> +		 * Do we allow devices to override a generic name with
> +		 * a specific one?
> +		 */
> +		if ((strcmp(builtname, ent->d_name) == 0) ||
> +		    (strcmp(builtname_generic, ent->d_name) == 0)) {
> +			ret = asprintf(&filename,
> +				       "%s/%s", scan_el_dir, ent->d_name);
> +			if (ret < 0) {
> +				ret = -ENOMEM;
> +				goto error_closedir;
> +			}
> +			sysfsfp = fopen(filename, "r");
> +			if (sysfsfp == NULL) {
> +				printf("failed to open %s\n", filename);
> +				ret = -errno;
> +				goto error_free_filename;
> +			}
> +
> +			ret = fscanf(sysfsfp,
> +				     "%ce:%c%u/%u>>%u",
> +				     &endianchar,
> +				     &signchar,
> +				     bits_used,
> +				     &padint, shift);
> +			if (ret < 0) {
> +				printf("failed to pass scan type description\n");
> +				ret = -errno;
> +				goto error_close_sysfsfp;
> +			}
> +			*be = (endianchar == 'b');
> +			*bytes = padint / 8;
> +			if (*bits_used == 64)
> +				*mask = ~0;
> +			else
> +				*mask = (1 << *bits_used) - 1;
> +			if (signchar == 's')
> +				*is_signed = 1;
> +			else
> +				*is_signed = 0;
> +			fclose(sysfsfp);
> +			free(filename);
> +
> +			filename = 0;
> +			sysfsfp = 0;
> +		}
> +error_close_sysfsfp:
> +	if (sysfsfp)
> +		fclose(sysfsfp);
> +error_free_filename:
> +	if (filename)
> +		free(filename);
> +error_closedir:
> +	closedir(dp);
> +error_free_builtname_generic:
> +	free(builtname_generic);
> +error_free_builtname:
> +	free(builtname);
> +error_free_scan_el_dir:
> +	free(scan_el_dir);
> +error_ret:
> +	return ret;
> +}
> +
> +int iioutils_get_param_float(float *output,
> +				    const char *param_name,
> +				    const char *device_dir,
> +				    const char *name,
> +				    const char *generic_name)
> +{
> +	FILE *sysfsfp;
> +	int ret;
> +	DIR *dp;
> +	char *builtname, *builtname_generic;
> +	char *filename = NULL;
> +	const struct dirent *ent;
> +
> +	ret = asprintf(&builtname, "%s_%s", name, param_name);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	ret = asprintf(&builtname_generic,
> +		       "%s_%s", generic_name, param_name);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_free_builtname;
> +	}
> +	dp = opendir(device_dir);
> +	if (dp == NULL) {
> +		ret = -errno;
> +		goto error_free_builtname_generic;
> +	}
> +	while (ent = readdir(dp), ent != NULL)
> +		if ((strcmp(builtname, ent->d_name) == 0) ||
> +		    (strcmp(builtname_generic, ent->d_name) == 0)) {
> +			ret = asprintf(&filename,
> +				       "%s/%s", device_dir, ent->d_name);
> +			if (ret < 0) {
> +				ret = -ENOMEM;
> +				goto error_closedir;
> +			}
> +			sysfsfp = fopen(filename, "r");
> +			if (!sysfsfp) {
> +				ret = -errno;
> +				goto error_free_filename;
> +			}
> +			fscanf(sysfsfp, "%f", output);
> +			break;
> +		}
> +error_free_filename:
> +	if (filename)
> +		free(filename);
> +error_closedir:
> +	closedir(dp);
> +error_free_builtname_generic:
> +	free(builtname_generic);
> +error_free_builtname:
> +	free(builtname);
> +error_ret:
> +	return ret;
> +}
> +
> +/**
> + * bsort_channel_array_by_index() - reorder so that the array is in index order
> + *
> + **/
> +
> +void bsort_channel_array_by_index(struct iio_channel_info **ci_array,
> +					 int cnt)
> +{
> +
> +	struct iio_channel_info temp;
> +	int x, y;
> +
> +	for (x = 0; x < cnt; x++)
> +		for (y = 0; y < (cnt - 1); y++)
> +			if ((*ci_array)[y].index > (*ci_array)[y+1].index) {
> +				temp = (*ci_array)[y + 1];
> +				(*ci_array)[y + 1] = (*ci_array)[y];
> +				(*ci_array)[y] = temp;
> +			}
> +}
> +
> +/**
> + * build_channel_array() - function to figure out what channels are present
> + * @device_dir: the IIO device directory in sysfs
> + * @
> + **/
> +int build_channel_array(const char *device_dir,
> +			      struct iio_channel_info **ci_array,
> +			      int *counter)
> +{
> +	DIR *dp;
> +	FILE *sysfsfp;
> +	int count, i;
> +	struct iio_channel_info *current;
> +	int ret;
> +	const struct dirent *ent;
> +	char *scan_el_dir;
> +	char *filename;
> +
> +	*counter = 0;
> +	ret = asprintf(&scan_el_dir, FORMAT_SCAN_ELEMENTS_DIR, device_dir);
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error_ret;
> +	}
> +	dp = opendir(scan_el_dir);
> +	if (dp == NULL) {
> +		ret = -errno;
> +		goto error_free_name;
> +	}
> +	while (ent = readdir(dp), ent != NULL)
> +		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
> +			   "_en") == 0) {
> +			ret = asprintf(&filename,
> +				       "%s/%s", scan_el_dir, ent->d_name);
> +			if (ret < 0) {
> +				ret = -ENOMEM;
> +				goto error_close_dir;
> +			}
> +			sysfsfp = fopen(filename, "r");
> +			if (sysfsfp == NULL) {
> +				ret = -errno;
> +				free(filename);
> +				goto error_close_dir;
> +			}
> +			fscanf(sysfsfp, "%i", &ret);
> +			if (ret == 1)
> +				(*counter)++;
> +			fclose(sysfsfp);
> +			free(filename);
> +		}
> +	*ci_array = malloc(sizeof(**ci_array) * (*counter));
> +	if (*ci_array == NULL) {
> +		ret = -ENOMEM;
> +		goto error_close_dir;
> +	}
> +	seekdir(dp, 0);
> +	count = 0;
> +	while (ent = readdir(dp), ent != NULL) {
> +		if (strcmp(ent->d_name + strlen(ent->d_name) - strlen("_en"),
> +			   "_en") == 0) {
> +			int current_enabled = 0;
> +
> +			current = &(*ci_array)[count++];
> +			ret = asprintf(&filename,
> +				       "%s/%s", scan_el_dir, ent->d_name);
> +			if (ret < 0) {
> +				ret = -ENOMEM;
> +				/* decrement count to avoid freeing name */
> +				count--;
> +				goto error_cleanup_array;
> +			}
> +			sysfsfp = fopen(filename, "r");
> +			if (sysfsfp == NULL) {
> +				free(filename);
> +				ret = -errno;
> +				goto error_cleanup_array;
> +			}
> +			fscanf(sysfsfp, "%i", &current_enabled);
> +			fclose(sysfsfp);
> +
> +			if (!current_enabled) {
> +				free(filename);
> +				count--;
> +				continue;
> +			}
> +
> +			current->scale = 1.0;
> +			current->offset = 0;
> +			current->name = strndup(ent->d_name,
> +						strlen(ent->d_name) -
> +						strlen("_en"));
> +			if (current->name == NULL) {
> +				free(filename);
> +				ret = -ENOMEM;
> +				goto error_cleanup_array;
> +			}
> +			/* Get the generic and specific name elements */
> +			ret = iioutils_break_up_name(current->name,
> +						     &current->generic_name);
> +			if (ret) {
> +				free(filename);
> +				goto error_cleanup_array;
> +			}
> +			ret = asprintf(&filename,
> +				       "%s/%s_index",
> +				       scan_el_dir,
> +				       current->name);
> +			if (ret < 0) {
> +				free(filename);
> +				ret = -ENOMEM;
> +				goto error_cleanup_array;
> +			}
> +			sysfsfp = fopen(filename, "r");
> +			fscanf(sysfsfp, "%u", &current->index);
> +			fclose(sysfsfp);
> +			free(filename);
> +			/* Find the scale */
> +			ret = iioutils_get_param_float(&current->scale,
> +						       "scale",
> +						       device_dir,
> +						       current->name,
> +						       current->generic_name);
> +			if (ret < 0)
> +				goto error_cleanup_array;
> +			ret = iioutils_get_param_float(&current->offset,
> +						       "offset",
> +						       device_dir,
> +						       current->name,
> +						       current->generic_name);
> +			if (ret < 0)
> +				goto error_cleanup_array;
> +			ret = iioutils_get_type(&current->is_signed,
> +						&current->bytes,
> +						&current->bits_used,
> +						&current->shift,
> +						&current->mask,
> +						&current->be,
> +						device_dir,
> +						current->name,
> +						current->generic_name);
> +		}
> +	}
> +
> +	closedir(dp);
> +	/* reorder so that the array is in index order */
> +	bsort_channel_array_by_index(ci_array, *counter);
> +
> +	return 0;
> +
> +error_cleanup_array:
> +	for (i = count - 1;  i >= 0; i--)
> +		free((*ci_array)[i].name);
> +	free(*ci_array);
> +error_close_dir:
> +	closedir(dp);
> +error_free_name:
> +	free(scan_el_dir);
> +error_ret:
> +	return ret;
> +}
> +
> +/**
> + * find_type_by_name() - function to match top level types by name
> + * @name: top level type instance name
> + * @type: the type of top level instance being sort
> + *
> + * Typical types this is used for are device and trigger.
> + **/
> +int find_type_by_name(const char *name, const char *type)
> +{
> +	const struct dirent *ent;
> +	int number, numstrlen;
> +
> +	FILE *nameFile;
> +	DIR *dp;
> +	char thisname[IIO_MAX_NAME_LENGTH];
> +	char *filename;
> +
> +	dp = opendir(iio_dir);
> +	if (dp == NULL) {
> +		printf("No industrialio devices available\n");
> +		return -ENODEV;
> +	}
> +
> +	while (ent = readdir(dp), ent != NULL) {
> +		if (strcmp(ent->d_name, ".") != 0 &&
> +			strcmp(ent->d_name, "..") != 0 &&
> +			strlen(ent->d_name) > strlen(type) &&
> +			strncmp(ent->d_name, type, strlen(type)) == 0) {
> +			numstrlen = sscanf(ent->d_name + strlen(type),
> +					   "%d",
> +					   &number);
> +			/* verify the next character is not a colon */
> +			if (strncmp(ent->d_name + strlen(type) + numstrlen,
> +					":",
> +					1) != 0) {
> +				filename = malloc(strlen(iio_dir)
> +						+ strlen(type)
> +						+ numstrlen
> +						+ 6);
> +				if (filename == NULL) {
> +					closedir(dp);
> +					return -ENOMEM;
> +				}
> +				sprintf(filename, "%s%s%d/name",
> +					iio_dir,
> +					type,
> +					number);
> +				nameFile = fopen(filename, "r");
> +				if (!nameFile) {
> +					free(filename);
> +					continue;
> +				}
> +				free(filename);
> +				fscanf(nameFile, "%s", thisname);
> +				fclose(nameFile);
> +				if (strcmp(name, thisname) == 0) {
> +					closedir(dp);
> +					return number;
> +				}
> +			}
> +		}
> +	}
> +	closedir(dp);
> +	return -ENODEV;
> +}
> +
> +int _write_sysfs_int(char *filename, char *basedir, int val, int verify)
> +{
> +	int ret = 0;
> +	FILE *sysfsfp;
> +	int test;
> +	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> +
> +	if (temp == NULL)
> +		return -ENOMEM;
> +	sprintf(temp, "%s/%s", basedir, filename);
> +	sysfsfp = fopen(temp, "w");
> +	if (sysfsfp == NULL) {
> +		printf("failed to open %s\n", temp);
> +		ret = -errno;
> +		goto error_free;
> +	}
> +	fprintf(sysfsfp, "%d", val);
> +	fclose(sysfsfp);
> +	if (verify) {
> +		sysfsfp = fopen(temp, "r");
> +		if (sysfsfp == NULL) {
> +			printf("failed to open %s\n", temp);
> +			ret = -errno;
> +			goto error_free;
> +		}
> +		fscanf(sysfsfp, "%d", &test);
> +		fclose(sysfsfp);
> +		if (test != val) {
> +			printf("Possible failure in int write %d to %s%s\n",
> +				val,
> +				basedir,
> +				filename);
> +			ret = -1;
> +		}
> +	}
> +error_free:
> +	free(temp);
> +	return ret;
> +}
> +
> +int write_sysfs_int(char *filename, char *basedir, int val)
> +{
> +	return _write_sysfs_int(filename, basedir, val, 0);
> +}
> +
> +int write_sysfs_int_and_verify(char *filename, char *basedir, int val)
> +{
> +	return _write_sysfs_int(filename, basedir, val, 1);
> +}
> +
> +int _write_sysfs_string(char *filename, char *basedir, char *val, int verify)
> +{
> +	int ret = 0;
> +	FILE  *sysfsfp;
> +	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> +
> +	if (temp == NULL) {
> +		printf("Memory allocation failed\n");
> +		return -ENOMEM;
> +	}
> +	sprintf(temp, "%s/%s", basedir, filename);
> +	sysfsfp = fopen(temp, "w");
> +	if (sysfsfp == NULL) {
> +		printf("Could not open %s\n", temp);
> +		ret = -errno;
> +		goto error_free;
> +	}
> +	fprintf(sysfsfp, "%s", val);
> +	fclose(sysfsfp);
> +	if (verify) {
> +		sysfsfp = fopen(temp, "r");
> +		if (sysfsfp == NULL) {
> +			printf("could not open file to verify\n");
> +			ret = -errno;
> +			goto error_free;
> +		}
> +		fscanf(sysfsfp, "%s", temp);
> +		fclose(sysfsfp);
> +		if (strcmp(temp, val) != 0) {
> +			printf("Possible failure in string write of %s "
> +				"Should be %s "
> +				"written to %s\%s\n",
> +				temp,
> +				val,
> +				basedir,
> +				filename);
> +			ret = -1;
> +		}
> +	}
> +error_free:
> +	free(temp);
> +
> +	return ret;
> +}
> +
> +/**
> + * write_sysfs_string_and_verify() - string write, readback and verify
> + * @filename: name of file to write to
> + * @basedir: the sysfs directory in which the file is to be found
> + * @val: the string to write
> + **/
> +int write_sysfs_string_and_verify(char *filename, char *basedir, char *val)
> +{
> +	return _write_sysfs_string(filename, basedir, val, 1);
> +}
> +
> +int write_sysfs_string(char *filename, char *basedir, char *val)
> +{
> +	return _write_sysfs_string(filename, basedir, val, 0);
> +}
> +
> +int read_sysfs_posint(char *filename, char *basedir)
> +{
> +	int ret;
> +	FILE  *sysfsfp;
> +	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> +
> +	if (temp == NULL) {
> +		printf("Memory allocation failed");
> +		return -ENOMEM;
> +	}
> +	sprintf(temp, "%s/%s", basedir, filename);
> +	sysfsfp = fopen(temp, "r");
> +	if (sysfsfp == NULL) {
> +		ret = -errno;
> +		goto error_free;
> +	}
> +	fscanf(sysfsfp, "%d\n", &ret);
> +	fclose(sysfsfp);
> +error_free:
> +	free(temp);
> +	return ret;
> +}
> +
> +int read_sysfs_float(char *filename, char *basedir, float *val)
> +{
> +	int ret = 0;
> +	FILE  *sysfsfp;
> +	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> +
> +	if (temp == NULL) {
> +		printf("Memory allocation failed");
> +		return -ENOMEM;
> +	}
> +	sprintf(temp, "%s/%s", basedir, filename);
> +	sysfsfp = fopen(temp, "r");
> +	if (sysfsfp == NULL) {
> +		ret = -errno;
> +		goto error_free;
> +	}
> +	fscanf(sysfsfp, "%f\n", val);
> +	fclose(sysfsfp);
> +error_free:
> +	free(temp);
> +	return ret;
> +}
> +
> +int read_sysfs_string(const char *filename, const char *basedir, char *str)
> +{
> +	int ret = 0;
> +	FILE  *sysfsfp;
> +	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> +
> +	if (temp == NULL) {
> +		printf("Memory allocation failed");
> +		return -ENOMEM;
> +	}
> +	sprintf(temp, "%s/%s", basedir, filename);
> +	sysfsfp = fopen(temp, "r");
> +	if (sysfsfp == NULL) {
> +		ret = -errno;
> +		goto error_free;
> +	}
> +	fscanf(sysfsfp, "%s\n", str);
> +	fclose(sysfsfp);
> +error_free:
> +	free(temp);
> +	return ret;
> +}
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> new file mode 100644
> index 0000000..1bc837b
> --- /dev/null
> +++ b/tools/iio/iio_utils.h
> @@ -0,0 +1,71 @@
> +#ifndef _IIO_UTILS_H_
> +#define _IIO_UTILS_H_
> +
> +/* IIO - useful set of util functionality
> + *
> + * Copyright (c) 2008 Jonathan Cameron
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <stdint.h>
> +
> +/* Made up value to limit allocation sizes */
> +#define IIO_MAX_NAME_LENGTH 30
> +
> +#define FORMAT_SCAN_ELEMENTS_DIR "%s/scan_elements"
> +#define FORMAT_TYPE_FILE "%s_type"
> +
> +extern const char *iio_dir;
> +
> +/**
> + * struct iio_channel_info - information about a given channel
> + * @name: channel name
> + * @generic_name: general name for channel type
> + * @scale: scale factor to be applied for conversion to si units
> + * @offset: offset to be applied for conversion to si units
> + * @index: the channel index in the buffer output
> + * @bytes: number of bytes occupied in buffer output
> + * @mask: a bit mask for the raw output
> + * @is_signed: is the raw value stored signed
> + * @enabled: is this channel enabled
> + **/
> +struct iio_channel_info {
> +	char *name;
> +	char *generic_name;
> +	float scale;
> +	float offset;
> +	unsigned index;
> +	unsigned bytes;
> +	unsigned bits_used;
> +	unsigned shift;
> +	uint64_t mask;
> +	unsigned be;
> +	unsigned is_signed;
> +	unsigned location;
> +};
> +
> +int iioutils_break_up_name(const char *full_name, char **generic_name);
> +int iioutils_get_type(unsigned *is_signed, unsigned *bytes,
> +					  unsigned *bits_used, unsigned *shift,
> +					  uint64_t *mask, unsigned *be,
> +					  const char *device_dir, const char *name,
> +					  const char *generic_name);
> +int iioutils_get_param_float(float *output, const char *param_name,
> +							 const char *device_dir, const char *name,
> +							 const char *generic_name);
> +void bsort_channel_array_by_index(struct iio_channel_info **ci_array, int cnt);
> +int build_channel_array(const char *device_dir,
> +						struct iio_channel_info **ci_array, int *counter);
> +int find_type_by_name(const char *name, const char *type);
> +int write_sysfs_int(char *filename, char *basedir, int val);
> +int write_sysfs_int_and_verify(char *filename, char *basedir, int val);
> +int write_sysfs_string_and_verify(char *filename, char *basedir, char *val);
> +int write_sysfs_string(char *filename, char *basedir, char *val);
> +int read_sysfs_posint(char *filename, char *basedir);
> +int read_sysfs_float(char *filename, char *basedir, float *val);
> +int read_sysfs_string(const char *filename, const char *basedir, char *str);
> +
> +#endif /* _IIO_UTILS_H_ */
> diff --git a/tools/iio/lsiio.c b/tools/iio/lsiio.c
> new file mode 100644
> index 0000000..98a0de0
> --- /dev/null
> +++ b/tools/iio/lsiio.c
> @@ -0,0 +1,163 @@
> +/*
> + * Industrial I/O utilities - lsiio.c
> + *
> + * Copyright (c) 2010 Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published by
> + * the Free Software Foundation.
> + */
> +
> +#include <string.h>
> +#include <dirent.h>
> +#include <stdio.h>
> +#include <errno.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/dir.h>
> +#include "iio_utils.h"
> +
> +
> +static enum verbosity {
> +	VERBLEVEL_DEFAULT,	/* 0 gives lspci behaviour */
> +	VERBLEVEL_SENSORS,	/* 1 lists sensors */
> +} verblevel = VERBLEVEL_DEFAULT;
> +
> +const char *type_device = "iio:device";
> +const char *type_trigger = "trigger";
> +
> +
> +static inline int check_prefix(const char *str, const char *prefix)
> +{
> +	return strlen(str) > strlen(prefix) &&
> +		strncmp(str, prefix, strlen(prefix)) == 0;
> +}
> +
> +static inline int check_postfix(const char *str, const char *postfix)
> +{
> +	return strlen(str) > strlen(postfix) &&
> +		strcmp(str + strlen(str) - strlen(postfix), postfix) == 0;
> +}
> +
> +static int dump_channels(const char *dev_dir_name)
> +{
> +	DIR *dp;
> +	const struct dirent *ent;
> +
> +	dp = opendir(dev_dir_name);
> +	if (dp == NULL)
> +		return -errno;
> +	while (ent = readdir(dp), ent != NULL)
> +		if (check_prefix(ent->d_name, "in_") &&
> +		    check_postfix(ent->d_name, "_raw")) {
> +			printf("   %-10s\n", ent->d_name);
> +		}
> +
> +	return 0;
> +}
> +
> +static int dump_one_device(const char *dev_dir_name)
> +{
> +	char name[IIO_MAX_NAME_LENGTH];
> +	int dev_idx;
> +	int retval;
> +
> +	retval = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_device),
> +			"%i", &dev_idx);
> +	if (retval != 1)
> +		return -EINVAL;
> +	read_sysfs_string("name", dev_dir_name, name);
> +	printf("Device %03d: %s\n", dev_idx, name);
> +
> +	if (verblevel >= VERBLEVEL_SENSORS)
> +		return dump_channels(dev_dir_name);
> +	return 0;
> +}
> +
> +static int dump_one_trigger(const char *dev_dir_name)
> +{
> +	char name[IIO_MAX_NAME_LENGTH];
> +	int dev_idx;
> +	int retval;
> +
> +	retval = sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_trigger),
> +			"%i", &dev_idx);
> +	if (retval != 1)
> +		return -EINVAL;
> +	read_sysfs_string("name", dev_dir_name, name);
> +	printf("Trigger %03d: %s\n", dev_idx, name);
> +	return 0;
> +}
> +
> +static void dump_devices(void)
> +{
> +	const struct dirent *ent;
> +	int number, numstrlen;
> +
> +	FILE *nameFile;
> +	DIR *dp;
> +	char thisname[IIO_MAX_NAME_LENGTH];
> +	char *filename;
> +
> +	dp = opendir(iio_dir);
> +	if (dp == NULL) {
> +		printf("No industrial I/O devices available\n");
> +		return;
> +	}
> +
> +	while (ent = readdir(dp), ent != NULL) {
> +		if (check_prefix(ent->d_name, type_device)) {
> +			char *dev_dir_name;
> +
> +			asprintf(&dev_dir_name, "%s%s", iio_dir, ent->d_name);
> +			dump_one_device(dev_dir_name);
> +			free(dev_dir_name);
> +			if (verblevel >= VERBLEVEL_SENSORS)
> +				printf("\n");
> +		}
> +	}
> +	rewinddir(dp);
> +	while (ent = readdir(dp), ent != NULL) {
> +		if (check_prefix(ent->d_name, type_trigger)) {
> +			char *dev_dir_name;
> +
> +			asprintf(&dev_dir_name, "%s%s", iio_dir, ent->d_name);
> +			dump_one_trigger(dev_dir_name);
> +			free(dev_dir_name);
> +		}
> +	}
> +	closedir(dp);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int c, err = 0;
> +
> +	while ((c = getopt(argc, argv, "d:D:v")) != EOF) {
> +		switch (c) {
> +		case 'v':
> +			verblevel++;
> +			break;
> +
> +		case '?':
> +		default:
> +			err++;
> +			break;
> +		}
> +	}
> +	if (err || argc > optind) {
> +		fprintf(stderr, "Usage: lsiio [options]...\n"
> +			"List industrial I/O devices\n"
> +			"  -v, --verbose\n"
> +			"      Increase verbosity (may be given multiple times)\n"
> +			);
> +		exit(1);
> +	}
> +
> +	dump_devices();
> +
> +	return 0;
> +}
> 

