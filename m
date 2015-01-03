Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:39025 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751036AbbACQxJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jan 2015 11:53:09 -0500
Date: Sat, 3 Jan 2015 17:53:06 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, marex@denx.de, fabio.estevam@freescale.com,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: mxs-lradc: fix iio channel map regression
Message-ID: <20150103165306.GK4194@piout.net>
References: <1420139477-2361-1-git-send-email-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1420139477-2361-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 01/01/2015 at 19:11:17 +0000, Stefan Wahren wrote :
> Since commit c8231a9af8147f8a ("iio: mxs-lradc: compute temperature
> from channel 8 and 9") with the removal of adc channel 9 there is
> no 1-1 mapping in the channel spec.
> 
> All hwmon channel values above 9 are accessible via there index minus
> one. So add a "bogus" iio channel 9 to fix this issue.
> 

I think the preferred way of doing that was explained there:

https://lkml.org/lkml/2014/6/14/69

Can you take care of that? 

Thanks!

> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index d9d6fad..126a07b 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -1413,6 +1413,7 @@ static const struct iio_chan_spec mxs_lradc_chan_spec[] = {
>  		.channel = 8,
>  		.scan_type = {.sign = 'u', .realbits = 18, .storagebits = 32,},
>  	},
> +	MXS_ADC_CHAN(9, IIO_VOLTAGE),
>  	MXS_ADC_CHAN(10, IIO_VOLTAGE),	/* VDDIO */
>  	MXS_ADC_CHAN(11, IIO_VOLTAGE),	/* VTH */
>  	MXS_ADC_CHAN(12, IIO_VOLTAGE),	/* VDDA */
> --
> 1.7.9.5
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
