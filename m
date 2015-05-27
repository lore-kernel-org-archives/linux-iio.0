Return-Path: <dan.carpenter@oracle.com>
Date: Wed, 27 May 2015 11:23:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Vladimirs Ambrosovs <rodriguez.twister@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, driverdev-devel@linuxdriverproject.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio_simple_dummy: fix init
Message-ID: <20150527082302.GN11588@mwanda>
References: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432678798-22903-1-git-send-email-rodriguez.twister@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 27, 2015 at 01:19:57AM +0300, Vladimirs Ambrosovs wrote:
> @@ -685,15 +684,14 @@ static int iio_dummy_remove(int index)
>  	/* Buffered capture related cleanup */
>  	iio_simple_dummy_unconfigure_buffer(indio_dev);
>  
> -	ret = iio_simple_dummy_events_unregister(indio_dev);
> -	if (ret)
> -		goto error_ret;
> +	/*
> +	 * Tidy up interrupt handling
> +	 * Always returns 0, so not checking for return value
> +	 */

Even though this is a dummy driver, this comment should be obvious to
everyone.  Just leave it out.

> +	iio_simple_dummy_events_unregister(indio_dev);
>  
>  	/* Free all structures */
>  	iio_device_free(indio_dev);
> -
> -error_ret:
> -	return ret;
>  }
>  
>  /**
> @@ -722,9 +720,17 @@ static __init int iio_dummy_init(void)
>  	for (i = 0; i < instances; i++) {
>  		ret = iio_dummy_probe(i);
>  		if (ret < 0)
> -			return ret;
> +			goto error_probe;
>  	}
>  	return 0;
> +
> +error_probe:

The label actually removes...  It's better to name labels after the
label location instead of the goto location.

> +	/* Free devices registered before error */

Leave out the obvious commment.

> +	while (i--)
> +		iio_dummy_remove(i);
> +
> +	kfree(iio_dummy_devs);
> +	return ret;
>  }
>  module_init(iio_dummy_init);

regards,
dan carpenter
