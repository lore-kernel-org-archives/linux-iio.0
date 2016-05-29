Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34278 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858AbcE2TRL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:17:11 -0400
Subject: Re: [PATCH v2 2/2] iio: generic_buffer: Add --device-num option
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <3eaa280e2467ffc970277c48ab617a4b5bd23d4f.1464019664.git.leonard.crestez@intel.com>
 <76604f31ab9355de7bd8c69537597feb7216e1f3.1464019664.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ed950783-8b25-b6e7-eb86-3bed6ed040a7@kernel.org>
Date: Sun, 29 May 2016 20:17:09 +0100
MIME-Version: 1.0
In-Reply-To: <76604f31ab9355de7bd8c69537597feb7216e1f3.1464019664.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/05/16 17:07, Crestez Dan Leonard wrote:
> This makes it possible to distinguish between iio devices with the same
> name.
> 
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
I'm a cheapskate and never had more than one of a given part ;)
Hence clearly never thought this through properly.

Applied to the togreg branch of iio.git - usual route via testing etc...

Thanks,

Jonathan
> ---
>  tools/iio/generic_buffer.c | 69 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 51 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 53fd28b..a93b771 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -251,7 +251,9 @@ void print_usage(void)
>  		"  -e         Disable wait for event (new data)\n"
>  		"  -g         Use trigger-less mode\n"
>  		"  -l <n>     Set buffer length to n samples\n"
> -		"  -n <name>  Set device name (mandatory)\n"
> +		"  --device-name -n <name>\n"
> +		"  --device-num -N <num>\n"
> +		"        Set device by name or number"
>  		"  -t <name>  Set trigger name\n"
>  		"  -w <n>     Set delay between reads in us (event-less mode)\n");
>  }
> @@ -315,6 +317,12 @@ void register_cleanup(void)
>  	}
>  }
>  
> +static const struct option longopts[] = {
> +	{ "device-name",	1, 0, 'n' },
> +	{ "device-num",		1, 0, 'N' },
> +	{ },
> +};
> +
>  int main(int argc, char **argv)
>  {
>  	unsigned long num_loops = 2;
> @@ -329,7 +337,7 @@ int main(int argc, char **argv)
>  
>  	char *data;
>  	ssize_t read_size;
> -	int dev_num, trig_num;
> +	int dev_num = -1, trig_num;
>  	char *buffer_access = NULL;
>  	int scan_size;
>  	int noevents = 0;
> @@ -340,7 +348,7 @@ int main(int argc, char **argv)
>  
>  	register_cleanup();
>  
> -	while ((c = getopt(argc, argv, "ac:egl:n:t:w:")) != -1) {
> +	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:w:", longopts, NULL)) != -1) {
>  		switch (c) {
>  		case 'a':
>  			autochannels = AUTOCHANNELS_ENABLED;
> @@ -370,7 +378,15 @@ int main(int argc, char **argv)
>  
>  			break;
>  		case 'n':
> -			device_name = optarg;
> +			device_name = strdup(optarg);
> +			break;
> +		case 'N':
> +			errno = 0;
> +			dev_num = strtoul(optarg, &dummy, 10);
> +			if (errno) {
> +				ret = -errno;
> +				goto error;
> +			}
>  			break;
>  		case 't':
>  			trigger_name = strdup(optarg);
> @@ -390,26 +406,42 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (!device_name) {
> -		fprintf(stderr, "Device name not set\n");
> -		print_usage();
> -		return -1;
> -	}
> -
>  	/* Find the device requested */
> -	dev_num = find_type_by_name(device_name, "iio:device");
> -	if (dev_num < 0) {
> -		fprintf(stderr, "Failed to find the %s\n", device_name);
> -		ret = dev_num;
> +	if (dev_num < 0 && !device_name) {
> +		fprintf(stderr, "Device not set\n");
> +		print_usage();
> +		ret = -1;
> +		goto error;
> +	} else if (dev_num >= 0 && device_name) {
> +		fprintf(stderr, "Only one of --device-num or --device-name needs to be set\n");
> +		print_usage();
> +		ret = -1;
>  		goto error;
> +	} else if (dev_num < 0) {
> +		dev_num = find_type_by_name(device_name, "iio:device");
> +		if (dev_num < 0) {
> +			fprintf(stderr, "Failed to find the %s\n", device_name);
> +			ret = dev_num;
> +			goto error;
> +		}
>  	}
> -
>  	printf("iio device number being used is %d\n", dev_num);
>  
>  	ret = asprintf(&dev_dir_name, "%siio:device%d", iio_dir, dev_num);
> -	if (ret < 0) {
> -		ret = -ENOMEM;
> -		goto error;
> +	if (ret < 0)
> +		return -ENOMEM;
> +	/* Fetch device_name if specified by number */
> +	if (!device_name) {
> +		device_name = malloc(IIO_MAX_NAME_LENGTH);
> +		if (!device_name) {
> +			ret = -ENOMEM;
> +			goto error;
> +		}
> +		ret = read_sysfs_string("name", dev_dir_name, device_name);
> +		if (ret < 0) {
> +			fprintf(stderr, "Failed to read name of device %d\n", dev_num);
> +			goto error;
> +		}
>  	}
>  
>  	if (!notrigger) {
> @@ -619,6 +651,7 @@ error:
>  	}
>  	free(channels);
>  	free(trigger_name);
> +	free(device_name);
>  	free(dev_dir_name);
>  
>  	return ret;
> 

