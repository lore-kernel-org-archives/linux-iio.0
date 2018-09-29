Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbeI2SRT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 29 Sep 2018 14:17:19 -0400
Date: Sat, 29 Sep 2018 12:49:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-iio@vger.kernel.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 1/2] iio: adc: meson-saradc: do not use
 meson_sar_adc_iio_channels directly
Message-ID: <20180929124905.70259e84@archlinux>
In-Reply-To: <20180924221326.2871-2-martin.blumenstingl@googlemail.com>
References: <20180924221326.2871-1-martin.blumenstingl@googlemail.com>
        <20180924221326.2871-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 25 Sep 2018 00:13:25 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> In the future we may support two different channel sets:
> - one which includes the voltage pads and the temperature sensor output
>   (for Meson8, Meson8b and Meson8m2)
> - one which only includes the voltage pads (GXBB, GXL, GXM and AXG)
> 
> Channel 7 has a special function on all of these platforms. However,
> since we will have different channel array definitions we want our code
> to always use whatever channels struct iio_dev uses.
> 
> No functional changes for now. This is the preparation for adding
> temperature sensor support to this driver.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Straight forward and 'obviously' correct.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/meson_saradc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 1c4ba83c0725..809d1230be34 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -854,7 +854,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
>  	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
>  	usleep_range(10, 20);
>  	ret = meson_sar_adc_get_sample(indio_dev,
> -				       &meson_sar_adc_iio_channels[7],
> +				       &indio_dev->channels[7],
>  				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
>  	if (ret < 0)
>  		goto out;
> @@ -862,7 +862,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
>  	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
>  	usleep_range(10, 20);
>  	ret = meson_sar_adc_get_sample(indio_dev,
> -				       &meson_sar_adc_iio_channels[7],
> +				       &indio_dev->channels[7],
>  				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
>  	if (ret < 0)
>  		goto out;
