Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51439 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012AbaECLBv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 3 May 2014 07:01:51 -0400
Message-ID: <5364CCFC.3080505@kernel.org>
Date: Sat, 03 May 2014 12:03:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH] iio: ak8975: Fix issue with the name
References: <1398786274-24868-1-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1398786274-24868-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/14 16:44, Srinivas Pandruvada wrote:
> Fixing issue caused by clash of two patches, one adding a name with
> the acpi enumeration patch.
>
> 54ab3e24 Beomho Seo          2014-04-02 @572  	indio_dev->name = id->name;
> d913971e Srinivas Pandruvada 2014-03-19  574  	indio_dev->name = name;
>
> The name added by commit 54ab3e24 is not required as this is already
> added by taking care of case where id is NULL.
>
> Datailed warning 0-DAY kernel build testing backend:
> vers/iio/magnetometer/ak8975.c:572 ak8975_probe() error: we previously assumed 'id' could be null (see line 546)
>
> git remote add iio git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
> git remote update iio
> git checkout d913971ecaf31d7d5a6836224b669e1972469445
> vim +/id +572 drivers/iio/magnetometer/ak8975.c
>
> 94a6d5cf drivers/iio/magnetometer/ak8975.c         Jacek Anaszewski    2013-05-07  540
> 94a6d5cf drivers/iio/magnetometer/ak8975.c         Jacek Anaszewski    2013-05-07  541  	data->client = client;
> 94a6d5cf drivers/iio/magnetometer/ak8975.c         Jacek Anaszewski    2013-05-07  542  	data->eoc_gpio = eoc_gpio;
> 94a6d5cf drivers/iio/magnetometer/ak8975.c         Jacek Anaszewski    2013-05-07  543  	data->eoc_irq = 0;
> 94a6d5cf drivers/iio/magnetometer/ak8975.c         Jacek Anaszewski    2013-05-07  544
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  545  	/* id will be NULL when enumerated via ACPI */
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19 @546  	if (id) {
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  547  		data->chipset =
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  548  			(enum asahi_compass_chipset)(id->driver_data);
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  549  		name = (char *) id->name;
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  550  	} else if (ACPI_HANDLE(&client->dev))
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  551  		name = ak8975_match_acpi_device(&client->dev, &data->chipset);
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  552  	else {
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  553  		err = -ENOSYS;
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  554  		goto exit_free_iio;
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  555  	}
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  556  	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
> 6027c077 drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  557
> 3285aae1 drivers/staging/iio/magnetometer/ak8975.c Andrew Chew         2010-09-08  558  	/* Perform some basic start-of-day setup of the device. */
> 3285aae1 drivers/staging/iio/magnetometer/ak8975.c Andrew Chew         2010-09-08  559  	err = ak8975_setup(client);
> 3285aae1 drivers/staging/iio/magnetometer/ak8975.c Andrew Chew         2010-09-08  560  	if (err < 0) {
> 3285aae1 drivers/staging/iio/magnetometer/ak8975.c Andrew Chew         2010-09-08  561  		dev_err(&client->dev, "AK8975 initialization fails\n");
> ad31d250 drivers/staging/iio/magnetometer/ak8975.c Stephen Warren      2011-09-21  562  		goto exit_free_iio;
> 3285aae1 drivers/staging/iio/magnetometer/ak8975.c Andrew Chew         2010-09-08  563  	}
> 3285aae1 drivers/staging/iio/magnetometer/ak8975.c Andrew Chew         2010-09-08  564
> 338473c8 drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-06-27  565  	data->client = client;
> 338473c8 drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-06-27  566  	mutex_init(&data->lock);
> 338473c8 drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-06-27  567  	data->eoc_gpio = eoc_gpio;
> 338473c8 drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-06-27  568  	indio_dev->dev.parent = &client->dev;
> 694e1b5f drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-08-12  569  	indio_dev->channels = ak8975_channels;
> 694e1b5f drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-08-12  570  	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
> 338473c8 drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-06-27  571  	indio_dev->info = &ak8975_info;
> 54ab3e24 drivers/iio/magnetometer/ak8975.c         Beomho Seo          2014-04-02 @572  	indio_dev->name = id->name;
> 338473c8 drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-06-27  573  	indio_dev->modes = INDIO_DIRECT_MODE;
> d913971e drivers/iio/magnetometer/ak8975.c         Srinivas Pandruvada 2014-03-19  574  	indio_dev->name = name;
> 338473c8 drivers/staging/iio/magnetometer/ak8975.c Jonathan Cameron    2011-06-27  575  	err = iio_device_register(indio_dev);
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git
I amended the commit message to simply give a reported by credit rather than the
whole message above.

Thanks,

> ---
>   drivers/iio/magnetometer/ak8975.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index f5c1d41..09ea5c4 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -569,7 +569,6 @@ static int ak8975_probe(struct i2c_client *client,
>   	indio_dev->channels = ak8975_channels;
>   	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
>   	indio_dev->info = &ak8975_info;
> -	indio_dev->name = id->name;
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   	indio_dev->name = name;
>   	err = iio_device_register(indio_dev);
>

