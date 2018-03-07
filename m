Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934472AbeCGTxS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 7 Mar 2018 14:53:18 -0500
Date: Wed, 7 Mar 2018 19:53:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: lars@metafoo.de, Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: iio: Remove unnecessary cast on void pointer
Message-ID: <20180307195315.7cd6fe93@archlinux>
In-Reply-To: <20180307131717.GA12326@seema-Inspiron-15-3567>
References: <20180307131717.GA12326@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 7 Mar 2018 18:47:17 +0530
Arushi Singhal <arushisinghal19971997@gmail.com> wrote:

> The following Coccinelle script was used to detect this:
> @r@
> expression x;
> void* e;
> type T;
> identifier f;
> @@
> (
>   *((T *)e)
> |
>   ((T *)x)[...]
> |
>   ((T*)x)->f
> |
> 
> - (T*)
>   e
> )
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing.git
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index bfe180a..bf76a86 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -254,7 +254,7 @@ static const struct attribute_group ad7816_attribute_group = {
>  static irqreturn_t ad7816_event_handler(int irq, void *private)
>  {
>  	iio_push_event(private, IIO_EVENT_CODE_AD7816_OTI,
> -		       iio_get_time_ns((struct iio_dev *)private));
> +		       iio_get_time_ns(private));
>  	return IRQ_HANDLED;
>  }
>  

