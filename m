Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54590 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175Ab1IANCf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 1 Sep 2011 09:02:35 -0400
Message-ID: <4E5F8459.7030400@cam.ac.uk>
Date: Thu, 01 Sep 2011 14:10:49 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH] iio: ad7152: fix channel assignment for AD7153
References: <1314876904-20984-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314876904-20984-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/11 12:35, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> In case the AD7153 is selected we need to make sure we provide channel info
> for the first capacitance input in both single ended and differential
> configuration.
Good point. I didn't think my original fix through.
> 
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
merged

looks like master.kernel.org is still undergoing reinstall so it'll be local
to me for a while (or to Greg when I've sent it on).
> ---
>  drivers/staging/iio/adc/ad7152.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7152.c b/drivers/staging/iio/adc/ad7152.c
> index 42efc37..dac3392 100644
> --- a/drivers/staging/iio/adc/ad7152.c
> +++ b/drivers/staging/iio/adc/ad7152.c
> @@ -440,17 +440,17 @@ static const struct iio_chan_spec ad7152_channels[] = {
>  		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
>  	}, {
>  		.type = IIO_CAPACITANCE,
> +		.differential = 1,
>  		.indexed = 1,
> -		.channel = 1,
> +		.channel = 0,
> +		.channel2 = 2,
>  		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
>  		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
>  		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),
>  	}, {
>  		.type = IIO_CAPACITANCE,
> -		.differential = 1,
>  		.indexed = 1,
> -		.channel = 0,
> -		.channel2 = 2,
> +		.channel = 1,
>  		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE) |
>  		(1 << IIO_CHAN_INFO_CALIBBIAS_SEPARATE) |
>  		(1 << IIO_CHAN_INFO_SCALE_SEPARATE),

