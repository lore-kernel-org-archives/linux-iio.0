Return-Path: <SRS0=/uUQ=5R=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH 38/38] iio: drop iio_info.driver_module and
 iio_trigger_ops.owner.
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
References: <20170529155154.22580-1-jic23@kernel.org>
 <20170529155154.22580-39-jic23@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <87aa917c-8e89-83f5-0ca4-ca8bb40e9b18@metafoo.de>
Date: Mon, 12 Jun 2017 18:16:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170529155154.22580-39-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 05/29/2017 05:51 PM, Jonathan Cameron wrote:
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 2e1800ad265b..ff2b7c7a9652 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -34,7 +34,6 @@ struct iio_trigger;

Update to the kernel-doc is missing here.

>   * instances of a given device.
>   **/
>  struct iio_trigger_ops {
> -	struct module *owner;
>  	int (*set_trigger_state)(struct iio_trigger *trig, bool state);
>  	int (*try_reenable)(struct iio_trigger *trig);
>  	int (*validate_device)(struct iio_trigger *trig,
>
