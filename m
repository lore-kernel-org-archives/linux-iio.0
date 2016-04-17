Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53247 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751385AbcDQLbD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 07:31:03 -0400
Subject: Re: [PATCH v3] iio: tools: generic_buffer: auto-enable channels
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1460622407-6403-1-git-send-email-linus.walleij@linaro.org>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571373F4.2030707@kernel.org>
Date: Sun, 17 Apr 2016 12:31:00 +0100
MIME-Version: 1.0
In-Reply-To: <1460622407-6403-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/04/16 09:26, Linus Walleij wrote:
> If no channels are enabled when we run generic_buffer on a
> device, add a command-line option to just enable all of them,
> run the sampling and disable them all again afterwards.
> 
> This is extremely useful when I'm low-level testing my
> sensors with interrupts and triggers, sample session:
> 
> root@Ux500:/ lsiio
> Device 000: lsm303dlh_accel
> Device 001: lis331dl_accel
> Device 002: l3g4200d
> Device 003: lsm303dlh_magn
> Device 004: lps001wp
> Trigger 000: lsm303dlh_accel-trigger
> Trigger 001: lis331dl_accel-trigger
> Trigger 002: l3g4200d-trigger
> 
> root@Ux500:/ generic_buffer -a -c 10 -n l3g4200d
> iio device number being used is 2
> iio trigger number being used is 2
> No channels are enabled, enabling all channels
> Enabling: in_anglvel_x_en
> Enabling: in_anglvel_y_en
> Enabling: in_anglvel_z_en
> Enabling: in_timestamp_en
> /sys/bus/iio/devices/iio:device2 l3g4200d-trigger
> -3.593664 -0.713133 4.870143 946684863662292480
> 3.225546 0.867357 -4.945878 946684863671875000
> -0.676413 0.127296 0.106641 946684863681488037
> -0.661113 0.110160 0.128826 946684863690673828
> -0.664173 0.113067 0.123471 946684863700683593
> -0.664938 0.109395 0.124848 946684863710144042
> -0.664173 0.110619 0.130203 946684863719512939
> -0.666162 0.111231 0.132651 946684863729125976
> -0.668610 0.111690 0.130662 946684863738739013
> -0.660501 0.110466 0.131733 946684863748565673
> Disabling: in_anglvel_x_en
> Disabling: in_anglvel_y_en
> Disabling: in_anglvel_z_en
> Disabling: in_timestamp_en
> 
> Pure awesomeness. If some channels have been enabled through
> scripts or manual interaction, nothing happens.
> 
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git.

Very nice.

If Peter has any comments / acks etc, it'll be only
exposed as testing for a few more days at least so
feel free to send them in!

