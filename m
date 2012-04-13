Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-152.synserver.de ([212.40.185.152]:1043 "EHLO
	smtp-out-147.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751194Ab2DMOaf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 10:30:35 -0400
Message-ID: <4F883921.4080109@metafoo.de>
Date: Fri, 13 Apr 2012 16:33:05 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 02/13] staging:iio:accel Add IIO_CHAN_INFO_RAW entries
 to all drivers.
References: <1334311471-23054-1-git-send-email-jic23@kernel.org> <1334311471-23054-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1334311471-23054-3-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/13/2012 12:04 PM, Jonathan Cameron wrote:
> Precursor to making value read / write attribute optional.
> No processed values in accelerometers.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> ---
> [...]
> 
> diff --git a/drivers/staging/iio/accel/adis16209_core.c b/drivers/staging/iio/accel/adis16209_core.c
> index 02c003f..114602e 100644
> --- a/drivers/staging/iio/accel/adis16209_core.c
> +++ b/drivers/staging/iio/accel/adis16209_core.c
> [...]
> @@ -425,7 +426,8 @@ static struct iio_chan_spec adis16209_channels[] = {
>  		.type = IIO_TEMP,
>  		.indexed = 0,
>  		.channel = 0,
> -		.info_mask = IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
> +		.info_mask =  IIO_CHAN_INFO_RAW_SEPARATE_BIT |

Here is a extra space.

> +		IIO_CHAN_INFO_SCALE_SEPARATE_BIT |
>  		IIO_CHAN_INFO_OFFSET_SEPARATE_BIT,
>  		.address = temp,
>  		.scan_index = ADIS16209_SCAN_TEMP,
> [...]
