Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58433 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1435080AbdDZGbf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 02:31:35 -0400
Subject: Re: [PATCH 3/3] iio: adc: meson-saradc: mark all meson_sar_adc_data
 static and const
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
References: <20170417182820.26670-1-martin.blumenstingl@googlemail.com>
 <20170417182820.26670-4-martin.blumenstingl@googlemail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <c1dd71e0-8c25-17ac-b113-291ebbdd5972@kernel.org>
Date: Wed, 26 Apr 2017 07:31:28 +0100
MIME-Version: 1.0
In-Reply-To: <20170417182820.26670-4-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/04/17 19:28, Martin Blumenstingl wrote:
> These are only passed as of_device_id.data and never modified. Thus we
> can mark them as static const, just like the of_device_id instances
> where they are used.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reordering the patches would make this simpler as you'd only have
to do the existing ones.

Not a bit issue though so you could just not bother...

Jonathan
> ---
>  drivers/iio/adc/meson_saradc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index cf13691009ee..8f742b71b165 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -843,31 +843,31 @@ static const struct iio_info meson_sar_adc_iio_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_meson8_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
>  	.has_bl30_integration = false,
>  	.resolution = 10,
>  	.name = "meson-meson8b-saradc",
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
>  	.has_bl30_integration = false,
>  	.resolution = 10,
>  	.name = "meson-meson8b-saradc",
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
>  	.has_bl30_integration = true,
>  	.resolution = 10,
>  	.name = "meson-gxbb-saradc",
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_gxl_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
>  	.has_bl30_integration = true,
>  	.resolution = 12,
>  	.name = "meson-gxl-saradc",
>  };
>  
> -struct meson_sar_adc_data meson_sar_adc_gxm_data = {
> +static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
>  	.has_bl30_integration = true,
>  	.resolution = 12,
>  	.name = "meson-gxm-saradc",
> 

