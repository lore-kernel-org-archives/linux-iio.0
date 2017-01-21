Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34812 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdAUNNp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 08:13:45 -0500
Subject: Re: [PATCH] iio: health: afe4404: retrieve a valid iio_dev in
 suspend/resume
To: Alison Schofield <amsfield22@gmail.com>
References: <20170115035241.GA19555@d830.WORKGROUP>
Cc: afd@ti.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <921be868-529b-bac2-dbca-f1a8ad943cf7@kernel.org>
Date: Sat, 21 Jan 2017 13:13:43 +0000
MIME-Version: 1.0
In-Reply-To: <20170115035241.GA19555@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/01/17 03:52, Alison Schofield wrote:
> The suspend/resume functions were using dev_to_iio_dev() to get
> the iio_dev. That only works on IIO dev's.  Replace it with i2c
> functions to get the correct iio_dev.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Applied with Andrew's Ack.
> ---
>  drivers/iio/health/afe4404.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
> index 4526640..964f523 100644
> --- a/drivers/iio/health/afe4404.c
> +++ b/drivers/iio/health/afe4404.c
> @@ -428,7 +428,7 @@ MODULE_DEVICE_TABLE(of, afe4404_of_match);
>  
>  static int __maybe_unused afe4404_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct afe4404_data *afe = iio_priv(indio_dev);
>  	int ret;
>  
> @@ -449,7 +449,7 @@ static int __maybe_unused afe4404_suspend(struct device *dev)
>  
>  static int __maybe_unused afe4404_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct afe4404_data *afe = iio_priv(indio_dev);
>  	int ret;
>  
> 

