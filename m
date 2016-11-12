Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35903 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966413AbcKLQgm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2016 11:36:42 -0500
Subject: Re: [PATCH v3 16/28] staging: iio: tsl2583: updated code comment to
 match what the code does
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
 <1478769964-7065-17-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <67166adf-5a89-3283-8a16-9a0a9a57e770@kernel.org>
Date: Sat, 12 Nov 2016 16:36:37 +0000
MIME-Version: 1.0
In-Reply-To: <1478769964-7065-17-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/11/16 09:25, Brian Masney wrote:
> If channel 0 does not have any data, then the code sets the lux to zero.
> The corresponding comment says that the last value is returned. This
> updates the comment to correctly reflect what the code does.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Better perhaps to just return an error, -EAGAIN perhaps?
I'm not sure why it would not give a value.
> ---
>  drivers/staging/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 52a39a6..390ff8b 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -221,7 +221,7 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
>  		goto return_max;
>  
>  	if (!ch0) {
> -		/* have no data, so return LAST VALUE */
> +		/* have no data, so return 0 */
>  		ret = 0;
>  		chip->als_cur_info.lux = 0;
>  		goto done;
> 

