Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40429 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933745AbcKMMSg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Nov 2016 07:18:36 -0500
Subject: Re: [PATCH v4 14/26] staging: iio: tsl2583: updated code comment to
 match what the code does
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
 <1478974781-1457-15-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b824100e-05d1-f43a-08fb-471819646f91@kernel.org>
Date: Sun, 13 Nov 2016 12:18:30 +0000
MIME-Version: 1.0
In-Reply-To: <1478974781-1457-15-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/11/16 18:19, Brian Masney wrote:
> If channel 0 does not have any data, then the code sets the lux to zero.
> The corresponding comment says that the last value is returned. This
> updates the comment to correctly reflect what the code does. It also
> clarifies the comment about why 0 is returned.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.
> ---
>  drivers/staging/iio/light/tsl2583.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 52a39a6..dbb7f6a 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -221,7 +221,11 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
>  		goto return_max;
>  
>  	if (!ch0) {
> -		/* have no data, so return LAST VALUE */
> +		/*
> +		 * The sensor appears to be in total darkness so set the
> +		 * calculated lux to 0 and return early to avoid a division by
> +		 * zero below when calculating the ratio.
> +		 */
>  		ret = 0;
>  		chip->als_cur_info.lux = 0;
>  		goto done;
> 

