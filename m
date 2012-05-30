Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38427 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757422Ab2E3SWH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 May 2012 14:22:07 -0400
Message-ID: <4FC67365.4080409@kernel.org>
Date: Wed, 30 May 2012 20:22:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Shubhrajyoti D <shubhrajyoti@ti.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ak8975: Make it behave better as modules
References: <1338217921-23174-1-git-send-email-shubhrajyoti@ti.com> <1338217921-23174-2-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1338217921-23174-2-git-send-email-shubhrajyoti@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/28/2012 04:12 PM, Shubhrajyoti D wrote:
> The memory regions of the probe and remove are move
> to __devinit and __devexit respectively.
> 
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> dont have hardware. Untested.
Can't see any way this could cause trouble, so fine to merge
anyway...
> 
>  drivers/staging/iio/magnetometer/ak8975.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
> index 5834e4a..7562caf 100644
> --- a/drivers/staging/iio/magnetometer/ak8975.c
> +++ b/drivers/staging/iio/magnetometer/ak8975.c
> @@ -471,7 +471,7 @@ static const struct iio_info ak8975_info = {
>  	.driver_module = THIS_MODULE,
>  };
>  
> -static int ak8975_probe(struct i2c_client *client,
> +static int __devinit ak8975_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct ak8975_data *data;
> @@ -545,7 +545,7 @@ exit:
>  	return err;
>  }
>  
> -static int ak8975_remove(struct i2c_client *client)
> +static int __devexit ak8975_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct ak8975_data *data = iio_priv(indio_dev);

