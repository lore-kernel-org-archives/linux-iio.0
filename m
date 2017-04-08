Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37518 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbdDHOtC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 10:49:02 -0400
Subject: Re: [PATCH v2 2/7] iio: light: rpr0521 whitespace fixes
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491566839-3925-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dd2e1ad8-bb61-f93e-41ed-8595d733e979@kernel.org>
Date: Sat, 8 Apr 2017 15:49:00 +0100
MIME-Version: 1.0
In-Reply-To: <1491566839-3925-2-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/17 13:07, Mikko Koivunen wrote:
> Just whitespace changes, no functional changes.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
> ---
>  drivers/iio/light/rpr0521.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index c15529b..30c2592 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -357,8 +357,8 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  
>  		*val = le16_to_cpu(raw_data);
> -
I'd argue that there are good readability reasons to leave this blank line.
If the original driver hadn't had it I wouldn't have felt strongly enough
to comment on it, but adding noise to remove it seems rather pointless..
>  		return IIO_VAL_INT;
> +
Adding this one is definitely worthwhile though!
>  	case IIO_CHAN_INFO_SCALE:
>  		mutex_lock(&data->lock);
>  		ret = rpr0521_get_gain(data, chan->address, val, val2);
> 

