Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55488 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761290Ab3JPRNg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Oct 2013 13:13:36 -0400
Message-ID: <525ED776.1010807@kernel.org>
Date: Wed, 16 Oct 2013 19:14:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH 09/17] iio:st_magn: Remove redundant call to iio_sw_buffer_preenable().
References: <1381769370-17100-1-git-send-email-lars@metafoo.de> <1381769370-17100-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1381769370-17100-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/13 17:49, Lars-Peter Clausen wrote:
> The equivalent of iio_sw_buffer_preenable() is now done in the IIO buffer core,
> so there is no need to do this from the driver anymore.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Denis Ciocca <denis.ciocca@st.com>
Applied to the togreg branch of iio.git

Thanks
> ---
>  drivers/iio/magnetometer/st_magn_buffer.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> index 708857b..bf427dc 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -25,16 +25,7 @@
>  
>  static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
>  {
> -	int err;
> -
> -	err = st_sensors_set_enable(indio_dev, true);
> -	if (err < 0)
> -		goto st_magn_set_enable_error;
> -
> -	err = iio_sw_buffer_preenable(indio_dev);
> -
> -st_magn_set_enable_error:
> -	return err;
> +	return st_sensors_set_enable(indio_dev, true);
>  }
>  
>  static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
> 
