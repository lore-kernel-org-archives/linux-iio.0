Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53175 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938579AbcJVPUR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 11:20:17 -0400
Subject: Re: [PATCH v2 1/2] tools: iio: iio_generic_buffer: rename and change
 type of force variable
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <cover.1476952931.git.eraretuya@gmail.com>
 <3749c6e558d696269bcdce627b470ddc60a87fc5.1476952931.git.eraretuya@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <10187e73-4181-b5fd-4936-ea3856de128c@kernel.org>
Date: Sat, 22 Oct 2016 16:20:15 +0100
MIME-Version: 1.0
In-Reply-To: <3749c6e558d696269bcdce627b470ddc60a87fc5.1476952931.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/10/16 10:19, Eva Rachel Retuya wrote:
> Replace the type of 'force' flag from int to bool and at the same time
> rename it to 'force_autochannels' for better readability.
> 
> Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  tools/iio/iio_generic_buffer.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 31ddd3a..8ef39ae 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -348,7 +348,7 @@ int main(int argc, char **argv)
>  	int noevents = 0;
>  	int notrigger = 0;
>  	char *dummy;
> -	int force = 0;
> +	bool force_autochannels = false;
>  
>  	struct iio_channel_info *channels = NULL;
>  
> @@ -362,7 +362,7 @@ int main(int argc, char **argv)
>  			break;
>  		case 'A':
>  			autochannels = AUTOCHANNELS_ENABLED;
> -			force = 1;
> +			force_autochannels = true;
>  			break;	
>  		case 'c':
>  			errno = 0;
> @@ -526,14 +526,15 @@ int main(int argc, char **argv)
>  			"diag %s\n", dev_dir_name);
>  		goto error;
>  	}
> -	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) && !force) {
> +	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) &&
> +	    !force_autochannels) {
>  		fprintf(stderr, "Auto-channels selected but some channels "
>  			"are already activated in sysfs\n");
>  		fprintf(stderr, "Proceeding without activating any channels\n");
>  	}
>  
>  	if ((!num_channels && autochannels == AUTOCHANNELS_ENABLED) ||
> -	    ((autochannels == AUTOCHANNELS_ENABLED) && force)) {
> +	    ((autochannels == AUTOCHANNELS_ENABLED) && force_autochannels)) {
>  		fprintf(stderr, "Enabling all channels\n");
>  
>  		ret = enable_disable_all_channels(dev_dir_name, 1);
> 

