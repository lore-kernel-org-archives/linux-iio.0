Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35126 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdAUOWa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:22:30 -0500
Subject: Re: [PATCH 1/3] iio: light: opt3001: Export OF device ID table as
 module aliases
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <1484581845-19457-1-git-send-email-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hornung <mhornung.linux@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexander Koch <mail@alexanderkoch.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8e240655-dfb0-6c8a-b5c5-0c671a579ea4@kernel.org>
Date: Sat, 21 Jan 2017 14:22:26 +0000
MIME-Version: 1.0
In-Reply-To: <1484581845-19457-1-git-send-email-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/01/17 15:50, Javier Martinez Canillas wrote:
> The I2C core always reports a MODALIAS of the form i2c:<foo> even if the
> device was registered via OF, this means that exporting the OF device ID
> table device aliases in the module is not needed. But in order to change
> how the core reports modaliases to user-space, it's better to export it.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
> 
>  drivers/iio/light/opt3001.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 78c9b3a6453a..b91ebc3483ce 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -840,6 +840,7 @@ static const struct of_device_id opt3001_of_match[] = {
>  	{ .compatible = "ti,opt3001" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, opt3001_of_match);
>  
>  static struct i2c_driver opt3001_driver = {
>  	.probe = opt3001_probe,
> 