Jonathan
> ---
> ChangeLog v2->v3:
> - Use an enum for channel enablement state
> - Rename check_suffix() to iioutils_check_suffix()
> - Fix a bug in a corner case for the iioutils_check_suffix()
>   function
> - Staticize the function enabling all channels
> - Restore helptext when no channels are enabled and
>   autochannels are not enabled either: we should bail out
>   with the error message like before
> ChangeLog v1->v2:
> - Provide for using the -a flag to indicate that you want all
>   available channels enabled.
> ---
>  tools/iio/generic_buffer.c | 102 +++++++++++++++++++++++++++++++++++++++++++--
>  tools/iio/iio_utils.h      |   7 ++++
>  2 files changed, 105 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index c42b7f836b48..2429c78de940 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -35,6 +35,15 @@
>  #include "iio_utils.h"
>  
>  /**
> + * enum autochan - state for the automatic channel enabling mechanism
> + */
> +enum autochan {
> +	AUTOCHANNELS_DISABLED,
> +	AUTOCHANNELS_ENABLED,
> +	AUTOCHANNELS_ACTIVE,
> +};
> +
> +/**
>   * size_from_channelarray() - calculate the storage size of a scan
>   * @channels:		the channel info array
>   * @num_channels:	number of channels
> @@ -191,10 +200,51 @@ void process_scan(char *data,
>  	printf("\n");
>  }
>  
> +static int enable_disable_all_channels(char *dev_dir_name, int enable)
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
> +		fprintf(stderr, "Enabling/disabling channels: can't open %s\n",
> +			scanelemdir);
> +		return -EIO;
> +	}
> +
> +	ret = -ENOENT;
> +	while (ent = readdir(dp), ent) {
> +		if (iioutils_check_suffix(ent->d_name, "_en")) {
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
> @@ -225,12 +275,16 @@ int main(int argc, char **argv)
>  	int scan_size;
>  	int noevents = 0;
>  	int notrigger = 0;
> +	enum autochan autochannels = AUTOCHANNELS_DISABLED;
>  	char *dummy;
>  
>  	struct iio_channel_info *channels;
>  
> -	while ((c = getopt(argc, argv, "c:egl:n:t:w:")) != -1) {
> +	while ((c = getopt(argc, argv, "ac:egl:n:t:w:")) != -1) {
>  		switch (c) {
> +		case 'a':
> +			autochannels = AUTOCHANNELS_ENABLED;
> +			break;
>  		case 'c':
>  			errno = 0;
>  			num_loops = strtoul(optarg, &dummy, 10);
> @@ -340,12 +394,47 @@ int main(int argc, char **argv)
>  			"diag %s\n", dev_dir_name);
>  		goto error_free_triggername;
>  	}
> -	if (!num_channels) {
> +	if (num_channels && autochannels == AUTOCHANNELS_ENABLED) {
> +		fprintf(stderr, "Auto-channels selected but some channels "
> +			"are already activated in sysfs\n");
> +		fprintf(stderr, "Proceeding without activating any channels\n");
> +	}
> +
> +	if (!num_channels && autochannels == AUTOCHANNELS_ENABLED) {
> +		fprintf(stderr,
> +			"No channels are enabled, enabling all channels\n");
> +
> +		ret = enable_disable_all_channels(dev_dir_name, 1);
> +		if (ret) {
> +			fprintf(stderr, "Failed to enable all channels\n");
> +			goto error_free_triggername;
> +		}
> +
> +		/* This flags that we need to disable the channels again */
> +		autochannels = AUTOCHANNELS_ACTIVE;
> +
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
> +	}
> +
> +	if (!num_channels && autochannels == AUTOCHANNELS_DISABLED) {
>  		fprintf(stderr,
>  			"No channels are enabled, we have nothing to scan.\n");
>  		fprintf(stderr, "Enable channels manually in "
>  			FORMAT_SCAN_ELEMENTS_DIR
> -			"/*_en and try again.\n", dev_dir_name);
> +			"/*_en or pass -a to autoenable channels and "
> +			"try again.\n", dev_dir_name);
>  		ret = -ENOENT;
>  		goto error_free_triggername;
>  	}
> @@ -479,7 +568,12 @@ error_free_channels:
>  error_free_triggername:
>  	if (datardytrigger)
>  		free(trigger_name);
> -
> +error_disable_channels:
> +	if (autochannels == AUTOCHANNELS_ACTIVE) {
> +		ret = enable_disable_all_channels(dev_dir_name, 0);
> +		if (ret)
> +			fprintf(stderr, "Failed to disable all channels\n");
> +	}
>  error_free_dev_dir_name:
>  	free(dev_dir_name);
>  
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index e3503bfe538b..780f2014f8fa 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -52,6 +52,13 @@ struct iio_channel_info {
>  	unsigned location;
>  };
>  
> +static inline int iioutils_check_suffix(const char *str, const char *suffix)
> +{
> +	return strlen(str) >= strlen(suffix) &&
> +		strncmp(str+strlen(str)-strlen(suffix),
> +			suffix, strlen(suffix)) == 0;
> +}
> +
>  int iioutils_break_up_name(const char *full_name, char **generic_name);
>  int iioutils_get_type(unsigned *is_signed, unsigned *bytes, unsigned *bits_used,
>  		      unsigned *shift, uint64_t *mask, unsigned *be,
> 

