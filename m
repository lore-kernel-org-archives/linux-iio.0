Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750775AbdFCI10 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 04:27:26 -0400
Date: Sat, 3 Jun 2017 09:27:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Paolo Cretaro <paolocretaro@gmail.com>
Cc: ksenija.stanojevic@gmail.com, marex@denx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mxs-lradc: fix non-static symbol warnings
Message-ID: <20170603092720.0b157a4f@kernel.org>
In-Reply-To: <20170531235055.30063-1-paolocretaro@gmail.com>
References: <20170531235055.30063-1-paolocretaro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu,  1 Jun 2017 01:50:55 +0200
Paolo Cretaro <paolocretaro@gmail.com> wrote:

> Fix sparse warning "symbol foo was not declared. Should it be static?"
> for the following symbols:
> mx23_lradc_adc_irq_names
> mx28_lradc_adc_irq_names
> iio_dev_attr_in_voltage0_scale_available
> iio_dev_attr_in_voltage1_scale_available
> iio_dev_attr_in_voltage2_scale_available
> iio_dev_attr_in_voltage3_scale_available
> iio_dev_attr_in_voltage4_scale_available
> iio_dev_attr_in_voltage5_scale_available
> iio_dev_attr_in_voltage6_scale_available
> iio_dev_attr_in_voltage7_scale_available
> iio_dev_attr_in_voltage10_scale_available
> iio_dev_attr_in_voltage11_scale_available
> iio_dev_attr_in_voltage12_scale_available
> iio_dev_attr_in_voltage13_scale_available
> iio_dev_attr_in_voltage14_scale_available
> iio_dev_attr_in_voltage15_scale_available
> 
> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>
Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mxs-lradc-adc.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
> index b0c7d8ee5cb8..3f955c1c14a0 100644
> --- a/drivers/iio/adc/mxs-lradc-adc.c
> +++ b/drivers/iio/adc/mxs-lradc-adc.c
> @@ -48,7 +48,7 @@
>  
>  #define VREF_MV_BASE 1850
>  
> -const char *mx23_lradc_adc_irq_names[] = {
> +static const char *mx23_lradc_adc_irq_names[] = {
>  	"mxs-lradc-channel0",
>  	"mxs-lradc-channel1",
>  	"mxs-lradc-channel2",
> @@ -57,7 +57,7 @@ const char *mx23_lradc_adc_irq_names[] = {
>  	"mxs-lradc-channel5",
>  };
>  
> -const char *mx28_lradc_adc_irq_names[] = {
> +static const char *mx28_lradc_adc_irq_names[] = {
>  	"mxs-lradc-thresh0",
>  	"mxs-lradc-thresh1",
>  	"mxs-lradc-channel0",
> @@ -344,20 +344,20 @@ static ssize_t mxs_lradc_adc_show_scale_avail(struct device *dev,
>  	IIO_DEVICE_ATTR(in_voltage##ch##_scale_available, 0444,\
>  			mxs_lradc_adc_show_scale_avail, NULL, ch)
>  
> -SHOW_SCALE_AVAILABLE_ATTR(0);
> -SHOW_SCALE_AVAILABLE_ATTR(1);
> -SHOW_SCALE_AVAILABLE_ATTR(2);
> -SHOW_SCALE_AVAILABLE_ATTR(3);
> -SHOW_SCALE_AVAILABLE_ATTR(4);
> -SHOW_SCALE_AVAILABLE_ATTR(5);
> -SHOW_SCALE_AVAILABLE_ATTR(6);
> -SHOW_SCALE_AVAILABLE_ATTR(7);
> -SHOW_SCALE_AVAILABLE_ATTR(10);
> -SHOW_SCALE_AVAILABLE_ATTR(11);
> -SHOW_SCALE_AVAILABLE_ATTR(12);
> -SHOW_SCALE_AVAILABLE_ATTR(13);
> -SHOW_SCALE_AVAILABLE_ATTR(14);
> -SHOW_SCALE_AVAILABLE_ATTR(15);
> +static SHOW_SCALE_AVAILABLE_ATTR(0);
> +static SHOW_SCALE_AVAILABLE_ATTR(1);
> +static SHOW_SCALE_AVAILABLE_ATTR(2);
> +static SHOW_SCALE_AVAILABLE_ATTR(3);
> +static SHOW_SCALE_AVAILABLE_ATTR(4);
> +static SHOW_SCALE_AVAILABLE_ATTR(5);
> +static SHOW_SCALE_AVAILABLE_ATTR(6);
> +static SHOW_SCALE_AVAILABLE_ATTR(7);
> +static SHOW_SCALE_AVAILABLE_ATTR(10);
> +static SHOW_SCALE_AVAILABLE_ATTR(11);
> +static SHOW_SCALE_AVAILABLE_ATTR(12);
> +static SHOW_SCALE_AVAILABLE_ATTR(13);
> +static SHOW_SCALE_AVAILABLE_ATTR(14);
> +static SHOW_SCALE_AVAILABLE_ATTR(15);
>  
>  static struct attribute *mxs_lradc_adc_attributes[] = {
>  	&iio_dev_attr_in_voltage0_scale_available.dev_attr.attr,

