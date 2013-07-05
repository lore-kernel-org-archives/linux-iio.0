Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-102.synserver.de ([212.40.185.102]:1089 "EHLO
	smtp-out-102.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207Ab3GEKjb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Jul 2013 06:39:31 -0400
Message-ID: <51D6A282.4040506@metafoo.de>
Date: Fri, 05 Jul 2013 12:40:02 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Hector Palacios <hector.palacios@digi.com>
CC: linux-iio@vger.kernel.org, alexandre.belloni@free-electrons.com,
	jic23@kernel.org, marex@denx.de, fabio.estevam@freescale.com
Subject: Re: [PATCH 3/4] iio: mxs-lradc: add scale_available file to channels
References: <1373013039-19461-1-git-send-email-hector.palacios@digi.com> <1373013039-19461-4-git-send-email-hector.palacios@digi.com>
In-Reply-To: <1373013039-19461-4-git-send-email-hector.palacios@digi.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/05/2013 10:30 AM, Hector Palacios wrote:
[...]
> +#define SHOW_SCALE_AVAILABLE_FUNC(ch) 					\
> +static ssize_t mxs_lradc_show_scale_available##ch(struct device *dev,	\
> +		struct device_attribute *attr, 				\
> +		char *buf)						\
> +{ 									\
> +	return c ch);	\
> +}

No need for a separate function for each channel. Use the address attribute
of the iio_dev_attr. E.g.

struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);

return mxs_lradc_show_scale_available_ch(dev, attr, buf, iio_attr->address);

The last parameter to IIO_DEVICE_ATTR initializes this field.

But I think you can need less boilerplate code if you use the
iio_chan_spec_ext_info feature. Take a look at IIO_ENUM_AVAILABLE and
friends to see how it is done.

- Lars
