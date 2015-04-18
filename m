Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33394 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445AbbDRTCr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 15:02:47 -0400
Message-ID: <5532AA55.3040609@kernel.org>
Date: Sat, 18 Apr 2015 20:02:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Karol Wrona <k.wrona@samsung.com>, linux-iio@vger.kernel.org
CC: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Karol Wrona <wrona.vy@gmail.com>
Subject: Re: [PATCH] iio: common: ssp_sensors: Fix uninitialized warning for
 timestamp
References: <1429176624-19223-1-git-send-email-k.wrona@samsung.com>
In-Reply-To: <1429176624-19223-1-git-send-email-k.wrona@samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/04/15 10:30, Karol Wrona wrote:
> calculated_time variable caused warning as uninitialized.  It was not harmful
> because it was evaluated in the path in which was used later but it is to
> satisfy the checkers.
> 
> Signed-off-by: Karol Wrona <k.wrona@samsung.com>
Dumb compiler. It's a false positive and as the function is an inline in the header,
it should be able to tell. 

What compiler is spitting out the warning?

> ---
>  drivers/iio/common/ssp_sensors/ssp_iio.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_iio.c b/drivers/iio/common/ssp_sensors/ssp_iio.c
> index a3ae165..16180e6 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_iio.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_iio.c
> @@ -80,7 +80,7 @@ int ssp_common_process_data(struct iio_dev *indio_dev, void *buf,
>  			    unsigned int len, int64_t timestamp)
>  {
>  	__le32 time;
> -	int64_t calculated_time;
> +	int64_t calculated_time = 0;
>  	struct ssp_sensor_data *spd = iio_priv(indio_dev);
>  
>  	if (indio_dev->scan_bytes == 0)
> 

