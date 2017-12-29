Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:60326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751727AbdL2RtI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:49:08 -0500
Date: Fri, 29 Dec 2017 17:49:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maciej Purski <m.purski@samsung.com>,
        <linux-kernel@vger.kernel.org>, "Andrew F . Davis" <afd@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v2 6/7] iio: adc: ina2xx: Align timestamp with
 conversion ready flag
Message-ID: <20171229174903.1b2f66b7@archlinux>
In-Reply-To: <78c52a18-e747-4661-963c-d06e05631eda@rwthex-w2-a.rwth-ad.de>
References: <20171221183138.361-1-stefan.bruens@rwth-aachen.de>
        <78c52a18-e747-4661-963c-d06e05631eda@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 21 Dec 2017 19:31:37 +0100
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> As the timestamp is no longer (ab-)used to measure the function run time,
> it can be taken at the correct time, i.e. when the conversion has finished.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
Applied.

Thanks,

Jonathan

> ---
> 
> Changes in v2: None
> 
>  drivers/iio/adc/ina2xx-adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 415e53b5c0a6..b7407ac91b59 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -706,8 +706,6 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  	s64 time;
>  	unsigned int alert;
>  
> -	time = iio_get_time_ns(indio_dev);
> -
>  	/*
>  	 * Because the timer thread and the chip conversion clock
>  	 * are asynchronous, the period difference will eventually
> @@ -736,6 +734,8 @@ static int ina2xx_work_buffer(struct iio_dev *indio_dev)
>  
>  		} while (!alert);
>  
> +	time = iio_get_time_ns(indio_dev);
> +
>  	/*
>  	 * Single register reads: bulk_read will not work with ina226/219
>  	 * as there is no auto-increment of the register pointer.

