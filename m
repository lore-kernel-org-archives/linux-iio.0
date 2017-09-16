Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbdIPWTy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 16 Sep 2017 18:19:54 -0400
Date: Sat, 16 Sep 2017 15:19:51 -0700
From: Jonathan Cameron <jic23@kernel.org>
To: Paolo Cretaro <paolocretaro@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, gwendal@chromium.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: cros_ec: Remove unused variable
Message-ID: <20170916151951.50dd076e@archlinux>
In-Reply-To: <20170914211922.29097-1-paolocretaro@gmail.com>
References: <20170914211922.29097-1-paolocretaro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 14 Sep 2017 23:19:22 +0200
Paolo Cretaro <paolocretaro@gmail.com> wrote:

> Fix gcc warning:
> cros_ec_baro.c:130:25: warning: variable ‘ec_device’ set but not used
> 
> Signed-off-by: Paolo Cretaro <paolocretaro@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/pressure/cros_ec_baro.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 48b2a30f57ae..5fd32ad6c64d 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -127,7 +127,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct cros_ec_dev *ec_dev = dev_get_drvdata(dev->parent);
> -	struct cros_ec_device *ec_device;
>  	struct iio_dev *indio_dev;
>  	struct cros_ec_baro_state *state;
>  	struct iio_chan_spec *channel;
> @@ -137,7 +136,6 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>  		dev_warn(dev, "No CROS EC device found.\n");
>  		return -EINVAL;
>  	}
> -	ec_device = ec_dev->ec_dev;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*state));
>  	if (!indio_dev)

