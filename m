Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44142 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752711AbaBOLON (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Feb 2014 06:14:13 -0500
Message-ID: <52FF4C26.4080703@kernel.org>
Date: Sat, 15 Feb 2014 11:14:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging: iio: Add tool to list IIO devices and triggers
References: <1391606581-31638-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1391606581-31638-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/14 13:23, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
We really should look at moving all these tools out of staging.  Ah well, another day.

A few comments inline, but I think it is worth merging as is on the basis
we can improve it in tree.  Afterall we don't have any firm abi
constraints on this sort of example code.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>   drivers/staging/iio/Documentation/iio_utils.h |  22 ++++
>   drivers/staging/iio/Documentation/lsiio.c     | 157 ++++++++++++++++++++++++++
>   2 files changed, 179 insertions(+)
>   create mode 100644 drivers/staging/iio/Documentation/lsiio.c
>
> diff --git a/drivers/staging/iio/Documentation/iio_utils.h b/drivers/staging/iio/Documentation/iio_utils.h
> index 35154d6..8dd2671 100644
> --- a/drivers/staging/iio/Documentation/iio_utils.h
> +++ b/drivers/staging/iio/Documentation/iio_utils.h
> @@ -652,3 +652,25 @@ error_free:
>   	free(temp);
>   	return ret;
>   }
> +
> +read_sysfs_string(const char *filename, const char *basedir, char *str)
> +{
> +	float ret = 0;
> +	FILE  *sysfsfp;
> +	char *temp = malloc(strlen(basedir) + strlen(filename) + 2);
> +	if (temp == NULL) {
> +		printf("Memory allocation failed");
> +		return -ENOMEM;
> +	}
> +	sprintf(temp, "%s/%s", basedir, filename);
Why not use an asprintf to simplify the allocation and writing of the string?
I guess this keeps it inline with the other similar functions. Can always clean
them all up in one go.
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
> diff --git a/drivers/staging/iio/Documentation/lsiio.c b/drivers/staging/iio/Documentation/lsiio.c
> new file mode 100644
> index 0000000..24ae969
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/lsiio.c
> @@ -0,0 +1,157 @@
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
> +	dp = opendir(dev_dir_name);
> +	if (dp == NULL)
> +		return -errno;
> +	while (ent = readdir(dp), ent != NULL)
> +		if (check_prefix(ent->d_name, "in_") &&
> +		    check_postfix(ent->d_name, "_raw")) {
> +			printf("   %-10s\n", ent->d_name);
> +		}
So this limits us to simple raw input channels?  We probably
want to cover the _input variant as well.
> +
> +	return 0;
> +}
> +
> +static int dump_one_device(const char *dev_dir_name)
> +{
> +	char name[IIO_MAX_NAME_LENGTH];
> +	int dev_idx;
> +
> +	sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_device),
> +			"%i", &dev_idx);
> +	read_sysfs_string("name", dev_dir_name, name);
> +	printf("Device %03d: %s\n", dev_idx, name);
> +
> +	if (verblevel >= VERBLEVEL_SENSORS) {
> +		int ret = dump_channels(dev_dir_name);
> +		if (ret)
> +			return ret;
> +	}
> +	return 0;
> +}
> +
> +static int dump_one_trigger(const char *dev_dir_name)
> +{
> +	char name[IIO_MAX_NAME_LENGTH];
> +	int dev_idx;
> +
> +	sscanf(dev_dir_name + strlen(iio_dir) + strlen(type_trigger),
> +			"%i", &dev_idx);
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

