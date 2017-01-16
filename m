Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lelnx194.ext.ti.com ([198.47.27.80]:33602 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751055AbdAPQiy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 11:38:54 -0500
Subject: Re: [PATCH] iio: health: afe4403: retrieve a valid iio_dev in
 suspend/resume
To: Alison Schofield <amsfield22@gmail.com>, <jic23@kernel.org>
References: <20170115035141.GA19547@d830.WORKGROUP>
CC: <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <9fc37bb7-0a0c-cf68-51e5-c91d096262d7@ti.com>
Date: Mon, 16 Jan 2017 10:38:27 -0600
MIME-Version: 1.0
In-Reply-To: <20170115035141.GA19547@d830.WORKGROUP>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/14/2017 09:51 PM, Alison Schofield wrote:
> The suspend/resume functions were using dev_to_iio_dev() to get
> the iio_dev. That only works on IIO dev's.  Replace it with spi
> functions to get the correct iio_dev.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>

Was this found with an automated tool? If not, it might be nice to have
a Coccinelle style check for this. Anyway for this and the afe4404
version patch:

Acked-by: Andrew F. Davis <afd@ti.com>

> ---
>  drivers/iio/health/afe4403.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
> index 9a08146..6bb23a4 100644
> --- a/drivers/iio/health/afe4403.c
> +++ b/drivers/iio/health/afe4403.c
> @@ -422,7 +422,7 @@ MODULE_DEVICE_TABLE(of, afe4403_of_match);
>  
>  static int __maybe_unused afe4403_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
>  	struct afe4403_data *afe = iio_priv(indio_dev);
>  	int ret;
>  
> @@ -443,7 +443,7 @@ static int __maybe_unused afe4403_suspend(struct device *dev)
>  
>  static int __maybe_unused afe4403_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
>  	struct afe4403_data *afe = iio_priv(indio_dev);
>  	int ret;
>  
> 
