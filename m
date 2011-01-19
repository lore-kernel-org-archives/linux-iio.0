Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:48103 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753688Ab1ASKF7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Jan 2011 05:05:59 -0500
Received: by gyd12 with SMTP id 12so191416gyd.17
        for <linux-iio@vger.kernel.org>; Wed, 19 Jan 2011 02:05:58 -0800 (PST)
Message-ID: <4D36B77F.1060709@ti.com>
Date: Wed, 19 Jan 2011 15:35:51 +0530
From: Shubhrajyoti <shubhrajyoti@ti.com>
MIME-Version: 1.0
To: shubhrajyoti@ti.com
CC: linux-iio@vger.kernel.org, greg@kroah.com,
	Shubhrajyoti D <a0393217@india.ti.com>
Subject: Re: [PATCH] hmc5843: Trivial optimisation
References: <1295431372-20951-1-git-send-email-shubhrajyoti@ti.com>
In-Reply-To: <1295431372-20951-1-git-send-email-shubhrajyoti@ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday 19 January 2011 03:32 PM, shubhrajyoti@ti.com wrote:
> From: Shubhrajyoti D<a0393217@india.ti.com>.
Some how the email addresses got messed up. Please ignore this patch.
> Free the memory that is used only at init
>
> Signed-off-by: Shubhrajyoti Datta<shubhrajyoti@ti.com>
> Acked-by: "Jonathan Cameron<jic23@cam.ac.uk>"
> ---
>   drivers/staging/iio/magnetometer/hmc5843.c |    8 ++++----
>   1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
> index 4f4c98a..a93c0fb 100644
> --- a/drivers/staging/iio/magnetometer/hmc5843.c
> +++ b/drivers/staging/iio/magnetometer/hmc5843.c
> @@ -516,7 +516,7 @@ static int hmc5843_detect(struct i2c_client *client,
>   }
>
>   /* Called when we have found a new HMC5843. */
> -static void hmc5843_init_client(struct i2c_client *client)
> +static void __devinit hmc5843_init_client(struct i2c_client *client)
>   {
>   	struct hmc5843_data *data = i2c_get_clientdata(client);
>   	hmc5843_set_meas_conf(client, data->meas_conf);
> @@ -527,7 +527,7 @@ static void hmc5843_init_client(struct i2c_client *client)
>   	pr_info("HMC5843 initialized\n");
>   }
>
> -static int hmc5843_probe(struct i2c_client *client,
> +static int __devinit hmc5843_probe(struct i2c_client *client,
>   			 const struct i2c_device_id *id)
>   {
>   	struct hmc5843_data *data;
> @@ -572,7 +572,7 @@ exit:
>   	return err;
>   }
>
> -static int hmc5843_remove(struct i2c_client *client)
> +static int __devexit hmc5843_remove(struct i2c_client *client)
>   {
>   	struct hmc5843_data *data = i2c_get_clientdata(client);
>   	 /*  sleep mode to save power */
> @@ -614,7 +614,7 @@ static struct i2c_driver hmc5843_driver = {
>   	},
>   	.id_table	= hmc5843_id,
>   	.probe		= hmc5843_probe,
> -	.remove		= hmc5843_remove,
> +	.remove		=  __devexit_p(hmc5843_remove),
>   	.detect		= hmc5843_detect,
>   	.address_list	= normal_i2c,
>   };

