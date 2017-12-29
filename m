Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751107AbdL2RqH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:46:07 -0500
Date: Fri, 29 Dec 2017 17:46:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v2 1/7] iio: adc: ina2xx: Remove bogus cast for data
 argument
Message-ID: <20171229174602.26e7d62d@archlinux>
In-Reply-To: <b59a9f59-da42-41b6-926b-50fb5b7909c3@rwthex-w2-a.rwth-ad.de>
References: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
        <b59a9f59-da42-41b6-926b-50fb5b7909c3@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 21 Dec 2017 19:31:32 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> iio_push_to_buffers_with_timestamp expects a void pointer, so the cast
> is both unnecessary and misleading.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Hi Stefan,

I applied the first few patches the first time around.
Please drop them from new versions - if nothing else 
if confuses me ;)

> ---
> 
> Changes in v2: None
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

