Return-Path: <pmeerw@pmeerw.net>
Date: Fri, 20 May 2016 17:55:09 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
    linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
    Lars-Peter Clausen <lars@metafoo.de>,
    Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 1/2] iio: generic_buffer: Cleanup when receiving
 signals
In-Reply-To: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
Message-ID: <alpine.DEB.2.02.1605201752050.13052@pmeerw.net>
References: <082703f268f7b8b868704006d285d605cce5a784.1463759121.git.leonard.crestez@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> This also drops all the code freeing string buffers at the end of main.
> Memory is freed when the process exits anyway so there's no point in
> cluttering the code with all those gotos.

well, it helps to see that all memory has been released when looking for 
leaks :)
e.g. valgrind becomes much less useful when the program exits with tons of 
memory still allocated

functions and global variables could be static

> ---
>  tools/iio/generic_buffer.c | 162 ++++++++++++++++++++++++---------------------
>  1 file changed, 88 insertions(+), 74 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 2429c78..e7bf477 100644
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
> @@ -254,6 +256,69 @@ void print_usage(void)
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
> +	fprintf(stderr, "Cleanup\n");
> +
> +	/* Disable trigger */
> +	if (dev_dir_name && current_trigger_set) {
> +		/* Disconnect the trigger - just write a dummy name. */
> +		ret = write_sysfs_string("trigger/current_trigger",
> +					 dev_dir_name, "NULL");
> +		if (ret < 0)
> +			fprintf(stderr, "Failed to disable trigger: %s\n",
> +				strerror(-ret));
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
> +	}
> +}
> +
> +void sig_handler(int signum)
> +{
> +	fprintf(stderr, "Caught signal %d\n", signum);
> +	exit(-signum);
> +}
> +
> +void register_cleanup(void)
> +{
> +	struct sigaction sa = { .sa_handler = sig_handler };
> +	const int signums[] = { SIGINT, SIGTERM, SIGABRT };
> +	int ret, i;
> +
> +	ret = atexit(cleanup);
> +	if (ret) {
> +		perror("Failed to register atexit");
> +		exit(-1);
> +	}
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
> @@ -265,9 +330,7 @@ int main(int argc, char **argv)
>  
>  	int num_channels;
>  	char *trigger_name = NULL, *device_name = NULL;
> -	char *dev_dir_name, *buf_dir_name;
>  
> -	int datardytrigger = 1;
>  	char *data;
>  	ssize_t read_size;
>  	int dev_num, trig_num;
> @@ -275,11 +338,12 @@ int main(int argc, char **argv)
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
> @@ -310,7 +374,6 @@ int main(int argc, char **argv)
>  			break;
>  		case 't':
>  			trigger_name = optarg;
> -			datardytrigger = 0;
>  			break;
>  		case 'w':
>  			errno = 0;
> @@ -352,10 +415,8 @@ int main(int argc, char **argv)
>  			 */
>  			ret = asprintf(&trigger_name,
>  				       "%s-dev%d", device_name, dev_num);
> -			if (ret < 0) {
> -				ret = -ENOMEM;
> -				goto error_free_dev_dir_name;
> -			}
> +			if (ret < 0)
> +				return -ENOMEM;
>  		}
>  
>  		/* Look for this "-devN" trigger */
> @@ -365,18 +426,15 @@ int main(int argc, char **argv)
>  			free(trigger_name);
>  			ret = asprintf(&trigger_name,
>  				       "%s-trigger", device_name);
> -			if (ret < 0) {
> -				ret = -ENOMEM;
> -				goto error_free_dev_dir_name;
> -			}
> +			if (ret < 0)
> +				return -ENOMEM;
>  		}
>  
>  		trig_num = find_type_by_name(trigger_name, "trigger");
>  		if (trig_num < 0) {
>  			fprintf(stderr, "Failed to find the trigger %s\n",
>  				trigger_name);
> -			ret = trig_num;
> -			goto error_free_triggername;
> +			return trig_num;
>  		}
>  
>  		printf("iio trigger number being used is %d\n", trig_num);
> @@ -392,7 +450,7 @@ int main(int argc, char **argv)
>  	if (ret) {
>  		fprintf(stderr, "Problem reading scan element information\n"
>  			"diag %s\n", dev_dir_name);
> -		goto error_free_triggername;
> +		return ret;
>  	}
>  	if (num_channels && autochannels == AUTOCHANNELS_ENABLED) {
>  		fprintf(stderr, "Auto-channels selected but some channels "
> @@ -407,7 +465,7 @@ int main(int argc, char **argv)
>  		ret = enable_disable_all_channels(dev_dir_name, 1);
>  		if (ret) {
>  			fprintf(stderr, "Failed to enable all channels\n");
> -			goto error_free_triggername;
> +			return ret;
>  		}
>  
>  		/* This flags that we need to disable the channels again */
> @@ -419,12 +477,12 @@ int main(int argc, char **argv)
>  			fprintf(stderr, "Problem reading scan element "
>  				"information\n"
>  				"diag %s\n", dev_dir_name);
> -			goto error_disable_channels;
> +		        return ret;
>  		}
>  		if (!num_channels) {
>  			fprintf(stderr, "Still no channels after "
>  				"auto-enabling, giving up\n");
> -			goto error_disable_channels;
> +		        return ret;
>  		}
>  	}
>  
> @@ -435,8 +493,7 @@ int main(int argc, char **argv)
>  			FORMAT_SCAN_ELEMENTS_DIR
>  			"/*_en or pass -a to autoenable channels and "
>  			"try again.\n", dev_dir_name);
> -		ret = -ENOENT;
> -		goto error_free_triggername;
> +		return -ENOENT;
>  	}
>  
>  	/*
> @@ -446,10 +503,8 @@ int main(int argc, char **argv)
>  	 */
>  	ret = asprintf(&buf_dir_name,
>  		       "%siio:device%d/buffer", iio_dir, dev_num);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error_free_channels;
> -	}
> +	if (ret < 0)
> +		return -ENOMEM;
>  
>  	if (!notrigger) {
>  		printf("%s %s\n", dev_dir_name, trigger_name);
> @@ -463,34 +518,35 @@ int main(int argc, char **argv)
>  		if (ret < 0) {
>  			fprintf(stderr,
>  				"Failed to write current_trigger file\n");
> -			goto error_free_buf_dir_name;
> +			return ret;
>  		}
> +		current_trigger_set = true;
>  	}
>  
>  	/* Setup ring buffer parameters */
>  	ret = write_sysfs_int("length", buf_dir_name, buf_len);
>  	if (ret < 0)
> -		goto error_free_buf_dir_name;
> +		return ret;
>  
>  	/* Enable the buffer */
>  	ret = write_sysfs_int("enable", buf_dir_name, 1);
>  	if (ret < 0) {
>  		fprintf(stderr,
>  			"Failed to enable buffer: %s\n", strerror(-ret));
> -		goto error_free_buf_dir_name;
> +		return ret;
>  	}
>  
>  	scan_size = size_from_channelarray(channels, num_channels);
>  	data = malloc(scan_size * buf_len);
>  	if (!data) {
>  		ret = -ENOMEM;
> -		goto error_free_buf_dir_name;
> +		return ret;
>  	}
>  
>  	ret = asprintf(&buffer_access, "/dev/iio:device%d", dev_num);
>  	if (ret < 0) {
>  		ret = -ENOMEM;
> -		goto error_free_data;
> +		return ret;
>  	}
>  
>  	/* Attempt to open non blocking the access dev */
> @@ -498,7 +554,7 @@ int main(int argc, char **argv)
>  	if (fp == -1) { /* TODO: If it isn't there make the node */
>  		ret = -errno;
>  		fprintf(stderr, "Failed to open %s\n", buffer_access);
> -		goto error_free_buffer_access;
> +		return ret;
>  	}
>  
>  	for (j = 0; j < num_loops; j++) {
> @@ -510,8 +566,7 @@ int main(int argc, char **argv)
>  
>  			ret = poll(&pfd, 1, -1);
>  			if (ret < 0) {
> -				ret = -errno;
> -				goto error_close_buffer_access;
> +				return -errno;
>  			} else if (ret == 0) {
>  				continue;
>  			}
> @@ -536,46 +591,5 @@ int main(int argc, char **argv)
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
> -
> -error_close_buffer_access:
> -	if (close(fp) == -1)
> -		perror("Failed to close buffer");
> -
> -error_free_buffer_access:
> -	free(buffer_access);
> -error_free_data:
> -	free(data);
> -error_free_buf_dir_name:
> -	free(buf_dir_name);
> -error_free_channels:
> -	for (i = num_channels - 1; i >= 0; i--) {
> -		free(channels[i].name);
> -		free(channels[i].generic_name);
> -	}
> -	free(channels);
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
> -	free(dev_dir_name);
> -
> -	return ret;
> +	return 0;
>  }
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
