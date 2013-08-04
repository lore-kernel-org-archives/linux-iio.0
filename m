Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44318 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab3HDJEU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 05:04:20 -0400
Message-ID: <51FE272D.10504@kernel.org>
Date: Sun, 04 Aug 2013 11:04:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: Re: [PATCH 4/9] staging:iio:hmc5843: 'add' is a poor abbreviation
 for address
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net> <1374939112-18237-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/13 16:31, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Confusing indeed.

Applied to the togreg branch of iio.git.

Thanks,
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 79117ad..465dc2a 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -556,14 +556,14 @@ static int hmc5843_read_raw(struct iio_dev *indio_dev,
>  	return -EINVAL;
>  }
>  
> -#define HMC5843_CHANNEL(axis, add)					\
> +#define HMC5843_CHANNEL(axis, addr)					\
>  	{								\
>  		.type = IIO_MAGN,					\
>  		.modified = 1,						\
>  		.channel2 = IIO_MOD_##axis,				\
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> -		.address = add						\
> +		.address = addr						\
>  	}
>  
>  static const struct iio_chan_spec hmc5843_channels[] = {
> 
