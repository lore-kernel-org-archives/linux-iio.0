Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:46190 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932485AbcDLJPD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 12 Apr 2016 05:15:03 -0400
Date: Tue, 12 Apr 2016 11:14:59 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Linus Walleij <linus.walleij@linaro.org>
cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: tools: generic_buffer: auto-enable channels
In-Reply-To: <1460451311-9819-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <alpine.DEB.2.02.1604121106070.4383@pmeerw.net>
References: <1460451311-9819-1-git-send-email-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> This is extremely useful when I'm low-level testing my
> sensors with interrupts and triggers, sample session:

 
> Pure awesomeness. If some channels have been enabled through
> scripts or manual interaction, nothing happens.

I like!

> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Provide for using the -a flag to indicate that you want all
>   available channels enabled.
> ---
>  tools/iio/generic_buffer.c | 90 +++++++++++++++++++++++++++++++++++++++++-----
>  tools/iio/iio_utils.h      |  7 ++++
>  2 files changed, 88 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index c42b7f836b48..81ebead47547 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -191,10 +191,51 @@ void process_scan(char *data,
>  	printf("\n");
>  }
>  
> +int enable_disable_all_channels(char *dev_dir_name, int enable)

could be static?
well, nothing in generic_buffer.c is...

> +{
> +	const struct dirent *ent;
> +	char scanelemdir[256];
> +	DIR *dp;
> +	int ret;
> +
> +	snprintf(scanelemdir, sizeof(scanelemdir),
> +		 FORMAT_SCAN_ELEMENTS_DIR, dev_dir_name);
> +	scanelemdir[sizeof(scanelemdir)-1] = '\0';
> +
> +	dp = opendir(scanelemdir);
> +	if (!dp) {

maybe perror() can be used here, it's used for closedir() check

> +		fprintf(stderr, "Enabling/disabling channels: can't open %s\n",
> +			scanelemdir);
> +		return -EIO;
> +	}
> +
> +	ret = -ENOENT;
> +	while (ent = readdir(dp), ent) {
> +		if (check_suffix(ent->d_name, "_en")) {
> +			printf("%sabling: %s\n",
> +			       enable ? "En" : "Dis",
> +			       ent->d_name);
> +			ret = write_sysfs_int(ent->d_name, scanelemdir,
> +					      enable);
> +			if (ret < 0)
> +				fprintf(stderr, "Failed to enable/disable %s\n",
> +					ent->d_name);
> +		}
> +	}
> +
> +	if (closedir(dp) == -1) {
> +		perror("Enabling/disabling channels: "
> +		       "Failed to close directory");
> +		return -errno;
> +	}
> +	return 0;
> +}
> +
>  void print_usage(void)
>  {
>  	fprintf(stderr, "Usage: generic_buffer [options]...\n"
>  		"Capture, convert and output data from IIO device buffer\n"
> +		"  -a         Auto-activate all available channels\n"
>  		"  -c <n>     Do n conversions\n"
>  		"  -e         Disable wait for event (new data)\n"
>  		"  -g         Use trigger-less mode\n"
> @@ -225,12 +266,16 @@ int main(int argc, char **argv)
>  	int scan_size;
>  	int noevents = 0;
>  	int notrigger = 0;
> +	int autochannels = 0;

maybe an enum for autochannels? it can be 0/1/2

>  	char *dummy;
>  
>  	struct iio_channel_info *channels;
>  
> -	while ((c = getopt(argc, argv, "c:egl:n:t:w:")) != -1) {
> +	while ((c = getopt(argc, argv, "ac:egl:n:t:w:")) != -1) {
>  		switch (c) {
> +		case 'a':
> +			autochannels = 1;
> +			break;
>  		case 'c':
>  			errno = 0;
>  			num_loops = strtoul(optarg, &dummy, 10);
> @@ -340,14 +385,36 @@ int main(int argc, char **argv)
>  			"diag %s\n", dev_dir_name);
>  		goto error_free_triggername;
>  	}
> -	if (!num_channels) {
> +	if (num_channels && autochannels) {
> +		fprintf(stderr, "Auto-channels selected but some channels "
> +			"are already activated in sysfs\n");
> +		fprintf(stderr, "Proceeding without activating any channels\n");
> +	}
> +	if (!num_channels && autochannels) {
>  		fprintf(stderr,
> -			"No channels are enabled, we have nothing to scan.\n");
> -		fprintf(stderr, "Enable channels manually in "
> -			FORMAT_SCAN_ELEMENTS_DIR
> -			"/*_en and try again.\n", dev_dir_name);
> -		ret = -ENOENT;
> -		goto error_free_triggername;
> +			"No channels are enabled, enabling all channels\n");
> +
> +		ret = enable_disable_all_channels(dev_dir_name, 1);
> +		if (ret) {
> +			fprintf(stderr, "Failed to enable all channels\n");
> +			goto error_free_triggername;
> +		}
> +
> +		/* This flags that we need to disable the channels again */
> +		autochannels = 2;
> +		ret = build_channel_array(dev_dir_name, &channels,
> +					  &num_channels);
> +		if (ret) {
> +			fprintf(stderr, "Problem reading scan element "
> +				"information\n"
> +				"diag %s\n", dev_dir_name);
> +			goto error_disable_channels;
> +		}
> +		if (!num_channels) {
> +			fprintf(stderr, "Still no channels after "
> +				"auto-enabling, giving up\n");
> +			goto error_disable_channels;
> +		}
>  	}
>  
>  	/*
> @@ -479,7 +546,12 @@ error_free_channels:
>  error_free_triggername:
>  	if (datardytrigger)
>  		free(trigger_name);
> -
> +error_disable_channels:
> +	if (autochannels == 2) {
> +		ret = enable_disable_all_channels(dev_dir_name, 0);
> +		if (ret)
> +			fprintf(stderr, "Failed to disable all channels\n");
> +	}
>  error_free_dev_dir_name:
>  	free(dev_dir_name);
>  
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index e3503bfe538b..9d5601421820 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -52,6 +52,13 @@ struct iio_channel_info {
>  	unsigned location;
>  };
>  
> +static inline int check_suffix(const char *str, const char *suffix)

prefix with iioutils_ maybe?

> +{
> +	return strlen(str) > strlen(suffix) &&

it should be >= probably such that
check_suffix("abc", "abc") is 1, currently returns 0

the other corner-case is
check_suffix("abc", "") which is 1, OK


> +		strncmp(str+strlen(str)-strlen(suffix),
> +			suffix, strlen(suffix)) == 0;
> +}
> +
>  int iioutils_break_up_name(const char *full_name, char **generic_name);
>  int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>  		      unsigned *shift, uint64_t *mask, unsigned *be,
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
