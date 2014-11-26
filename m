Return-Path: <knaack.h@gmx.de>
Message-ID: <54764997.5050708@gmx.de>
Date: Wed, 26 Nov 2014 22:43:51 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 jic23@kernel.org
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: imu: inv_mpu6050: Add i2c mux for by pass
References: <1416333184-1367-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1416333184-1367-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1416333184-1367-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Srinivas Pandruvada schrieb am 18.11.2014 um 18:53:
> This chip has a mode in which this chipset can be i2c master. But
> the current upstream driver doesn't support such mode as there is
> some limited support of clients, which can be connected.
> 
> To attach such clients to main i2c bus chip has to be set up in
> bypass mode. Creates an i2c mux, which will enable/disable this mode.
> This was discussed for a while in mailing list, this was the decision.
> 
> This change also provides an API, which allows clients to be created for
> this mux adapter.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
<...>
> @@ -720,6 +871,10 @@ static int inv_mpu_probe(struct i2c_client *client,
>  		goto out_remove_trigger;
>  	}
>  
> +	result = inv_mpu6050_create_mux(indio_dev);
> +	if (result)
> +		goto out_remove_trigger;
At this point, iio_device_register(indio_dev) has successfully been called, so I think you should add an extra label and the entry iio_device_unregister(indio_dev) to the error path.
> +
>  	return 0;
>  
>  out_remove_trigger:
> @@ -734,6 +889,7 @@ static int inv_mpu_remove(struct i2c_client *client)
>  	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct inv_mpu6050_state *st = iio_priv(indio_dev);
>  
> +	inv_mpu6050_destroy_mux(indio_dev);
>  	iio_device_unregister(indio_dev);
>  	inv_mpu6050_remove_trigger(st);
>  	iio_triggered_buffer_cleanup(indio_dev);
