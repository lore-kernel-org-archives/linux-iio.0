Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35173 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbdAUO1l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:27:41 -0500
Subject: Re: [PATCH] iio: adc: palmas_gpadc: retrieve a valid iio_dev in
 suspend/resume
To: Alison Schofield <amsfield22@gmail.com>
References: <20170116192742.GA9521@d830.WORKGROUP>
Cc: pgoudagunta@nvidia.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a1fdba51-d19d-3b66-26c6-6a585710962c@kernel.org>
Date: Sat, 21 Jan 2017 14:27:28 +0000
MIME-Version: 1.0
In-Reply-To: <20170116192742.GA9521@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/17 19:27, Alison Schofield wrote:
> The suspend/resume functions were using dev_to_iio_dev() to get
> the iio_dev. That only works on IIO dev's.  Use dev_get_drvdata()
> for a platform device to get the correct iio_dev.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/palmas_gpadc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 2bbf0c5..7d61b56 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -775,7 +775,7 @@ static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
>  
>  static int palmas_gpadc_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
>  	int wakeup = adc->wakeup1_enable || adc->wakeup2_enable;
>  	int ret;
> @@ -798,7 +798,7 @@ static int palmas_gpadc_suspend(struct device *dev)
>  
>  static int palmas_gpadc_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct palmas_gpadc *adc = iio_priv(indio_dev);
>  	int wakeup = adc->wakeup1_enable || adc->wakeup2_enable;
>  	int ret;
> 

