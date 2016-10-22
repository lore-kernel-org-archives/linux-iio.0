Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53184 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937229AbcJVPUl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 11:20:41 -0400
Subject: Re: [PATCH v2 2/2] tools: iio: iio_generic_buffer: drop unneeded
 parentheses
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org
References: <cover.1476952931.git.eraretuya@gmail.com>
 <514fcbf5d2713395ebe0b6aa0b141ccbbbbeb495.1476952931.git.eraretuya@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c7efff04-620a-4e8d-e6f1-f8a6912a9af0@kernel.org>
Date: Sat, 22 Oct 2016 16:20:40 +0100
MIME-Version: 1.0
In-Reply-To: <514fcbf5d2713395ebe0b6aa0b141ccbbbbeb495.1476952931.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/10/16 10:19, Eva Rachel Retuya wrote:
> Remove extra parentheses introduced in commit <73e176a tools: iio:
> iio_generic_buffer: add -A to force-enable all channels>.
> 
> Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
Applied, thanks,

Jonathan
> ---
>  tools/iio/iio_generic_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 8ef39ae..f0c6f54 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -526,7 +526,7 @@ int main(int argc, char **argv)
>  			"diag %s\n", dev_dir_name);
>  		goto error;
>  	}
> -	if ((num_channels && autochannels == AUTOCHANNELS_ENABLED) &&
> +	if (num_channels && autochannels == AUTOCHANNELS_ENABLED &&
>  	    !force_autochannels) {
>  		fprintf(stderr, "Auto-channels selected but some channels "
>  			"are already activated in sysfs\n");
> @@ -534,7 +534,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	if ((!num_channels && autochannels == AUTOCHANNELS_ENABLED) ||
> -	    ((autochannels == AUTOCHANNELS_ENABLED) && force_autochannels)) {
> +	    (autochannels == AUTOCHANNELS_ENABLED && force_autochannels)) {
>  		fprintf(stderr, "Enabling all channels\n");
>  
>  		ret = enable_disable_all_channels(dev_dir_name, 1);
> 

