Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47212 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbcEUTVq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 May 2016 15:21:46 -0400
Subject: Re: [PATCH] max44000: Remove scale from proximity
To: Crestez Dan Leonard <leonard.crestez@intel.com>,
	linux-iio@vger.kernel.org
References: <ecdf6ef45b5010c079dd7a2876204c20dcc4bfb7.1463755473.git.leonard.crestez@intel.com>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1f6f8c36-e15b-8d4e-b6c8-bba3f8e53e49@kernel.org>
Date: Sat, 21 May 2016 20:21:44 +0100
MIME-Version: 1.0
In-Reply-To: <ecdf6ef45b5010c079dd7a2876204c20dcc4bfb7.1463755473.git.leonard.crestez@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/05/16 15:44, Crestez Dan Leonard wrote:
> This is not implemented and doesn't really make sense because IIO
> proximity is unit-less.
> 
> Remove IIO_CHAN_INFO_SCALE from info_mask because so that the _scale
> sysfs entry won't appear. This fixes userspace tools like generic_buffer
> which abort when reads returns an error.
> 
Applied to the fixes-togreg-post-rc1 branch of iio.git.

Thanks,

Jonathan
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  drivers/iio/light/max44000.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
> index e01e58a..f17cb2e 100644
> --- a/drivers/iio/light/max44000.c
> +++ b/drivers/iio/light/max44000.c
> @@ -147,7 +147,6 @@ static const struct iio_chan_spec max44000_channels[] = {
>  	{
>  		.type = IIO_PROXIMITY,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
>  		.scan_index = MAX44000_SCAN_INDEX_PRX,
>  		.scan_type = {
>  			.sign		= 'u',
> 

