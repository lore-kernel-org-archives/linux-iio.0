Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44686 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbcC1KQF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 06:16:05 -0400
Subject: Re: [PATCH] iio: tools: make generic_buffer look for "-trigger"
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1458808754-31088-1-git-send-email-linus.walleij@linaro.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F90460.9020507@kernel.org>
Date: Mon, 28 Mar 2016 11:16:00 +0100
MIME-Version: 1.0
In-Reply-To: <1458808754-31088-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 08:39, Linus Walleij wrote:
> All the ST Sensors use the old "<foo>-trigger" rather than the
> standard "<foo>-devN" new standard suffix for triggers. Now much
> to do about it since it is ABI, but make the testing tools
> recognize it too.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
It is a bit ugly to do the find_trigger_by_name call twice, but I couldn't
find a cleaner way of doing it either, so fair enough.

Applied to the togreg branch of iio.git. Initially pushed out as testing
for the autobuilders to play with it (possibly - adding tools/iio has been
requested and they weren't against it...)

Jonathan
> ---
>  tools/iio/generic_buffer.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 01c4f67801e0..c42b7f836b48 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -304,7 +304,19 @@ int main(int argc, char **argv)
>  			}
>  		}
>  
> -		/* Verify the trigger exists */
> +		/* Look for this "-devN" trigger */
> +		trig_num = find_type_by_name(trigger_name, "trigger");
> +		if (trig_num < 0) {
> +			/* OK try the simpler "-trigger" suffix instead */
> +			free(trigger_name);
> +			ret = asprintf(&trigger_name,
> +				       "%s-trigger", device_name);
> +			if (ret < 0) {
> +				ret = -ENOMEM;
> +				goto error_free_dev_dir_name;
> +			}
> +		}
> +
>  		trig_num = find_type_by_name(trigger_name, "trigger");
>  		if (trig_num < 0) {
>  			fprintf(stderr, "Failed to find the trigger %s\n",
> 

