Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57160 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932306Ab3JQVws (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Oct 2013 17:52:48 -0400
Message-ID: <52606A64.8050103@kernel.org>
Date: Thu, 17 Oct 2013 23:53:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 11/11] staging:iio:hmc5843: Trivial cleanup
References: <1381961954-25596-1-git-send-email-pmeerw@pmeerw.net> <1381961954-25596-12-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381961954-25596-12-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/16/13 23:19, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied.

Thanks for your hardwork on this series!

Jonathan
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 7e688dd..99421f9 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -587,7 +587,7 @@ static int hmc5843_remove(struct i2c_client *client)
>  	iio_device_unregister(indio_dev);
>  	iio_triggered_buffer_cleanup(indio_dev);
>  
> -	 /*  sleep mode to save power */
> +	/*  sleep mode to save power */
>  	hmc5843_set_mode(iio_priv(indio_dev), HMC5843_MODE_SLEEP);
>  
>  	return 0;
> 
