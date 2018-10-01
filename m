Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.117]:34548 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729181AbeJAT3a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Oct 2018 15:29:30 -0400
Date: Mon, 1 Oct 2018 14:51:48 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Slawomir Stepien <sst@poczta.fm>
cc: linux-iio@vger.kernel.org, lars@metafoo.de, jic23@kernel.org,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: iio: adc: add missing spaces around minus
 sign
In-Reply-To: <20181001122834.GA13306@x220.localdomain>
Message-ID: <alpine.DEB.2.21.1810011449270.19690@vps.pmeerw.net>
References: <20181001122834.GA13306@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> The checkpatch.pl tool detected coding style problem:
> 
>     CHECK: spaces preferred around that '-' (ctx:VxV)

oh no, not again
please see e.g. https://lore.kernel.org/patchwork/patch/635994/
for some discussion why this patch doesn't make sense
 
> in two files inside the adc directory. This patch will remove this
> problem.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
>  drivers/staging/iio/adc/ad7192.c  | 2 +-
>  drivers/staging/iio/adc/ad7280a.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..7c632cf1932b 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -355,7 +355,7 @@ ad7192_show_scale_available(struct device *dev,
>  }
>  

>  static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
> -			     in_voltage-voltage_scale_available,
> +			     in_voltage - voltage_scale_available,
>  			     0444, ad7192_show_scale_available, NULL, 0);
>  
>  static IIO_DEVICE_ATTR(in_voltage_scale_available, 0444,
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index 58420dcb406d..a4b4f8678c56 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -750,14 +750,14 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  }
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
> -		in_voltage-voltage_thresh_low_value,
> +		in_voltage - voltage_thresh_low_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
>  		AD7280A_CELL_UNDERVOLTAGE);
>  
>  static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
> -		in_voltage-voltage_thresh_high_value,
> +		in_voltage - voltage_thresh_high_value,
>  		0644,
>  		ad7280_read_channel_config,
>  		ad7280_write_channel_config,
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
