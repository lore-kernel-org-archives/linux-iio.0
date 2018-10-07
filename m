Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727517AbeJGWPK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Oct 2018 18:15:10 -0400
Date: Sun, 7 Oct 2018 16:07:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Phil Reid <preid@electromag.com.au>
Cc: Song Qiang <songqiang1304521@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, himanshujha199640@gmail.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20181007160730.4df1010b@archlinux>
In-Reply-To: <b73d2ff2-f93a-1268-67f9-08620f05770d@electromag.com.au>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181002143812.3661-4-songqiang1304521@gmail.com>
        <b73d2ff2-f93a-1268-67f9-08620f05770d@electromag.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 3 Oct 2018 09:42:14 +0800
Phil Reid <preid@electromag.com.au> wrote:

> G'day Song,

Hi Phil. Good point below. One general thing though, if you
could possibly crop down a review email when you are addressing one specific
point it would be very much appreciated!

Saves everyone else scrolling and if they have a rubbish email client
missing the comment entirely!

Thanks,
> 
> Noticed a one more thing below
> 
...
> > +int rm3100_common_probe(struct device *dev, struct regmap *regmap, int irq)
> > +{
> > +	struct iio_dev *indio_dev;
> > +	struct rm3100_data *data;
> > +	unsigned int tmp;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	data = iio_priv(indio_dev);
> > +	data->regmap = regmap;
> > +
> > +	mutex_init(&data->lock);
> > +
> > +	indio_dev->dev.parent = dev;
> > +	indio_dev->name = "rm3100";
> > +	indio_dev->info = &rm3100_info;
> > +	indio_dev->channels = rm3100_channels;
> > +	indio_dev->num_channels = ARRAY_SIZE(rm3100_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = rm3100_scan_masks;
> > +
> > +	if (!irq)
> > +		data->use_interrupt = false;
> > +	else {
> > +		data->use_interrupt = true;
> > +		ret = devm_request_irq(dev,
> > +				       irq,
> > +				       rm3100_irq_handler,
> > +				       IRQF_TRIGGER_RISING,
> > +				       indio_dev->name,
> > +				       data);  
> 
> Assuming the irq source is the DRDY pin, this pin is active high.
> Which is automatically cleared when reading the measurement results register.
> 
> Perhaps when using interrupts the irq handler should do the read into data->buffer
> to clear the irq. Would need to use devm_request_threaded_irq instead.

Agreed. With a level interrupt that is the easiest way to handle it.
Grab the data in the threaded handler and complete after that.

Jonathan


> 
> The SOC irq block I use doesn't support edge triggered irqs, so this currently wouldn't work if
> DRDY was connected to that.
> 
> 
> > +		if (ret < 0) {
> > +			dev_err(dev, "request irq line failed.\n");
> > +			return ret;
> > +		}
> > +		init_completion(&data->measuring_done);
> > +	}
> > +
> > +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> > +					      rm3100_trigger_handler, NULL);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret = regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> > +	if (ret < 0)
> > +		return ret;
> > +	/* Initializing max wait time, 3sec more wait time for conversion. */
> > +	data->conversion_time =
> > +		rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2] + 3000;
> > +
...
