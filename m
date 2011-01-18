Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37723 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751332Ab1ARLPn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jan 2011 06:15:43 -0500
Message-ID: <4D35765F.6060406@cam.ac.uk>
Date: Tue, 18 Jan 2011 11:15:43 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: shubhrajyoti@ti.com
CC: linux-iio@vger.kernel.org, achew@nvidia.com
Subject: Re: [PATCH] [RFC] ak8975: Trivial optimisations
References: <1295333911-3762-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1295333911-3762-1-git-send-email-shubhrajyoti@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/18/11 06:58, shubhrajyoti@ti.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti@ti.com>
> 
> The probe memory could be freed after init.
> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Probably best to wait for Andrew to reply before sending this one on...
> ---
> Compile tested only.
>  drivers/staging/iio/magnetometer/ak8975.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/magnetometer/ak8975.c b/drivers/staging/iio/magnetometer/ak8975.c
> index 420f206..694da1e 100644
> --- a/drivers/staging/iio/magnetometer/ak8975.c
> +++ b/drivers/staging/iio/magnetometer/ak8975.c
> @@ -431,7 +431,7 @@ static struct attribute_group ak8975_attr_group = {
>  	.attrs = ak8975_attr,
>  };
>  
> -static int ak8975_probe(struct i2c_client *client,
> +static int __devinit ak8975_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct ak8975_data *data;
> @@ -510,7 +510,7 @@ exit:
>  	return err;
>  }
>  
> -static int ak8975_remove(struct i2c_client *client)
> +static int  __devexit ak8975_remove(struct i2c_client *client)
>  {
>  	struct ak8975_data *data = i2c_get_clientdata(client);
>  

