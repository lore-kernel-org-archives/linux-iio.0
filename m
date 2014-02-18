Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-137.synserver.de ([212.40.185.137]:1087 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755470AbaBRPzH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Feb 2014 10:55:07 -0500
Message-ID: <53038267.6080205@metafoo.de>
Date: Tue, 18 Feb 2014 16:55:19 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Johannes Thumshirn <johannes.thumshirn@men.de>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: Add MEN 16z188 ADC driver
References: <1392737654-22682-1-git-send-email-johannes.thumshirn@men.de> <1392737654-22682-4-git-send-email-johannes.thumshirn@men.de>
In-Reply-To: <1392737654-22682-4-git-send-email-johannes.thumshirn@men.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On top of what Peter said. Just some nitpicks...
[...]
> +static struct iio_chan_spec z188_adc_iio_channels[] = {

const

> +	Z188_ADC_CHANNEL(0),
> +	Z188_ADC_CHANNEL(1),
> +	Z188_ADC_CHANNEL(2),
> +	Z188_ADC_CHANNEL(3),
> +	Z188_ADC_CHANNEL(4),
> +	Z188_ADC_CHANNEL(5),
> +	Z188_ADC_CHANNEL(6),
> +	Z188_ADC_CHANNEL(7),
> +};
> +
[...]
> +static struct iio_info z188_adc_info = {

const

> +	.read_raw = &z188_iio_read_raw,
> +	.driver_module = THIS_MODULE,
> +};

 > +
 > +static void men_z188_remove(struct mcb_device *dev)
 > +{
[...]
 > +	mcb_set_drvdata(dev, NULL);

This is already done by the device driver core.

 > +}
[...]
 > +static struct mcb_device_id men_z188_ids[] = {

const

 > +	{ .device = 0xbc },
 > +};
 > +MODULE_DEVICE_TABLE(mcb, men_z188_ids);
