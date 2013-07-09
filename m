Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45289 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169Ab3GIVQW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jul 2013 17:16:22 -0400
Message-ID: <51DC7DA5.4090507@kernel.org>
Date: Tue, 09 Jul 2013 22:16:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 5/5] iio: fix semicolon in io_core_trigger.h
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net> <1373228646-5356-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-5-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/07/2013 09:24 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/iio_core_trigger.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
> index 6f7c56f..1fdb1e4 100644
> --- a/drivers/iio/iio_core_trigger.h
> +++ b/drivers/iio/iio_core_trigger.h
> @@ -30,7 +30,7 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
>  static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>  {
>  	return 0;
> -};
> +}
>  
>  /**
>   * iio_device_unregister_trigger_consumer() - reverse the registration process
> @@ -38,9 +38,6 @@ static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
>   **/
>  static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
>  {
> -};
> +}
>  
>  #endif /* CONFIG_TRIGGER_CONSUMER */
> -
> -
> -
> 
