Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56536 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab2H0SGt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 Aug 2012 14:06:49 -0400
Message-ID: <503BB737.6030701@kernel.org>
Date: Mon, 27 Aug 2012 19:06:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging iio: fix potential memory leak in lis3l02dq_ring.c
References: <1345664238-5446-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1345664238-5446-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/22/2012 08:37 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Thanks, merged to fixes-togreg.
> ---
>  drivers/staging/iio/accel/lis3l02dq_ring.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/accel/lis3l02dq_ring.c b/drivers/staging/iio/accel/lis3l02dq_ring.c
> index 18d108f..f3da590 100644
> --- a/drivers/staging/iio/accel/lis3l02dq_ring.c
> +++ b/drivers/staging/iio/accel/lis3l02dq_ring.c
> @@ -121,8 +121,10 @@ static int lis3l02dq_get_buffer_element(struct iio_dev *indio_dev,
>  	if (rx_array == NULL)
>  		return -ENOMEM;
>  	ret = lis3l02dq_read_all(indio_dev, rx_array);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kfree(rx_array);
>  		return ret;
> +	}
>  	for (i = 0; i < scan_count; i++)
>  		data[i] = combine_8_to_16(rx_array[i*4+1],
>  					rx_array[i*4+3]);
> 
