Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:36996 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab1ARLOo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jan 2011 06:14:44 -0500
Message-ID: <4D357622.1070908@cam.ac.uk>
Date: Tue, 18 Jan 2011 11:14:42 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: shubhrajyoti@ti.com
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH ] hmc5843: Trivial optimisation
References: <1295333951-3793-1-git-send-email-shubhrajyoti@ti.com> <1295333951-3793-2-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1295333951-3793-2-git-send-email-shubhrajyoti@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/18/11 06:59, shubhrajyoti@ti.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti@ti.com>
> 
> Free the memory that is used only at init

hmc5843_init_client is only called by probe.
Could also be marked as devinit for consistency
and possible tiny saving in memory...

Otherwise all fine with me, please forward to GregKH.
> 
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/magnetometer/hmc5843.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index b1c26d8..9df66cd 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -529,7 +529,7 @@ static void hmc5843_init_client(struct i2c_client *client)
>  	pr_info("HMC5843 initialized\n");
>  }
>  
> -static int hmc5843_probe(struct i2c_client *client,
> +static int __devinit hmc5843_probe(struct i2c_client *client,
>  			 const struct i2c_device_id *id)
>  {
>  	struct hmc5843_data *data;
> @@ -574,7 +574,7 @@ exit:
>  	return err;
>  }
>  
> -static int hmc5843_remove(struct i2c_client *client)
> +static int __devexit hmc5843_remove(struct i2c_client *client)
>  {
>  	struct hmc5843_data *data = i2c_get_clientdata(client);
>  	 /*  sleep mode to save power */
> @@ -616,7 +616,7 @@ static struct i2c_driver hmc5843_driver = {
>  	},
>  	.id_table	= hmc5843_id,
>  	.probe		= hmc5843_probe,
> -	.remove		= hmc5843_remove,
> +	.remove		=  __devexit_p(hmc5843_remove),
>  	.detect		= hmc5843_detect,
>  	.address_list	= normal_i2c,
>  };

