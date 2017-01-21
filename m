Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35138 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbdAUOWv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:22:51 -0500
Subject: Re: [PATCH 3/3] iio: adc: max1363: Export OF device ID table as
 module aliases
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <1484581845-19457-1-git-send-email-javier@osg.samsung.com>
 <1484581845-19457-3-git-send-email-javier@osg.samsung.com>
Cc: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Stefan Eichenberger <eichest@gmail.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Florian Vaussard <florian.vaussard@gmail.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <818ab275-2a3f-8087-603d-ff5fc96f854f@kernel.org>
Date: Sat, 21 Jan 2017 14:22:49 +0000
MIME-Version: 1.0
In-Reply-To: <1484581845-19457-3-git-send-email-javier@osg.samsung.com>
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
Applied.

Thanks,

Jonathan
> ---
> 
>  drivers/iio/adc/max1363.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 841a13c9b6ea..c6c12feb4a08 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1567,6 +1567,7 @@ static const struct of_device_id max1363_of_match[] = {
>  	MAX1363_COMPATIBLE("maxim,max11647", max11647),
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, max1363_of_match);
>  #endif
>  
>  static int max1363_probe(struct i2c_client *client,
> 

