Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:63215 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932124AbbHLQGV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 12 Aug 2015 12:06:21 -0400
Message-ID: <1439395504.2244.36.camel@spandruv-desk3.jf.intel.com>
Subject: Re: [PATCH v3 3/6] iio: bmg160: Use generic dev_drvdata
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Paul Bolle <pebolle@tiscali.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date: Wed, 12 Aug 2015 09:05:04 -0700
In-Reply-To: <1439391009-6051-4-git-send-email-mpa@pengutronix.de>
References: <1439391009-6051-1-git-send-email-mpa@pengutronix.de>
	 <1439391009-6051-4-git-send-email-mpa@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 2015-08-12 at 16:50 +0200, Markus Pargmann wrote:
> i2c_get_clientdata() is specifically for i2c. Replace it with the
> generic dev_get/set_drvdata() to support different protocols.
> 
> Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/iio/gyro/bmg160.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index 4701ea17baea..6eab91ba8977 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -1020,7 +1020,7 @@ static int bmg160_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	data = iio_priv(indio_dev);
> -	i2c_set_clientdata(client, indio_dev);
> +	dev_set_drvdata(&client->dev, indio_dev);
>  	data->dev = &client->dev;
>  
>  	ret = bmg160_chip_init(data);
> @@ -1154,7 +1154,7 @@ static int bmg160_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int bmg160_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmg160_data *data = iio_priv(indio_dev);
>  
>  	mutex_lock(&data->mutex);
> @@ -1166,7 +1166,7 @@ static int bmg160_suspend(struct device *dev)
>  
>  static int bmg160_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmg160_data *data = iio_priv(indio_dev);
>  
>  	mutex_lock(&data->mutex);
> @@ -1182,7 +1182,7 @@ static int bmg160_resume(struct device *dev)
>  #ifdef CONFIG_PM
>  static int bmg160_runtime_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmg160_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> @@ -1197,7 +1197,7 @@ static int bmg160_runtime_suspend(struct device *dev)
>  
>  static int bmg160_runtime_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct bmg160_data *data = iio_priv(indio_dev);
>  	int ret;
>  


