Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:12770 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752723Ab3B0UpQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Feb 2013 15:45:16 -0500
Message-ID: <512E705A.3050100@nvidia.com>
Date: Wed, 27 Feb 2013 15:45:14 -0500
From: Rhyland Klein <rklein@nvidia.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 58/67] staging:iio:light:isl29018 move to info_mask_(shared_by_type/separate)
References: <1361997553-31058-1-git-send-email-jic23@kernel.org> <1361997553-31058-59-git-send-email-jic23@kernel.org>
In-Reply-To: <1361997553-31058-59-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2/27/2013 3:39 PM, Jonathan Cameron wrote:
> The original info_mask is going away in favour of the broken out versions.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> cc: Rhyland Klein <rklein@nvidia.com>
> ---
>   drivers/staging/iio/light/isl29018.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index b0adac0..c1bf1d5 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -412,17 +412,17 @@ static const struct iio_chan_spec isl29018_channels[] = {
>   		.type = IIO_LIGHT,
>   		.indexed = 1,
>   		.channel = 0,
> -		.info_mask = IIO_CHAN_INFO_PROCESSED_SEPARATE_BIT |
> -		IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT,
> +		.info_mask_separate = IIO_CHAN_INFO_PROCESSED |
> +		IIO_CHAN_INFO_CALIBSCALE,
>   	}, {
>   		.type = IIO_INTENSITY,
>   		.modified = 1,
> -		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
> +		.info_mask_separate = IIO_CHAN_INFO_RAW,
>   		.channel2 = IIO_MOD_LIGHT_IR,
>   	}, {
>   		/* Unindexed in current ABI.  But perhaps it should be. */
>   		.type = IIO_PROXIMITY,
> -		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,
> +		.info_mask_separate = IIO_CHAN_INFO_RAW,
>   	}
>   };
>   
looks good to me.

Acked-by Rhyland Klein <rklein@nvidia.com>

-- 
nvpublic

