Return-Path: <SRS0=/uUQ=5R=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 01/38] iio: Use macro magic to avoid manual assign of
 driver_module
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20170529155154.22580-1-jic23@kernel.org>
 <20170529155154.22580-2-jic23@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <17c0dc67-31a2-f634-96d2-d2305e7829dc@metafoo.de>
Date: Mon, 12 Jun 2017 18:13:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170529155154.22580-2-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/29/2017 05:51 PM, Jonathan Cameron wrote:
> Starting point in boiler plate reduction similar to that done for
> many similar cases elsewhere in the kernel.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Sorry for the long delay.

Whole patch series looks sensible.

Although I personally believe we shouldn't grab the owner module at all, but 
that is a separate issue.

One small bit inline.

- Lars


> @@ -598,9 +600,34 @@ struct iio_dev {
>
>  const struct iio_chan_spec
>  *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);
> -int iio_device_register(struct iio_dev *indio_dev);
> +/**
> + * iio_device_register() - register a device with the IIO subsystem
> + * @indio_dev:		Device structure filled by the device driver
> + **/
> +#define iio_device_register(iio_dev) \
> +	__iio_device_register(iio_dev, THIS_MODULE)

There should be parentheses around iio_dev.

> +int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod);
>  void iio_device_unregister(struct iio_dev *indio_dev);
> -int devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev);
> +/**
> + * devm_iio_device_register - Resource-managed iio_device_register()
> + * @dev:	Device to allocate iio_dev for
> + * @indio_dev:	Device structure filled by the device driver
> + *
> + * Managed iio_device_register.  The IIO device registered with this
> + * function is automatically unregistered on driver detach. This function
> + * calls iio_device_register() internally. Refer to that function for more
> + * information.
> + *
> + * If an iio_dev registered with this function needs to be unregistered
> + * separately, devm_iio_device_unregister() must be used.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +#define devm_iio_device_register(dev, indio_dev) \
> +	__devm_iio_device_register(dev, indio_dev, THIS_MODULE);

Same here

> +int __devm_iio_device_register(struct device *dev, struct iio_dev *indio_dev,
> +			       struct module *this_mod);
>  void devm_iio_device_unregister(struct device *dev, struct iio_dev *indio_dev);
>  int iio_push_event(struct iio_dev *indio_dev, u64 ev_code, s64 timestamp);
>  int iio_device_claim_direct_mode(struct iio_dev *indio_dev);
>
