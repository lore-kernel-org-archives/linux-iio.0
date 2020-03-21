Return-Path: <SRS0=UYdU=5G=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E59C4332B
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 16:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BEFD20767
	for <linux-iio@archiver.kernel.org>; Sat, 21 Mar 2020 16:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584809458;
	bh=RPv8UOgVIs9nCDe9evJHx/ZTgUSYEbnD3Cig1MBBG6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PNtr3jA6aybEIuKgqH6DCoYCjJdM0NzrpSPCPWM4L1r87/3IaghJn+72z7QHuPvM3
	 /QFcsORFuITAcaoJ7f0gSwrQGa1lAlA8bIXatMw5mjUDww+7zH0o7QPrPSp+vu/9vr
	 9DXdKXqDDn18HNFvnWOtmjSJjpQHEmXEYYVp3vDM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgCUQu5 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 21 Mar 2020 12:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbgCUQu5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Mar 2020 12:50:57 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AF8420732;
        Sat, 21 Mar 2020 16:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584809457;
        bh=RPv8UOgVIs9nCDe9evJHx/ZTgUSYEbnD3Cig1MBBG6s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qj+0UFgC3EdAGwCjvlH5rJQ0G4xWBpKyDbEAA3vpjV2DGwB1BXnZJZjuyoSEU5JJv
         38jmt1WVyFPNZMX3AC9rqM0K4eiRSG6ffEevLKQjKYod7YqQouwq8OogNt8Q1H8kyV
         fTkTHA4nvs9s9G5vAXl6v6mAKkMdT8wsDPLx2CZ8=
Date:   Sat, 21 Mar 2020 16:50:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lars@metafoo.de>
Subject: Re: [PATCH v2 1/5] iio: adc: ad7780: define/use own IIO channel
 macros
Message-ID: <20200321165053.0af56ffe@archlinux>
In-Reply-To: <20200321090802.11537-1-alexandru.ardelean@analog.com>
References: <20200321090802.11537-1-alexandru.ardelean@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 21 Mar 2020 11:07:58 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This change gets rid of the AD_SD_*_CHANNEL macros in favor of defining
> it's own. The ad7780 is quite simpler than it's other Sigma-Delta brothers.
> 
> It turned out that centralizing the AD_SD_*_CHANNEL macros doesn't scale
> too well, especially with some more complicated drivers. Some of the
> variations in the more complicated drivers require new macros, and that way
> things can become harder to maintain.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan

> ---
> 
> Changelog v1 -> v2:
> * re-send + change author @analog.com; GMail messed it up
> 
>  drivers/iio/adc/ad7780.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7780.c b/drivers/iio/adc/ad7780.c
> index 291c1a898129..f47606ebbbbe 100644
> --- a/drivers/iio/adc/ad7780.c
> +++ b/drivers/iio/adc/ad7780.c
> @@ -206,10 +206,29 @@ static const struct ad_sigma_delta_info ad7780_sigma_delta_info = {
>  	.irq_flags = IRQF_TRIGGER_LOW,
>  };
>  
> -#define AD7780_CHANNEL(bits, wordsize) \
> -	AD_SD_CHANNEL(1, 0, 0, bits, 32, (wordsize) - (bits))
> -#define AD7170_CHANNEL(bits, wordsize) \
> -	AD_SD_CHANNEL_NO_SAMP_FREQ(1, 0, 0, bits, 32, (wordsize) - (bits))
> +#define _AD7780_CHANNEL(_bits, _wordsize, _mask_all)		\
> +{								\
> +	.type = IIO_VOLTAGE,					\
> +	.indexed = 1,						\
> +	.channel = 0,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +		BIT(IIO_CHAN_INFO_OFFSET),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.info_mask_shared_by_all = _mask_all,			\
> +	.scan_index = 1,					\
> +	.scan_type = {						\
> +		.sign = 'u',					\
> +		.realbits = (_bits),				\
> +		.storagebits = 32,				\
> +		.shift = (_wordsize) - (_bits),			\
> +		.endianness = IIO_BE,				\
> +	},							\
> +}
> +
> +#define AD7780_CHANNEL(_bits, _wordsize)	\
> +	_AD7780_CHANNEL(_bits, _wordsize, BIT(IIO_CHAN_INFO_SAMP_FREQ))
> +#define AD7170_CHANNEL(_bits, _wordsize)	\
> +	_AD7780_CHANNEL(_bits, _wordsize, 0)
>  
>  static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  	[ID_AD7170] = {

