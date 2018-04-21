Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752882AbeDUQ0i (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:26:38 -0400
Date: Sat, 21 Apr 2018 17:26:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 07/13] staging: iio: tsl2x7x: simplify device id
 verification
Message-ID: <20180421172632.61dfcd5b@archlinux>
In-Reply-To: <20180421004153.19073-8-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-8-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:47 -0400
Brian Masney <masneyb@onstation.org> wrote:

> This patch renames tsl2x7x_device_id() to tsl2x7x_device_id_verif(),
> removes the unnecessary pointer on the id parameter, and only calls
> the verification function once.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
That double call is just weird..

Anyhow, applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index d202bc7e1f4f..56730baea927 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1277,22 +1277,22 @@ static DEVICE_ATTR_WO(in_proximity0_calibrate);
>  static DEVICE_ATTR_RW(in_illuminance0_lux_table);
>  
>  /* Use the default register values to identify the Taos device */
> -static int tsl2x7x_device_id(int *id, int target)
> +static int tsl2x7x_device_id_verif(int id, int target)
>  {
>  	switch (target) {
>  	case tsl2571:
>  	case tsl2671:
>  	case tsl2771:
> -		return (*id & 0xf0) == TRITON_ID;
> +		return (id & 0xf0) == TRITON_ID;
>  	case tmd2671:
>  	case tmd2771:
> -		return (*id & 0xf0) == HALIBUT_ID;
> +		return (id & 0xf0) == HALIBUT_ID;
>  	case tsl2572:
>  	case tsl2672:
>  	case tmd2672:
>  	case tsl2772:
>  	case tmd2772:
> -		return (*id & 0xf0) == SWORDFISH_ID;
> +		return (id & 0xf0) == SWORDFISH_ID;
>  	}
>  
>  	return -EINVAL;
> @@ -1612,8 +1612,7 @@ static int tsl2x7x_probe(struct i2c_client *clientp,
>  	if (ret < 0)
>  		return ret;
>  
> -	if ((!tsl2x7x_device_id(&ret, id->driver_data)) ||
> -	    (tsl2x7x_device_id(&ret, id->driver_data) == -EINVAL)) {
> +	if (tsl2x7x_device_id_verif(ret, id->driver_data) <= 0) {
>  		dev_info(&chip->client->dev,
>  			 "%s: i2c device found does not match expected id\n",
>  				__func__);

