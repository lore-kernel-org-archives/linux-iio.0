Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48521 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750698AbcJJUbW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 16:31:22 -0400
Subject: Re: [PATCH v2 1/8] staging: iio: isl29018: add newlines to improve
 readability
To: Brian Masney <masneyb@onstation.org>
References: <1476084002-29683-1-git-send-email-masneyb@onstation.org>
 <1476084002-29683-2-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5b19de6a-4155-a776-1f55-6e5abfdb331a@kernel.org>
Date: Mon, 10 Oct 2016 21:31:20 +0100
MIME-Version: 1.0
In-Reply-To: <1476084002-29683-2-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/10/16 08:19, Brian Masney wrote:
> Add newlines to improve code readability in preparation for moving the
> driver out of staging.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/isl29018.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 52bfb1cb..26bbbb8 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -399,6 +399,7 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
>  
>  write_done:
>  	mutex_unlock(&chip->lock);
> +
>  	return ret;
>  }
>  
> @@ -464,6 +465,7 @@ static int isl29018_read_raw(struct iio_dev *indio_dev,
>  
>  read_done:
>  	mutex_unlock(&chip->lock);
> +
>  	return ret;
>  }
>  
> @@ -726,6 +728,7 @@ static int isl29018_probe(struct i2c_client *client,
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>  	if (!indio_dev)
>  		return -ENOMEM;
> +
>  	chip = iio_priv(indio_dev);
>  
>  	i2c_set_clientdata(client, indio_dev);
> @@ -765,6 +768,7 @@ static int isl29018_probe(struct i2c_client *client,
>  	indio_dev->name = name;
>  	indio_dev->dev.parent = &client->dev;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +
>  	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
> @@ -782,6 +786,7 @@ static int isl29018_suspend(struct device *dev)
>  	chip->suspended = true;
>  
>  	mutex_unlock(&chip->lock);
> +
>  	return 0;
>  }
>  
> @@ -797,6 +802,7 @@ static int isl29018_resume(struct device *dev)
>  		chip->suspended = false;
>  
>  	mutex_unlock(&chip->lock);
> +
>  	return err;
>  }
>  
> 

