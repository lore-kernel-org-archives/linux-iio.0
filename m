Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34438 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752839AbcE2TiF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:38:05 -0400
Subject: Re: [PATCHv3 1/7] iio: generic_buffer: Cleanup when receiving signals
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1464027859.git.leonard.crestez@intel.com>
 <54d715ce97e1b39f32a29c8ead65e5b5c4942a56.1464027859.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <16eddad0-b2f9-ac6c-e0e8-baa0fd4ac057@kernel.org>
Date: Sun, 29 May 2016 20:38:00 +0100
MIME-Version: 1.0
In-Reply-To: <54d715ce97e1b39f32a29c8ead65e5b5c4942a56.1464027859.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/05/16 19:39, Crestez Dan Leonard wrote:
> This will clean (disable buffer/trigger/channels) when doing
> something like a CTRL-C. Otherwise restarting generic_buffer requires a
> manual echo 0 > buffer/enable
> 
> This also cleanup up all the code freeing string buffers at
> the end of main. We initialize all pointers to NULL so that cleanup can
> all be done under a single error label.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Dropped v2 and applied this one with the same name mangling to match new
naming as iio_generic_buffer

Thanks,

Jonathan
> ---
> Changes since v2: Initialize data to NULL to prevent crash on free.
> 
>  tools/iio/generic_buffer.c | 172 ++++++++++++++++++++++++++++-----------------
>  1 file changed, 108 insertions(+), 64 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 2429c78..972f400 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -32,6 +32,8 @@
>  #include <endian.h>
>  #include <getopt.h>
>  #include <inttypes.h>
> +#include <stdbool.h>
> +#include <signal.h>
>  #include "iio_utils.h"
>  
>  /**
> @@ -254,6 +256,65 @@ void print_usage(void)
>  		"  -w <n>     Set delay between reads in us (event-less mode)\n");
>  }
>  
> +enum autochan autochannels = AUTOCHANNELS_DISABLED;
> +char *dev_dir_name = NULL;
> +char *buf_dir_name = NULL;
> +bool current_trigger_set = false;
> +
> +void cleanup(void)
> +{
> +	int ret;
> +
> +	/* Disable trigger */
> +	if (dev_dir_name && current_trigger_set) {
> +		/* Disconnect the trigger - just write a dummy name. */
> +		ret = write_sysfs_string("trigger/current_trigger",
> +					 dev_dir_name, "NULL");
> +		if (ret < 0)
> +			fprintf(stderr, "Failed to disable trigger: %s\n",
> +				strerror(-ret));
> +		current_trigger_set = false;
> +	}
> +
> +	/* Disable buffer */
> +	if (buf_dir_name) {
> +		ret = write_sysfs_int("enable", buf_dir_name, 0);
> +		if (ret < 0)
> +			fprintf(stderr, "Failed to disable buffer: %s\n",
> +				strerror(-ret));
> +	}
> +
> +	/* Disable channels if auto-enabled */
> +	if (dev_dir_name && autochannels == AUTOCHANNELS_ACTIVE) {
> +		ret = enable_disable_all_channels(dev_dir_name, 0);
> +		if (ret)
> +			fprintf(stderr, "Failed to disable all channels\n");
> +		autochannels = AUTOCHANNELS_DISABLED;
> +	}
> +}
> +
> +void sig_handler(int signum)
> +{
> +	fprintf(stderr, "Caught signal %d\n", signum);
> +	cleanup();
> +	exit(-signum);
> +}
> +
> +void register_cleanup(void)
> +{
> +	struct sigaction sa = { .sa_handler = sig_handler };
> +	const int signums[] = { SIGINT, SIGTERM, SIGABRT };
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(signums); ++i) {
> +		ret = sigaction(signums[i], &sa, NULL);
> +		if (ret) {
> +			perror("Failed to register signal handler");
> +			exit(-1);
> +		}
> +	}
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	unsigned long num_loops = 2;
> @@ -261,25 +322,24 @@ int main(int argc, char **argv)
>  	unsigned long buf_len = 128;
>  
>  	int ret, c, i, j, toread;
> -	int fp;
> +	int fp = -1;
>  
> -	int num_channels;
> +	int num_channels = 0;
>  	char *trigger_name = NULL, *device_name = NULL;
> -	char *dev_dir_name, *buf_dir_name;
>  
> -	int datardytrigger = 1;
> -	char *data;
> +	char *data = NULL;
>  	ssize_t read_size;
>  	int dev_num, trig_num;
> -	char *buffer_access;
> +	char *buffer_access = NULL;
>  	int scan_size;
>  	int noevents = 0;
>  	int notrigger = 0;
> -	enum autochan autochannels = AUTOCHANNELS_DISABLED;
>  	char *dummy;
>  
>  	struct iio_channel_info *channels;
>  
> +	register_cleanup();
> +
>  	while ((c = getopt(argc, argv, "ac:egl:n:t:w:")) != -1) {
>  		switch (c) {
>  		case 'a':
> @@ -288,8 +348,10 @@ int main(int argc, char **argv)
>  		case 'c':
>  			errno = 0;
>  			num_loops = strtoul(optarg, &dummy, 10);
> -			if (errno)
> -				return -errno;
> +			if (errno) {
> +				ret = -errno;
> +				goto error;
> +			}
>  
>  			break;
>  		case 'e':
> @@ -301,26 +363,30 @@ int main(int argc, char **argv)
>  		case 'l':
>  			errno = 0;
>  			buf_len = strtoul(optarg, &dummy, 10);
> -			if (errno)
> -				return -errno;
> +			if (errno) {
> +				ret = -errno;
> +				goto error;
> +			}
>  
>  			break;
>  		case 'n':
>  			device_name = optarg;
>  			break;
>  		case 't':
> -			trigger_name = optarg;
> -			datardytrigger = 0;
> +			trigger_name = strdup(optarg);
>  			break;
>  		case 'w':
>  			errno = 0;
>  			timedelay = strtoul(optarg, &dummy, 10);
> -			if (errno)
> -				return -errno;
> +			if (errno) {
> +				ret = -errno;
> +				goto error;
> +			}
>  			break;
>  		case '?':
>  			print_usage();
> -			return -1;
> +			ret = -1;
> +			goto error;
>  		}
>  	}
>  
> @@ -334,14 +400,17 @@ int main(int argc, char **argv)
>  	dev_num = find_type_by_name(device_name, "iio:device");
>  	if (dev_num < 0) {
>  		fprintf(stderr, "Failed to find the %s\n", device_name);
> -		return dev_num;
> +		ret = dev_num;
> +		goto error;
>  	}
>  
>  	printf("iio device number being used is %d\n", dev_num);
>  
>  	ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
> -	if (ret < 0)
> -		return -ENOMEM;
> +	if (ret < 0) {
> +		ret = -ENOMEM;
> +		goto error;
> +	}
>  
>  	if (!notrigger) {
>  		if (!trigger_name) {
> @@ -354,7 +423,7 @@ int main(int argc, char **argv)
>  				       "%s-dev%d", device_name, dev_num);
>  			if (ret < 0) {
>  				ret = -ENOMEM;
> -				goto error_free_dev_dir_name;
> +				goto error;
>  			}
>  		}
>  
> @@ -367,7 +436,7 @@ int main(int argc, char **argv)
>  				       "%s-trigger", device_name);
>  			if (ret < 0) {
>  				ret = -ENOMEM;
> -				goto error_free_dev_dir_name;
> +				goto error;
>  			}
>  		}
>  
> @@ -376,7 +445,7 @@ int main(int argc, char **argv)
>  			fprintf(stderr, "Failed to find the trigger %s\n",
>  				trigger_name);
>  			ret = trig_num;
> -			goto error_free_triggername;
> +			goto error;
>  		}
>  
>  		printf("iio trigger number being used is %d\n", trig_num);
> @@ -392,7 +461,7 @@ int main(int argc, char **argv)
>  	if (ret) {
>  		fprintf(stderr, "Problem reading scan element information\n"
>  			"diag %s\n", dev_dir_name);
> -		goto error_free_triggername;
> +		goto error;
>  	}
>  	if (num_channels && autochannels == AUTOCHANNELS_ENABLED) {
>  		fprintf(stderr, "Auto-channels selected but some channels "
> @@ -407,7 +476,7 @@ int main(int argc, char **argv)
>  		ret = enable_disable_all_channels(dev_dir_name, 1);
>  		if (ret) {
>  			fprintf(stderr, "Failed to enable all channels\n");
> -			goto error_free_triggername;
> +			goto error;
>  		}
>  
>  		/* This flags that we need to disable the channels again */
> @@ -419,12 +488,12 @@ int main(int argc, char **argv)
>  			fprintf(stderr, "Problem reading scan element "
>  				"information\n"
>  				"diag %s\n", dev_dir_name);
> -			goto error_disable_channels;
> +			goto error;
>  		}
>  		if (!num_channels) {
>  			fprintf(stderr, "Still no channels after "
>  				"auto-enabling, giving up\n");
> -			goto error_disable_channels;
> +			goto error;
>  		}
>  	}
>  
> @@ -436,7 +505,7 @@ int main(int argc, char **argv)
>  			"/*_en or pass -a to autoenable channels and "
>  			"try again.\n", dev_dir_name);
>  		ret = -ENOENT;
> -		goto error_free_triggername;
> +		goto error;
>  	}
>  
>  	/*
> @@ -448,7 +517,7 @@ int main(int argc, char **argv)
>  		       "%siio:device%d/buffer", iio_dir, dev_num);
>  	if (ret < 0) {
>  		ret = -ENOMEM;
> -		goto error_free_channels;
> +		goto error;
>  	}
>  
>  	if (!notrigger) {
> @@ -463,34 +532,34 @@ int main(int argc, char **argv)
>  		if (ret < 0) {
>  			fprintf(stderr,
>  				"Failed to write current_trigger file\n");
> -			goto error_free_buf_dir_name;
> +			goto error;
>  		}
>  	}
>  
>  	/* Setup ring buffer parameters */
>  	ret = write_sysfs_int("length", buf_dir_name, buf_len);
>  	if (ret < 0)
> -		goto error_free_buf_dir_name;
> +		goto error;
>  
>  	/* Enable the buffer */
>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
>  	if (ret < 0) {
>  		fprintf(stderr,
>  			"Failed to enable buffer: %s\n", strerror(-ret));
> -		goto error_free_buf_dir_name;
> +		goto error;
>  	}
>  
>  	scan_size = size_from_channelarray(channels, num_channels);
>  	data = malloc(scan_size * buf_len);
>  	if (!data) {
>  		ret = -ENOMEM;
> -		goto error_free_buf_dir_name;
> +		goto error;
>  	}
>  
>  	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
>  	if (ret < 0) {
>  		ret = -ENOMEM;
> -		goto error_free_data;
> +		goto error;
>  	}
>  
>  	/* Attempt to open non blocking the access dev */
> @@ -498,7 +567,7 @@ int main(int argc, char **argv)
>  	if (fp == -1) { /* TODO: If it isn't there make the node */
>  		ret = -errno;
>  		fprintf(stderr, "Failed to open %s\n", buffer_access);
> -		goto error_free_buffer_access;
> +		goto error;
>  	}
>  
>  	for (j = 0; j < num_loops; j++) {
> @@ -511,7 +580,7 @@ int main(int argc, char **argv)
>  			ret = poll(&pfd, 1, -1);
>  			if (ret < 0) {
>  				ret = -errno;
> -				goto error_close_buffer_access;
> +				goto error;
>  			} else if (ret == 0) {
>  				continue;
>  			}
> @@ -536,45 +605,20 @@ int main(int argc, char **argv)
>  				     num_channels);
>  	}
>  
> -	/* Stop the buffer */
> -	ret = write_sysfs_int("enable", buf_dir_name, 0);
> -	if (ret < 0)
> -		goto error_close_buffer_access;
> -
> -	if (!notrigger)
> -		/* Disconnect the trigger - just write a dummy name. */
> -		ret = write_sysfs_string("trigger/current_trigger",
> -					 dev_dir_name, "NULL");
> -		if (ret < 0)
> -			fprintf(stderr, "Failed to write to %s\n",
> -				dev_dir_name);
> +error:
> +	cleanup();
>  
> -error_close_buffer_access:
> -	if (close(fp) == -1)
> +	if (fp >= 0 && close(fp) == -1)
>  		perror("Failed to close buffer");
> -
> -error_free_buffer_access:
>  	free(buffer_access);
> -error_free_data:
>  	free(data);
> -error_free_buf_dir_name:
>  	free(buf_dir_name);
> -error_free_channels:
>  	for (i = num_channels - 1; i >= 0; i--) {
>  		free(channels[i].name);
>  		free(channels[i].generic_name);
>  	}
>  	free(channels);
> -error_free_triggername:
> -	if (datardytrigger)
> -		free(trigger_name);
> -error_disable_channels:
> -	if (autochannels == AUTOCHANNELS_ACTIVE) {
> -		ret = enable_disable_all_channels(dev_dir_name, 0);
> -		if (ret)
> -			fprintf(stderr, "Failed to disable all channels\n");
> -	}
> -error_free_dev_dir_name:
> +	free(trigger_name);
>  	free(dev_dir_name);
>  
>  	return ret;
> 

