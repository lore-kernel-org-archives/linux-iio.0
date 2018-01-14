Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeANNly (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jan 2018 08:41:54 -0500
Date: Sun, 14 Jan 2018 13:41:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: ad5272: Add support for Analog Devices digital
 potentiometers
Message-ID: <20180114134149.39313916@archlinux>
In-Reply-To: <17f90f57-e1a1-3c5e-4044-fc6673ff1cff@electromag.com.au>
References: <1515565051-72535-1-git-send-email-preid@electromag.com.au>
        <1515565051-72535-3-git-send-email-preid@electromag.com.au>
        <17f90f57-e1a1-3c5e-4044-fc6673ff1cff@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 11 Jan 2018 17:00:31 +0800
Phil Reid <preid@electromag.com.au> wrote:
...

> > +static int ad5272_probe(struct i2c_client *client,
> > +			const struct i2c_device_id *id)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct gpio_desc *reset_gpio;
> > +	struct iio_dev *indio_dev;
> > +	struct ad5272_data *data;
> > +	int ret;
> > +
> > +	reset_gpio = devm_gpiod_get_optional(&client->dev, "reset",
> > +		GPIOD_OUT_LOW);  
> Reset line to the chip is active low, so I guess I should really be setting it to GPIOD_OUT_HIGH.
> Instead of having the DT define it as active-low?
> I'm not sure what makes the most sense.

As long as you are consistent it doesn't really matter.  This flexibility is
more relevant for generic code where we might need to make things work across
both options.

Jonathan


