Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751960AbdGDTsA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 4 Jul 2017 15:48:00 -0400
Date: Tue, 4 Jul 2017 20:47:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 10/10] iio: light: rpr0521 iio_device_register to
 devm_
Message-ID: <20170704204755.404abac0@kernel.org>
In-Reply-To: <1499086214-1811-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1499086214-1811-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
        <1499086214-1811-3-git-send-email-mikko.koivunen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  3 Jul 2017 15:50:14 +0300
Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com> wrote:

> Change iio_device_register to devm_
> 
> --
> 
>  drivers/iio/light/rpr0521.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
> index a6efa126..4c090d0 100644
> --- a/drivers/iio/light/rpr0521.c
> +++ b/drivers/iio/light/rpr0521.c
> @@ -1029,7 +1029,7 @@ static int rpr0521_probe(struct i2c_client *client,
>  		}
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  	if (ret)
>  		goto err_pm_disable;
>  
> @@ -1049,8 +1049,6 @@ static int rpr0521_remove(struct i2c_client *client)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  
> -	iio_device_unregister(indio_dev);
> -
Given this now means you turn the power off before you remove the userspace
interfaces (and in kernel ones) this is a very bad idea.  

So dropping this patch.

Thanks,

Jonathan
>  	pm_runtime_disable(&client->dev);
>  	pm_runtime_set_suspended(&client->dev);
>  	pm_runtime_put_noidle(&client->dev);

