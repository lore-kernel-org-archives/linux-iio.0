Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35882 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbcEDOkD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 May 2016 10:40:03 -0400
Subject: Re: [PATCH 05/13] iio: health/afe440x: Fix scan_index assignment
To: "Andrew F. Davis" <afd@ti.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
 <1462135023-14445-6-git-send-email-afd@ti.com>
Cc: linux-iio@vger.kernel.org, linux-api@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d2c4fafd-2fd0-ab63-df23-4a6fda897554@kernel.org>
Date: Wed, 4 May 2016 11:03:27 +0100
MIME-Version: 1.0
In-Reply-To: <1462135023-14445-6-git-send-email-afd@ti.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/16 21:36, Andrew F. Davis wrote:
> The LED channels are not scannable and so scan_index should
> be negative, fix this here.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
Good point.  I've applied this to the togreg branch, but if
you want me to push this one out as a fix it definitely qualifies.

Jonathan
> ---
>  drivers/iio/health/afe440x.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
> index 544bbab..583d071 100644
> --- a/drivers/iio/health/afe440x.h
> +++ b/drivers/iio/health/afe440x.h
> @@ -125,7 +125,7 @@ struct afe440x_reg_info {
>  		.type = IIO_CURRENT,				\
>  		.channel = _index,				\
>  		.address = _index,				\
> -		.scan_index = _index,				\
> +		.scan_index = -1,				\
>  		.extend_name = _name,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
>  			BIT(IIO_CHAN_INFO_SCALE),		\
> 

