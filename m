Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750925AbdFTRKs (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 20 Jun 2017 13:10:48 -0400
Date: Tue, 20 Jun 2017 18:10:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 10/10] iio: light: rpr0521 iio_device_register to
 devm_
Message-ID: <20170620181042.26bfd59c@kernel.org>
In-Reply-To: <1497516947-21482-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1497516947-21482-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 15 Jun 2017 11:55:47 +0300
Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com> wrote:

> Change iio_device_register to devm_
> 
> Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
This leads to a race I think.
Power is turned off in remove.  Userspace interface is only removed
after the remove call ends.

Basic rule of thumb is that if you have anything in .remove then
you can't use the devm_iio_device_register call.

Jonathan
> ---
> 
>  drivers/iio/light/rpr0521.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index ce576be..e00f427 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -1025,7 +1025,7 @@ static int rpr0521_probe(struct i2c_client *client,
>  		}
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  	if (ret)
>  		goto err_pm_disable;
>  
> @@ -1045,8 +1045,6 @@ static int rpr0521_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
> -	iio_device_unregister(indio_dev);
> -
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  	pm_runtime_put_noidle(&client->dev);

