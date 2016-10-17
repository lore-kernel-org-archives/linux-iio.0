Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 17 Oct 2016 23:15:53 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Eva Rachel Retuya <eraretuya@gmail.com>
cc: linux-iio@vger.kernel.org, outreachy-kernel@googlegroups.com,
    jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: add -A to force-enable
 all channels
In-Reply-To: <1476440319-11124-1-git-send-email-eraretuya@gmail.com>
Message-ID: <alpine.DEB.2.02.1610172311510.31400@pmeerw.net>
References: <1476440319-11124-1-git-send-email-eraretuya@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> If attribute/s is/are already enabled (by default or via scripts or
> manual interaction), issuing -a will fail to enable the channels thereby
> one has to manually disable the said attribute/s before proceeding with
> auto-enabling.
> 
> Add a command-line option -A to force-activate all channels regardless
> of their current state.

comments below
 
> Suggested-by: Alison Schofield <amsfield22@gmail.com>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> ---
>  tools/iio/iio_generic_buffer.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index f39c0e9..84c9888 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -247,6 +247,7 @@ void print_usage(void)
>  	fprintf(stderr, "Usage: generic_buffer [options]...\n"
>  		"Capture, convert and output data from IIO device buffer\n"
>  		"  -a         Auto-activate all available channels\n"
> +		"  -A         Force-activate ALL channels\n"
>  		"  -c <n>     Do n conversions\n"
>  		"  -e         Disable wait for event (new data)\n"
>  		"  -g         Use trigger-less mode\n"
> @@ -347,16 +348,22 @@ int main(int argc, char **argv)
>  	int noevents = 0;
>  	int notrigger = 0;
>  	char *dummy;
> +	int force = 0;

bool instead of int
maybe force_autochannels

>  
>  	struct iio_channel_info *channels = NULL;
>  
>  	register_cleanup();
>  
> -	while ((c = getopt_long(argc, argv, "ac:egl:n:N:t:T:w:", longopts, NULL)) != -1) {
> +	while ((c = getopt_long(argc, argv, "aAc:egl:n:N:t:T:w:", longopts,
> +		NULL)) != -1) {
>  		switch (c) {
>  		case 'a':
>  			autochannels = AUTOCHANNELS_ENABLED;
>  			break;
> +		case 'A':
> +			autochannels = AUTOCHANNELS_ENABLED;
> +			force = 1;
> +			break;
>  		case 'c':
>  			errno = 0;
>  			num_loops = strtoul(optarg, &dummy, 10);
> @@ -519,15 +526,15 @@ int main(int argc, char **argv)
>  			"diag %s\n", dev_dir_name);
>  		goto error;
>  	}
> -	if (num_channels && autochannels == AUTOCHANNELS_ENABLED) {
> +	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) && !force) {

parenthesis not strictly required/needed
the bracketing is inconsistent, when do you use parenthesis with && and 
when not? I suggest to drop parenthesis

>  		fprintf(stderr, "Auto-channels selected but some channels "
>  			"are already activated in sysfs\n");
>  		fprintf(stderr, "Proceeding without activating any channels\n");
>  	}
>  
> -	if (!num_channels && autochannels == AUTOCHANNELS_ENABLED) {
> -		fprintf(stderr,
> -			"No channels are enabled, enabling all channels\n");
> +	if ((!num_channels && autochannels == AUTOCHANNELS_ENABLED) ||
> +	    ((autochannels == AUTOCHANNELS_ENABLED) && force)) {
> +		fprintf(stderr, "Enabling all channels\n");

as above

>  
>  		ret = enable_disable_all_channels(dev_dir_name, 1);
>  		if (ret) {
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
