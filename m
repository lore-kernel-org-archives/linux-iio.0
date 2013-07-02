Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54935 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932521Ab3GBJZF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 2 Jul 2013 05:25:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glki-linux-iio@m.gmane.org>)
	id 1Utwpa-0004tZ-VD
	for linux-iio@vger.kernel.org; Tue, 02 Jul 2013 11:25:02 +0200
Received: from 217.151.242.15 ([217.151.242.15])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2013 11:25:02 +0200
Received: from hector.palacios by 217.151.242.15 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-iio@vger.kernel.org>; Tue, 02 Jul 2013 11:25:02 +0200
To: linux-iio@vger.kernel.org
From: Hector Palacios <hector.palacios@digi.com>
Subject: Re: [PATCH] iio: mxs-lradc: Remove useless check in read_raw
Date: Tue, 02 Jul 2013 11:19:37 +0200
Message-ID: <51D29B29.8080909@digi.com>
References: <1372723722-13902-1-git-send-email-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: public-linux-iio-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org,
	public-otavio-fKevB0iiKLMBZ+LybsDmbA@plane.gmane.org,
	Jonathan Cameron
	<public-jic23-DgEjT+Ai2ygdnm+yROfE0A@plane.gmane.org>,
	Fabio Estevam
	<public-fabio.estevam-KZfg59tc24xl57MIdRCFDg@plane.gmane.org>
In-Reply-To: <1372723722-13902-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear Marek,

On 07/02/2013 02:08 AM, Marek Vasut wrote:
> The removed check in the read_raw implementation was always true,
> therefore remove it.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>   drivers/staging/iio/adc/mxs-lradc.c |    7 -------
>   1 file changed, 7 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index d92c97a..c318eb6 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -234,7 +234,6 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>   {
>   	struct mxs_lradc *lradc = iio_priv(iio_dev);
>   	int ret;
> -	unsigned long mask;
>
>   	if (m != IIO_CHAN_INFO_RAW)
>   		return -EINVAL;
> @@ -243,12 +242,6 @@ static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>   	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
>   		return -EINVAL;
>
> -	/* Validate the channel if it doesn't intersect with reserved chans. */
> -	bitmap_set(&mask, chan->channel, 1);
> -	ret = iio_validate_scan_mask_onehot(iio_dev, &mask);
> -	if (ret)
> -		return -EINVAL;
> -
>   	/*
>   	 * See if there is no buffered operation in progess. If there is, simply
>   	 * bail out. This can be improved to support both buffered and raw IO at
>

By "always true" you mean that it always entered the if and exited with -EINVAL, right?
I just started to look at this driver on my MX28 platform and this check was always 
returning -EINVAL. With this patch I can now read the channels.
Was this what was happening to you as well?

Thank you,
-- 
Héctor Palacios

