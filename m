Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41522 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBXMZZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Feb 2018 07:25:25 -0500
Date: Sat, 24 Feb 2018 12:18:09 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <lars@metafoo.de>
Subject: Re: [PATCH] staging: iio: ad5933: merge ring init function into
 probe function
Message-ID: <20180224121747.6ff4b90b@archlinux>
In-Reply-To: <20180216120915.19277-1-alexandru.ardelean@analog.com>
References: <20180216120915.19277-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 16 Feb 2018 14:09:15 +0200
Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:

> This is a small cleanup of the driver's init code.
> It does not fix anything.
> 
> The `devm_iio_kfifo_allocate()` function is used instead of
> `iio_kfifo_allocate()`.  This removes the need for explicit deallocation of
> the driver's iio_buffer, which will now be handled via
> `iio_device_unregister()`.
> 
> The `setup_ops` assignment has been moved into the `ad5933_probe()` call,
> since it's a one-liner.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
> 
> Note: this change is based on top of `fixes-togreg-post-rc1` branch which
> contains commit (7d2b8e6aaf9: staging: iio: ad5933: switch buffer mode to
> software)
It will take a few weeks for that to get to my togreg branch so please
do remind me if it has and I seem to have forgotten this!

Jonathan

> 
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 35 +++++++------------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 3bcf49466361..1cab67b3a81e 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -635,22 +635,6 @@ static const struct iio_buffer_setup_ops ad5933_ring_setup_ops = {
>  	.postdisable = ad5933_ring_postdisable,
>  };
>  
> -static int ad5933_register_ring_funcs_and_init(struct iio_dev *indio_dev)
> -{
> -	struct iio_buffer *buffer;
> -
> -	buffer = iio_kfifo_allocate();
> -	if (!buffer)
> -		return -ENOMEM;
> -
> -	iio_device_attach_buffer(indio_dev, buffer);
> -
> -	/* Ring buffer functions - here trigger setup related */
> -	indio_dev->setup_ops = &ad5933_ring_setup_ops;
> -
> -	return 0;
> -}
> -
>  static void ad5933_work(struct work_struct *work)
>  {
>  	struct ad5933_state *st = container_of(work,
> @@ -714,12 +698,19 @@ static int ad5933_probe(struct i2c_client *client,
>  	int ret, voltage_uv = 0;
>  	struct ad5933_platform_data *pdata = dev_get_platdata(&client->dev);
>  	struct ad5933_state *st;
> +	struct iio_buffer *buffer;
>  	struct iio_dev *indio_dev;
>  
>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	buffer = devm_iio_kfifo_allocate(&client->dev);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
>  	st = iio_priv(indio_dev);
>  	i2c_set_clientdata(client, indio_dev);
>  	st->client = client;
> @@ -763,23 +754,18 @@ static int ad5933_probe(struct i2c_client *client,
>  	indio_dev->modes = (INDIO_BUFFER_SOFTWARE | INDIO_DIRECT_MODE);
>  	indio_dev->channels = ad5933_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad5933_channels);
> -
> -	ret = ad5933_register_ring_funcs_and_init(indio_dev);
> -	if (ret)
> -		goto error_disable_reg;
> +	indio_dev->setup_ops = &ad5933_ring_setup_ops;
>  
>  	ret = ad5933_setup(st);
>  	if (ret)
> -		goto error_unreg_ring;
> +		goto error_disable_reg;
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_unreg_ring;
> +		goto error_disable_reg;
>  
>  	return 0;
>  
> -error_unreg_ring:
> -	iio_kfifo_free(indio_dev->buffer);
>  error_disable_reg:
>  	regulator_disable(st->reg);
>  
> @@ -792,7 +778,6 @@ static int ad5933_remove(struct i2c_client *client)
>  	struct ad5933_state *st = iio_priv(indio_dev);
>  
>  	iio_device_unregister(indio_dev);
> -	iio_kfifo_free(indio_dev->buffer);
>  	regulator_disable(st->reg);
>  
>  	return 0;

