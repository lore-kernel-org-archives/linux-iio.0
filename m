Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbdFXUto (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Jun 2017 16:49:44 -0400
Date: Sat, 24 Jun 2017 21:49:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: pmeerw@pmeerw.net, robh+dt@kernel.org,
        william.markezana@meas-spec.com,
        ludovic.tancerel@maplehightech.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, nicolas.dechesne@linaro.org,
        amit.kucheria@linaro.org
Subject: Re: [PATCH 1/4] iio: humidity: htu21: Add OF match table
Message-ID: <20170624214939.30182945@kernel.org>
In-Reply-To: <1497374405-20871-1-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1497374405-20871-1-git-send-email-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 13 Jun 2017 22:50:05 +0530
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:

> Add of_match_table for Measurement-Specialties htu21 temperature & humidity sensor and humidity part of MS8607 sensor
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  drivers/iio/humidity/htu21.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/humidity/htu21.c b/drivers/iio/humidity/htu21.c
> index 0fbbd8c..2c4b9be 100644
> --- a/drivers/iio/humidity/htu21.c
> +++ b/drivers/iio/humidity/htu21.c
> @@ -238,11 +238,19 @@ static const struct i2c_device_id htu21_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, htu21_id);
>  
> +static const struct of_device_id htu21_of_match[] = {
> +	{ .compatible = "meas,htu21", },
> +	{ .compatible = "meas,ms8607-humidity", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, htu21_of_match);
> +
>  static struct i2c_driver htu21_driver = {
>  	.probe = htu21_probe,
>  	.id_table = htu21_id,
>  	.driver = {
>  		   .name = "htu21",
> +		   .of_match_table = of_match_ptr(htu21_of_match),
>  		   },
>  };
>  

