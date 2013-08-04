Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44531 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752516Ab3HDJXb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 4 Aug 2013 05:23:31 -0400
Message-ID: <51FE2BA7.1030701@kernel.org>
Date: Sun, 04 Aug 2013 11:23:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 9/9] staging:iio:hmc5843: Use i2c_smbus_read_word_swapped()
References: <1374939112-18237-1-git-send-email-pmeerw@pmeerw.net> <1374939112-18237-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1374939112-18237-10-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/27/13 16:31, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,

So, all applied except for those two patches in the middle that seem
to have gotten rather scrambled up.

Jonathan
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 0b24d7e..70541aa 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -221,12 +221,12 @@ static int hmc5843_read_measurement(struct iio_dev *indio_dev,
>  		return -EIO;
>  	}
>  
> -	result = i2c_smbus_read_word_data(client, address);
> +	result = i2c_smbus_read_word_swapped(client, address);
>  	mutex_unlock(&data->lock);
>  	if (result < 0)
>  		return -EINVAL;
>  
> -	*val = (s16)swab16((u16)result);
> +	*val = result;
>  	return IIO_VAL_INT;
>  }
>  
> 
