Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34477 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932373AbcE2TnT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 May 2016 15:43:19 -0400
Subject: Re: [PATCHv3 3/7] iio: generic_buffer: Add --trigger-num option
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <cover.1464027859.git.leonard.crestez@intel.com>
 <2c51dcad4cbc011247ea3a5f8360f56594bdd40a.1464027859.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4fb47acf-34fc-cd8d-d6c2-9f4dde7d0c23@kernel.org>
Date: Sun, 29 May 2016 20:43:17 +0100
MIME-Version: 1.0
In-Reply-To: <2c51dcad4cbc011247ea3a5f8360f56594bdd40a.1464027859.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/05/16 19:39, Crestez Dan Leonard wrote:
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
Again, sensible and straight forward.

Thanks,

Jonathan
> ---
>  tools/iio/generic_buffer.c | 34 +++++++++++++++++++++++++++++-----
>  1 file changed, 29 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 3f16e9f..e8c3052 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -254,7 +254,9 @@ void print_usage(void)
>  		"  --device-name -n <name>\n"
>  		"  --device-num -N <num>\n"
>  		"        Set device by name or number (mandatory)\n"
> -		"  -t <name>  Set trigger name\n"
> +		"  --trigger-name -t <name>\n"
> +		"  --trigger-num -T <num>\n"
> +		"        Set trigger by name or number\n"
>  		"  -w <n>     Set delay between reads in us (event-less mode)\n");
>  }
>  
> @@ -320,6 +322,8 @@ void register_cleanup(void)
>  static const struct option longopts[] = {
>  	{ "device-name",	1, 0, 'n' },
>  	{ "device-num",		1, 0, 'N' },
> +	{ "trigger-name",	1, 0, 't' },
> +	{ "trigger-num",	1, 0, 'T' },
>  	{ },
>  };
>  
> @@ -348,7 +352,7 @@ int main(int argc, char **argv)
>  
>  	register_cleanup();
>  
> -	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:w:", longopts, NULL)) != -1) {
> +	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:", longopts, NULL)) != -1) {
>  		switch (c) {
>  		case 'a':
>  			autochannels = AUTOCHANNELS_ENABLED;
> @@ -391,6 +395,12 @@ int main(int argc, char **argv)
>  		case 't':
>  			trigger_name = strdup(optarg);
>  			break;
> +		case 'T':
> +			errno = 0;
> +			trig_num = strtoul(optarg, &dummy, 10);
> +			if (errno)
> +				return -errno;
> +			break;
>  		case 'w':
>  			errno = 0;
>  			timedelay = strtoul(optarg, &dummy, 10);
> @@ -444,7 +454,23 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	if (!notrigger) {
> +	if (notrigger) {
> +		printf("trigger-less mode selected\n");
> +	} if (trig_num > 0) {
> +		char *trig_dev_name;
> +		ret = asprintf(&trig_dev_name, "%strigger%d", iio_dir, trig_num);
> +		if (ret < 0) {
> +			return -ENOMEM;
> +		}
> +		trigger_name = malloc(IIO_MAX_NAME_LENGTH);
> +		ret = read_sysfs_string("name", trig_dev_name, trigger_name);
> +		free(trig_dev_name);
> +		if (ret < 0) {
> +			fprintf(stderr, "Failed to read trigger%d name from\n", trig_num);
> +			return ret;
> +		}
> +		printf("iio trigger number being used is %d\n", trig_num);
> +	} else {
>  		if (!trigger_name) {
>  			/*
>  			 * Build the trigger name. If it is device associated
> @@ -481,8 +507,6 @@ int main(int argc, char **argv)
>  		}
>  
>  		printf("iio trigger number being used is %d\n", trig_num);
> -	} else {
> -		printf("trigger-less mode selected\n");
>  	}
>  
>  	/*
> 

