Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42840 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938219AbdAHJnh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:43:37 -0500
Subject: Re: [PATCH 11/19] staging: iio: isl29028: made column alignment in
 isl29028_channels consistent
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-12-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <6f358765-6a87-76e1-ab23-207a82e81ee6@kernel.org>
Date: Sun, 4 Dec 2016 11:48:29 +0000
MIME-Version: 1.0
In-Reply-To: <1480817983-32359-12-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/16 02:19, Brian Masney wrote:
> The three info_mask_separate members OR several BIT(xxx) fields
> together. This patch changes the column alignment of these fields to be
> aligned at the same column to improve the overall code readability. It
> also moves the { for the next channel to the next line to improve code
> readability.
Skip the bracket change - to my mind it doesn't improve readability.
I mostly don't care which form is used on these (others are fussier) but
changing it from the one I slightly prefer to the one I dislike
is a step too far ;)

Jonathan

> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/isl29028.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 0e727ba..218d165 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -419,14 +419,16 @@ static const struct iio_chan_spec isl29028_channels[] = {
>  	{
>  		.type = IIO_LIGHT,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> -		BIT(IIO_CHAN_INFO_SCALE),
> -	}, {
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
>  		.type = IIO_INTENSITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -	}, {
> +	},
> +	{
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -		BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +				      BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  	}
>  };
>  
> 

