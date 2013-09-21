Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab3IUKGH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 06:06:07 -0400
Message-ID: <523D7DB3.8090307@kernel.org>
Date: Sat, 21 Sep 2013 12:06:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 2/4] iio: Fix bma180 dev-to-indio_dev conversion in suspend/resume
References: <1379540853-15189-1-git-send-email-pmeerw@pmeerw.net> <1379540853-15189-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1379540853-15189-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/18/13 22:47, Peter Meerwald wrote:
> dev_to_iio_dev() is a false friend
> 
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied to the fixes togreg branch of iio.git

Thanks
> ---
>  drivers/iio/accel/bma180.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 3eff246..9b0ad23 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -620,7 +620,7 @@ static int bma180_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM_SLEEP
>  static int bma180_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct bma180_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> @@ -633,7 +633,7 @@ static int bma180_suspend(struct device *dev)
>  
>  static int bma180_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
>  	struct bma180_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> 
