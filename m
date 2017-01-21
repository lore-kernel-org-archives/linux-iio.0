Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35131 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750876AbdAUOWi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jan 2017 09:22:38 -0500
Subject: Re: [PATCH 2/3] iio: potentiometer: mcp4531: Export OF device ID
 table as module aliases
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <1484581845-19457-1-git-send-email-javier@osg.samsung.com>
 <1484581845-19457-2-git-send-email-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Rosin <peda@axentia.se>, Hartmut Knaack <knaack.h@gmx.de>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <368a545c-4c6e-88b5-847d-de6260518a03@kernel.org>
Date: Sat, 21 Jan 2017 14:22:36 +0000
MIME-Version: 1.0
In-Reply-To: <1484581845-19457-2-git-send-email-javier@osg.samsung.com>
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
> ---
> 
>  drivers/iio/potentiometer/mcp4531.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
> index 0d1bcf89ae17..314353d7ab59 100644
> --- a/drivers/iio/potentiometer/mcp4531.c
> +++ b/drivers/iio/potentiometer/mcp4531.c
> @@ -284,6 +284,7 @@ static const struct of_device_id mcp4531_of_match[] = {
>  	MCP4531_COMPATIBLE("microchip,mcp4662-104", MCP466x_104),
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, mcp4531_of_match);
>  #endif
>  
>  static int mcp4531_probe(struct i2c_client *client,
> 

