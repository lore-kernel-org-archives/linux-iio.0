Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52624 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751665AbcL3Sfe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2016 13:35:34 -0500
Subject: Re: [PATCH] iio: dummy: No semicolon at end of function definition
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1482251890-9721-1-git-send-email-pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7d709893-875c-c1e1-3906-3517b468d3e1@kernel.org>
Date: Fri, 30 Dec 2016 18:35:33 +0000
MIME-Version: 1.0
In-Reply-To: <1482251890-9721-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/12/16 16:38, Peter Meerwald-Stadler wrote:
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Ah. My bad habits long ago ;)

Applied.

Thanks,

Jonathan
> ---
>  drivers/iio/dummy/iio_simple_dummy.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/dummy/iio_simple_dummy.h b/drivers/iio/dummy/iio_simple_dummy.h
> index b9069a1..f7005c3 100644
> --- a/drivers/iio/dummy/iio_simple_dummy.h
> +++ b/drivers/iio/dummy/iio_simple_dummy.h
> @@ -88,11 +88,11 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
>  iio_simple_dummy_events_register(struct iio_dev *indio_dev)
>  {
>  	return 0;
> -};
> +}
>  
>  static inline void
>  iio_simple_dummy_events_unregister(struct iio_dev *indio_dev)
> -{ };
> +{}
>  
>  #endif /* CONFIG_IIO_SIMPLE_DUMMY_EVENTS*/
>  
> @@ -119,11 +119,11 @@ enum iio_simple_dummy_scan_elements {
>  static inline int iio_simple_dummy_configure_buffer(struct iio_dev *indio_dev)
>  {
>  	return 0;
> -};
> +}
>  
>  static inline
>  void iio_simple_dummy_unconfigure_buffer(struct iio_dev *indio_dev)
> -{};
> +{}
>  
>  #endif /* CONFIG_IIO_SIMPLE_DUMMY_BUFFER */
>  #endif /* _IIO_SIMPLE_DUMMY_H_ */
> 

