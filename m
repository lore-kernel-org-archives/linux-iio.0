Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48059 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755385AbdL2JLg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Dec 2017 04:11:36 -0500
Date: Fri, 29 Dec 2017 10:11:23 +0100
From: jacopo mondi <jacopo@jmondi.org>
To: Dmitry Mastykin <mastichi@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Rob Herring <robh@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max9611: fix module auto-loading
Message-ID: <20171229091123.GA8023@w540>
References: <1514531684-3872-1-git-send-email-mastichi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1514531684-3872-1-git-send-email-mastichi@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Dmitry,

On Fri, Dec 29, 2017 at 10:14:27AM +0300, Dmitry Mastykin wrote:
> Module auto-load doesn't work because i2c table is not exported.
>
> Signed-off-by: Dmitry Mastykin <mastichi@gmail.com>
> ---
>  drivers/iio/adc/max9611.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index b1dd17c..7924b5c 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -516,13 +516,20 @@ static int max9611_init(struct max9611_dev *max9611)
>  	return 0;
>  }
>
> +static const struct i2c_device_id max9611_id[] = {
> +	{ "max9611", 0 },
> +	{ "max9612", 0 },
> +	{ },
> + };
> +MODULE_DEVICE_TABLE(i2c, max9611_id);
> +

Wouldn't you need to also set the "id_table" field of "struct
i2c_driver" to point this?

Thanks
   j


>  static const struct of_device_id max9611_of_table[] = {
>  	{.compatible = "maxim,max9611", .data = "max9611"},
>  	{.compatible = "maxim,max9612", .data = "max9612"},
>  	{ },
>  };
> -
>  MODULE_DEVICE_TABLE(of, max9611_of_table);
> +
>  static int max9611_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
> --
> 2.7.4
>
