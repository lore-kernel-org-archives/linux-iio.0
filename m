Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45974 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752014AbbKOKyU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 15 Nov 2015 05:54:20 -0500
Subject: Re: [PATCH v3] iio: core: added support for IIO_VAL_INT
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org
References: <1447073734-18602-1-git-send-email-sean.nyekjaer@prevas.dk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56486458.4000801@kernel.org>
Date: Sun, 15 Nov 2015 10:54:16 +0000
MIME-Version: 1.0
In-Reply-To: <1447073734-18602-1-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/11/15 12:55, Sean Nyekjaer wrote:
> Added core support for IIO_VAL_INT in write_raw_get_fmt function.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to try and break it.

Thanks for sorting this out!

Jonathan
> ---
> Sorry for v1, i've missed the "too many 'd's" comment
> 
> Changes since v2:
>  - Fixed commit msg
> 
> Changes since v1:
>  - fract_mult set to 0
>  - iio_str_to_fixpoint uses kstrtoint for fract_mult = 0
> 
>  drivers/iio/industrialio-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 208358f..d0a84fe 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -512,6 +512,12 @@ int iio_str_to_fixpoint(const char *str, int fract_mult,
>  	int i = 0, f = 0;
>  	bool integer_part = true, negative = false;
>  
> +	if (fract_mult == 0) {
> +		*fract = 0;
> +
> +		return kstrtoint(str, 0, integer);
> +	}
> +
>  	if (str[0] == '-') {
>  		negative = true;
>  		str++;
> @@ -571,6 +577,9 @@ static ssize_t iio_write_channel_info(struct device *dev,
>  	if (indio_dev->info->write_raw_get_fmt)
>  		switch (indio_dev->info->write_raw_get_fmt(indio_dev,
>  			this_attr->c, this_attr->address)) {
> +		case IIO_VAL_INT:
> +			fract_mult = 0;
> +			break;
>  		case IIO_VAL_INT_PLUS_MICRO:
>  			fract_mult = 100000;
>  			break;
> 

