Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59915 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755726AbbAJWIQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 10 Jan 2015 17:08:16 -0500
Message-ID: <54B1A2CD.40208@kernel.org>
Date: Sat, 10 Jan 2015 22:08:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Prevent dereferencing NULL
References: <1420845217-16920-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1420845217-16920-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/01/15 23:13, Srinivas Pandruvada wrote:
> When id is null, with ACPI enumeration, don't dereference it.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index f73e60b..d8d5bed 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -780,7 +780,11 @@ static int inv_mpu_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, indio_dev);
>  	indio_dev->dev.parent = &client->dev;
> -	indio_dev->name = id->name;
> +	/* id will be NULL when enumerated via ACPI */
> +	if (id)
> +		indio_dev->name = (char *)id->name;
> +	else
> +		indio_dev->name = (char *)dev_name(&client->dev);
>  	indio_dev->channels = inv_mpu_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
>  
> 

