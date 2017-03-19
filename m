Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48486 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbdCSK5Y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 06:57:24 -0400
Subject: Re: [PATCH v2 11/17] iio: dac: max5821: Set .of_match_table to OF
 device ID table
To: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-kernel@vger.kernel.org
References: <20170315044505.20660-1-javier@osg.samsung.com>
 <20170315044505.20660-12-javier@osg.samsung.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f7dad8e3-6bda-0d8c-f4b4-e2c7d0c12a9d@kernel.org>
Date: Sun, 19 Mar 2017 10:56:38 +0000
MIME-Version: 1.0
In-Reply-To: <20170315044505.20660-12-javier@osg.samsung.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/03/17 04:44, Javier Martinez Canillas wrote:
> The driver has a OF device ID table but the struct i2c_driver
> .of_match_table field is not set.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
applied.
> ---
> 
>  drivers/iio/dac/max5821.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
> index 86e9e112f554..193fac3059a3 100644
> --- a/drivers/iio/dac/max5821.c
> +++ b/drivers/iio/dac/max5821.c
> @@ -392,6 +392,7 @@ MODULE_DEVICE_TABLE(of, max5821_of_match);
>  static struct i2c_driver max5821_driver = {
>  	.driver = {
>  		.name	= "max5821",
> +		.of_match_table = max5821_of_match,
>  		.pm     = MAX5821_PM_OPS,
>  	},
>  	.probe		= max5821_probe,
> 

