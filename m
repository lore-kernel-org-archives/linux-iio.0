Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34416 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304Ab3ASNuo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 19 Jan 2013 08:50:44 -0500
Message-ID: <50FAA4B2.1020200@kernel.org>
Date: Sat, 19 Jan 2013 13:50:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 01/15] staging:iio:adis16400: Don't pass 0 to ilog2
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/16/2013 12:48 PM, Lars-Peter Clausen wrote:
> ilog2 is not defined for 0, so we need to handle the case where the requested
> frequency is larger than the base sampling rate. In this case we'll round down
> and set the sampling rate to the base sampling rate.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Added whole series to togreg branch of iio.git

Also, now these are in, I have applied the sw_ring removal series that
I held at Lars-Peter's request as this series was on its way.


> ---
>  drivers/staging/iio/imu/adis16400_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/imu/adis16400_core.c b/drivers/staging/iio/imu/adis16400_core.c
> index 9c8f5ab..cb66225 100644
> --- a/drivers/staging/iio/imu/adis16400_core.c
> +++ b/drivers/staging/iio/imu/adis16400_core.c
> @@ -178,7 +178,11 @@ static int adis16334_set_freq(struct iio_dev *indio_dev, unsigned int freq)
>  {
>  	unsigned int t;
>  
> -	t = ilog2(8192 / (freq * 10));
> +	freq *= 10;
> +	if (freq < 8192)
> +		t = ilog2(8192 / freq);
> +	else
> +		t = 0;
>  
>  	if (t > 0x31)
>  		t = 0x31;
> 
