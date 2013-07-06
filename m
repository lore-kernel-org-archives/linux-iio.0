Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37610 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752728Ab3GFJiC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 6 Jul 2013 05:38:02 -0400
Message-ID: <51D7E575.40708@kernel.org>
Date: Sat, 06 Jul 2013 10:37:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Wei Yongjun <weiyj.lk@gmail.com>
CC: jic23@cam.ac.uk, gregkh@linuxfoundation.org, sameo@linux.intel.com,
	rachna@ti.com, bigeasy@linutronix.de,
	yongjun_wei@trendmicro.com.cn, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: ti_am335x_adc: add missing .driver_module to struct
 iio_info
References: <CAPgLHd-Y35AOCRLcjdFfoNrK9v6n7Th_gjB-GAPpwoAe81H63w@mail.gmail.com>
In-Reply-To: <CAPgLHd-Y35AOCRLcjdFfoNrK9v6n7Th_gjB-GAPpwoAe81H63w@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/06/2013 05:20 AM, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Add missing .driver_module of struct iio_info. This prevents the
> module from being removed from underneath its users.
> 
> Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Applied to the fixes-togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 5f9a7e7..985f588 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -134,6 +134,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  
>  static const struct iio_info tiadc_info = {
>  	.read_raw = &tiadc_read_raw,
> +	.driver_module = THIS_MODULE,
>  };
>  
>  static int tiadc_probe(struct platform_device *pdev)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
