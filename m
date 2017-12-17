Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbdLQJnb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Dec 2017 04:43:31 -0500
Date: Sun, 17 Dec 2017 09:43:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        "Javier Martinez Canillas" <javier@osg.samsung.com>
Subject: Re: [PATCH v1 1/7] iio: adc: ina2xx: Remove bogus cast for data
 argument
Message-ID: <20171217094320.59d395b3@archlinux>
In-Reply-To: <03d5c78a-96c2-4f6d-9333-8d5a0e590745@rwthex-w2-a.rwth-ad.de>
References: <20171208174152.30341-1-stefan.bruens@rwth-aachen.de>
        <03d5c78a-96c2-4f6d-9333-8d5a0e590745@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 8 Dec 2017 18:41:46 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> iio_push_to_buffers_with_timestamp expects a void pointer, so the cast
> is both unnecessary and misleading.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
>  drivers/iio/adc/ina2xx-adc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index ddf878163bf9..3195f8754c3b 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -767,8 +767,7 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  
>  	time_b = iio_get_time_ns(indio_dev);
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev,
> -					   (unsigned int *)data, time_a);
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, time_a);
>  
>  	return (unsigned long)(time_b - time_a) / 1000;
>  };

