Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E086753.9070105@cam.ac.uk>
Date: Mon, 27 Jun 2011 12:19:47 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: greg@kroah.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 12/54] staging:iio:accel:kxsd9: allocate state with iio_dev
 and use iio_priv to access.
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk> <1309169104-22139-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-13-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

And here is the clanger I mentioned.  Always a good idea to
actually allocate the storage you are using...
>  	struct kxsd9_state *st;
>  	int ret = 0;
>  
> -	st = kzalloc(sizeof(*st), GFP_KERNEL);
> -	if (st == NULL) {
> +	indio_dev = iio_allocate_device(0);
GAH. Going to have to check this set more thoroughly.
> +	if (indio_dev == NULL) {
>  		ret = -ENOMEM;
>  		goto error_ret;
>  	}
> -	spi_set_drvdata(spi, st);
> -
> -	st->rx = kmalloc(sizeof(*st->rx)*KXSD9_STATE_RX_SIZE,
> -			 GFP_KERNEL);
> -	if (st->rx == NULL) {
> -		ret = -ENOMEM;
> -		goto error_free_st;
> -	}
> -	st->tx = kmalloc(sizeof(*st->tx)*KXSD9_STATE_TX_SIZE,
> -			 GFP_KERNEL);
> -	if (st->tx == NULL) {
> -		ret = -ENOMEM;
> -		goto error_free_rx;
> -	}
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
>  
>  	st->us = spi;
>  	mutex_init(&st->buf_lock);
> -	st->indio_dev = iio_allocate_device(0);
> -	if (st->indio_dev == NULL) {
> -		ret = -ENOMEM;
> -		goto error_free_tx;
> -	}
> -	st->indio_dev->dev.parent = &spi->dev;
> -	st->indio_dev->info = &kxsd9_info;
> -	st->indio_dev->dev_data = (void *)(st);
> -	st->indio_dev->modes = INDIO_DIRECT_MODE;
>  
> -	ret = iio_device_register(st->indio_dev);
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->info = &kxsd9_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = iio_device_register(indio_dev);
>  	if (ret)
>  		goto error_free_dev;
>  
> @@ -355,25 +336,14 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
>  	return 0;
>  
>  error_free_dev:
> -	iio_free_device(st->indio_dev);
> -error_free_tx:
> -	kfree(st->tx);
> -error_free_rx:
> -	kfree(st->rx);
> -error_free_st:
> -	kfree(st);
> +	iio_free_device(indio_dev);
>  error_ret:
>  	return ret;
>  }
>  
>  static int __devexit kxsd9_remove(struct spi_device *spi)
>  {
> -	struct kxsd9_state *st = spi_get_drvdata(spi);
> -
> -	iio_device_unregister(st->indio_dev);
> -	kfree(st->tx);
> -	kfree(st->rx);
> -	kfree(st);
> +	iio_device_unregister(spi_get_drvdata(spi));
>  
>  	return 0;
>  }
