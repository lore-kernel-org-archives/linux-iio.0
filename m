Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:37995 "EHLO pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbdAaH00 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 31 Jan 2017 02:26:26 -0500
Date: Tue, 31 Jan 2017 08:19:16 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
cc: Andreas Klinger <ak@it-klinger.de>, lars@metafoo.de,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: distance: add devantech us ranger srf04
In-Reply-To: <8051b9f7-ef91-8746-1a13-693ec5cdc9e4@kernel.org>
Message-ID: <alpine.DEB.2.02.1701310816520.1494@pmeerw.net>
References: <20170130125117.GA9865@andreas> <8051b9f7-ef91-8746-1a13-693ec5cdc9e4@kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> > +	indio_dev->num_channels = ARRAY_SIZE(srf04_chan_spec);
> > +
> > +	return iio_device_register(indio_dev);
> > +}
> > +
> > +static int srf04_remove(struct platform_device *pdev)
> > +{
> > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > +
> > +	iio_device_unregister(indio_dev);
> With nothing else in here, you can use devm_iio_device_register
> and drop the remove entirely.

can devm_request_irq() and devm_iio_device_register() be used together?
if both are devm_ we cant't guarantee that iio_device_unregister() comes 
first in _remove()?

these devm_ things...

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id of_srf04_match[] = {
> > +	{ .compatible = "devantech,srf04", },
> > +	{},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, of_srf04_match);
> > +
> > +static struct platform_driver srf04_driver = {
> > +	.probe		= srf04_probe,
> > +	.remove		= srf04_remove,
> > +	.driver		= {
> > +		.name		= "srf04-gpio",
> > +		.of_match_table	= of_srf04_match,
> > +	},
> > +};
> > +
> > +module_platform_driver(srf04_driver);
> > +
> > +MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> > +MODULE_DESCRIPTION("SRF04 ultrasonic sensor for distance measuring using GPIOs");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:srf04");
> > 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
