Return-Path: <mfuzzey@parkeon.com>
Message-ID: <53D65323.8030507@parkeon.com>
Date: Mon, 28 Jul 2014 15:41:55 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 4/8] iio: mma8452: Add support for transient event debouncing
References: <20140723171719.22067.79447.stgit@localhost> <20140723171727.22067.61322.stgit@localhost> <alpine.DEB.2.01.1407232016350.21518@pmeerw.net>
In-Reply-To: <alpine.DEB.2.01.1407232016350.21518@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 23/07/14 20:20, Peter Meerwald wrote:
> +static ssize_t mma8452_set_transient_period(struct device *dev,
> +						struct device_attribute *attr,
> +						const char *buf,
> +						size_t len)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mma8452_data *data = iio_priv(indio_dev);
> +	int i, f, us, steps, ret;
> +
> +	ret = iio_str_to_fixpoint(buf, USEC_PER_SEC / 10, &i, &f);
> +	if (ret)
> +		return ret;
> +
> +	us = i * USEC_PER_SEC + f;
> +	steps = us / mma8452_transient_time_step_us[
> +				mma8452_get_odr_index(data)];
> +
> +	if (steps < 0 || steps > 0xFF)
> perhaps do the check for negative i earlier; use lowercase hex-values
>
Ok done for V2
