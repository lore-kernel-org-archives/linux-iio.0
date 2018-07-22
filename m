Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727786AbeGVJPG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 22 Jul 2018 05:15:06 -0400
Date: Sun, 22 Jul 2018 09:19:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: meson-saradc: add support for the
 Meson8m2 SoCs
Message-ID: <20180722091910.20cb9a9d@archlinux>
In-Reply-To: <20180721194049.23265-3-martin.blumenstingl@googlemail.com>
References: <20180721194049.23265-1-martin.blumenstingl@googlemail.com>
        <20180721194049.23265-3-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 21 Jul 2018 21:40:49 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> The SAR ADC on Meson8m2 behaves identical to the one found in the
> Meson8b SoCs. Add a separate compatible string because the temperature
> sensor logic (not supported yet) differs between Meson8 and Meson8m2
> (however, it's the same for Meson8b and Meson8m2).
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Applied, thanks

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 2948909f3ee3..da2d16dfa63e 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -922,6 +922,11 @@ static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
>  	.name = "meson-meson8b-saradc",
>  };
>  
> +static const struct meson_sar_adc_data meson_sar_adc_meson8m2_data = {
> +	.param = &meson_sar_adc_meson8_param,
> +	.name = "meson-meson8m2-saradc",
> +};
> +
>  static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>  	.param = &meson_sar_adc_gxbb_param,
>  	.name = "meson-gxbb-saradc",
> @@ -951,6 +956,10 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
>  		.compatible = "amlogic,meson8b-saradc",
>  		.data = &meson_sar_adc_meson8b_data,
>  	},
> +	{
> +		.compatible = "amlogic,meson8m2-saradc",
> +		.data = &meson_sar_adc_meson8m2_data,
> +	},
>  	{
>  		.compatible = "amlogic,meson-gxbb-saradc",
>  		.data = &meson_sar_adc_gxbb_data,

