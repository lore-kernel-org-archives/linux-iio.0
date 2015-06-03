Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:34917 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751999AbbFCHGF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jun 2015 03:06:05 -0400
Message-ID: <1433315157.2361.100.camel@x220>
Subject: Re: [PATCH 1/3] iio: adc: hi-843x: Holt HI-8435/8436/8437 descrete
 ADC
From: Paul Bolle <pebolle@tiscali.nl>
To: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Date: Wed, 03 Jun 2015 09:05:57 +0200
In-Reply-To: <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com>
References: <1433161073-21967-1-git-send-email-vladimir.barinov@cogentembedded.com>
	 <1433161211-22034-1-git-send-email-vladimir.barinov@cogentembedded.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just a nit, that I spotted while scanning for other issues.

On Mon, 2015-06-01 at 15:20 +0300, Vladimir Barinov wrote:
> --- /dev/null
> +++ b/drivers/iio/adc/hi-843x.c

> +ssize_t hi843x_debounce_soft_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	[...]
> +}
>+
>+[...]
>+
> +ssize_t hi843x_threshold_socval_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	[...]
> +}

It seems all these *_show and *_store functions should be made static,
right?

> +static IIO_DEVICE_ATTR(debounce_soft, S_IRUGO | S_IWUSR,
> +	hi843x_debounce_soft_show, hi843x_debounce_soft_store, 0);
> +static IIO_DEVICE_ATTR(debounce_soft_delay, S_IRUGO | S_IWUSR,
> +	hi843x_debounce_soft_delay_show, hi843x_debounce_soft_delay_store, 0);
> +static IIO_DEVICE_ATTR(sensing_mode, S_IRUGO | S_IWUSR,
> +	hi843x_sensing_mode_show, hi843x_sensing_mode_store, 0);
> +static IIO_DEVICE_ATTR(test_enable, S_IRUGO | S_IWUSR,
> +	hi843x_test_enable_show, hi843x_test_enable_store, 0);
> +static IIO_DEVICE_ATTR(test_mode, S_IRUGO | S_IWUSR,
> +	hi843x_test_mode_show, hi843x_test_mode_store, 0);
> +static IIO_DEVICE_ATTR(threshold_gohys, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_gohys_show, hi843x_threshold_gohys_store, 0);
> +static IIO_DEVICE_ATTR(threshold_gocval, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_gocval_show, hi843x_threshold_gocval_store, 0);
> +static IIO_DEVICE_ATTR(threshold_sohys, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_sohys_show, hi843x_threshold_sohys_store, 0);
> +static IIO_DEVICE_ATTR(threshold_socval, S_IRUGO | S_IWUSR,
> +	hi843x_threshold_socval_show, hi843x_threshold_socval_store, 0);

Thanks,


Paul Bolle

