Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:55359 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbdCZKDC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Mar 2017 06:03:02 -0400
Date: Sun, 26 Mar 2017 12:02:39 +0200
From: jacopo <jacopo@jmondi.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: adc: Add Maxim max9611 ADC driver
Message-ID: <20170326100239.GB5981@w540>
References: <1490369323-13866-1-git-send-email-jacopo+renesas@jmondi.org>
 <1490369323-13866-4-git-send-email-jacopo+renesas@jmondi.org>
 <a911f5d1-e019-772f-0889-849cf42e6827@kernel.org>
 <20170325171735.GA5981@w540>
 <834f03d3-36d2-9b86-6b1e-04a23d440e10@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <834f03d3-36d2-9b86-6b1e-04a23d440e10@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

On Sat, Mar 25, 2017 at 05:37:52PM +0000, Jonathan Cameron wrote:
> On 25/03/17 17:21, jacopo wrote:
> > Hi Jonathan,
> >     thanks for review

[snip]

> >>> +
> >>> +	indio_dev->dev.parent	= &client->dev;
> >>> +	indio_dev->dev.of_node	= client->dev.of_node;
> >>> +	indio_dev->name		= client->dev.of_node->name;
> >> What's this going to give for the name?  Name in IIO is supposed to
> >> be an indication of the part rather than anything more explicit.
> >> That's not easily obtained from device tree directly...
> >>
> > 
> > I used the one coming from device tree as otherwise device entries
> > have the same name, and I wanted to have it to inclued the unit
> > address (eg. adc@7c and not just adc)
> > But from you comment I guess it's fine just adc, so I'll change this
> > back to v1).
> Should be the part number - so max9611 or similar..
> 
> You can query the device node details directly if you need to identify
> which is which.

That would not help, as I've been suggested to use a generic "adc" in
node name property.

I can hard-code "max9611" here. That would not help with the fact that
two chips will appear in userspace with the same name (and that's why
I wanted to have the unit address).

Otherwise I can do what Quentin is suggesting in his review of
AST2400: have different name for each compatible entry, so that this
will appear as either max9611 or max9612 in userspace

Thanks
   j

> > 
> > Thanks
> >   j
> > 
> >>> +	indio_dev->modes	= INDIO_DIRECT_MODE;
> >>> +	indio_dev->info		= &indio_info;
> >>> +	indio_dev->channels	= max9611_channels;
> >>> +	indio_dev->num_channels	= ARRAY_SIZE(max9611_channels);
> >>> +
> >>> +	return devm_iio_device_register(&client->dev, indio_dev);
> >>> +}
> >>> +
> >>> +static const struct of_device_id max9611_of_table[] = {
> >>> +	{.compatible = "maxim,max9611"},
> >>> +	{.compatible = "maxim,max9612"},
> >>> +	{ },
> >>> +};
> >>> +
> >>> +MODULE_DEVICE_TABLE(of, max9611_of_table);
> >>> +
> >>> +static struct i2c_driver max9611_driver = {
> >>> +	.driver = {
> >>> +		   .name = DRIVER_NAME,
> >>> +		   .owner = THIS_MODULE,
> >>> +		   .of_match_table = max9611_of_table,
> >>> +	},
> >>> +	.probe = max9611_probe,
> >>> +};
> >>> +module_i2c_driver(max9611_driver);
> >>> +
> >>> +MODULE_AUTHOR("Jacopo Mondi <jacopo+renesas@jmondi.org>");
> >>> +MODULE_DESCRIPTION("Maxim max9611/12 current sense amplifier with 12bit ADC");
> >>> +MODULE_LICENSE("GPL v2");
> >>>
> >>
> 
