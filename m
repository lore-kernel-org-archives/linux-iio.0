Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:59759 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750966AbbEBXVg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 2 May 2015 19:21:36 -0400
Message-ID: <55455BF6.1040307@gmx.de>
Date: Sun, 03 May 2015 01:21:26 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 3/5] iio: Move iio userspace applications out of staging
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com> <1424940567-24877-4-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-4-git-send-email-roberta.dobrescu@gmail.com>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Roberta Dobrescu schrieb am 26.02.2015 um 09:49:
> This patch moves iio userspace applications out of staging, to tools/iio/
> and adds a Makefile in order to compile them easily. It also adds tools/iio/
> to MAINTAINERS file.
> 

Finally, I managed to have a close look on this one, and there seems quite a
lot of work left, which preferably should have been done in staging. I'll
send a series to cover some issues asap. Anyway, during review, there were
some questions rising, please find them inline (mainly addressed to Jonathan,
as he commited most of the code in the first place).

[...]

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

Is this supposed to check for negative values? My understanding is, that the
sign bit is inside those bits_used, so after shifting them all out, only some
random bits could be left over.

> +					val = (val & channels[k].mask) |
> +						~channels[k].mask;

What is the purpose of this? Looks a bit like a sign extension, but not really.

> +				/* special case for timestamp */
> +				if (channels[k].scale == 1.0f &&
> +				    channels[k].offset == 0.0f)
> +					printf("%" PRId64 " ", val);
> +				else
> +					printf("%05f ", ((float)val +
> +							 channels[k].offset)*
> +					       channels[k].scale);
> +			}

Is there a certain purpose, that no shift gets applied to either the 4 bytes
as well as the 8 bytes values? And what about signed 4 byte values and unsigned
8 byte values?

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

Is this comment supposed to be a TODO, or what node is meant here?

> +		printf("Failed to open %s\n", buffer_access);
> +		ret = -errno;
> +		goto error_free_buffer_access;
> +	}
> +
> +	/* Wait for events 10 times */

I don't exactly see those 10 times happening. Is this comment obsolete
or a TODO?

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

[...]

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

Shouldn't that be
			strlen(ent->d_name) >= strlen(type) &&
or why would the left one have to be bigger than the right one?

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

[...]

Should this function be defined static?
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

[...]

> +++ b/tools/iio/lsiio.c
[...]
> +int main(int argc, char **argv)
> +{
> +	int c, err = 0;
> +
> +	while ((c = getopt(argc, argv, "d:D:v")) != EOF) {

What are d and D used for? Should they be implemented or dropped?

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

Thanks,

Hartmut

