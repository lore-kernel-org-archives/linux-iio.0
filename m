Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37744 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbdDHPaL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Apr 2017 11:30:11 -0400
Subject: Re: [PATCH v2 7/7] iio: light: rpr0521 magic number to sizeof() on
 value read
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
 <1491566839-3925-7-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b2a5a720-b025-a6d3-1c20-962b10a7893b@kernel.org>
Date: Sat, 8 Apr 2017 16:30:10 +0100
MIME-Version: 1.0
In-Reply-To: <1491566839-3925-7-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/04/17 13:07, Mikko Koivunen wrote:
> Changed magic number to sizeof() on value read.
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Nice little change. I'd have preferred it near the start of the set
before you got going as it could have been picked up whilst the
complex stuff was undergoing revision.

Anyhow, will pick up when the rest is ready.

Jonathan
> ---
> Tested on LeMaker HiKey AOSP7, kernel 4.4.
> checkpatch.pl ok
> ---
>  drivers/iio/light/rpr0521.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index 72f608d..75fd3ca 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -662,7 +662,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
>  
>  		ret = regmap_bulk_read(data->regmap,
>  				       rpr0521_data_reg[chan->address].address,
> -				       &raw_data, 2);
> +				       &raw_data, sizeof(raw_data));
>  		if (ret < 0) {
>  			rpr0521_set_power_state(data, false, device_mask);
>  			mutex_unlock(&data->lock);
> 

