Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52781 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750969Ab3HSRy4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 13:54:56 -0400
Message-ID: <521269FB.4040402@kernel.org>
Date: Mon, 19 Aug 2013 19:54:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adjd_s311: Fix non-scan mode data read
References: <1376830753-2430-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1376830753-2430-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/18/13 13:59, Peter Meerwald wrote:
> forgot to convert channel index to data register
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/light/adjd_s311.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/light/adjd_s311.c b/drivers/iio/light/adjd_s311.c
> index 55b9e18..c4b730d 100644
> --- a/drivers/iio/light/adjd_s311.c
> +++ b/drivers/iio/light/adjd_s311.c
> @@ -232,7 +232,8 @@ static int adjd_s311_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = adjd_s311_read_data(indio_dev, chan->address, val);
> +		ret = adjd_s311_read_data(indio_dev,
> +			ADJD_S311_DATA_REG(chan->address), val);
>  		if (ret < 0)
>  			return ret;
>  		return IIO_VAL_INT;
> 
